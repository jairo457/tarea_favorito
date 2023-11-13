import 'package:flutter/material.dart';
import 'package:tarea_favorito/Database/Masterdb.dart';
import 'package:tarea_favorito/Models/favorite_model.dart';
import 'package:tarea_favorito/Models/popular_model.dart';
import 'package:tarea_favorito/Network/api_popular.dart';
import 'package:tarea_favorito/Widgets/item_movie_widget.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  ApiPopular? apiPopular;
  MasterDB? masterDB;
  //List<Favorite_model> list_cn = [];
  List<PopularModel>? list1 = [];
  late Future<List<PopularModel>> list2;
  List<String> list_fav = [];

  void initState() {
    super.initState();
    masterDB = MasterDB();
    apiPopular = ApiPopular();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/popular');
          },
          icon: Icon(Icons.chevron_left),
        ),
      ),
      body: FutureBuilder(
        future: masterDB!.GETALL_Favo(),
        builder: (context, AsyncSnapshot<List<PopularModel>?> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .9,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return itemMovieWidget(
                      snapshot.data![index], context, '/fav', true);
                });
          } else if (snapshot.hasError) {
            return Center(child: Text('Algo salio mal :('));
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
