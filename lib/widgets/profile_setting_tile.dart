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
      contentPadding: const EdgeInsets.symmetric(vertical: 2),

      // Radius 28 (56px) + bold 22px title + 17px subtitle was too
      // wide for the space left after the leading icon and trailing
      // chevron on narrow screens, forcing titles onto 2 lines.
      leading: CircleAvatar(
        radius: 22,
        backgroundColor: const Color(0xffF3F3F3),
        child: Icon(icon, color: Colors.black54, size: 20),
      ),

      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),

      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black54, fontSize: 13),
      ),

      trailing: const Icon(Icons.chevron_right, size: 24),

      onTap: onTap,
    );
  }
}