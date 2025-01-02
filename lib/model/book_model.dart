import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final double price;
  final int quantity;

  const BookModel(
      {required this.id,
      required this.title,
      required this.author,
      required this.imageUrl,
      required this.price,
      this.quantity = 1});

  BookModel copyWith({
    String? id,
    String? title,
    String? author,
    String? imageUrl,
    double? price,
    int? quantity,
  }) {
    return BookModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object> get props => [id, title, author, imageUrl, price, quantity];
}
