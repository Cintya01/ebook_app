import 'package:ebook_app/pages/bloc/ebookapp_bloc.dart';
import 'package:ebook_app/pages/secondary_pages/cart_page.dart';
import 'package:ebook_app/pages/secondary_pages/mantainer.dart';
import 'package:ebook_app/pages/secondary_pages/more_books.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/book_card.dart';
import 'package:ebook_app/widgets/card_reading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//PRIMERA PAGINA DE LA APLICACION
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookappBloc>()..add(LoadBooksEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 28;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        toolbarHeight: size.height * 0.05,
        backgroundColor: AppColor.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Mantainer()));
              },
              icon:
                  Icon(Icons.settings, size: iconSize, color: AppColor.orange)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
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
          _searchBar(size),
          // list book view
          _bookCarrousel(context, size),
          // continue reading
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Stack(
              children: [
                _continueReading(size),
                Positioned(
                  top: size.height * 0.24,
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
        ],
      ),
    );
  }

  Widget _searchBar(size) {
    return Container(
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
                style: TextStyle(color: AppColor.mediumGrey, fontSize: 18)),
          ),
          Icon(Icons.mic_outlined, color: AppColor.darkGrey),
        ],
      ),
    );
  }

  Widget _bookCarrousel(BuildContext context, Size size) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Trending Books",
                  style: TextStyle(
                      color: AppColor.darkGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MoreBooks()));
                },
                child: Text("View more",
                    style: TextStyle(
                        color: AppColor.darkGrey,
                        fontSize: 16,
                        fontWeight: FontWeight.normal)),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.35,
            child: BlocBuilder<EbookappBloc, EbookappState>(
              builder: (context, state) {
                if (state.homeScreenState == HomeScreenState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return BookCard(
                      title: book.title,
                      author: book.author,
                      imageUrl: book.imageUrl,
                      id: book.id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _continueReading(size) {
    return Container(
        height: size.height * 0.28,
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
                  Icon(Icons.more_horiz, color: AppColor.white),
                ],
              ),
              const SizedBox(height: 10),
              CardReading(
                pagehost: "HomePage",
              )
            ],
          ),
        ));
  }
}
