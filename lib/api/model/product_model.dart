// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  ProductModel({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductModel copyWith({
    List<Product>? products,
    int? total,
    int? skip,
    int? limit,
  }) =>
      ProductModel(
        products: products ?? this.products,
        total: total ?? this.total,
        skip: skip ?? this.skip,
        limit: limit ?? this.limit,
      );

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

class Product {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;
  int? quantity = 0;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images,
      this.quantity = 0});

  Product copyWith(
          {int? id,
          String? title,
          String? description,
          int? price,
          double? discountPercentage,
          double? rating,
          int? stock,
          String? brand,
          String? category,
          String? thumbnail,
          List<String>? images,
          int? quantity = 0}) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        stock: stock ?? this.stock,
        brand: brand ?? this.brand,
        category: category ?? this.category,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
        quantity: quantity ?? this.quantity,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      discountPercentage: json["discountPercentage"]?.toDouble(),
      rating: json["rating"]?.toDouble(),
      stock: json["stock"],
      brand: json["brand"],
      category: json["category"],
      thumbnail: json["thumbnail"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      quantity: json["quantity"] ?? 0);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "quantity": quantity ?? 0
      };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'brand': brand,
      'category': category,
      'thumbnail': thumbnail,
      'images': images?.join(','),
      "quantity": quantity ?? 0
      // Serialize List<String> to a comma-separated String
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        title: map['title'],
        description: map['description'],
        price: map['price'],
        discountPercentage: map['discountPercentage'],
        rating: map['rating'],
        stock: map['stock'],
        brand: map['brand'],
        category: map['category'],
        thumbnail: map['thumbnail'],
        images: map['images']?.split(','),
        quantity: map['quantity'] ?? 0);
  }
}
