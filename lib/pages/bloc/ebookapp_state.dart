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
  final List<BookModel> detailBooks;
  final List<BookModel> favorites;
  final List<BookModel> cart;
  final HomeScreenState homeScreenState;
  final MoreBooksScreenState moreBooksScreenState;
  final DetailBooksScreenState detailBooksScreenState;

  const EbookappState({
    required this.books,
    required this.homeScreenState,
    required this.moreBooksScreenState,
    required this.detailBooksScreenState,
    required this.detailBooks,
    required this.cart,
    required this.favorites,
  });

  factory EbookappState.initial() {
    return const EbookappState(
      books: [],
      favorites: [],
      detailBooks: [],
      homeScreenState: HomeScreenState.none,
      moreBooksScreenState: MoreBooksScreenState.none,
      detailBooksScreenState: DetailBooksScreenState.none,
      cart: [],
    );
  }

  EbookappState copyWith({
    List<BookModel>? books,
    List<BookModel>? favorites,
    List<BookModel>? detailBooks,
    List<BookModel>? cart,
    HomeScreenState? homeScreenState,
    MoreBooksScreenState? moreBooksScreenState,
    DetailBooksScreenState? detailBooksScreenState,
  }) {
    return EbookappState(
      books: books ?? this.books,
      favorites: favorites ?? this.favorites,
      homeScreenState: homeScreenState ?? this.homeScreenState,
      moreBooksScreenState: moreBooksScreenState ?? this.moreBooksScreenState,
      detailBooksScreenState:
          detailBooksScreenState ?? this.detailBooksScreenState,
      detailBooks: detailBooks ?? this.detailBooks,
      cart: cart ?? this.cart,
    );
  }

  @override
  List<Object> get props => [
        books,
        homeScreenState,
        moreBooksScreenState,
        detailBooksScreenState,
        detailBooks,
        cart,
      ];
}
