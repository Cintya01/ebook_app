import 'dart:developer';

import 'package:ebook_app/model/book_model.dart';
import 'package:ebook_app/pages/bloc/ebookapp_bloc.dart';
import 'package:ebook_app/pages/primary_pages/main_page.dart';
import 'package:ebook_app/widgets/app_colors.dart';
import 'package:ebook_app/widgets/generic_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EbookappBloc>()..add(LoadCartItemsEvent()),
      child: const CartBody(),
    );
  }
}

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: GenericAppBar(
          leadingIcon: Icons.arrow_back,
          actionIcon: Icons.more_horiz_outlined,
          title: "Cart",
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
              (route) => false,
            );
          }),
      body: BlocBuilder<EbookappBloc, EbookappState>(
        builder: (context, state) {
          if (state.cart.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "Sin productos agregados al carrito de compras",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.darkGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }

          double totalAllBooks = state.cart
              .fold(0, (sum, p) => sum + (p.price ?? 0) * (p.quantity ?? 0));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Total: \$${totalAllBooks.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkGrey,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    final product = state.cart[index];
                    return _buildCartList(context, product);
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: AppColor.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "Checkout",
                style: TextStyle(
                    color: AppColor.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCartList(BuildContext context, BookModel product) {
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
          IconButton(
            onPressed: () {
              context
                  .read<EbookappBloc>()
                  .add(RemoveFromCartEvent(productBook: product));
            },
            icon: Icon(Icons.delete),
          ),
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
                Text(product.author,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColor.mediumGrey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: 120,
                      color: AppColor.lightGrey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              context.read<EbookappBloc>().add(
                                  DecreaseQuantityCartEvent(
                                      productBook: product));
                            },
                            icon: Icon(Icons.remove),
                          ),
                          Text(product.quantity.toString(),
                              style: TextStyle(
                                  color: AppColor.darkGreen,
                                  fontWeight: FontWeight.w700)),
                          IconButton(
                            onPressed: () {
                              context.read<EbookappBloc>().add(
                                  IncreaseQuantityCartEvent(
                                      productBook: product));
                            },
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                    Text("\$${product.price * product.quantity}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColor.darkGrey))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
