import 'package:flutter/material.dart';
import 'package:management_app/presentation/widget/bottom_bar_item.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key, required this.items});

  List<BottomBarItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items,
      ),
    );
  }
}
