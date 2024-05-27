import 'package:cinemapedia/presentation/providers/movies/movie_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MovieScreen extends ConsumerStatefulWidget {
const MovieScreen({ super.key, required this.movieId });

  static const name = 'movie-screen';

  final String movieId ;

  @override
  ConsumerState<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends ConsumerState<MovieScreen> {
  

  @override
  void initState(){
    super.initState();
    ref.read(movieDetailsProvider.notifier).loadDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context){
    final currentMovie = ref.watch(movieDetailsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Screen ${widget.movieId}'),
      ),
      body: currentMovie != null ? 
        Center(
          child: Column(
            children: [
              Text(currentMovie.title),
              Text(currentMovie.overview),
              Image.network(currentMovie.posterPath),
            ],
          ),
        ) : 
        const Center(
          child: CircularProgressIndicator(),
        )
    );
  }
}