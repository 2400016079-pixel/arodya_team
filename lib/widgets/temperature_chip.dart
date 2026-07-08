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
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmall = screenWidth < 360;

    final horizontalPadding = isSmall ? 8.0 : 10.0;
    final verticalPadding = isSmall ? 10.0 : 12.0;
    final iconSize = isSmall ? 18.0 : 20.0;
    final fontSize = isSmall ? 13.5 : 15.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffE7F0EA) : const Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: iconSize, color: const Color(0xff5A845F)),
            SizedBox(width: isSmall ? 4 : 6),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  color: const Color(0xff4A4A4A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
