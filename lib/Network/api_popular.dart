import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tarea_favorito/Models/credits_model.dart';
import 'package:tarea_favorito/Models/popular_model.dart';
import 'package:tarea_favorito/Models/video_model.dart';

class ApiPopular {
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=84376d11354a413f8d8476b07e82d0ff&language=es-MX&page=1');

  String part1 = 'https://api.themoviedb.org/3/movie/';
  String part2 =
      '/credits?api_key=84376d11354a413f8d8476b07e82d0ff&language=es-MX';
  String tra = 'https://api.themoviedb.org/3/movie/';
  String iler =
      '/videos?api_key=84376d11354a413f8d8476b07e82d0ff&language=es-MX';

  Future<List<PopularModel>?> getAllPopular() async {
    var response = await http.get(link); //capturamos el resultado
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['results'] as List;
//recuperar conjunto de resultados, antes lo parseamos y luego a lista
      return jsonResult
          .map((popular) => PopularModel.fromMap(popular))
          .toList();
      //retornamos el json obtenido como lista o
    }
    return null; //no
  }

  Future<List<CreditModel>?> getAllCredits(String id) async {
    var response =
        await http.get(Uri.parse(part1 + id + part2)); //capturamos el resultado
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['cast'] as List;
//recuperar conjunto de resultados, antes lo parseamos y luego a lista
      return jsonResult.map((popular) => CreditModel.fromMap(popular)).toList();
      //retornamos el json obtenido como lista o
    }
    return null; //no
  }

  Future<List<VideoModel>?> getAllVideos(String id) async {
    var response =
        await http.get(Uri.parse(tra + id + iler)); //capturamos el resultado
    if (response.statusCode == 200) {
      var jsonResult = jsonDecode(response.body)['results'] as List;
//recuperar conjunto de resultados, antes lo parseamos y luego a lista
      return jsonResult.map((popular) => VideoModel.fromMap(popular)).toList();
      //retornamos el json obtenido como lista o
    }
    return null; //no
  }
}
