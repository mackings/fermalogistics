import 'package:fama/Views/Stock/Widgets/widgetviews/texts.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';


class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final dynamic price;
  final double rating;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.price,
    required this.rating,
  }) : super(key: key);


String formatPrice(dynamic price) {
  try {
    if (price == null) return "₦0";

    // Remove currency symbol, comma, spaces
    String cleaned = price.toString().replaceAll(RegExp(r'[₦,\s]'), '');

    double parsedPrice = double.tryParse(cleaned) ?? 0.0;

    // Use NumberFormat to format with commas
    final formatter = NumberFormat("#,##0", "en_NG");

    return "₦${formatter.format(parsedPrice)}";
  } catch (e) {
    return "₦0";
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    width: 42.w,
                    height: 20.h,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image, size: 42.w, color: Colors.grey);
                    },
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                      size: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ProductText(
                  text: productName,
                  fontSize: 8.sp,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 12.sp,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            CustomText(
              text: formatPrice(price),
              fontSize: 10.sp,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}

