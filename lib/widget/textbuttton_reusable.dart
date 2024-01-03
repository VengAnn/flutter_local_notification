import 'package:flutter/material.dart';

class TextbuttonReusable extends StatelessWidget {
  final Color color;
  final String text;
  final Function()? onPressed;
  const TextbuttonReusable(
      {super.key, required this.color, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: color,
          child: TextButton(onPressed: onPressed, child: Text(text)),
        ),
      ],
    );
  }
}
