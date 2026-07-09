import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String text;

  const TagChip({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isSmall = screenWidth < 360;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 12.0 : 16.0,
        vertical: isSmall ? 6.0 : 8.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffE8EFEB),
        borderRadius: BorderRadius.circular(30),
      ),
      // Text dibungkus Flexible: berguna kalau TagChip nanti dipakai
      // dalam Row/Wrap dan tag custom dari user cukup panjang.
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: const Color(0xff35694A),
          fontWeight: FontWeight.w600,
          fontSize: isSmall ? 13.0 : 14.0,
        ),
      ),
    );
  }
}
