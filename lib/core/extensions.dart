import 'package:spotoffline/features/auth/data/models/auth_data_model.dart';
import 'package:spotoffline/features/auth/data/models/token_model.dart';
import 'package:spotoffline/features/auth/data/models/user_model.dart';
import 'package:spotoffline/features/auth/domain/entity/auth_data.dart';
import 'package:spotoffline/features/auth/domain/entity/token.dart';
import 'package:spotoffline/features/auth/domain/entity/user.dart';
import 'package:spotoffline/features/library/data/models/album_model.dart';
import 'package:spotoffline/features/library/data/models/artist_model.dart';
import 'package:spotoffline/features/library/data/models/image_model.dart';
import 'package:spotoffline/features/library/data/models/playlist_model.dart';
import 'package:spotoffline/features/library/data/models/track_model.dart';
import 'package:spotoffline/features/library/domain/entity/album.dart';
import 'package:spotoffline/features/library/domain/entity/artist.dart';
import 'package:spotoffline/features/library/domain/entity/image.dart';
import 'package:spotoffline/features/library/domain/entity/playlist.dart';
import 'package:spotoffline/features/library/domain/entity/track.dart';

extension AuthDataModelMapper on AuthDataModel {
  AuthData toEntity() =>
      AuthData(user: user?.toEntity(), token: token?.toEntity());
}

extension UserModelMapper on UserModel {
  User toEntity() => User(id: id, name: name, images: images, email: email);
}

extension TokenModelMapper on TokenModel {
  Token toEntity() => Token(accessToken, refreshToken);
}

extension AlbumModelMapper on AlbumModel {
  Album toEntity() => Album(
        id: id,
        name: name,
        type: type,
        totalTracks: totalTracks,
        releaseDate: releaseDate,
        artists: artists.map((artist) => artist.toEntity()).toList(),
        images: images.map((img) => img.toEntity()).toList(),
      );
}

extension PlaylistModelMapper on PlaylistModel {
  Playlist toEntity() => Playlist(
        id: id,
        name: name,
        description: description,
        ownerName: ownerName,
        images: images.map((img) => img.toEntity()).toList(),
      );
}

extension ArtistModelMapper on ArtistModel {
  Artist toEntity() => Artist(id: id, name: name);
}

extension ImageModelMapper on ImageModel {
  Image toEntity() => Image(url: url, height: height, width: width);
}

extension TrackModelMapper on TrackModel {
  Track toEntity() => Track(
        id: id,
        name: name,
        previewUrl: previewUrl,
        artists: artists.map((artist) => artist.toEntity()).toList(),
        album: album.toEntity(),
        durationMs: durationMs,
      );
}
