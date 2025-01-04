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

class IncreaseQuantityDetailEvent extends EbookappEvent {
  final BookModel productBook;

  const IncreaseQuantityDetailEvent({required this.productBook});
}

class DecreaseQuantityDetailEvent extends EbookappEvent {
  final BookModel productBook;

  const DecreaseQuantityDetailEvent({required this.productBook});
}

class AddToCartEvent extends EbookappEvent {
  final BookModel productBook;
  final BookModel detailBook;

  const AddToCartEvent({required this.productBook, required this.detailBook});
}

class LoadCartItemsEvent extends EbookappEvent {}

class RemoveFromCartEvent extends EbookappEvent {
  final BookModel productBook;

  const RemoveFromCartEvent({required this.productBook});
}

class IncreaseQuantityCartEvent extends EbookappEvent {
  final BookModel productBook;

  const IncreaseQuantityCartEvent({required this.productBook});
}

class DecreaseQuantityCartEvent extends EbookappEvent {
  final BookModel productBook;

  const DecreaseQuantityCartEvent({required this.productBook});
}
