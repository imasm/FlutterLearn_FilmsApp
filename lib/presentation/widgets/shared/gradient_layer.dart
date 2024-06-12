import 'package:flutter/material.dart';

// Create a gradient to make the title more readable
class GradientLayer extends StatelessWidget {
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<double> stops;
  final List<Color> colors;

  const GradientLayer({
    super.key,
    required this.begin,
    required this.end,
    required this.stops,
    this.colors = const [Colors.black87, Colors.transparent, ],
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(
      begin: begin,
      end: end,
      stops: stops,
      colors: colors,
    ))));
  }
}
