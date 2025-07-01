import 'package:flutter/material.dart';

Future<void> showResponseDialog({
  required BuildContext context,
  required String title,
  required String message,
  bool isSuccess = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false, // User must tap close icon to dismiss
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              // Content Column
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Icon(
                    isSuccess ? Icons.check_circle_outline : Icons.error_outline,
                    size: 64,
                    color: isSuccess ? Colors.green : Colors.red,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
              // Close button top right
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                  splashRadius: 20,
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
