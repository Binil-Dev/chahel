import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
  });
  final String title;
  final Widget? leading;
  final List<Widget>? trailing;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      forceElevated: true,
      pinned: true,
      leading: leading,
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      actions: trailing,
      elevation: 2, // Increase elevation
      shadowColor: Colors.black, // Set shadow color
      backgroundColor: Colors.grey[100],
      surfaceTintColor: Colors.white,
      toolbarHeight: 90,
    );
  }
}

// IconButton(
//           onPressed: () {}, icon: const Icon(Icons.arrow_back_ios_new_rounded)),