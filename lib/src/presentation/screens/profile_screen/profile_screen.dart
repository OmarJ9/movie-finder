import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/blocs/Auth/authentication_bloc.dart';
import 'package:movie_finder/src/utils/extensions/extensions.dart';

import '../../../config/app_route.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          GoRouter.of(context).go(AppRoute.welcomescreen);
        } else if (state is AuthErrorState) {
          context.showsnackbar(title: 'Something Went Wrong!');
        }
      },
      child: Center(
        child: CustomButton(
            func: () {
              context.read<AuthenticationBloc>().add(const SignOutEvent());
            },
            title: 'Sign Out'),
      ),
    );
  }
}
