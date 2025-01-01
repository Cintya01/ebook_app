import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CardReading extends StatelessWidget {
  const CardReading({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          tileColor: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          leading: Icon(Icons.book_outlined),
          title: Text('Title'),
          subtitle: Text('Author'),
          trailing: CircularPercentIndicator(
            radius: 20,
            lineWidth: 4,
            percent: 0.65,
            center: Text(
              '65%',
              style: TextStyle(
                  fontSize: 12,
                  color: AppColor.orange,
                  fontWeight: FontWeight.bold),
            ),
            progressColor: AppColor.orange,
          )),
    );
  }
}
