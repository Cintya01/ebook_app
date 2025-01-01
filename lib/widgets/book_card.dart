import 'package:ebook_app/pages/detail_book.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailBookPage()));
      },
      child: Container(
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
            Text(author,
                style: TextStyle(color: AppColor.mediumGrey, fontSize: 12)),
            Text(title,
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
