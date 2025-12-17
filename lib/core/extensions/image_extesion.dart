import 'package:flutter/material.dart';

extension ImageExtension on String {
  // Basic image from asset
  Image get image => Image.asset(this);

  // Image from asset with custom properties
  Image toImage({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    BlendMode? colorBlendMode,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    FilterQuality filterQuality = FilterQuality.low,
  }) {
    return Image.asset(
      this,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      repeat: repeat,
      filterQuality: filterQuality,
    );
  }

  // Network image
  Image get networkImage => Image.network(this);

  // Network image with custom properties
  Image toNetworkImage({
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    BlendMode? colorBlendMode,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    FilterQuality filterQuality = FilterQuality.low,
    Map<String, String>? headers,
    Widget Function(BuildContext, Widget, int?, bool)? frameBuilder,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
  }) {
    return Image.network(
      this,
      width: width,
      height: height,
      fit: fit,
      color: color,
      colorBlendMode: colorBlendMode,
      alignment: alignment,
      repeat: repeat,
      filterQuality: filterQuality,
      headers: headers,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      loadingBuilder: loadingBuilder,
    );
  }

  // Circle avatar from asset
  CircleAvatar toCircleAvatar({
    double? radius,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      backgroundImage: AssetImage(this),
    );
  }

  // Circle avatar from network
  CircleAvatar toNetworkCircleAvatar({
    double? radius,
    Color? backgroundColor,
    Color? foregroundColor,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      backgroundImage: NetworkImage(this),
    );
  }

  // Rounded image from asset
  Widget toRoundedImage({
    double? width,
    double? height,
    double borderRadius = 8,
    BoxFit fit = BoxFit.cover,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        this,
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }

  // Rounded network image
  Widget toRoundedNetworkImage({
    double? width,
    double? height,
    double borderRadius = 8,
    BoxFit fit = BoxFit.cover,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        this,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: errorBuilder,
        loadingBuilder: loadingBuilder,
      ),
    );
  }

  // Circle image from asset
  Widget toCircleImage({
    double? size,
    BoxFit fit = BoxFit.cover,
  }) {
    return ClipOval(
      child: Image.asset(
        this,
        width: size,
        height: size,
        fit: fit,
      ),
    );
  }

  // Circle network image
  Widget toCircleNetworkImage({
    double? size,
    BoxFit fit = BoxFit.cover,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
  }) {
    return ClipOval(
      child: Image.network(
        this,
        width: size,
        height: size,
        fit: fit,
        errorBuilder: errorBuilder,
        loadingBuilder: loadingBuilder,
      ),
    );
  }

  // Image with border
  Widget toImageWithBorder({
    double? width,
    double? height,
    double borderWidth = 2,
    Color borderColor = Colors.black,
    double borderRadius = 0,
    BoxFit fit = BoxFit.cover,
    bool isNetwork = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: isNetwork
            ? Image.network(this, fit: fit)
            : Image.asset(this, fit: fit),
      ),
    );
  }

  // Image with shadow
  Widget toImageWithShadow({
    double? width,
    double? height,
    double borderRadius = 8,
    BoxFit fit = BoxFit.cover,
    List<BoxShadow>? shadows,
    bool isNetwork = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: isNetwork
            ? Image.network(this, fit: fit)
            : Image.asset(this, fit: fit),
      ),
    );
  }

  // Image as background with child
  Widget asBackground({
    required Widget child,
    BoxFit fit = BoxFit.cover,
    AlignmentGeometry alignment = Alignment.center,
    bool isNetwork = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isNetwork ? NetworkImage(this) : AssetImage(this) as ImageProvider,
          fit: fit,
          alignment: alignment,
        ),
      ),
      child: child,
    );
  }

  // Image provider
  ImageProvider get assetImageProvider => AssetImage(this);
  ImageProvider get networkImageProvider => NetworkImage(this);
}

// Extension for Image widget
extension ImageWidgetExtension on Image {
  // Add rounded corners
  Widget rounded(double radius) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: this,
    );
  }

  // Make circular
  Widget circle() {
    return ClipOval(child: this);
  }

  // Add border
  Widget withBorder({
    double borderWidth = 2,
    Color borderColor = Colors.black,
    double borderRadius = 0,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: borderWidth),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: this,
      ),
    );
  }

  // Add shadow
  Widget withShadow({
    double borderRadius = 8,
    List<BoxShadow>? shadows,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows ??
            [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: this,
      ),
    );
  }

  // Set size
  Widget sized(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: this,
    );
  }

  // Square size
  Widget square(double size) {
    return SizedBox(
      width: size,
      height: size,
      child: this,
    );
  }
}
