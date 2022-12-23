import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/data/models/video_model.dart';
import '../presentation/screens/base_screen.dart';
import '../presentation/screens/details_screen/details_screen.dart';
import '../presentation/screens/screen_layout/screen_layout.dart';
import '../presentation/screens/trailers_screen/trailer_screen.dart';
import '../presentation/widgets/custom_text.dart';

class AppRoute {
  static const root = '/';
  static const details = '/details';
  static const trailer = '/trailer';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        builder: (context, state) {
          return const BaseScreen();
        },
      ),
      GoRoute(
        path: details,
        builder: (context, state) {
          final id = state.extra as int;
          return DetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: trailer,
        builder: (context, state) {
          final data = state.extra as List<VideoModel>;
          return TrailerScreen(
            videos: data,
          );
        },
      ),
    ],
    initialLocation: root,
    errorBuilder: (context, state) => const ScreenLayout(
        child: Center(
      child: CustomText(title: "This page does'nt exist!"),
    )),
  );

  static GoRouter get router => _router;
}
