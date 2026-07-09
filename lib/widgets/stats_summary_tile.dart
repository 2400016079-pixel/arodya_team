import 'package:flutter/material.dart';

class StatsSummaryTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String value;
  final String unit;

  const StatsSummaryTile({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Breakpoint sederhana
    final isSmall = width < 360;
    final isMedium = width < 400;

    final avatarRadius = isSmall ? 24.0 : (isMedium ? 28.0 : 32.0);
    final iconSize = isSmall ? 24.0 : (isMedium ? 28.0 : 34.0);
    final titleFontSize = isSmall ? 14.0 : (isMedium ? 16.0 : 18.0);
    final valueFontSize = isSmall ? 18.0 : (isMedium ? 20.0 : 24.0);
    final unitFontSize = isSmall ? 14.0 : (isMedium ? 16.0 : 18.0);
    final trailingIconSize = isSmall ? 28.0 : (isMedium ? 32.0 : 38.0);
    final tilePadding = isSmall ? 12.0 : (isMedium ? 15.0 : 18.0);

    return Container(
      padding: EdgeInsets.all(tilePadding),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmall ? 18 : 26),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 15),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor, size: iconSize),
          ),

          SizedBox(width: isSmall ? 10 : 18),

          // Expanded supaya teks bisa menyusut/menyesuaikan ruang tersisa
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: titleFontSize,
                  ),
                ),

                const SizedBox(height: 4),

                // FittedBox mencegah overflow jika angka/unit terlalu panjang
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: value,
                          style: TextStyle(
                            fontSize: valueFontSize,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: " $unit",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: unitFontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: isSmall ? 6 : 10),

          Icon(
            Icons.show_chart,
            size: trailingIconSize,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
