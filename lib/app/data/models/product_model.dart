class ProductModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final double rating;
  final int reviews;
  bool isFavorite;
  String? size;
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviews,
    this.isFavorite = false,
    this.size,
    this.quantity = 0,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      image: map['image'] as String,
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
      reviews: map['reviews'] as int,
      isFavorite: map['isFavorite'] as bool? ?? false,
      size: map['size'] as String?,
      quantity: map['quantity'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'rating': rating,
      'reviews': reviews,
      'isFavorite': isFavorite,
      'size': size,
      'quantity': quantity,
    };
  }

  ProductModel copyWith({
    int? id,
    String? name,
    String? image,
    double? price,
    double? rating,
    int? reviews,
    bool? isFavorite,
    String? size,
    int? quantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      reviews: reviews ?? this.reviews,
      isFavorite: isFavorite ?? this.isFavorite,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviews: json['reviews'] as int,
      isFavorite: json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'rating': rating,
      'reviews': reviews,
      'is_favorite': isFavorite,
    };
  }
}
