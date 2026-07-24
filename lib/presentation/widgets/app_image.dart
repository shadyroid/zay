import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

enum AppImageShape { rectangle, rounded, circle }

class AppImage extends StatelessWidget {
  const AppImage.network(
    this._source, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = AppImageShape.rectangle,
    this.borderRadius = 8,
    this.colorFilter,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.errorWidget,
  }) : _type = _AppImageType.network;

  const AppImage.file(
    dynamic file, {
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = AppImageShape.rectangle,
    this.borderRadius = 8,
    this.colorFilter,
    this.shimmerBaseColor,
    this.shimmerHighlightColor,
    this.errorWidget,
  })  : _type = _AppImageType.file,
        _source = file;

  final dynamic _source;
  final _AppImageType _type;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AppImageShape shape;
  final double borderRadius;
  final ColorFilter? colorFilter;
  final Color? shimmerBaseColor;
  final Color? shimmerHighlightColor;
  final Widget? errorWidget;

  static bool isSvg(String path) => path.toLowerCase().endsWith('.svg');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: _clipShape(_buildImage(context)),
    );
  }

  Widget _clipShape(Widget child) {
    return switch (shape) {
      AppImageShape.circle => ClipOval(child: child),
      AppImageShape.rounded => ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: child,
        ),
      AppImageShape.rectangle => child,
    };
  }

  Widget _buildImage(BuildContext context) {
    return switch (_type) {
      _AppImageType.network => _buildNetwork(context),
      _AppImageType.file => _buildFile(),
    };
  }

  Widget _buildNetwork(BuildContext context) {
    final url = _source as String;
    if (isSvg(url)) {
      return SvgPicture.network(
        url,
        width: width,
        height: height,
        fit: fit,
        colorFilter: colorFilter,
        placeholderBuilder: (_) => _shimmer(context),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: width,
      height: height,
      fit: fit,
      placeholder: (_, _) => _shimmer(context),
      errorWidget: (_, _, _) => _error(context),
    );
  }

  Widget _buildFile() {
    final file = _source is File ? _source : File(_source as String);
    final path = file.path;

    if (isSvg(path)) {
      return SvgPicture.file(
        file,
        width: width,
        height: height,
        fit: fit,
        colorFilter: colorFilter,
      );
    }

    return Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, _, _) => _error(null),
    );
  }

  Widget _shimmer(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final base = shimmerBaseColor ??
        (isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0));
    final highlight = shimmerHighlightColor ??
        (isDark ? const Color(0xFF4A5568) : const Color(0xFFF7FAFC));

    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      child: ColoredBox(
        color: base,
        child: const SizedBox.expand(),
      ),
    );
  }

  Widget _error(BuildContext? context) {
    if (errorWidget != null) return errorWidget!;

    final isDark = context != null &&
        Theme.of(context).brightness == Brightness.dark;

    return ColoredBox(
      color: isDark ? const Color(0xFF2D3748) : const Color(0xFFE2E8F0),
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          color: Color(0xFF9CA3AF),
        ),
      ),
    );
  }
}

enum _AppImageType { network, file }
