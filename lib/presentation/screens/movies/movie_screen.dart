import 'package:flutter/material.dart';

class MovieScreen extends StatelessWidget {
const MovieScreen({ super.key, required this.movieId });

  static const name = 'movie-screen';

  final String movieId ;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Screen $movieId'),
      ),
    );
  }
}