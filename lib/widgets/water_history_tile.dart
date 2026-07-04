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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),

      child: Row(
        children: [

          CircleAvatar(
            radius: 28,
            backgroundColor: const Color(0xffE5EFE8),

            child: Icon(
              icon,
              color: const Color(0xff35694A),
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ),

          Text(
            amount,
            style: const TextStyle(
              color: Color(0xff35694A),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}