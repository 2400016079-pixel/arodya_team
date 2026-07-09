import 'package:flutter/material.dart';

class TargetCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String value;
  final String unit;
  final double sliderValue;
  final double min;
  final double max;
  final String minLabel;
  final String maxLabel;

  const TargetCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.unit,
    required this.sliderValue,
    required this.min,
    required this.max,
    required this.minLabel,
    required this.maxLabel,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmall = screenWidth < 360;
    final isMedium = screenWidth < 400;

    final cardPadding = isSmall ? 18.0 : (isMedium ? 22.0 : 26.0);
    final headerIconSize = isSmall ? 26.0 : (isMedium ? 30.0 : 34.0);
    final titleFontSize = isSmall ? 20.0 : (isMedium ? 24.0 : 28.0);
    final valueFontSize = isSmall ? 40.0 : (isMedium ? 47.0 : 54.0);
    final unitFontSize = isSmall ? 20.0 : (isMedium ? 24.0 : 28.0);
    final labelFontSize = isSmall ? 13.0 : 14.0;

    return Container(
      padding: EdgeInsets.all(cardPadding),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isSmall ? 22 : 30),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: headerIconSize),

              SizedBox(width: isSmall ? 8 : 12),

              // Flexible + ellipsis: title custom dari user bisa
              // panjang dan tadinya bisa overflow di HP sempit.
              Flexible(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: isSmall ? 28 : 40),

          Center(
            // FittedBox mencegah overflow horizontal kalau value
            // punya banyak digit (mis. "2500" dibanding "8").
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: value,
                      style: TextStyle(
                        fontSize: valueFontSize,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff4F7F5D),
                      ),
                    ),

                    TextSpan(
                      text: " $unit",
                      style: TextStyle(
                        fontSize: unitFontSize,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: isSmall ? 20 : 30),

          Slider(
            value: sliderValue,
            min: min,
            max: max,
            activeColor: const Color(0xff4F7F5D),
            inactiveColor: const Color(0xffE5EFE8),
            onChanged: (_) {},
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  minLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: labelFontSize,
                  ),
                ),
              ),

              SizedBox(width: isSmall ? 8 : 12),

              Flexible(
                child: Text(
                  maxLabel,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: labelFontSize,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
