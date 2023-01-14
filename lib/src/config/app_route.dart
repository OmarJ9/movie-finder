import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/data/models/video_model.dart';
import 'package:movie_finder/src/presentation/screens/login_screen/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../presentation/screens/base_screen.dart';
import '../presentation/screens/details_screen/details_screen.dart';
import '../presentation/screens/screen_layout/screen_layout.dart';
import '../presentation/screens/trailers_screen/trailer_screen.dart';
import '../presentation/screens/welcome_screen/welcome_screen.dart';
import '../presentation/widgets/custom_text.dart';

class AppRoute {
  static const root = '/';
  static const welcomescreen = '/welcomescreen';
  static const loginscreen = '/loginscreen';
  static const homescreen = '/homescreen';
  static const details = '/details';
  static const trailer = '/trailer';

  static final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: root,
        builder: (context, state) {
          if (Supabase.instance.client.auth.currentUser != null) {
            return const BaseScreen();
          } else {
            return const WelcomeScreen();
          }
        },
      ),
      GoRoute(
        path: welcomescreen,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: loginscreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: homescreen,
        builder: (context, state) => const BaseScreen(),
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
