import 'dart:async';
import 'dart:ui';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tarea_favorito/Models/popular_model.dart';
import 'package:tarea_favorito/Models/video_model.dart';
import 'package:tarea_favorito/Network/api_popular.dart';
import 'package:tarea_favorito/Widgets/item_actor_widget.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreen();
}

class _DetailMovieScreen extends State<DetailMovieScreen> {
  PopularModel? movie;
  bool beforeSunset = false;
  ApiPopular? apiPopular;
  List<VideoModel>? list_cn = [];
  List<VideoModel> list_cn2 = [];
  String ur = '';

  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  late PlayerState _playerState;
  late YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiPopular = ApiPopular();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        beforeSunset = true;
      });
    });
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;
    Getvidio(String ud) async {
      list_cn = await apiPopular!.getAllVideos(ud);
      list_cn2 = list_cn!;
      for (VideoModel vidio in list_cn2) {
        if (vidio.type.toString() == 'Trailer' &&
            vidio.site.toString() == 'YouTube') {
          ur = vidio.key!.toString();
          print(ur);
          break;
        }
      }
    }

    Getvidio(movie!.id.toString());
    print(ur + ' dos');
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: ur,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    Widget createActorsListView(BuildContext context, AsyncSnapshot snapshot) {
      var values = snapshot.data;
      return Container(
        height: 200.0,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: values == null ? 0 : values.length,
          itemBuilder: (BuildContext context, int index) {
            return itemActorWidget(snapshot.data![index], context);
          },
        ),
      );
    }

    final movietittle = Container(
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 228, 237, 247)),
      child: Text(
        movie!.title!,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
    final moviedsc = Container(
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 228, 237, 247)),
      child: Text(
        movie!.overview!,
        style: TextStyle(color: Colors.black),
      ),
    );

    final rat = Container(
      padding: EdgeInsets.all(30),
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 228, 237, 247)),
      child: Center(
        child: RatingBar.builder(
          initialRating: movie!.voteAverage! / 2,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Color.fromARGB(255, 67, 103, 203),
          ),
          onRatingUpdate: (rating) {
            //print(rating);
          },
        ),
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Detail movie'),
        ),
        body: Hero(
            tag: 'poster' + movie!.posterPath.toString(),
            child: Container(
              //desvanecido de imagen
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://image.tmdb.org/t/p/w500/${movie!.posterPath}'))),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                  child: Container(
                      decoration:
                          BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      child: beforeSunset
                          ? ListView(
                              /*mainAxisSize: MainAxisSize.max,
                              verticalDirection: VerticalDirection.down,*/
                              children: [
                                movietittle,
                                const SizedBox(
                                  height: 10,
                                ),
                                rat,
                                const SizedBox(
                                  height: 10,
                                ),
                                FutureBuilder(
                                    future: apiPopular!
                                        .getAllVideos(movie!.id.toString()),
                                    initialData: [],
                                    builder: (context, snapshot) {
                                      for (VideoModel vidio in list_cn2) {
                                        if (vidio.type.toString() ==
                                                'Trailer' &&
                                            vidio.site.toString() ==
                                                'YouTube') {
                                          ur = vidio.key!.toString();
                                          //print(ur);
                                          break;
                                        }
                                      }
                                      return YoutubePlayer(
                                        controller: _controller,
                                        showVideoProgressIndicator: true,
                                        progressIndicatorColor: Colors.amber,
                                        progressColors: ProgressBarColors(
                                          playedColor: Colors.amber,
                                          handleColor: Colors.amberAccent,
                                        ),
                                        onReady: () {
                                          _controller.load(
                                              ur != '' ? ur : 'Yl5o5ZGNpPQ');
                                          _controller.addListener(listener);
                                        },
                                      );
                                    }),
                                FutureBuilder(
                                    future: apiPopular!
                                        .getAllCredits(movie!.id.toString()),
                                    initialData: [],
                                    builder: (context, snapshot) {
                                      return createActorsListView(
                                          context, snapshot);
                                    }),
                                const SizedBox(
                                  height: 10,
                                ),
                                movie!.overview != ''
                                    ? moviedsc
                                    : const SizedBox(
                                        height: 2,
                                      ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : ListView(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ))),
            )));
  }
}
