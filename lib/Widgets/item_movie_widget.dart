import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:tarea_favorito/Database/Masterdb.dart';
import 'package:tarea_favorito/Models/popular_model.dart';

Widget itemMovieWidget(
    PopularModel movie, context, String route, bool colorcito) {
  MasterDB? masterDB;
  masterDB = MasterDB();

  return Stack(fit: StackFit.expand, children: <Widget>[
    GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/detail', arguments: movie),
      //Mandamos el contexto, la pantalla y un arguemnto, la pelicula
      child: Hero(
        tag: 'poster' + movie.posterPath.toString(),
        child: /*FadeInImage.assetNetwork(
            placeholder: 'assets/loading.gif',
            image: 'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
            fit: BoxFit.fill,
          ),*/
            FadeInImage(
                //desvanecido de imagen
                fit: BoxFit.fill,
                fadeInDuration: const Duration(milliseconds: 500),
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${movie.posterPath}')),
      ),
    ),
    Align(
      alignment: Alignment.topRight,
      child: IconButton(
        color: colorcito ? Colors.red : Colors.white,
        iconSize: 52,
        icon: const Icon(Icons.favorite),
        onPressed: () {
          if (colorcito) {
            masterDB!.DELETE_Favo('tblFavoritoMovie', movie.id.toString());
            masterDB!.DELETE_Fav('tblFavorito', movie.id.toString());
            print('eliminado');
          } else {
            masterDB!
                .INSERT_Fav('tblFavorito', {'Id_movie': movie.id.toString()});
            masterDB!.INSERT_Favo('tblFavoritoMovie', {
              'adult': movie.adult.toString(),
              'backdrop_path': movie.backdropPath.toString(),
              'id': movie.id.toString(),
              'original_language': movie.originalLanguage.toString(),
              'original_title': movie.originalTitle.toString(),
              'overview': movie.overview.toString(),
              'popularity': movie.popularity.toString(),
              'poster_path': movie.posterPath.toString(),
              'release_date': movie.releaseDate.toString(),
              'title': movie.title.toString(),
              'vote_average': movie.voteAverage.toString(),
              'vote_count': movie.voteCount.toString()
            }).then((value) => print('insertado'));
          }
          Navigator.pushNamed(context, route);
          // ...
        },
      ),
    )
    /*LikeButton(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      size: 40,
    )*/
  ]);
}
