/// ErrorBanner — Inline dismissible error message strip.
library;

import 'package:flutter/material.dart';

class ErrorBanner extends StatelessWidget {
  const ErrorBanner({
    super.key,
    required this.message,
    this.onDismiss,
  });

  /// The error text to display. If null/empty the banner is hidden.
  final String? message;

  /// Optional callback when the user taps the dismiss icon.
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.isEmpty) return const SizedBox.shrink();

    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(message),
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: colorScheme.error.withValues(alpha: 0.10),
          border: Border.all(
              color: colorScheme.error.withValues(alpha: 0.40)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.error_outline,
                color: colorScheme.error, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.error,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            if (onDismiss != null) ...[
              const SizedBox(width: 4),
              GestureDetector(
                onTap: onDismiss,
                child: Icon(Icons.close,
                    size: 18, color: colorScheme.error),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
