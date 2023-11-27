import 'package:flutter/material.dart';

class Mainbutton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color color;
  const Mainbutton({super.key, required this.title, required this.ontap, required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              title,
              textAlign: TextAlign.center,
            ),
          )),
    );
  }
}
