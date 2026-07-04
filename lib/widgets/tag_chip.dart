import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String text;

  const TagChip({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffE8EFEB),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xff35694A),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}