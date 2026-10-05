/// PrimaryButton — Full-width themed button with an integrated loading state.
library;

import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
  });

  final String label;

  /// Callback invoked when the button is tapped.
  /// Pass [null] or rely on [isLoading] to disable the button.
  final VoidCallback? onPressed;

  /// When [true] the button shows a circular progress indicator
  /// and ignores taps (automatically disabled).
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
      // Disable while loading
      onPressed: isLoading ? null : onPressed,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: isLoading
            ? SizedBox(
                key: const ValueKey('loader'),
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: colorScheme.onPrimary,
                ),
              )
            : Text(
                label,
                key: const ValueKey('label'),
              ),
      ),
    );
  }
}
