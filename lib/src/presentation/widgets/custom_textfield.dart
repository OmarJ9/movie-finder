import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextfield extends StatelessWidget {
  final IconData icon;
  final String hint;
  final FormFieldValidator<String>? validator;
  final TextEditingController textEditingController;
  final TextInputType keyboardtype;
  final bool isSufix;
  final void Function(String)? onchange;
  final void Function(String)? onsubmit;

  const CustomTextfield({
    Key? key,
    required this.hint,
    required this.icon,
    this.validator,
    required this.textEditingController,
    required this.isSufix,
    this.onchange,
    this.onsubmit,
    this.keyboardtype = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: 1,
      keyboardType: keyboardtype,
      controller: textEditingController,
      onChanged: onchange,
      onFieldSubmitted: onsubmit,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
          alignLabelWithHint: true,
          filled: true,
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                style: BorderStyle.none,
              )),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.3.h),
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
          suffixIcon: (isSufix)
              ? Icon(
                  icon,
                  size: 20.sp,
                  color: Colors.grey.shade400,
                )
              : null,
          prefixIcon: (!isSufix)
              ? Icon(
                  icon,
                  size: 20.sp,
                  color: Colors.grey.shade400,
                )
              : null),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
