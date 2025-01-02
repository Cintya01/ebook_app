part of 'ebookapp_bloc.dart';

enum HomeScreenState {
  none,
  loading,
  sucess,
  error,
}

enum MoreBooksScreenState {
  none,
  loading,
  sucess,
  error,
}

enum DetailBooksScreenState {
  none,
  loading,
  sucess,
  error,
}

class EbookappState extends Equatable {
  final List<BookModel> books;
  final HomeScreenState homeScreenState;
  final MoreBooksScreenState moreBooksScreenState;
  final DetailBooksScreenState detailBooksScreenState;
  final BookModel? detailBook;

  const EbookappState({
    required this.books,
    required this.homeScreenState,
    required this.moreBooksScreenState,
    required this.detailBooksScreenState,
    this.detailBook,
  });

  factory EbookappState.initial() {
    return const EbookappState(
      books: [],
      homeScreenState: HomeScreenState.none,
      moreBooksScreenState: MoreBooksScreenState.none,
      detailBooksScreenState: DetailBooksScreenState.none,
      detailBook: null,
    );
  }

  EbookappState copyWith({
    List<BookModel>? books,
    HomeScreenState? homeScreenState,
    MoreBooksScreenState? moreBooksScreenState,
    DetailBooksScreenState? detailBooksScreenState,
    BookModel? detailBook,
  }) {
    return EbookappState(
      books: books ?? this.books,
      homeScreenState: homeScreenState ?? this.homeScreenState,
      moreBooksScreenState: moreBooksScreenState ?? this.moreBooksScreenState,
      detailBooksScreenState:
          detailBooksScreenState ?? this.detailBooksScreenState,
      detailBook: detailBook ?? this.detailBook,
    );
  }

  @override
  List<Object> get props =>
      [books, homeScreenState, moreBooksScreenState, detailBooksScreenState, detailBook ?? ''];
}
