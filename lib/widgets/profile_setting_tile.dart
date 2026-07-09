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
    final width = MediaQuery.sizeOf(context).width;
    final isSmall = width < 360;

    final avatarRadius = isSmall ? 19.0 : 22.0;
    final leadingIconSize = isSmall ? 18.0 : 20.0;
    final titleFontSize = isSmall ? 14.5 : 16.0;
    final subtitleFontSize = isSmall ? 12.0 : 13.0;
    final trailingIconSize = isSmall ? 20.0 : 24.0;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),

      // Radius & font dikecilkan sedikit di layar sempit supaya
      // title tetap muat 1 baris walau leading + trailing tetap ada.
      leading: CircleAvatar(
        radius: avatarRadius,
        backgroundColor: const Color(0xffF3F3F3),
        child: Icon(icon, color: Colors.black54, size: leadingIconSize),
      ),

      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: titleFontSize),
      ),

      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black54, fontSize: subtitleFontSize),
      ),

      trailing: Icon(Icons.chevron_right, size: trailingIconSize),

      onTap: onTap,
    );
  }
}
