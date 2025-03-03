import 'package:spotoffline/core/db/db_setup.dart';
import 'package:spotoffline/features/library/data/models/album_model.dart';
import 'package:spotoffline/features/library/data/models/artist_model.dart';
import 'package:spotoffline/features/library/data/models/image_model.dart';
import 'package:spotoffline/features/library/data/models/playlist_model.dart';
import 'package:spotoffline/features/library/data/models/track_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  const LocalDataSource(this._databaseSetup);
  final DatabaseSetup _databaseSetup;

  Future<void> insertOrUpdateImage({
    required ImageModel image,
    String? albumId,
    String? playlistId,
  }) async {
    final db = await _databaseSetup.database;

    // Check if the image already exists
    final existingImage = await db.query(
      DatabaseSetup.imageTable,
      where: 'url = ?',
      whereArgs: [image.url],
    );

    if (existingImage.isNotEmpty) {
      await db.update(
        DatabaseSetup.imageTable,
        {
          if (albumId != null) 'album_id': albumId,
          if (playlistId != null) 'playlist_id': playlistId,
        },
        where: 'url = ?',
        whereArgs: [image.url],
      );
    } else {
      // The image doesn't exist, insert a new row
      await db.insert(
        'imageTable',
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

  Future<void> _insertCollection(
      {required String table,
      required String id,
      required String name,
      required List<ImageModel> images,
      required bool? isUserAlbum}) async {
    final db = await _databaseSetup.database;
    final Map<String, dynamic> data = {
      'id': id,
      'name': name,
    };
    if (isUserAlbum != null) {
      data['is_user_album'] = isUserAlbum ? 1 : 0;
    }
    await db.insert(table, data);

    for (final image in images) {
      insertOrUpdateImage(
        image: image,
        albumId: table == DatabaseSetup.albumTable ? id : null,
        playlistId: table == DatabaseSetup.playlistTable ? id : null,
      );
    }
  }

  Future<void> insertAlbum(AlbumModel album, bool isUserAlbum) async {
    await _insertCollection(
      table: DatabaseSetup.albumTable,
      id: album.id,
      name: album.name,
      images: album.images,
      isUserAlbum: isUserAlbum,
    );
  }

  Future<void> insertPlaylist(PlaylistModel playlist) async {
    await _insertCollection(
      table: DatabaseSetup.playlistTable,
      id: playlist.id,
      name: playlist.name,
      images: playlist.images,
      isUserAlbum: null,
    );
  }

  Future<void> _insertArtistsAndRelations(TrackModel track) async {
    for (final artist in track.artists) {
      await insertArtist(artist);
      await insertTrackArtist(track.id, artist.id);
    }
  }

  Future<void> insertAlbumTracks(
      List<TrackModel> tracks, AlbumModel album) async {
    final db = await _databaseSetup.database;
    final batch = db.batch();
    for (final track in tracks) {
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
    }

    await batch.commit(noResult: true);
  }

  Future<void> insertPlaylistTracks(
      List<TrackModel> tracks, PlaylistModel playlist) async {
    final db = await _databaseSetup.database;
    final batch = db.batch();
    for (final track in tracks) {
      await _insertArtistsAndRelations(track);
      batch.insert(
        DatabaseSetup.trackTable,
        {
          'id': track.id,
          'name': track.name,
          'preview_url': track.previewUrl,
          'playlist_id': playlist.id,
          'duration_ms': track.durationMs,
        },
      );
    }

    await batch.commit(noResult: true);
  }

  Future<void> insertArtist(ArtistModel artist) async {
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

  Future<void> insertTrackArtist(String trackId, String artistId) async {
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

  Future<void> insertLikedSongTracks(List<TrackModel> tracks) async {
    final db = await _databaseSetup.database;

    for (final track in tracks) {
      _insertArtistsAndRelations(track);
      final existingLikedSongAlbum = await db.query(
        DatabaseSetup.albumTable,
        where: 'id = ?',
        whereArgs: [track.album.id],
      );

      if (existingLikedSongAlbum.isEmpty) {
        await insertAlbum(track.album, false);
      }

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
      );
    }
  }
}
