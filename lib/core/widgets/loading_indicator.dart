import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';

class LoadingIndicator extends StatelessWidget {
  final String? message;

  const LoadingIndicator({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RepaintBoundary(child: const CircularProgressIndicator()),
          if (message != null) ...[
            const SizedBox(height: AppDimensions.spacingMedium),
            Text(message!, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }
}
