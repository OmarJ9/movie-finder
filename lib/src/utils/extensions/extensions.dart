import 'package:flutter/material.dart';

extension ShowSnackBar on BuildContext {
  showsnackbar({required title, Color color = Colors.red}) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(title),
      backgroundColor: color,
    ));
  }
}
