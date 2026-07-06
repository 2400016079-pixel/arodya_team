import 'package:flutter/material.dart';

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const ActivityItem({
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
        width: 92,
        height: 120,

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xff5A845F)
              : Colors.white,

          borderRadius: BorderRadius.circular(2),

          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              size: 34,
              color: selected
                  ? Colors.white
                  : Colors.black54,
            ),

            const SizedBox(height: 12),

            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: selected
                    ? Colors.white
                    : Colors.black87,
              ),
            ),

          ],
        ),
      ),
    );
  }
}