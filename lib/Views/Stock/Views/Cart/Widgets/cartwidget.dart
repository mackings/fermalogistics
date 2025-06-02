import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';



class CartProductWidget extends StatefulWidget {
  final String productName;
  final String productImage;
  final num price; // Base price of a single item
  final int quantity;
  final VoidCallback onDelete;
  final Function(int) onQuantityChange;

  CartProductWidget({
    required this.productName,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.onDelete,
    required this.onQuantityChange,
  });

  @override
  _CartProductWidgetState createState() => _CartProductWidgetState();
}

class _CartProductWidgetState extends State<CartProductWidget> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  void _incrementQuantity() {
    setState(() {
      quantity++;
    });
    widget.onQuantityChange(quantity);
  }

  void _decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
      widget.onQuantityChange(quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    final totalPrice = (widget.price * quantity).toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.productImage,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.productName,
                        style: GoogleFonts.inter()
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: widget.onDelete,
                    ),
                  ],
                ),

                SizedBox(height: 20),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$$totalPrice', style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600
                    )),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: _decrementQuantity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.remove, color: Colors.red, size: 16),
                            ),
                          ),
                          SizedBox(width: 8),

                          Text(quantity.toString(), style: TextStyle(fontSize: 16)),
                          
                          SizedBox(width: 8),

                          GestureDetector(
                            onTap: _incrementQuantity,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.add, color: Colors.red, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
