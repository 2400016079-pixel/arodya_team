import 'package:flutter/material.dart';

class WeeklyBar extends StatelessWidget {
  final double height;
  final String day;

  const WeeklyBar({
    super.key,
    required this.height,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [

        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: 28,
          height: height,

          decoration: BoxDecoration(
            color: const Color(0xff35694A),
            borderRadius: BorderRadius.circular(20),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          day,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}