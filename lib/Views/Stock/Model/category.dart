

class Category {

  final String id;
  final String userId;
  final String category;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'],
      userId: json['userId'],
      category: json['category'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}



// class Category {

//   final String id;
//   final String userId;
//   final String categoryId;
//   final String categoryName;
//   final String productName;
//   final String? description;
//   final List<String> productImages;
//   final double price;
//   final double vatAmount;
//   final double discount;
//   final int quantitySold;
//   final String taxClass;
//   final String sku;
//   final int quantity;
//   final List<String> variation;
//   final double weight;
//   final double height;
//   final double length;
//   final double width;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Category({
//     required this.id,
//     required this.userId,
//     required this.categoryId,
//     required this.categoryName,
//     required this.productName,
//     this.description,
//     required this.productImages,
//     required this.price,
//     required this.vatAmount,
//     required this.discount,
//     required this.quantitySold,
//     required this.taxClass,
//     required this.sku,
//     required this.quantity,
//     required this.variation,
//     required this.weight,
//     required this.height,
//     required this.length,
//     required this.width,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Category.fromJson(Map<String, dynamic> json) {
//     return Category(
//       id: json['_id'],
//       userId: json['userId'],
//       categoryId: json['categoryId'],
//       categoryName: json['categoryName'],
//       productName: json['productName'],
//       description: json['description'],
//       productImages: List<String>.from(json['productImages']),
//       price: (json['price'] as num).toDouble(),
//       vatAmount: (json['vatAmount'] as num).toDouble(),
//       discount: (json['discount'] as num).toDouble(),
//       quantitySold: json['quantitySold'],
//       taxClass: json['taxClass'],
//       sku: json['sku'],
//       quantity: json['quantity'],
//       variation: List<String>.from(json['variation'].map((v) => v.toString())),
//       weight: (json['weight'] as num).toDouble(),
//       height: (json['height'] as num).toDouble(),
//       length: (json['length'] as num).toDouble(),
//       width: (json['width'] as num).toDouble(),
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//     );
//   }
// }
