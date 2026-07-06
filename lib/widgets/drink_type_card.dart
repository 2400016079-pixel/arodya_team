import 'package:flutter/material.dart';

class DrinkTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const DrinkTypeCard({
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
        width: 100,
        height: 110,

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff5A845F)
              : const Color(0xffF4F4F4),

          borderRadius: BorderRadius.circular(18),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 36,
              color: selected
                  ? Colors.white
                  : Colors.black54,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: selected
                    ? Colors.white
                    : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}