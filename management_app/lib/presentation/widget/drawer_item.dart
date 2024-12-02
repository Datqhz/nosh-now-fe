import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem(
      {super.key,
      required this.title,
      required this.onTap,
      required this.icon});

  String title;
  IconData icon;
  VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
          weight: 600,
          size: 22,
        ),
        title: Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
        ),
        titleAlignment: ListTileTitleAlignment.center,
        minLeadingWidth: 24,
        onTap: onTap,
      ),
    );
  }
}
