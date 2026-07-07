import 'package:flutter/material.dart';

class TemperatureChip extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const TemperatureChip({
    super.key,
    required this.icon,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffE7F0EA) : const Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          // Centered + content shrunk to fit: previously this Row
          // defaulted to mainAxisAlignment.start with unconstrained
          // text, so icon+label together were wider than each
          // Expanded's 1/3 share of the row.
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: const Color(0xff5A845F)),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15, color: Color(0xff4A4A4A)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
