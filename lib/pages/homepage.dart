import 'package:ebook_app/widgets/app_colors.dart';
import 'package:flutter/material.dart';

//PRIMERA PAGINA DE LA APLICACION
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, dynamic>> bookData = [
    {
      "title": "Harry Potter",
      "author": "JK Rowling",
      "image": "",
    },
    {
      "title": "Lauren Ipsum",
      "author": "lauren ipsum",
      "image": "",
    },
    {
      "title": "La Catedral del Mar",
      "author": "Idelfonso Falcones",
      "image": "",
    },
    {
      "title": "La Islas",
      "author": "Carolina",
      "image": "",
    },
    {
      "title": "Jardin Secreto",
      "author": "Johanna Basford",
      "image": "",
    },
    {
      "title": "Divergente",
      "author": "Veronica Roth",
      "image": "",
    },
  ];

  @override
  Widget build(BuildContext context) {
    const double iconSize = 32;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: AppColor.white,
        appBar: AppBar(
          toolbarHeight: size.height * 0.1,
          backgroundColor: AppColor.white,
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.settings, size: iconSize, color: AppColor.orange),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shopping_bag_outlined,
                          size: iconSize, color: AppColor.darkGrey)),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: AppColor.orange,
                    child: Icon(Icons.person, color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ),
        body: Column(
          children: [
            //search bar
            Container(
              height: size.height * 0.07,
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
              decoration: BoxDecoration(
                color: AppColor.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: AppColor.darkGrey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text("Search",
                        style: TextStyle(
                            color: AppColor.mediumGrey, fontSize: 18)),
                  ),
                  Icon(Icons.mic_outlined, color: AppColor.darkGrey),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("data"),
                  Text("data"),
                ],
              ),
            ),
            // list book view
            _imgCarrousel(size),
            //continue reading view
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Continue Reading",
                      style: TextStyle(
                          color: AppColor.darkGrey,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  Text("View All",
                      style: TextStyle(
                          color: AppColor.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _imgCarrousel(size) {
    return SizedBox(
      height: size.height * 0.35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          var book = bookData[index];
          return Container(
            margin: const EdgeInsets.all(10),
            width: 150,
            decoration: BoxDecoration(
              color: AppColor.lightGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColor.mediumGrey,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book["title"],
                          style:
                              TextStyle(color: AppColor.white, fontSize: 18)),
                      Text(book["author"],
                          style:
                              TextStyle(color: AppColor.white, fontSize: 14)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
