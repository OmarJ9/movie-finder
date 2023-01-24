import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_finder/src/constants/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: AppColors.green,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
            )),
        child: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )));
  }
}
