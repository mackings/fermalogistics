class Product {
  final String id;
  final String userId;
  final String categoryId;
  final String productName;
  final List<String> productImages;
  final int price;
  final int vatAmount;
  final String taxClass;
  final String sku;
  final int quantity;
  final String variation;
  final int weight;
  final int height;
  final int width;
  final int? length;
  final int quantitySold;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.productName,
    required this.productImages,
    required this.price,
    required this.vatAmount,
    required this.taxClass,
    required this.sku,
    required this.quantity,
    required this.variation,
    required this.weight,
    required this.height,
    required this.width,
    this.length,
    required this.quantitySold,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? 'N/A',
      userId: json['userId'] ?? 'N/A',
      categoryId: json['categoryId'] ?? 'N/A',
      productName: json['productName'] ?? 'N/A',
      productImages: json['productImages'] != null
          ? List<String>.from(json['productImages'])
          : [],
      price: json['price'] ?? 0,
      vatAmount: json['vatAmount'] ?? 0,
      taxClass: json['taxClass'] ?? 'N/A',
      sku: json['sku'] ?? 'N/A',
      quantity: json['quantity'] ?? 0,
      variation: json['variation'] ?? 'N/A',
      weight: json['weight'] ?? 0,
      height: json['height'] ?? 0,
      width: json['width'] ?? 0,
      length: json['length'] ?? 0,
      quantitySold: json['quantitySold'] ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  // Helper methods to display "N/A" if data is null
  String get displayCategoryId => categoryId.isNotEmpty ? categoryId : 'N/A';
  String get displayProductName => productName.isNotEmpty ? productName : 'N/A';
  String get displaySku => sku.isNotEmpty ? sku : 'N/A';
  String get displayTaxClass => taxClass.isNotEmpty ? taxClass : 'N/A';
  String get displayVariation => variation.isNotEmpty ? variation : 'N/A';
}
