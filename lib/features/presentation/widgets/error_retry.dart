// error_retry_widget.dart
import 'package:flutter/material.dart';

class ErrorRetryWidget extends StatelessWidget {
  final dynamic error;
  final VoidCallback onRetry;

  ErrorRetryWidget({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Error: $error'),
          ElevatedButton(
            onPressed: onRetry,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}
