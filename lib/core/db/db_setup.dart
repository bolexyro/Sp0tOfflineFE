import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseSetup {
  static sql.Database? _database;

  static const _dbName = 'app.db';
  static const _dbVersion = 1;

  static const trackTable = 'Track';
  static const albumTable = 'Album';
  static const artistTable = 'Artist';
  static const imageTable = 'Image';
  static const trackArtistTable = 'TrackArtist';
  static const albumArtistTable = 'AlbumArtist';
  static const playlistTable = 'Playlist';

  Future<sql.Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<sql.Database> _initDB() async {
    final dbPath = await sql.getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await sql.openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(sql.Database db, int newVersion) async {
    for (int version = 0; version < newVersion; version++) {
      await _performDbOperationsVersionWise(db, version + 1);
    }
  }

  Future<void> _onUpgrade(
      sql.Database db, int oldVersion, int newVersion) async {
    for (int version = oldVersion; version < newVersion; version++) {
      await _performDbOperationsVersionWise(db, version + 1);
    }
  }

  Future<void> _performDbOperationsVersionWise(
      sql.Database db, int version) async {
    switch (version) {
      case 1:
        await _databaseVersion1(db);
        break;
    }
  }

  Future<void> _databaseVersion1(sql.Database db) async {
    final batch = db.batch();
    batch.execute('''
    CREATE TABLE $trackTable (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      preview_url TEXT,
      album_id TEXT REFERENCES $albumTable(id) ON DELETE CASCADE,
      playlist_id TEXT REFERENCES $playlistTable(id) ON DELETE CASCADE,
      is_liked BOOLEAN NOT NULL DEFAULT 0,
      duration_ms INTEGER NOT NULL
    )
  ''');

    batch.execute('''
    CREATE TABLE $albumTable (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      album_type TEXT NOT NULL,
      total_tracks INTEGER NOT NULL,
      release_date TEXT NOT NULL,
      is_user_album BOOLEAN NOT NULL DEFAULT 0
    )
  ''');

    batch.execute('''
    CREATE TABLE $playlistTable (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL,
      description TEXT,
      owner_name TEXT NOT NULL,
      total_tracks INTEGER NOT NULL
    )
  ''');

    batch.execute('''
    CREATE TABLE $imageTable (
      url TEXT PRIMARY KEY,
      height INTEGER NOT NULL,
      width INTEGER NOT NULL,
      album_id TEXT REFERENCES album(id) ON DELETE SET NULL,
      playlist_id TEXT REFERENCES playlist(id) ON DELETE SET NULL,
      CHECK (album_id IS NOT NULL OR playlist_id IS NOT NULL)
    )
  ''');

    batch.execute('''
    CREATE TABLE $artistTable (
      id TEXT PRIMARY KEY,
      name TEXT NOT NULL
    )
  ''');

    batch.execute('''
    CREATE TABLE $trackArtistTable (
      track_id TEXT NOT NULL REFERENCES $trackTable(id) ON DELETE CASCADE,
      artist_id TEXT NOT NULL REFERENCES $artistTable(id) ON DELETE CASCADE,
      PRIMARY KEY (track_id, artist_id)
    )
  ''');

    batch.execute('''
    CREATE TABLE $albumArtistTable (
      album_id TEXT NOT NULL REFERENCES $albumTable(id) ON DELETE CASCADE,
      artist_id TEXT NOT NULL REFERENCES $artistTable(id) ON DELETE CASCADE,
      PRIMARY KEY (album_id, artist_id)
    )
  ''');

    await batch.commit(noResult: true);
  }

  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }
}
