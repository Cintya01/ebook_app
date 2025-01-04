import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/card_reading.dart';
import 'package:flutter/material.dart';

class ReadingPage extends StatelessWidget {
  const ReadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            Positioned(
                child: Container(
                    height: size.height * 0.875,
                    decoration: BoxDecoration(
                      color: AppColor.darkGreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Continue Reading",
                                  style: TextStyle(
                                      color: AppColor.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.75,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return CardReading(pagehost: "ReadingPage");
                              },
                            ),
                          ),
                        ],
                      ),
                    ))),
            Positioned(
              top: size.height * 0.84,
              bottom: 0,
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
