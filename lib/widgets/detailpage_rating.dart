import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

class DetailpageRating extends StatelessWidget {
  const DetailpageRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: AppColor.lightGrey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Rating",
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Text("4.5",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ]),
              Text("|",
                  style: TextStyle(fontSize: 30, color: AppColor.mediumGrey)),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Number of Pages",
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Text("300",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ]),
              Text("|",
                  style: TextStyle(fontSize: 30, color: AppColor.mediumGrey)),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text("Language",
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 5),
                Text("ESP",
                    style:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Siglo XIV. La ciudad de Barcelona se encuentra en su momento de mayor prosperidad; ha crecido hacia la Ribera, el humilde barrio ...",
          style: TextStyle(color: AppColor.darkGrey, fontSize: 14),
        )
      ],
    );
  }
}
