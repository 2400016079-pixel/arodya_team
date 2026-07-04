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

        width: 170,
        padding: const EdgeInsets.all(18),

        decoration: BoxDecoration(
          color: selected
              ? const Color(0xffE7F0EA)
              : const Color(0xffF4F4F4),

          borderRadius: BorderRadius.circular(18),

          border: Border.all(
            color: selected
                ? const Color(0xff5A845F)
                : Colors.transparent,
          ),
        ),

        child: Row(

          children: [

            CircleAvatar(
              radius: 26,
              backgroundColor: Colors.white,

              child: Icon(
                icon,
                color: const Color(0xff5A845F),
              ),
            ),

            const SizedBox(width: 14),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  amount,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}