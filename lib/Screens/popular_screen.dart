import 'package:flutter/material.dart';
import 'package:tarea_favorito/Database/Masterdb.dart';
import 'package:tarea_favorito/Models/favorite_model.dart';
import 'package:tarea_favorito/Models/popular_model.dart';
import 'package:tarea_favorito/Network/api_popular.dart';
import 'package:tarea_favorito/Widgets/item_movie_widget.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;
  MasterDB? masterDB;
  bool band = false;
  List<Favorite_model> list_cn = [];
  List<String> list_favo = [];

  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    masterDB = MasterDB();
    listar();
  }

  listar() async {
    list_cn = await masterDB!.GETALL_Fav();
    /*items = list_cn
        .map((item) => DropdownMenuItem(
            value: item, child: Text(item.NameCareer.toString())))
        .toList();*/
    for (Favorite_model favori in list_cn) {
      //print(favori.Id_movie.toString());
      list_favo.add(favori.Id_movie.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Popular Movies'),
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/basic');
            },
            icon: Icon(Icons.chevron_left),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/fav');
              },
              icon: Icon(Icons.favorite),
            ),
          ]),
      body: FutureBuilder(
        future: apiPopular!.getAllPopular(),
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
                  //print(list_favo);
                  /* print(list_favo.toString() +
                      ' ' +
                      snapshot.data![index].id.toString());*/
                  return itemMovieWidget(
                      snapshot.data![index],
                      context,
                      '/popular',
                      list_favo.contains(snapshot.data![index].id.toString()));
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
