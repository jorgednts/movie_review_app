import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.url,
    this.boxFit = BoxFit.cover,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
  });

  final String url;
  final BoxFit boxFit;
  final double? height;
  final double? width;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return url.isEmpty
        ? errorWidget ?? DefaultErrorWidget()
        : Image.network(
          url,
          fit: BoxFit.cover,
          height: height,
          width: width,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return placeholder ?? DefaultPlaceholder();
          },
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? DefaultErrorWidget();
          },
        );
  }
}
