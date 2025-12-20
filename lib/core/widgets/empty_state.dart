import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyState({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingMedium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIcon(context),
            const SizedBox(height: AppDimensions.spacingMedium),
            _buildMessage(context),
            if (_hasAction) ...[
              const SizedBox(height: AppDimensions.spacingMedium),
              _buildActionButton(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Icon(
      icon,
      size: AppDimensions.iconXLarge,
      color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.5),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _buildActionButton() {
    return ElevatedButton(onPressed: onAction, child: Text(actionText!));
  }

  bool get _hasAction => actionText != null && onAction != null;
}
