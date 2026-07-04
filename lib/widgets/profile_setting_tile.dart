import 'package:flutter/material.dart';

class ProfileSettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileSettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return ListTile(

      contentPadding:
          const EdgeInsets.symmetric(vertical: 8),

      leading: CircleAvatar(
        radius: 28,
        backgroundColor: const Color(0xffF3F3F3),

        child: Icon(
          icon,
          color: Colors.black54,
        ),
      ),

      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),

      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.black54,
          fontSize: 17,
        ),
      ),

      trailing: const Icon(
        Icons.chevron_right,
        size: 30,
      ),

      onTap: onTap,
    );
  }
}