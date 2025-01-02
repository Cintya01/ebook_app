import 'package:ebook_app/model/book_model.dart';
import 'package:ebook_app/pages/bloc/ebookapp_bloc.dart';
import 'package:ebook_app/pages/main_page.dart';
import 'package:ebook_app/widgets/app_colors.dart';
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
          return Center(child: CircularProgressIndicator());
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
                  //book
                  SizedBox(
                    height: size.height * 0.35,
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

                  // body

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
                            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Continue Reading",
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600)),
                                    Icon(Icons.more_horiz,
                                        color: AppColor.white),
                                  ],
                                ),
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
        return Container();
      },
    );
  }
}
