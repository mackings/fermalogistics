
class Product {
  
  final String id;
  final String userId;
  final String categoryId;
  final String? categoryName;
  final String productName;
  final List<String> productImages;
  final double price;
  final double vatAmount;
  final String taxClass;
  final String sku;
  final int quantity;
 // final List<String> variation;
  final double weight;
  final double height;
  final double width;
  final double? length;
  final int quantitySold;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? discount;
  final String? description;
  final String? barcode;

  Product({
    required this.id,
    required this.userId,
    required this.categoryId,
    this.categoryName,
    required this.productName,
    required this.productImages,
    required this.price,
    required this.vatAmount,
    required this.taxClass,
    required this.sku,
    required this.quantity,
   // required this.variation,
    required this.weight,
    required this.height,
    required this.width,
    this.length,
    required this.quantitySold,
    required this.createdAt,
    required this.updatedAt,
    this.discount,
    this.description,
    this.barcode
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      userId: json['userId'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      productName: json['productName'],
      productImages: List<String>.from(json['productImages']),
      price: json['price'].toDouble(),
      vatAmount: json['vatAmount'].toDouble(),
      taxClass: json['taxClass'],
      sku: json['sku'],
      quantity: json['quantity'],
     // variation: List<String>.from(json['variation'].map((v) => v.toString())),
      weight: json['weight'].toDouble(),
      height: json['height'].toDouble(),
      width: json['width'].toDouble(),
      length: json['length'] != null ? json['length'].toDouble() : null,
      quantitySold: json['quantitySold'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      discount: json['discount'] != null ? json['discount'].toDouble() : null,
      description: json['description'],
      barcode: json['barcode']
    );
  }
}


