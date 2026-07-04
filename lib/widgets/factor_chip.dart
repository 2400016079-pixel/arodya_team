import 'package:flutter/material.dart';

class FactorChip extends StatelessWidget {

  final String title;
  final bool selected;
  final VoidCallback onTap;

  const FactorChip({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: onTap,

      child: Container(

        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff5A845F)
              : const Color(0xffE3ECE6),

          borderRadius: BorderRadius.circular(30),
        ),

        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: selected
                ? Colors.white
                : Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}