//import 'dart:developer';

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ebook_app/model/book_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ebookapp_event.dart';
part 'ebookapp_state.dart';

const homeUrl = "https://ebook-app-adl-default-rtdb.firebaseio.com/";

class EbookappBloc extends Bloc<EbookappEvent, EbookappState> {
  var dio = Dio();
  var uuid = Uuid();

  EbookappBloc() : super(EbookappState.initial()) {
    on<LoadBooksEvent>(_onLoadBooksEvent);
    on<LoadMoreBooksEvent>(_onMoreBooksEvent);
    on<LoadDetailBookEvent>(_onDetailBookEvent);
  }

  void _onLoadBooksEvent(
      LoadBooksEvent event, Emitter<EbookappState> emit) async {
    emit(state.copyWith(homeScreenState: HomeScreenState.loading));

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
      );
    }).toList();

    emit(
      state.copyWith(
        homeScreenState: HomeScreenState.sucess,
        books: books,
      ),
    );
  }

  void _onDetailBookEvent(
      LoadDetailBookEvent event, Emitter<EbookappState> emit) async {
    final bookId = event.bookId;
    try {
      final response = await dio.get('$homeUrl/$bookId.json');
      final data = response.data as Map<String, dynamic>?;

      if (data == null || data.isEmpty) {
        emit(state.copyWith(
          detailBooksScreenState: DetailBooksScreenState.error,
          detailBook: null,
        ));
        return;
      }

      final detailBook = BookModel(
        id: data['id'],
        title: data['title'],
        author: data['author'],
        imageUrl: data['image_url'],
        price: double.parse(data['price'].toString()),
      );

      emit(state.copyWith(
        detailBooksScreenState: DetailBooksScreenState.sucess,
        detailBook: detailBook,
      ));
    } catch (e) {
      emit(state.copyWith(
        detailBooksScreenState: DetailBooksScreenState.error,
        detailBook: null,
      ));
    }
  }
}
