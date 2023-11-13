import 'package:flutter/material.dart';
import 'package:tarea_favorito/Models/credits_model.dart';
import 'package:tarea_favorito/Models/popular_model.dart';

Widget itemActorWidget(CreditModel actor, context) {
  return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: IntrinsicHeight(
                  child: Column(
                    children: [
                      Image.network(
                          actor.profile_path.toString() != ''
                              ? 'https://image.tmdb.org/t/p/w500${actor.profile_path}'
                              : 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                          height: 150.0,
                          width: 100.0),
                      Center(
                          child: Text(actor.character.toString(),
                              textAlign: TextAlign.center)),
                      Center(
                          child: Text(actor.name.toString(),
                              textAlign: TextAlign.center))
                    ],
                  ),
                ),
              );
            });
      },
      //Mandamos el contexto, la pantalla y un arguemnto, la pelicula
      child: CircleAvatar(
          radius: 60, // Image radius
          child: ClipOval(
            child: SizedBox(
              height: 115,
              width: 115, // Image radius
              child: Image.network(
                  actor.profile_path.toString() != ''
                      ? 'https://image.tmdb.org/t/p/w500${actor.profile_path}'
                      : 'https://cdn-icons-png.flaticon.com/512/149/149071.png',
                  fit: BoxFit.cover),
            ),
          ))

      /*CircleAvatar(
        radius: 48, // Image radius
        child: Image.network(
          'https://image.tmdb.org/t/p/w500${actor.profile_path}',
        ),
      )*/

      /*CircleAvatar(
        radius: 48, // Image radius
        backgroundImage: NetworkImage(
            'https://image.tmdb.org/t/p/w500${actor.profile_path}',
            scale: 1),
      )*/
      /*ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        child: Image.network(
            'https://image.tmdb.org/t/p/w500${actor.profile_path}',
            fit: BoxFit.fill),*/

      /*   ClipOval(
        child: SizedBox(
          height: 30,
          width: 90, // Image radius
          child: Image.network(
              'https://image.tmdb.org/t/p/w500${actor.profile_path}',
              fit: BoxFit.fitHeight),
        ),
      )*/
      /* child: FadeInImage(
              //desvanecido de imagen
              fit: BoxFit.fill,
              fadeInDuration: const Duration(milliseconds: 500),
              placeholder: const AssetImage('assets/loading.gif'),
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${actor.profile_path}'))*/
      );
}
