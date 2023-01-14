import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/constants/app_colors.dart';
import 'package:movie_finder/src/constants/assets_constants.dart';
import 'package:movie_finder/src/presentation/screens/screen_layout/screen_layout.dart';
import 'package:movie_finder/src/presentation/screens/welcome_screen/widgets/outlined_button.dart';
import 'package:movie_finder/src/utils/extensions/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/Auth/authentication_bloc.dart';
import '../../../config/app_route.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthenticationBloc blocProvider =
        BlocProvider.of<AuthenticationBloc>(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          GoRouter.of(context).go(AppRoute.homescreen);
        } else if (state is UnAuthenticatedState) {
          GoRouter.of(context).go(AppRoute.welcomescreen);
        } else if (state is AuthErrorState) {
          context.showsnackbar(title: 'Something Went Wrong!');
        }
      },
      child: ScreenLayout(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedSize(
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  AssetsConstants.loginimage,
                  height: 30.h,
                  fit: BoxFit.cover,
                ),
              ),
              const CustomText(
                title: 'Welcome, Shall We Begin ?',
                headline: true,
              ),
              SizedBox(
                height: 6.h,
              ),
              MyOutlinedButton(
                func: () {
                  context.showsnackbar(
                      title: 'Coming Soon !', color: Colors.grey);
                },
                title: 'Continue with Google',
                img: AssetsConstants.facebook,
              ),
              SizedBox(
                height: 2.h,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is GoogleAuthLoadingState) {
                  return const CircularProgressIndicator(
                    color: Colors.green,
                  );
                } else {
                  return MyOutlinedButton(
                    func: () {
                      blocProvider.add(const GoogleAuthEvent());
                    },
                    title: 'Continue with Google',
                    img: AssetsConstants.google,
                  );
                }
              }),
              SizedBox(
                height: 2.h,
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const CircularProgressIndicator(
                    color: Colors.green,
                  );
                } else {
                  return MyOutlinedButton(
                    func: () {
                      blocProvider.add(const AnounymousAuthEvent());
                    },
                    title: 'Continue Anonymously',
                    img: AssetsConstants.anonymous,
                  );
                }
              }),
              SizedBox(
                height: 4.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey,
                    width: 100,
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  CustomText(
                    title: 'Or',
                    headline: false,
                    size: 10.sp,
                  ),
                  Container(
                    color: Colors.grey,
                    width: 100,
                    height: 1,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 4.h,
              ),
              CustomButton(
                func: () {
                  GoRouter.of(context).push(AppRoute.loginscreen);
                },
                color: AppColors.green,
                title: 'Login with Password',
              )
            ],
          ),
        ),
      ),
    );
  }
}
