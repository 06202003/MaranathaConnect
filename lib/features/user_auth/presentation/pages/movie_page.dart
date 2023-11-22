import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '../../../../data/data_movie.dart';
import 'detail_page.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  TextEditingController controller = TextEditingController();
  final List<String> titles = [];
  final List<String> actors = [];
  final List<String> posters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            // physics: const ScrollPhysics(parent: null),
            children: [
              const Center(child: Text('Movie Search Engine')),
              TextField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: controller,
              ),
              ElevatedButton(
                  onPressed: () {
                    titles.clear();
                    actors.clear();
                    posters.clear();
                    Movie.fetchMovie(controller.text).then((value) {
                      for (int i = 0; i < value.length; i++) {
                        titles.add(value[i].title);
                        actors.add(value[i].actors);
                        (value[i].posters != null)
                            ? posters.add(value[i].posters)
                            : posters.add('');
                      }
                      setState(() {});
                    });
                    print(posters);
                  },
                  child: const Text('Search')),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailPage(
                                title: titles[index],
                                actors: actors[index],
                                posters: posters[index],
                              );
                            }));
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  posters[index] == ''
                                      ? const Icon(Icons.error)
                                      : Image.network(
                                          posters[index],
                                          height: 150,
                                        ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            titles[index],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
