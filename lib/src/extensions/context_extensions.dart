import 'package:flutter/widgets.dart';

extension MDQ on BuildContext {
  /// The same of [MediaQuery.of(context).size]
  Size get mediaQuerySize => MediaQuery.of(this).size;

  /// The same of [MediaQuery.of(context).size.height]
  /// Note: updates when you rezise your screen (like on a browser or desktop window)
  double get height => mediaQuerySize.height;

  /// The same of [MediaQuery.of(context).size.width]
  /// Note: updates when you rezise your screen (like on a browser or desktop window)
  double get width => mediaQuerySize.width;

  /// Gives you the power to get a portion of the height.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you would get
  /// like for example: if you want a value that represents a third of the screen
  /// you can set it to 3, and you will get a third of the height
  ///
  /// [reducedBy] is a percentage value of how much of the height you want
  /// if you for example want 46% of the height, then you reduce it by 56%.
  double heightTransformer({double dividedBy = 1, double reducedBy = 0.0}) {
    return (mediaQuerySize.height -
            ((mediaQuerySize.height / 100) * reducedBy)) /
        dividedBy;
  }

  /// Gives you the power to get a portion of the width.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you would get
  /// like for example: if you want a value that represents a third of the screen
  /// you can set it to 3, and you will get a third of the width
  ///
  /// [reducedBy] is a percentage value of how much of the width you want
  /// if you for example want 46% of the width, then you reduce it by 56%.
  double widthTransformer({double dividedBy = 1, double reducedBy = 0.0}) {
    return (mediaQuerySize.width - ((mediaQuerySize.width / 100) * reducedBy)) /
        dividedBy;
  }

  /// TODO: make docs about that
  double ratio({
    double dividedBy = 1,
    double reducedByW = 0.0,
    double reducedByH = 0.0,
  }) {
    return heightTransformer(dividedBy: dividedBy, reducedBy: reducedByH) /
        widthTransformer(dividedBy: dividedBy, reducedBy: reducedByW);
  }

  /// similar to `MediaQuery.of(this).padding`.
  EdgeInsets get mediaQueryPadding => MediaQuery.of(this).padding;

  /// similar to `MediaQuery.of(this).viewPadding`.
  EdgeInsets get mediaQueryViewPadding => MediaQuery.of(this).viewPadding;

  /// similar to `MediaQuery.of(this).viewInsets`.
  EdgeInsets get mediaQueryViewInsets => MediaQuery.of(this).viewInsets;

  /// similar to `MediaQuery.of(this).orientation`.
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// check if device is on LANDSCAPE mode.
  bool get isLandscape => orientation == Orientation.landscape;

  /// check if device is on PORTRAIT mode.
  bool get isPortrait => orientation == Orientation.portrait;

  /// similar to `MediaQuery.of(this).devicePixelRatio`.
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// similar to `MediaQuery.of(this).textScaleFactor`.
  double get textScaleFactor => MediaQuery.of(this).textScaleFactor;

  /// get the `shortestSide` from screen.
  double get mediaQueryShortestSide => mediaQuerySize.shortestSide;

  /// True if `width` is larger than 800p.
  bool get showNavbar => (width > 800);

  /// True if the `shortestSide` is smaller than 600p.
  bool get isPhone => (mediaQueryShortestSide < 600);

  /// True if the `shortestSide` is largest than 600p.
  bool get isSmallTablet => (mediaQueryShortestSide >= 600);

  /// True if the `shortestSide` is largest than 720p.
  bool get isLargeTablet => (mediaQueryShortestSide >= 720);

  /// True if the current device is TABLET.
  bool get isTablet => isSmallTablet || isLargeTablet;
}
