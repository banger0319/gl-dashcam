import 'dart:ui';
import '../theme/app_colors.dart';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double blurAmount;
  final Border? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 12.0,
    this.padding,
    this.backgroundColor,
    this.blurAmount = 8.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.bgSurface,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border ?? Border.all(color: AppColors.borderDefault),
          ),
          child: child,
        ),
      ),
    );
  }
}
