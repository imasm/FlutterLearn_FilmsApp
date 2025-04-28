import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MoviePosterLink extends StatelessWidget {
  final int movieId;
  final String posterPath;

  const MoviePosterLink({super.key, required this.movieId, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 300),
      child: GestureDetector(
        onTap: () {
          // Handle movie tap
          context.push('/movies/$movieId');
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Image.network(
            posterPath,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
