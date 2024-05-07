import 'package:flutter/material.dart';

class FigmaButton extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final bool isDiactivated;

  const FigmaButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.isDiactivated = false,
  });

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(vertical: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
    );

    if (isDiactivated) {
      buttonStyle = ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.onInverseSurface,
      );
    }

    return ElevatedButton(
      onPressed: isDiactivated ? () {} : onPressed,
      style: buttonStyle,
      child: Text(
        label,
        style: const TextStyle().copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
