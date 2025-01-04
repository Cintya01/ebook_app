import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ebook_app/model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ebookapp_event.dart';
part 'ebookapp_state.dart';

const homeUrl = "https://ebook-app-adl-default-rtdb.firebaseio.com/books";
const cartUrl = "https://ebook-app-adl-default-rtdb.firebaseio.com/cart";

class EbookappBloc extends Bloc<EbookappEvent, EbookappState> {
  var dio = Dio();
  var uuid = Uuid();

  EbookappBloc() : super(EbookappState.initial()) {
    on<LoadBooksEvent>(_onLoadBooksEvent);
    on<LoadMoreBooksEvent>(_onMoreBooksEvent);
    on<LoadDetailBookEvent>(_onLoadDetailBookEvent);
    on<ToggleFavorite>(_onToggleFavorite);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<LoadCartItemsEvent>(_onLoadCartItemsEvent);
    on<RemoveFromCartEvent>(_onRemoveFromCartEvent);
    on<IncreaseQuantityCartEvent>(_onIncreaseQuantityCartEvent);
    on<DecreaseQuantityCartEvent>(_onDecreaseQuantityCartEvent);
    on<IncreaseQuantityDetailEvent>(_onIncreaseQuantityDetailEvent);
    on<DecreaseQuantityDetailEvent>(_onDecreaseQuantityDetailEvent);
  }

  void _onLoadBooksEvent(
      LoadBooksEvent event, Emitter<EbookappState> emit) async {
    emit(state.copyWith(homeScreenState: HomeScreenState.loading));

    final response = await dio.get('$homeUrl.json');
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(
        state.copyWith(
          homeScreenState: HomeScreenState.error,
          books: [],
        ),
      );
      return;
    }

    final books = data.entries.map((b) {
      return BookModel(
        author: b.value['author'],
        id: b.value['id'],
        imageUrl: b.value['image_url'],
        price: double.parse(b.value['price'].toString()),
        title: b.value['title'],
        bookmarked: b.value['bookmarked'],
        quantity: b.value['quantity'],
      );
    }).toList();

    emit(
      state.copyWith(
        homeScreenState: HomeScreenState.sucess,
        books: books,
      ),
    );
  }

  void _onMoreBooksEvent(
      LoadMoreBooksEvent event, Emitter<EbookappState> emit) async {
    emit(state.copyWith(moreBooksScreenState: MoreBooksScreenState.loading));

    final response = await dio.get('$homeUrl.json');
    final data = response.data as Map<String, dynamic>?;

    if (data == null || data.isEmpty) {
      emit(
        state.copyWith(
          homeScreenState: HomeScreenState.error,
          books: [],
        ),
      );
      return;
    }

    final books = data.entries.map((b) {
      return BookModel(
        author: b.value['author'],
        id: b.value['id'],
        imageUrl: b.value['image_url'],
        price: double.parse(b.value['price'].toString()),
        title: b.value['title'],
        bookmarked: b.value['bookmarked'],
      );
    }).toList();

    emit(
      state.copyWith(
        homeScreenState: HomeScreenState.sucess,
        books: books,
      ),
    );
  }

  void _onLoadDetailBookEvent(
      LoadDetailBookEvent event, Emitter<EbookappState> emit) async {
    emit(
        state.copyWith(detailBooksScreenState: DetailBooksScreenState.loading));

    final response = await dio.get('$homeUrl.json');
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(
        detailBooks: [],
      ));
      return;
    }

    final detailItems = data.entries.map((b) {
      return BookModel(
        author: b.value['author'],
        id: b.value['id'],
        imageUrl: b.value['image_url'],
        price: double.parse(b.value['price'].toString()),
        title: b.value['title'],
        quantity: b.value['quantity'],
        bookmarked: b.value['bookmarked'],
      );
    }).toList();

    emit(state.copyWith(
      detailBooksScreenState: DetailBooksScreenState.sucess,
      detailBooks: detailItems,
    ));
  }

  void _onToggleFavorite(
      ToggleFavorite event, Emitter<EbookappState> emit) async {
    final books = state.detailBooks.map((b) {
      if (b.id == event.bookId) {
        return b.copyWith(bookmarked: !b.bookmarked);
      }
      return b;
    }).toList();
    //seecciona el libro a marcar como favorito
    final updatedBookStatus = books.firstWhere((b) => b.id == event.bookId);

    if (updatedBookStatus.bookmarked) {
      await dio.patch('$homeUrl/${updatedBookStatus.id}.json', data: {
        'bookmarked': true,
      });
      emit(state.copyWith(
        detailBooks: books,
        books: books,
        favorites: [...state.favorites, updatedBookStatus],
      ));
    } else {
      await dio.patch('$homeUrl/${updatedBookStatus.id}.json', data: {
        'bookmarked': false,
      });
      emit(state.copyWith(
        books: books,
        favorites:
            state.favorites.where((b) => b.id != updatedBookStatus.id).toList(),
      ));
    }
    final bookmarkedBooks = [...state.favorites];

    emit(state.copyWith(
      detailBooks: books,
      books: books,
      favorites: bookmarkedBooks,
    ));
  }

  void _onIncreaseQuantityDetailEvent(
      IncreaseQuantityDetailEvent event, Emitter<EbookappState> emit) {
    final update = state.detailBooks.map((p) {
      if (p.id == event.productBook.id && p.quantity < 5) {
        return p.copyWith(quantity: p.quantity + 1);
      }
      return p;
    }).toList();

    emit(state.copyWith(detailBooks: update));
  }

  void _onDecreaseQuantityDetailEvent(
      DecreaseQuantityDetailEvent event, Emitter<EbookappState> emit) {
    final update = state.detailBooks.map((p) {
      if (p.id == event.productBook.id) {
        return p.copyWith(quantity: p.quantity - 1);
      }
      return p;
    }).toList();
    

    emit(state.copyWith(detailBooks: update));
  }

  void _onLoadCartItemsEvent(
      LoadCartItemsEvent event, Emitter<EbookappState> emit) async {
    final response = await dio.get('$cartUrl.json');
    final data = response.data as Map<String, dynamic>?;

    if (data == null) {
      emit(state.copyWith(cart: []));
      return;
    }

    final cartItems = data.entries.map((b) {
      return BookModel(
        id: b.value['id'],
        title: b.value['title'],
        author: b.value['author'],
        price: double.parse(b.value['price'].toString()),
        imageUrl: b.value['imageUrl'],
        quantity: b.value['quantity'] ?? 1,
      );
    }).toList();

    emit(state.copyWith(cart: cartItems));
  }

  void _onAddToCartEvent(
      AddToCartEvent event, Emitter<EbookappState> emit) async {
    final BookModel productBook = event.productBook;

    final existItemIndex = state.cart.indexWhere((b) => b.id == productBook.id);

    if (existItemIndex >= 0) {
      final productItem = state.cart[existItemIndex];
      final newQuantity = productItem.quantity + 1;

      await dio.patch(
        "$cartUrl/${productBook.id}.json",
        data: {
          "quantity": newQuantity,
        },
      );

      final updateCart = [...state.cart];
      updateCart[existItemIndex] = productItem.copyWith(quantity: newQuantity);

      emit(state.copyWith(cart: updateCart));
    } else {
      await dio.put(
        "$cartUrl/${productBook.id}.json",
        data: {
          "id": productBook.id,
          "title": productBook.title,
          "author": productBook.author,
          "price": productBook.price,
          "imageUrl": productBook.imageUrl,
          "quantity": 1,
        },
      );
      final updateCart = [...state.cart, productBook];
      emit(state.copyWith(cart: updateCart));
    }
  }

  void _onRemoveFromCartEvent(
      RemoveFromCartEvent event, Emitter<EbookappState> emit) async {
    final BookModel productBook = event.productBook;

    await dio.delete("$cartUrl/${productBook.id}.json");
    final updateCart = state.cart.where((b) => b.id != productBook.id).toList();

    emit(state.copyWith(cart: updateCart));
  }

  void _onIncreaseQuantityCartEvent(
      IncreaseQuantityCartEvent event, Emitter<EbookappState> emit) {
    final updateCart = state.cart.map((p) {
      if (p.id == event.productBook.id) {
        return p.copyWith(quantity: p.quantity + 1);
      }
      return p;
    }).toList();

    emit(state.copyWith(cart: updateCart));
  }

  void _onDecreaseQuantityCartEvent(
      DecreaseQuantityCartEvent event, Emitter<EbookappState> emit) {
    final updateCart = state.cart.map((p) {
      if (p.id == event.productBook.id && p.quantity > 1) {
        return p.copyWith(quantity: p.quantity - 1);
      }
      return p;
    }).toList();

    emit(state.copyWith(cart: updateCart));
  }
}
