import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../widgets/custom_text.dart';

class MyOutlinedButton extends StatelessWidget {
  final void Function() func;
  final String img, title;
  final double fontsize;
  const MyOutlinedButton({
    super.key,
    required this.func,
    required this.title,
    required this.img,
    this.fontsize = 10,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: func,
      style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h)),
          alignment: Alignment.center,
          fixedSize: MaterialStateProperty.all<Size>(Size(75.w, 7.h))),
      child: Row(
        children: [
          Image.asset(
            img,
            height: 4.h,
          ),
          SizedBox(
            width: 4.w,
          ),
          CustomText(
            title: title,
            size: fontsize,
          ),
        ],
      ),
    );
  }
}
