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
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
          ),
        ],
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 32,
            backgroundColor: iconBg,

            child: Icon(
              icon,
              color: iconColor,
              size: 34,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 4),

                RichText(
                  text: TextSpan(
                    children: [

                      TextSpan(
                        text: value,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextSpan(
                        text: " $unit",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.show_chart,
            size: 38,
            color: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}