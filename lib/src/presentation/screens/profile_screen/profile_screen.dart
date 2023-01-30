import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/blocs/Auth/authentication_bloc.dart';
import 'package:movie_finder/src/config/app_route.dart';
import 'package:movie_finder/src/constants/assets_constants.dart';
import 'package:movie_finder/src/presentation/widgets/custom_text.dart';
import 'package:movie_finder/src/utils/extensions/extensions.dart';
import 'package:movie_finder/src/utils/services/database_service.dart';
import 'package:sizer/sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = Supabase.instance.client.auth.currentUser;
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is UnAuthenticatedState) {
          GoRouter.of(context).pushReplacement(AppRoute.welcomescreen);
        } else if (state is AuthErrorState) {
          context.showsnackbar(title: 'Something Went Wrong!');
        }
      },
      child: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AssetsConstants.placeholder,
              height: 20.h,
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomText(
              title:
                  "Welcome\n ${(user?.email == "omar@gmail.com") ? "Anonymous" : user?.email}",
              maxlines: 3,
            ),
            SizedBox(
              height: 5.h,
            ),
            CustomButton(
                func: () {
                  context.read<AuthenticationBloc>().add(const SignOutEvent());
                },
                title: 'Sign Out'),
            SizedBox(
              height: 2.h,
            ),
            (user?.email == "omar@gmail.com")
                ? const SizedBox()
                : CustomButton(
                    color: Colors.red,
                    func: () {
                      DataBaseService().deleteAllMovies();
                    },
                    title: 'Remove all saved data'),
          ],
        ),
      ),
    );
  }
}
