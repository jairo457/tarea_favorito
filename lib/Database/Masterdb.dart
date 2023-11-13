import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:tarea_favorito/Models/favorite_model.dart';
import 'package:tarea_favorito/Models/popular_model.dart';

class MasterDB {
  static final nameDB = 'MOVIEDB';
  static final versionDB = 1;

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  Future<Database?> _initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String pathDB = join(folder.path, nameDB);
    return openDatabase(pathDB, version: versionDB, onCreate: _createTables);
  }

  FutureOr<void> _createTables(Database db, int version) {
    String query1 = '''CREATE TABLE tblFavorito(
        IdFav INTEGER PRIMARY KEY,
        Id_movie VARCHAR(100)
    );''';
    String query2 = '''CREATE TABLE tblFavoritoMovie(
        IdF INTEGER PRIMARY KEY,
        backdrop_path VARCHAR(100),
        adult VARCHAR(100),
        id VARCHAR(100),
        original_language VARCHAR(100),
        original_title VARCHAR(100),
        overview VARCHAR(100),
        popularity VARCHAR(100),
        poster_path VARCHAR(100),
        release_date VARCHAR(100),
        title VARCHAR(100),
        vote_average VARCHAR(100),
        vote_count VARCHAR(100)
    );''';
    db.execute(query2);
    db.execute(query1);
  }

//Career---------------------------------------
  Future<int> INSERT_Fav(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> DELETE_Fav(String tblName, String id) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'Id_movie = ?', whereArgs: [id]);
  }

  Future<List<Favorite_model>> GETALL_Fav() async {
    var conexion = await database;
    var result = await conexion!.query('tblFavorito');
    return result
        .map((task) => Favorite_model.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }

  //----------------------------------------------
  Future<int> INSERT_Favo(String tblName, Map<String, dynamic> data) async {
    var conexion = await database;
    return conexion!.insert(tblName, data);
  }

  Future<int> DELETE_Favo(String tblName, String id) async {
    var conexion = await database;
    return conexion!.delete(tblName, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PopularModel>> GETALL_Favo() async {
    var conexion = await database;
    var result = await conexion!.query('tblFavoritoMovie');
    return result
        .map((task) => PopularModel.fromMap(task))
        .toList(); //muevete en cada elemento y genera la lista
  }
}
