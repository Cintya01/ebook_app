import 'package:ebook_app/pages/bloc/ebookapp_bloc.dart';
import 'package:ebook_app/pages/primary_pages/main_page.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: GenericAppBar(
          leadingIcon: Icons.arrow_back,
          actionIcon: Icons.more_horiz_outlined,
          title: "My Bookmarks",
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
            if (state.favorites.isEmpty) {
              return Center(
                child: Text("No bookmarks"),
              );
            }
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final product = state.favorites[index];
                return _buildList(context, product);
              },
            );
          })),
    );
  }

  Widget _buildList(BuildContext context, product) {
    return Container(
      height: 120,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.mediumGrey,
              image: DecorationImage(
                image: NetworkImage(product.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.title,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppColor.darkGrey)),
              Text(
                product.author,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.mediumGrey),
              ),
            ],
          )),
          IconButton(
            onPressed: () {
              context.read<EbookappBloc>().add(ToggleFavorite(product.id));
            },
            icon: Icon(Icons.bookmark_remove_rounded),
          ),
        ],
      ),
    );
  }
}
