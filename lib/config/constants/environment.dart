import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get theMovieDbKey => dotenv.env['THE_MOVIEDB_KEY'] ?? '';
  static bool get useIsar => dotenv.env['USE_ISAR'] == 'true';
}
