import 'package:ebook_app/pages/bloc/ebookapp_bloc.dart';
import 'package:ebook_app/pages/primary_pages/main_page.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/book_card.dart';
import 'package:ebook_app/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreBooks extends StatelessWidget {
  const MoreBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookappBloc>()..add(LoadMoreBooksEvent()),
      child: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: GenericAppBar(
          leadingIcon: Icons.arrow_back,
          actionIcon: Icons.more_horiz_outlined,
          title: "More Books",
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
              (route) => false,
            );
          }),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: BlocBuilder<EbookappBloc, EbookappState>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: state.books.length,
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
    );
  }
}
