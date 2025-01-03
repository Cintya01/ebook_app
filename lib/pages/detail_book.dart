import 'dart:developer';

import 'package:ebook_app/pages/bloc/ebookapp_bloc.dart';
import 'package:ebook_app/pages/main_page.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/detailpage_rating.dart';
import 'package:ebook_app/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBookPage extends StatelessWidget {
  final String bookId;

  const DetailBookPage({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookappBloc>()
        ..add(LoadDetailBookEvent(bookId: bookId)),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<EbookappBloc, EbookappState>(
      builder: (context, state) {
        if (state.detailBooksScreenState == DetailBooksScreenState.loading) {
          return Material(child: Center(child: CircularProgressIndicator()));
        }
        if (state.detailBooksScreenState == DetailBooksScreenState.sucess) {
          final detailBook = state.detailBook;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.3,
                    1
                  ],
                  colors: [
                    AppColor.white,
                    AppColor.mediumGrey,
                  ]),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: GenericAppBar(
                  leadingIcon: Icons.arrow_back,
                  actionIcon: Icons.share_outlined,
                  title: "Detail Book",
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainPage()),
                      (route) => false,
                    );
                  }),
              body: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.37,
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      width: 150,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(detailBook!.imageUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                        height: size.height * 0.65,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //precio
                                Text("\$ ${detailBook.price.toString()}",
                                    style: TextStyle(
                                        color: AppColor.darkGreen,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600)),
                                //nombre, autor y bookmark
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(detailBook.title,
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600)),
                                        Text(detailBook.author,
                                            style: TextStyle(
                                                color: AppColor.mediumGrey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                    CircleAvatar(
                                      backgroundColor: detailBook.isFavorite
                                          ? AppColor.orange
                                          : AppColor.darkGreen,
                                      child: IconButton(
                                          onPressed: () {
                                            context.read<EbookappBloc>().add(
                                                ToggleFavorite(detailBook.id));
                                          },
                                          icon: Icon(Icons.bookmark),
                                          color: AppColor.white,
                                          iconSize: 20),
                                    ),
                                  ],
                                ),
                                //rating estatico
                                const SizedBox(height: 20),
                                DetailpageRating(),
                                // botones
                                const SizedBox(height: 20),
                                _bottomButtons(),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _bottomButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 38,
          width: 200,
          color: AppColor.lightGrey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "QTY",
                style: TextStyle(
                    color: AppColor.mediumGrey, fontWeight: FontWeight.w600),
              ),
              Text("|",
                  style: TextStyle(fontSize: 20, color: AppColor.mediumGrey)),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.remove),
                color: AppColor.mediumGrey,
              ),
              Text("1",
                  style: TextStyle(
                      color: AppColor.darkGreen, fontWeight: FontWeight.w700)),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
                color: AppColor.mediumGrey,
              ),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {},
          child: Text("Add to Cart",
              style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
        )
      ],
    );
  }
}
