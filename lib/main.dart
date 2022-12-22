import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_finder/src/config/app_theme.dart';
import 'package:movie_finder/src/data/core/dio_client.dart';
import 'package:movie_finder/src/data/data_sources/remote_data_source.dart';
import 'package:movie_finder/src/data/repositories/movie_repo_impl.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // load env
  await dotenv.load(fileName: '.env');

  DioClient client = DioClient();
  RemoteDataSource source = RemoteDataSourceImpl(client);

  MovieRepoImpl repo = MovieRepoImpl(source);

  var list = await repo.getSearchedMovie(query: 'spider');

  print(list);

  runApp(const MovieFinder());
}

class MovieFinder extends StatelessWidget {
  const MovieFinder({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType) => MaterialApp(
              title: 'Movie Finder',
              debugShowCheckedModeBanner: false,
              theme: AppThemes.light,
              darkTheme: AppThemes.dark,
            ));
  }
}
