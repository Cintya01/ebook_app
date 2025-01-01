import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class GenericAppBar extends StatelessWidget implements PreferredSizeWidget {
  final IconData leadingIcon;
  final IconData actionIcon;
  final String title;
  final VoidCallback onPressed;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  const GenericAppBar({
    super.key,
    required this.leadingIcon,
    required this.actionIcon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
            backgroundColor: AppColor.white,
            leading: IconButton(
                icon: Icon(
                  leadingIcon,
                  color: AppColor.darkGrey,
                  size: 28,
                ),
                onPressed: onPressed),
            title: Center(
              child: Text(title,
                  style: TextStyle(
                      color: AppColor.darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(actionIcon),
              )
            ]));
  }
}
