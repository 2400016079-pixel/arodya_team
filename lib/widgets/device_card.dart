import 'package:flutter/material.dart';

class DeviceCard extends StatelessWidget {
  final String title;
  final String status;
  final bool connected;
  final String imagePath;
  final VoidCallback? onPressed;
  final ValueChanged<bool>? onChanged;

  const DeviceCard({
    super.key,
    required this.title,
    required this.status,
    required this.connected,
    required this.imagePath,
    this.onPressed,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [

          CircleAvatar(
            radius: 34,
            backgroundColor: const Color(0xffF4F4F4),
            backgroundImage: AssetImage(imagePath),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  status,
                  style: TextStyle(
                    fontSize: 18,
                    color: connected
                        ? const Color(0xff35694A)
                        : Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),

              ],
            ),
          ),

          connected
              ? Switch(
                  value: true,
                  activeColor: Colors.white,
                  activeTrackColor: const Color(0xff4F7F5D),
                  onChanged: onChanged,
                )
              : OutlinedButton(
                  onPressed: onPressed,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xff35694A),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    "Hubungkan",
                    style: TextStyle(
                      color: Color(0xff35694A),
                      fontSize: 18,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}