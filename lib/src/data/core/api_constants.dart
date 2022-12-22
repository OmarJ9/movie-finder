import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static String apiKey = dotenv.env['API_KEY'] ?? '';
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static String baseImageUrl = 'https://image.tmdb.org/t/p/w500';
}
