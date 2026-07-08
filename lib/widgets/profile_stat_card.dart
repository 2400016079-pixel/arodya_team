import 'package:flutter/material.dart';

class ProfileStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final Widget? bottomWidget;

  const ProfileStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 360;
    final isMedium = width < 400;

    final cardPadding = isSmall ? 12.0 : (isMedium ? 14.0 : 16.0);
    final iconSize = isSmall ? 22.0 : (isMedium ? 24.0 : 26.0);
    final valueFontSize = isSmall ? 20.0 : (isMedium ? 22.0 : 24.0);
    final labelFontSize = isSmall ? 11.0 : 12.0;

    return Container(
      // width: double.infinity tetap dipertahankan karena widget ini
      // dipakai baik dalam Expanded (2-up) maupun standalone.
      width: double.infinity,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmall ? 18 : 22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: iconSize),
          SizedBox(height: isSmall ? 8 : 10),

          // FittedBox mencegah value overflow saat angka panjang
          // di layar sempit / kolom 2-up.
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              maxLines: 1,
              style: TextStyle(
                fontSize: valueFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: labelFontSize,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),

          if (bottomWidget != null) ...[
            SizedBox(height: isSmall ? 10 : 14),
            bottomWidget!,
          ],
        ],
      ),
    );
  }
}