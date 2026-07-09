import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final Widget child;

  const StatCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Skala padding & radius berdasarkan lebar layar
    final horizontalPadding = width < 360 ? 16.0 : (width < 400 ? 20.0 : 24.0);
    final radius = width < 360 ? 22.0 : 30.0;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(horizontalPadding),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: child,
    );
  }
}