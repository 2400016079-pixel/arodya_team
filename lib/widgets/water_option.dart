import 'package:flutter/material.dart';

class WaterOption extends StatelessWidget {
  final IconData icon;
  final String amount;
  final bool selected;
  final VoidCallback onTap;

  const WaterOption({
    super.key,
    required this.icon,
    required this.amount,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmall = screenWidth < 360;
    final isMedium = screenWidth < 400;

    final boxWidth = isSmall ? 84.0 : (isMedium ? 92.0 : 100.0);
    final boxHeight = isSmall ? 112.0 : (isMedium ? 122.0 : 130.0);
    final iconSize = isSmall ? 32.0 : (isMedium ? 35.0 : 38.0);
    final amountFontSize = isSmall ? 17.0 : (isMedium ? 18.5 : 20.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: boxWidth,
        height: boxHeight,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xffDDE9E1)
              : const Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xff35694A)
                : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: const Color(0xff6B756E),
            ),
            SizedBox(height: isSmall ? 8 : 12),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                amount,
                maxLines: 1,
                style: TextStyle(
                  fontSize: amountFontSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}