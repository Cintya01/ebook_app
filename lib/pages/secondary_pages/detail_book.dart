import 'package:ebook_app/pages/bloc/ebookapp_bloc.dart';
import 'package:ebook_app/pages/primary_pages/main_page.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/detailpage_rating.dart';
import 'package:ebook_app/model/book_model.dart';
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
      child: Body(bookId: bookId),
    );
  }
}

class Body extends StatelessWidget {
  final String bookId;

  const Body({super.key, required this.bookId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<EbookappBloc, EbookappState>(
      builder: (context, state) {
        //loading
        if (state.detailBooksScreenState == DetailBooksScreenState.loading) {
          return Material(child: Center(child: CircularProgressIndicator()));
        }
        //success
        if (state.detailBooksScreenState == DetailBooksScreenState.sucess) {
          final detailBook = state.detailBooks.firstWhere((book) {
            return book.id == bookId;
          });

          return Scaffold(
            backgroundColor: AppColor.white,
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
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 1],
                  colors: [
                    AppColor.white,
                    AppColor.mediumGrey,
                  ],
                ),
              ),
              child: Column(
                children: [
                  _imgBook(imgUrl: detailBook.imageUrl, size: size),
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
                            children: [
                              _detailInfo(
                                  price: detailBook.price,
                                  title: detailBook.title,
                                  author: detailBook.author,
                                  bookmarked: detailBook.bookmarked,
                                  context: context,
                                  id: detailBook.id),
                              const SizedBox(height: 20),
                              DetailpageRating(),
                              // botones
                              const SizedBox(height: 20),
                              _bottomButtons(
                                  context: context, detailBook: detailBook),
                            ],
                          ),
                        ),
                      ),
                    ),
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

  Widget _imgBook({
    required String imgUrl,
    required Size size,
  }) {
    return SizedBox(
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
                    image: NetworkImage(imgUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailInfo({
    required double price,
    required String title,
    required String author,
    required bool bookmarked,
    required BuildContext context,
    required String id,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //precio
        Text("\$ ${price.toString()}",
            style: TextStyle(
                color: AppColor.darkGreen,
                fontSize: 16,
                fontWeight: FontWeight.w600)),
        //nombre, autor y bookmark
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        color: AppColor.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600)),
                Text(author,
                    style: TextStyle(
                        color: AppColor.mediumGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            GestureDetector(
              onTap: () => context.read<EbookappBloc>().add(ToggleFavorite(id)),
              child: CircleAvatar(
                backgroundColor:
                    bookmarked ? AppColor.orange : AppColor.darkGreen,
                child: Icon(Icons.bookmark, color: AppColor.white, size: 20),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _bottomButtons({
    required BuildContext context,
    required BookModel detailBook,
  }) {
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
                onPressed: () {
                  context.read<EbookappBloc>().add(
                      DecreaseQuantityDetailEvent(productBook: detailBook));
                },
                icon: Icon(Icons.remove),
                color: AppColor.mediumGrey,
              ),
              Text(detailBook.quantity.toString(),
                  style: TextStyle(
                      color: AppColor.darkGreen, fontWeight: FontWeight.w700)),
              IconButton(
                onPressed: () {
                  context.read<EbookappBloc>().add(
                      IncreaseQuantityDetailEvent(productBook: detailBook));
                },
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
          onPressed: () {
            context.read<EbookappBloc>().add(AddToCartEvent(
                productBook: detailBook, detailBook: detailBook));
          },
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
