import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class DetailBookPage extends StatelessWidget {
  const DetailBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Book"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.mediumGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
