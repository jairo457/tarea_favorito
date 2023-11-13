import 'package:flutter/material.dart';
import 'package:tarea_favorito/Screens/Fav_screen.dart';
import 'package:tarea_favorito/Screens/LoginScreen.dart';
import 'package:tarea_favorito/Screens/detail_movie.dart';
import 'package:tarea_favorito/Screens/popular_screen.dart';

Map<String, WidgetBuilder> GetRoutes() {
  return {
    '/home': (BuildContext context) => PopularScreen(),
    '/popular': (BuildContext context) => PopularScreen(),
    '/detail': (BuildContext context) => DetailMovieScreen(),
    '/fav': (BuildContext context) => FavScreen(),
    '/basic': (BuildContext context) => LoginScreen(),
    /* '/addCareer': (BuildContext context) => AddCareer(),
    '/Career': (BuildContext context) => CareerScreen(),
    '/Profesor': (BuildContext context) => ProfesorScreen(),
    '/Calendar': (BuildContext context) => CalendarScreen(),
    '/addProfesor': (BuildContext context) => AddProfesor(),
    '/addTask': (BuildContext context) => AddTask(),*/
  };
}
