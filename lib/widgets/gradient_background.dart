import 'dart:ui';
import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background base
        Positioned.fill(
          child: Container(
            color: const Color(0xFFF8FAFC), // A light background base
          ),
        ),
        // Gradient blobs with massive blur
        Positioned.fill(
          child: Opacity(
            opacity: 0.6, // Overall mask group opacity
            child: Stack(
              children: [
                // Blue blob
                Positioned(
                  top: 0,
                  left: -50,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF93BFFF).withValues(alpha: 0.4),
                    ),
                  ),
                ),
                // Green blob 1
                Positioned(
                  top: 150,
                  right: -50,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF4ADE80).withValues(alpha: 0.4),
                    ),
                  ),
                ),
                // Green blob 2
                Positioned(
                  bottom: -50,
                  left: 50,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF86EFAC).withValues(alpha: 0.4),
                    ),
                  ),
                ),
                // Dark green blob
                Positioned(
                  bottom: 100,
                  right: -100,
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF22C55E).withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Apply huge blur to the blobs
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 105, sigmaY: 105),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
        // Content
        Positioned.fill(child: child),
      ],
    );
  }
}
