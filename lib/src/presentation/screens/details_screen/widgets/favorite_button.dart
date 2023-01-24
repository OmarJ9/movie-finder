import 'package:flutter/material.dart';

class CustomFavoriteButton extends StatelessWidget {
  final void Function() func;
  const CustomFavoriteButton({required this.func, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 119, 235, 123),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: IconButton(
            onPressed: func,
            icon: const Icon(
              Icons.favorite,
              color: Colors.white,
            )));
  }
}
