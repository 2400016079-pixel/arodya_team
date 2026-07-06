import 'package:flutter/material.dart';

class TemperatureChip extends StatelessWidget {

  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const TemperatureChip({
    super.key,
    required this.icon,
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
          horizontal: 20,
          vertical: 12,
        ),

        decoration: BoxDecoration(

          color: selected
              ? const Color(0xffE7F0EA)
              : const Color(0xffF4F4F4),

          borderRadius: BorderRadius.circular(30),
        ),

        child: Row(

          children: [

            Icon(
              icon,
              color: const Color(0xff5A845F),
            ),

            const SizedBox(width: 8),

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                color: Color(0xff4A4A4A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}