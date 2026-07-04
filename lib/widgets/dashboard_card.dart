import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final Color iconBackground;
  final Color iconColor;

  final String title;
  final String value;
  final String subtitle;

  final Color backgroundColor;
  final Color borderColor;

  final Widget? bottomWidget;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.iconBackground,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.backgroundColor,
    required this.borderColor,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: borderColor,
          width: 1.2,
        ),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              CircleAvatar(
                radius: 32,
                backgroundColor: iconBackground,

                child: Icon(
                  icon,
                  size: 32,
                  color: iconColor,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.75),
                  borderRadius: BorderRadius.circular(20),
                ),

                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 28),

          Text(
            value,
            style: const TextStyle(
              fontSize: 46,
              fontWeight: FontWeight.bold,
              color: Color(0xff012B20),
            ),
          ),

          const SizedBox(height: 6),

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),

          if (bottomWidget != null) ...[
            const SizedBox(height: 22),
            bottomWidget!,
          ]
        ],
      ),
    );
  }
}