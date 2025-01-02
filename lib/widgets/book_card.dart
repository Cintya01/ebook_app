import 'package:ebook_app/pages/detail_book.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  final String title;
  final String author;
  final String imageUrl;
  final String id;

  const BookCard({
    super.key,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => DetailBookPage(bookId: id)));
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
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text("by $author",
                style: TextStyle(
                    color: AppColor.mediumGrey,
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
            Text(title,
                style: TextStyle(
                    color: AppColor.darkGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
