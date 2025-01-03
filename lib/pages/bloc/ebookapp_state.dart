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
  final List<BookModel> favorites;
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
    required this.favorites,
  });

  factory EbookappState.initial() {
    return const EbookappState(
      books: [],
      favorites: [],
      homeScreenState: HomeScreenState.none,
      moreBooksScreenState: MoreBooksScreenState.none,
      detailBooksScreenState: DetailBooksScreenState.none,
      detailBook: null,
    );
  }

  EbookappState copyWith({
    List<BookModel>? books,
    List<BookModel>? favorites,
    HomeScreenState? homeScreenState,
    MoreBooksScreenState? moreBooksScreenState,
    DetailBooksScreenState? detailBooksScreenState,
    BookModel? detailBook,
  }) {
    return EbookappState(
      books: books ?? this.books,
      favorites: favorites ?? this.favorites,
      homeScreenState: homeScreenState ?? this.homeScreenState,
      moreBooksScreenState: moreBooksScreenState ?? this.moreBooksScreenState,
      detailBooksScreenState:
          detailBooksScreenState ?? this.detailBooksScreenState,
      detailBook: detailBook ?? this.detailBook,
    );
  }

  @override
  List<Object> get props => [
        books,
        homeScreenState,
        moreBooksScreenState,
        detailBooksScreenState,
        detailBook ?? ''
      ];
}
