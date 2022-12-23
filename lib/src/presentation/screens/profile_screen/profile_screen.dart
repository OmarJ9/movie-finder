import 'package:flutter/material.dart';

import '../../widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomButton(func: () {}, title: 'Sign Out'),
    );
  }
}
