import 'package:flutter/material.dart';
import 'package:getnamibia/Views/Tracking/Model/scanmodel.dart';
import 'package:getnamibia/Views/widgets/button.dart';
import 'package:getnamibia/Views/widgets/texts.dart';
import 'package:intl/intl.dart';


class ProductDetailsModal extends StatelessWidget {
  final Product product;

  const ProductDetailsModal({Key? key, required this.product}) : super(key: key);

  String formatDate(String date) {
    try {
      final parsedDate = DateTime.parse(date);
      return DateFormat("d, MMMM yyyy").format(parsedDate); // e.g., 12, July 2025
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0.00');

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Close icon
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(Icons.close, size: 28),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Product Image
            if (product.productImages.isNotEmpty)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    product.productImages.first,
                    height: 160,
                    width: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            // Product Name & Price
            Center(
              child: Column(
                children: [
                  CustomText(
                    text: product.productName,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                  const SizedBox(height: 6),
                  CustomText(
                    text: "\$${formatter.format(product.price)}",
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _sectionWithDivider(
              title: "Product Information",
              children: [
                _infoRow(Icons.category, "Category", product.categoryName),
               // _infoRow(Icons.qr_code, "Barcode", product.barcode),
                _infoRow(Icons.confirmation_number, "SKU", product.sku),
                _infoRow(Icons.receipt_long, "Tax Class", product.taxClass),
                _infoRow(Icons.inventory_2, "Available", "${product.quantity}"),
                _infoRow(Icons.shopping_cart_checkout, "Sold", "${product.quantitySold}"),
              ],
            ),

            _sectionWithDivider(
              title: "Dimensions & Specs",
              children: [
                _infoRow(Icons.scale, "Weight", "${product.weight} kg"),
                _infoRow(Icons.square_foot, "Size", "${product.length} × ${product.width} × ${product.height} cm"),
                _infoRow(Icons.public, "Origin", product.countryOfOrigin),
              ],
            ),

            _sectionWithDivider(
              title: "Additional Details",
              children: [
                _infoRow(Icons.percent, "VAT", "${product.vatAmount}%"),
                _infoRow(Icons.money_off, "Discount", "${product.discount}%"),
              ],
            ),

            _sectionWithDivider(
              title: "Description",
              children: [
                CustomText(
                  text: product.description,
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ],
            ),

            _sectionWithDivider(
              title: "Timestamps",
              children: [
                _infoRow(Icons.calendar_today, "Created", formatDate(product.createdAt)),
                _infoRow(Icons.update, "Updated", formatDate(product.updatedAt)),
              ],
            ),

            const SizedBox(height: 20),

            CustomButton(
              text: "Done",
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Expanded(
            flex: 4,
            child: CustomText(
              text: "$label:",
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          Expanded(
            flex: 6,
            child: CustomText(
              text: value,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomText(
        text: title,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _sectionWithDivider({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(title),
        const SizedBox(height: 6),
        ...children,
        const SizedBox(height: 12),
        const Divider(),
        const SizedBox(height: 12),
      ],
    );
  }
}
