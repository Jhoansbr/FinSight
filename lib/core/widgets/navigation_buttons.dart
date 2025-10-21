import 'package:flutter/material.dart';

class NavigationButtons extends StatelessWidget {
  final bool showPrevious;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final String previousText;
  final String nextText;
  final Color? primaryColor;

  const NavigationButtons({
    super.key,
    required this.showPrevious,
    required this.onPrevious,
    required this.onNext,
    this.previousText = "Anterior",
    this.nextText = "Siguiente",
    this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (showPrevious)
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.grey.shade100,
              foregroundColor: Colors.black87,
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onPrevious,
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 16),
            label: Text(previousText,
                style: const TextStyle(fontWeight: FontWeight.w500)),
          )
        else
          const SizedBox(width: 120),

        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: primaryColor ?? const Color(0xFF647DEE),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: onNext,
          label: Text(
            nextText,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          icon: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        ),
      ],
    );
  }
}
