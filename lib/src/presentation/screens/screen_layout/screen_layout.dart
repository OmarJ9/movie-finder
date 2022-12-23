import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;
  const ScreenLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w,
              vertical: 4.h,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
