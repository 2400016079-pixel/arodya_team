import 'package:flutter/material.dart';

class WeeklyBar extends StatelessWidget {
  final double height;
  final String day;

  const WeeklyBar({super.key, required this.height, required this.day});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmall = screenWidth < 360;

    final barWidth = isSmall ? 22.0 : 28.0;
    final dayFontSize = isSmall ? 12.0 : 14.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Sisakan ruang untuk label hari + jarak, sisanya untuk bar.
        final labelAreaHeight = (isSmall ? 8.0 : 10.0) + dayFontSize + 4;
        final maxBarHeight = constraints.hasBoundedHeight
            ? (constraints.maxHeight - labelAreaHeight).clamp(
                4.0,
                double.infinity,
              )
            : height;

        final safeHeight = height.clamp(4.0, maxBarHeight);

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: barWidth,
              height: safeHeight,
              decoration: BoxDecoration(
                color: const Color(0xff35694A),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            SizedBox(height: isSmall ? 8 : 10),

            Text(
              day,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: dayFontSize,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
