import 'package:flutter/material.dart';

class ProfileTextField extends StatelessWidget {
  final String label;
  final String hint;
  final bool readOnly;
  final Widget? suffix;

  const ProfileTextField({
    super.key,
    required this.label,
    required this.hint,
    this.readOnly = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 360;
    final isMedium = width < 400;

    final labelFontSize = isSmall ? 15.0 : (isMedium ? 16.0 : 18.0);
    final verticalPadding = isSmall ? 14.0 : (isMedium ? 17.0 : 20.0);
    final horizontalPadding = isSmall ? 14.0 : (isMedium ? 17.0 : 20.0);
    final radius = isSmall ? 14.0 : 18.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: labelFontSize,
            fontWeight: FontWeight.w600,
          ),
        ),

        SizedBox(height: isSmall ? 8 : 10),

        TextField(
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffix,
            contentPadding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
        ),

        SizedBox(height: isSmall ? 18 : 24),
      ],
    );
  }
}