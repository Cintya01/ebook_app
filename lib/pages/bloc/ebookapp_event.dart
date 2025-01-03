part of 'ebookapp_bloc.dart';

sealed class EbookappEvent extends Equatable {
  const EbookappEvent();

  @override
  List<Object> get props => [];
}

class LoadBooksEvent extends EbookappEvent {}

class LoadMoreBooksEvent extends EbookappEvent {}

class LoadDetailBookEvent extends EbookappEvent {
  final String bookId;

  const LoadDetailBookEvent({required this.bookId});
}

class ToggleFavorite extends EbookappEvent {
  final String bookId;

  const ToggleFavorite(this.bookId);
}



// class AddToCartEvent extends EbookappEvent {
//   final BookModel product;

//   const AddToCartEvent({required this.product});
// }
