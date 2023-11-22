import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as htmlParser;

class Movie {
  final String title;
  final String actors;
  final String posters;

  const Movie(
      {required this.title, required this.actors, required this.posters});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['#TITLE'],
        actors: json['#ACTORS'] ?? '',
        posters: json['#IMG_POSTER'] ?? '');
  }

  static Future<List<Movie>> fetchMovie(String name) async {
    String apiURL = 'https://search.imdbot.workers.dev/?q=$name';

    var apiResult = await http.get(Uri.parse(apiURL));

    var jsonObject = json.decode(apiResult.body);
    List<dynamic> listMovie = (jsonObject as Map<String, dynamic>)['description'];

    List<Movie> movies = [];
    for (int i = 0; i < listMovie.length; i++) {
      movies.add(Movie.fromJson(listMovie[i]));
    }
    return movies;
  }
}