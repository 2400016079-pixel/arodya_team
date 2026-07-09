import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final bool selected;
  final VoidCallback onTap;

  const ContainerCard({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Fixed width removed: this card already sits inside an
        // Expanded in the parent Row, so it should fill whatever
        // space it's given instead of forcing 170px.
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xffE7F0EA) : const Color(0xffF4F4F4),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? const Color(0xff5A845F) : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: Icon(icon, size: 22, color: const Color(0xff5A845F)),
            ),
            const SizedBox(width: 10),
            // Expanded + ellipsis: text now shrinks/truncates instead
            // of pushing past the card's right edge.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    amount,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}