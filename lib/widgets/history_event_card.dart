import 'package:flutter/material.dart';
import 'tag_chip.dart';

class HistoryEventCard extends StatelessWidget {

  final IconData icon;
  final Color iconBg;
  final Color iconColor;

  final String title;
  final String description;
  final String time;

  final List<String> tags;

  const HistoryEventCard({
    super.key,
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.description,
    required this.time,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(22),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0,8),
          ),
        ],
      ),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          CircleAvatar(
            radius: 34,
            backgroundColor: iconBg,

            child: Icon(
              icon,
              color: iconColor,
              size: 34,
            ),
          ),

          const SizedBox(width:20),

          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Row(

                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                  children: [

                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ],
                ),

                const SizedBox(height:10),

                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height:18),

                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: tags
                      .map((e)=>TagChip(text:e))
                      .toList(),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}