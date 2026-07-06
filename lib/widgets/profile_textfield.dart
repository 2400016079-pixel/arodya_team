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

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height:10),

        TextField(

          readOnly: readOnly,

          decoration: InputDecoration(

            hintText: hint,

            suffixIcon: suffix,

            contentPadding: const EdgeInsets.symmetric(
              horizontal:20,
              vertical:20,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),

        const SizedBox(height:24),

      ],
    );
  }
}