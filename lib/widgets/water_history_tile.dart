import 'package:flutter/material.dart';

class WaterHistoryTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String amount;

  const WaterHistoryTile({
    super.key,
    required this.icon,
    required this.title,
    required this.time,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmall = screenWidth < 360;
    final isMedium = screenWidth < 400;

    final avatarRadius = isSmall ? 23.0 : (isMedium ? 25.0 : 28.0);
    final titleFontSize = isSmall ? 17.0 : (isMedium ? 19.0 : 22.0);
    final timeFontSize = isSmall ? 14.0 : (isMedium ? 15.5 : 17.0);
    final amountFontSize = isSmall ? 17.0 : (isMedium ? 19.0 : 22.0);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: isSmall ? 10 : 14),
      child: Row(
        children: [
          CircleAvatar(
            radius: avatarRadius,
            backgroundColor: const Color(0xffE5EFE8),
            child: Icon(icon, color: const Color(0xff35694A)),
          ),

          SizedBox(width: isSmall ? 12 : 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: timeFontSize,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: isSmall ? 8 : 12),

          // Dibungkus agar amount yang panjang (mis. "1200 ml") tidak
          // memaksa Row overflow di layar sempit.
          Flexible(
            child: Text(
              amount,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: TextStyle(
                color: const Color(0xff35694A),
                fontSize: amountFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
