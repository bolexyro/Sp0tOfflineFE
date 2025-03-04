import 'package:spotoffline/core/db/db_setup.dart';
import 'package:spotoffline/features/library/data/models/album_model.dart';
import 'package:spotoffline/features/library/data/models/artist_model.dart';
import 'package:spotoffline/features/library/data/models/image_model.dart';
import 'package:spotoffline/features/library/data/models/library_data_model.dart';
import 'package:spotoffline/features/library/data/models/playlist_model.dart';
import 'package:spotoffline/features/library/data/models/track_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  const LocalDataSource(this._databaseSetup);
  final DatabaseSetup _databaseSetup;

  Future<void> _insertOrUpdateImage({
    required ImageModel image,
    String? albumId,
    String? playlistId,
  }) async {
    final db = await _databaseSetup.database;

    if (albumId != null) {
      final existingImage = await db.query(
        DatabaseSetup.imageTable,
        where: 'url = ? AND album_id = ?',
        whereArgs: [image.url, albumId],
      );

      if (existingImage.isEmpty) {
        await db.insert(
          DatabaseSetup.imageTable,
          {
            'url': image.url,
            'height': image.height,
            'width': image.width,
            'album_id': albumId,
            'playlist_id': playlistId,
          },
        );
      }
    }
    if (playlistId != null) { 
      final existingImage = await db.query(
        DatabaseSetup.imageTable,
        where: 'url = ? AND playlist_id = ?',
        whereArgs: [image.url, playlistId],
      );
      if (existingImage.isEmpty) {
        await db.insert(
          DatabaseSetup.imageTable,
          {
            'url': image.url,
            'height': image.height,
            'width': image.width,
            'album_id': albumId,
            'playlist_id': playlistId,
          },
        );
      }
    }

    // if (existingImage.isNotEmpty) {
    // } else {
    //   // The image doesn't exist, insert a new row
    //   await db.insert(
    //     DatabaseSetup.imageTable,
    //     {
    //       'url': image.url,
    //       'height': image.height,
    //       'width': image.width,
    //       'album_id': albumId,
    //       'playlist_id': playlistId,
    //     },
    //   );
    // }
  }

  Future<void> insertAlbum(AlbumModel album, bool isUserAlbum) async {
    final db = await _databaseSetup.database;

    final existingLikedSongAlbum = await db.query(
      DatabaseSetup.albumTable,
      where: 'id = ?',
      whereArgs: [album.id],
    );

    if (existingLikedSongAlbum.isNotEmpty) {
      db.update(
        DatabaseSetup.albumTable,
        {
          'is_user_album': existingLikedSongAlbum[0]['is_user_album'] == 1
              ? 1
              : isUserAlbum
                  ? 1
                  : 0,
        },
        where: 'id = ?',
        whereArgs: [album.id],
      );
      return;
    }

    for (final artist in album.artists) {
      await _insertArtist(artist);
    }
    for (final artist in album.artists) {
      await _insertAlbumArtist(album.id, artist.id);
    }

    await db.insert(
      DatabaseSetup.albumTable,
      {
        'id': album.id,
        'name': album.name,
        'album_type': album.type,
        'total_tracks': album.totalTracks,
        'release_date': album.releaseDate,
        'is_user_album': isUserAlbum ? 1 : 0,
      },
    );

    for (final image in album.images) {
      _insertOrUpdateImage(image: image, albumId: album.id);
    }
  }

  Future<void> insertPlaylist(PlaylistModel playlist) async {
    final db = await _databaseSetup.database;
    await db.insert(
      DatabaseSetup.playlistTable,
      {
        'id': playlist.id,
        'name': playlist.name,
        'description': playlist.description,
        'owner_name': playlist.ownerName,
        'total_tracks': playlist.totalTracks,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );

    for (final image in playlist.images) {
      _insertOrUpdateImage(image: image, playlistId: playlist.id);
    }
  }

  Future<void> _insertArtistsAndRelations(TrackModel track) async {
    for (final artist in track.artists) {
      await _insertArtist(artist);
      await _insertTrackArtist(track.id, artist.id);
    }
  }

  Future<void> insertAlbumTracks(
      List<TrackModel> tracks, AlbumModel album) async {
    final db = await _databaseSetup.database;
    final batch = db.batch();
    for (final track in tracks) {
      final existingTrack = await db.query(
        DatabaseSetup.trackTable,
        where: 'id = ?',
        whereArgs: [track.id],
      );
      if (existingTrack.isEmpty) {
        await _insertArtistsAndRelations(track);

        batch.insert(
          DatabaseSetup.trackTable,
          {
            'id': track.id,
            'name': track.name,
            'preview_url': track.previewUrl,
            'album_id': album.id,
            'duration_ms': track.durationMs,
          },
        );
        continue;
      }
      batch.update(
        DatabaseSetup.trackTable,
        {'album_id': album.id},
        where: 'id = ?',
        whereArgs: [track.id],
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> insertPlaylistTracks(
      List<TrackModel> tracks, PlaylistModel playlist) async {
    final db = await _databaseSetup.database;
    final batch = db.batch();
    for (final track in tracks) {
      final existingTrack = await db.query(
        DatabaseSetup.trackTable,
        where: 'id = ?',
        whereArgs: [track.id],
      );

      if (existingTrack.isEmpty) {
        await _insertArtistsAndRelations(track);
        await insertAlbum(track.album, false);
        batch.insert(
          DatabaseSetup.trackTable,
          {
            'id': track.id,
            'name': track.name,
            'preview_url': track.previewUrl,
            'playlist_id': playlist.id,
            'album_id': track.album.id,
            'duration_ms': track.durationMs,
          },
        );
        continue;
      }

      batch.update(
        DatabaseSetup.trackTable,
        {'playlist_id': playlist.id},
        where: 'id = ?',
        whereArgs: [track.id],
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> _insertArtist(ArtistModel artist) async {
    final db = await _databaseSetup.database;
    await db.insert(
      DatabaseSetup.artistTable,
      {
        'id': artist.id,
        'name': artist.name,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> _insertTrackArtist(String trackId, String artistId) async {
    final db = await _databaseSetup.database;
    db.insert(
      DatabaseSetup.trackArtistTable,
      {
        'track_id': trackId,
        'artist_id': artistId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> _insertAlbumArtist(String albumId, String artistId) async {
    final db = await _databaseSetup.database;
    db.insert(
      DatabaseSetup.albumArtistTable,
      {
        'album_id': albumId,
        'artist_id': artistId,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertLikedSongTracks(List<TrackModel> tracks) async {
    final db = await _databaseSetup.database;

    for (final track in tracks) {
      _insertArtistsAndRelations(track);

      await insertAlbum(track.album, false);

      await db.insert(
        DatabaseSetup.trackTable,
        {
          'id': track.id,
          'name': track.name,
          'preview_url': track.previewUrl,
          'album_id': track.album.id,
          'is_liked': 1,
          'duration_ms': track.durationMs,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
  }

  // READ OPERATIONS
  Future<LibraryDataModel> getLibrary() async {
    final likedSongs = await getLikedSongs();
    final albums = await getAlbums();
    final playlists = await getPlaylists();

    return LibraryDataModel(
      totalLikedSongs: likedSongs.length,
      albums: albums,
      playlists: playlists,
    );
  }

  Future<List<Map<String, dynamic>>> _fetchArtistsForTrack(
      String trackId) async {
    final db = await DatabaseSetup().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
    SELECT *
    FROM Artist
    JOIN TrackArtist ON Artist.id = TrackArtist.artist_id
    WHERE TrackArtist.track_id = ?
  ''',
      [trackId],
    );

    return result;
  }

  Future<Map<String, dynamic>> _getAlbum(String albumId) async {
    final db = await DatabaseSetup().database;

    final List<Map<String, dynamic>> result = await db.query(
      DatabaseSetup.albumTable,
      where: 'id = ?',
      whereArgs: [albumId],
    );

    return result.first;
  }

  Future<List<Map<String, dynamic>>> _getArtistsForAlbum(String albumId) async {
    final db = await DatabaseSetup().database;

    final List<Map<String, dynamic>> result = await db.rawQuery(
      '''
    SELECT *
    FROM Artist
    JOIN AlbumArtist ON Artist.id = AlbumArtist.artist_id
    WHERE AlbumArtist.album_id = ?
  ''',
      [albumId],
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> _getImagesForAlbum(String albumId) async {
    final db = await DatabaseSetup().database;

    final List<Map<String, dynamic>> result = await db.query(
      DatabaseSetup.imageTable,
      where: 'album_id = ?',
      whereArgs: [albumId],
    );

    return result;
  }

  Future<List<Map<String, dynamic>>> _getImagesForPlaylist(
      String playlistId) async {
    final db = await DatabaseSetup().database;

    final List<Map<String, dynamic>> result = await db.query(
      DatabaseSetup.imageTable,
      where: 'playlist_id = ?',
      whereArgs: [playlistId],
    );
    return result;
  }

  Future<TrackModel> _getTrackDetails(Map<String, Object?> json) async {
    final mutableJson = Map.of(json);
    // get artists
    final artists = await _fetchArtistsForTrack(json['id'] as String);
    mutableJson['artists'] = artists;
    // get album
    final albumId = json['album_id'] as String;
    final album = await _getAlbum(albumId);
    final mutableAlbum = Map.of(album);

    final albumArtists = await _getArtistsForAlbum(albumId);
    mutableAlbum['artists'] = albumArtists;
    final albumImages = await _getImagesForAlbum(albumId);
    mutableAlbum['images'] = albumImages;
    mutableJson['album'] = mutableAlbum;
    return TrackModel.fromJson(mutableJson);
  }

  Future<List<TrackModel>> getLikedSongs() async {
    final db = await _databaseSetup.database;
    final likedSongs = await db.query(
      DatabaseSetup.trackTable,
      where: 'is_liked = ?',
      whereArgs: [1],
    );

    return Future.wait(
      likedSongs.map((json) async {
        return await _getTrackDetails(json);
      }).toList(),
    );
  }

  Future<List<AlbumModel>> getAlbums() async {
    final db = await _databaseSetup.database;
    final albums = await db.query(
      DatabaseSetup.albumTable,
      where: 'is_user_album = ?',
      whereArgs: [1],
    );

    return Future.wait(albums.map((json) async {
      final albumId = json['id'] as String;
      final mutableJson = Map.of(json);
      final albumArtists = await _getArtistsForAlbum(albumId);
      mutableJson['artists'] = albumArtists;
      final albumImages = await _getImagesForAlbum(albumId);
      mutableJson['images'] = albumImages;
      return AlbumModel.fromJson(mutableJson);
    }).toList());
  }

  Future<List<PlaylistModel>> getPlaylists() async {
    final db = await _databaseSetup.database;
    final playlists = await db.query(
      DatabaseSetup.playlistTable,
    );

    return Future.wait(playlists.map((json) async {
      final playlistId = json['id'] as String;
      final mutableJson = Map.of(json);
      final playlistImages = await _getImagesForPlaylist(playlistId);
      mutableJson['images'] = playlistImages;
      return PlaylistModel.fromJson(mutableJson);
    }).toList());
  }

  Future<List<TrackModel>> getAlbumTracks(String albumId) async {
    final db = await _databaseSetup.database;
    final tracks = await db.query(
      DatabaseSetup.trackTable,
      where: 'album_id = ?',
      whereArgs: [albumId],
    );

    return Future.wait(
      tracks.map((json) async {
        return await _getTrackDetails(json);
      }).toList(),
    );
  }

  Future<List<TrackModel>> getPlaylistTracks(String playlistId) async {
    final db = await _databaseSetup.database;
    final tracks = await db.query(
      DatabaseSetup.trackTable,
      where: 'playlist_id = ?',
      whereArgs: [playlistId],
    );

    return Future.wait(tracks.map((json) async {
      return await _getTrackDetails(json);
    }).toList());
  }
}
