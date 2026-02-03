import 'package:flutter/material.dart';

extension ImageExtension on String {
  // Validators
  bool get isValidUrl {
    final urlPattern = RegExp(
      r'^(http|https):\/\/([\w.]+\/?)\S*$',
      caseSensitive: false,
    );
    return urlPattern.hasMatch(this);
  }

  bool get isValidImageUrl {
    final imagePattern = RegExp(
      r'\.(jpg|jpeg|png|gif|bmp|webp|svg)$',
      caseSensitive: false,
    );
    return isValidUrl && imagePattern.hasMatch(this.toLowerCase());
  }

  bool get isValidAssetPath {
    return isNotEmpty && !startsWith('http');
  }

  // Default error builder
  static Widget _defaultErrorBuilder(
    BuildContext context,
    Object error,
    StackTrace? stackTrace, {
    IconData? customIcon,
    double? iconSize,
    Color? iconColor,
  }) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Center(
      child: Icon(
        customIcon ?? Icons.image_not_supported,
        size: iconSize ?? (isMobile ? 30 : 40),
        color: iconColor ?? Colors.grey,
      ),
    );
  }

  // Default loading builder
  static Widget _defaultLoadingBuilder(
    BuildContext context,
    Widget child,
    ImageChunkEvent? loadingProgress,
  ) {
    if (loadingProgress == null) return child;
    return Center(
      child: CircularProgressIndicator(
        value: loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes!
            : null,
      ),
    );
  }

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
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
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
      errorBuilder:
          errorBuilder ??
          (context, error, stackTrace) => _defaultErrorBuilder(
            context,
            error,
            stackTrace,
            customIcon: errorIcon,
            iconSize: errorIconSize,
            iconColor: errorIconColor,
          ),
    );
  }

  // Network image
  Image get networkImage => Image.network(
    this,
    errorBuilder: _defaultErrorBuilder,
    loadingBuilder: _defaultLoadingBuilder,
  );

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
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
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
      errorBuilder:
          errorBuilder ??
          (context, error, stackTrace) => _defaultErrorBuilder(
            context,
            error,
            stackTrace,
            customIcon: errorIcon,
            iconSize: errorIconSize,
            iconColor: errorIconColor,
          ),
      loadingBuilder: loadingBuilder ?? _defaultLoadingBuilder,
    );
  }

  // Safe network image (validates URL before loading)
  Widget toSafeNetworkImage({
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
    String? fallbackAssetImage,
  }) {
    if (!isValidUrl) {
      // If not a valid URL, try to load as asset if fallback provided
      if (fallbackAssetImage != null) {
        return Image.asset(
          fallbackAssetImage,
          width: width,
          height: height,
          fit: fit,
        );
      }
      // Return error widget
      return Builder(
        builder: (context) => _defaultErrorBuilder(
          context,
          'Invalid URL',
          null,
          customIcon: errorIcon,
          iconSize: errorIconSize,
          iconColor: errorIconColor,
        ),
      );
    }

    return Image.network(
      this,
      width: width,
      height: height,
      fit: fit,
      errorBuilder:
          errorBuilder ??
          (context, error, stackTrace) => _defaultErrorBuilder(
            context,
            error,
            stackTrace,
            customIcon: errorIcon,
            iconSize: errorIconSize,
            iconColor: errorIconColor,
          ),
      loadingBuilder: loadingBuilder ?? _defaultLoadingBuilder,
    );
  }

  // Circle avatar from asset
  CircleAvatar toCircleAvatar({
    double? radius,
    Color? backgroundColor,
    Color? foregroundColor,
    Widget? errorWidget,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      backgroundImage: AssetImage(this),
      onBackgroundImageError: errorWidget != null
          ? (exception, stackTrace) {}
          : null,
      child: errorWidget,
    );
  }

  // Circle avatar from network
  CircleAvatar toNetworkCircleAvatar({
    double? radius,
    Color? backgroundColor,
    Color? foregroundColor,
    IconData? errorIcon,
  }) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey[300],
      foregroundColor: foregroundColor,
      backgroundImage: isValidUrl ? NetworkImage(this) : null,
      child: !isValidUrl ? Icon(errorIcon ?? Icons.person, size: radius) : null,
    );
  }

  // Rounded image from asset
  Widget toRoundedImage({
    double? width,
    double? height,
    double borderRadius = 8,
    BoxFit fit = BoxFit.cover,
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        this,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _defaultErrorBuilder(
          context,
          error,
          stackTrace,
          customIcon: errorIcon,
          iconSize: errorIconSize,
          iconColor: errorIconColor,
        ),
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
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        this,
        width: width,
        height: height,
        fit: fit,
        errorBuilder:
            errorBuilder ??
            (context, error, stackTrace) => _defaultErrorBuilder(
              context,
              error,
              stackTrace,
              customIcon: errorIcon,
              iconSize: errorIconSize,
              iconColor: errorIconColor,
            ),
        loadingBuilder: loadingBuilder ?? _defaultLoadingBuilder,
      ),
    );
  }

  // Circle image from asset
  Widget toCircleImage({
    double? size,
    BoxFit fit = BoxFit.cover,
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
  }) {
    return ClipOval(
      child: Image.asset(
        this,
        width: size,
        height: size,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _defaultErrorBuilder(
          context,
          error,
          stackTrace,
          customIcon: errorIcon,
          iconSize: errorIconSize,
          iconColor: errorIconColor,
        ),
      ),
    );
  }

  // Circle network image
  Widget toCircleNetworkImage({
    double? size,
    BoxFit fit = BoxFit.cover,
    Widget Function(BuildContext, Object, StackTrace?)? errorBuilder,
    Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder,
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
  }) {
    return ClipOval(
      child: Image.network(
        this,
        width: size,
        height: size,
        fit: fit,
        errorBuilder:
            errorBuilder ??
            (context, error, stackTrace) => _defaultErrorBuilder(
              context,
              error,
              stackTrace,
              customIcon: errorIcon,
              iconSize: errorIconSize,
              iconColor: errorIconColor,
            ),
        loadingBuilder: loadingBuilder ?? _defaultLoadingBuilder,
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
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
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
            ? Image.network(
                this,
                fit: fit,
                errorBuilder: (context, error, stackTrace) =>
                    _defaultErrorBuilder(
                      context,
                      error,
                      stackTrace,
                      customIcon: errorIcon,
                      iconSize: errorIconSize,
                      iconColor: errorIconColor,
                    ),
                loadingBuilder: _defaultLoadingBuilder,
              )
            : Image.asset(
                this,
                fit: fit,
                errorBuilder: (context, error, stackTrace) =>
                    _defaultErrorBuilder(
                      context,
                      error,
                      stackTrace,
                      customIcon: errorIcon,
                      iconSize: errorIconSize,
                      iconColor: errorIconColor,
                    ),
              ),
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
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow:
            shadows ??
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
            ? Image.network(
                this,
                fit: fit,
                errorBuilder: (context, error, stackTrace) =>
                    _defaultErrorBuilder(
                      context,
                      error,
                      stackTrace,
                      customIcon: errorIcon,
                      iconSize: errorIconSize,
                      iconColor: errorIconColor,
                    ),
                loadingBuilder: _defaultLoadingBuilder,
              )
            : Image.asset(
                this,
                fit: fit,
                errorBuilder: (context, error, stackTrace) =>
                    _defaultErrorBuilder(
                      context,
                      error,
                      stackTrace,
                      customIcon: errorIcon,
                      iconSize: errorIconSize,
                      iconColor: errorIconColor,
                    ),
              ),
      ),
    );
  }

  // Image as background with child
  Widget asBackground({
    required Widget child,
    BoxFit fit = BoxFit.cover,
    AlignmentGeometry alignment = Alignment.center,
    bool isNetwork = false,
    Widget? errorWidget,
  }) {
    if (isNetwork && !isValidUrl && errorWidget != null) {
      return Stack(
        children: [
          Positioned.fill(child: errorWidget),
          child,
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: isNetwork
              ? NetworkImage(this)
              : AssetImage(this) as ImageProvider,
          fit: fit,
          alignment: alignment,
          onError: errorWidget != null ? (exception, stackTrace) {} : null,
        ),
      ),
      child: child,
    );
  }

  // Image provider
  ImageProvider get assetImageProvider => AssetImage(this);
  ImageProvider get networkImageProvider => NetworkImage(this);

  // Safe image provider (validates before creating)
  ImageProvider? get safeNetworkImageProvider =>
      isValidUrl ? NetworkImage(this) : null;
}

// Extension for Image widget
extension ImageWidgetExtension on Image {
  // Add rounded corners
  Widget rounded(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
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
  Widget withShadow({double borderRadius = 8, List<BoxShadow>? shadows}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow:
            shadows ??
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
    return SizedBox(width: width, height: height, child: this);
  }

  // Square size
  Widget square(double size) {
    return SizedBox(width: size, height: size, child: this);
  }
}
