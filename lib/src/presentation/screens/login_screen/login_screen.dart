import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_finder/src/constants/app_colors.dart';
import 'package:movie_finder/src/constants/assets_constants.dart';
import 'package:movie_finder/src/presentation/screens/screen_layout/screen_layout.dart';
import 'package:movie_finder/src/utils/extensions/extensions.dart';
import 'package:sizer/sizer.dart';

import '../../../blocs/Auth/authentication_bloc.dart';
import '../../../utils/helpers/validator.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield.dart';
import 'widgets/social_card.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late TextEditingController _emailcontroller;
  late TextEditingController _passcontroller;
  final _formkey = GlobalKey<FormState>();
  bool _isloginscreen = true;
  late AnimationController _controller;
  late final Animation<double> _rotationAnimation;

  @override
  void initState() {
    _emailcontroller = TextEditingController();
    _passcontroller = TextEditingController();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000))
      ..forward();

    _rotationAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passcontroller = TextEditingController();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc blocProvider =
        BlocProvider.of<AuthenticationBloc>(context);
    return ScreenLayout(
      child: Center(
        child: SizedBox(
          width: double.infinity,
          height: 100.h,
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RotationTransition(
                  turns: _rotationAnimation,
                  child: Image.asset(
                    AssetsConstants.appicon,
                    height: 15.h,
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                CustomText(
                  title: (_isloginscreen)
                      ? 'Login to Your Account'
                      : 'Create Your Account',
                  size: 17,
                ),
                SizedBox(
                  height: 7.h,
                ),
                CustomTextfield(
                  isSufix: false,
                  hint: 'Enter your Email',
                  icon: Icons.email,
                  keyboardtype: TextInputType.emailAddress,
                  validator: (value) {
                    return !Validators.isValidEmail(value!)
                        ? 'Enter a valid Email'
                        : null;
                  },
                  textEditingController: _emailcontroller,
                ),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextfield(
                  isSufix: false,
                  hint: 'Enter your Password',
                  icon: Icons.lock,
                  keyboardtype: TextInputType.text,
                  validator: (value) {
                    return value!.length < 6 ? 'Enter a valid Password' : null;
                  },
                  textEditingController: _passcontroller,
                ),
                SizedBox(
                  height: 4.h,
                ),
                BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const CircularProgressIndicator(
                        color: Colors.green,
                      );
                    } else {
                      return CustomButton(
                        func: () {
                          if (_formkey.currentState!.validate()) {
                            if (_isloginscreen) {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  EmailSignInAuthEvent(_emailcontroller.text,
                                      _passcontroller.text));
                            } else {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                EmailSignUpAuthEvent(_emailcontroller.text,
                                    _passcontroller.text),
                              );
                            }
                          }
                        },
                        title: (_isloginscreen) ? 'Log In' : 'Sign Up',
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: (_isloginscreen)
                          ? "Don't have an account ?"
                          : "You already have an account ?",
                      headline: false,
                      size: 9,
                    ),
                    SizedBox(width: 2.w),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isloginscreen = !_isloginscreen;

                          _controller
                            ..reset()
                            ..forward();
                        });
                      },
                      child: Text(
                        (_isloginscreen) ? 'Sign Up' : 'Log In',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              color: AppColors.green,
                              fontSize: 10.sp,
                            ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.grey,
                      width: 70,
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    CustomText(
                      title: 'Or Continue with',
                      headline: false,
                      size: 10.sp,
                    ),
                    Container(
                      color: Colors.grey,
                      width: 70,
                      height: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      img: AssetsConstants.facebook,
                      func: () {
                        context.showsnackbar(
                            title: 'Coming Soon !', color: Colors.grey);
                      },
                    ),
                    SizedBox(width: 4.w),
                    SocialCard(
                      img: AssetsConstants.google,
                      func: () {
                        blocProvider.add(const GoogleAuthEvent());
                      },
                    ),
                    SizedBox(width: 4.w),
                    SocialCard(
                      img: AssetsConstants.anonymous,
                      func: () {
                        blocProvider.add(const AnounymousAuthEvent());
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
