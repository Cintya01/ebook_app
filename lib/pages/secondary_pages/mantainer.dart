import 'package:ebook_app/pages/primary_pages/main_page.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';

class Mantainer extends StatelessWidget {
  const Mantainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: GenericAppBar(
          leadingIcon: Icons.arrow_back,
          actionIcon: Icons.more_horiz_outlined,
          title: "Mantainer",
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
              (route) => false,
            );
          }),
    );
  }
}
