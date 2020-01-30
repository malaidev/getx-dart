import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'routes.dart';
import 'snack_route.dart' as route;

typedef void SnackStatusCallback(SnackStatus status);
typedef void OnTap(GetBar snack);

// ignore: must_be_immutable
class GetBar<T extends Object> extends StatefulWidget {
  GetBar(
      {Key key,
      String title,
      String message,
      Widget titleText,
      Widget messageText,
      Widget icon,
      bool shouldIconPulse = true,
      double maxWidth,
      EdgeInsets margin = const EdgeInsets.all(0.0),
      EdgeInsets padding = const EdgeInsets.all(16),
      double borderRadius = 0.0,
      Color borderColor,
      double borderWidth = 1.0,
      Color backgroundColor = const Color(0xFF303030),
      Color leftBarIndicatorColor,
      List<BoxShadow> boxShadows,
      Gradient backgroundGradient,
      FlatButton mainButton,
      OnTap onTap,
      Duration duration,
      bool isDismissible = true,
      SnackDismissDirection dismissDirection = SnackDismissDirection.VERTICAL,
      bool showProgressIndicator = false,
      AnimationController progressIndicatorController,
      Color progressIndicatorBackgroundColor,
      Animation<Color> progressIndicatorValueColor,
      SnackPosition snackPosition = SnackPosition.BOTTOM,
      SnackStyle snackStyle = SnackStyle.FLOATING,
      Curve forwardAnimationCurve = Curves.easeOutCirc,
      Curve reverseAnimationCurve = Curves.easeOutCirc,
      Duration animationDuration = const Duration(seconds: 1),
      SnackStatusCallback onStatusChanged,
      double barBlur = 0.0,
      double overlayBlur = 0.0,
      Color overlayColor = Colors.transparent,
      Form userInputForm})
      : this.title = title,
        this.message = message,
        this.titleText = titleText,
        this.messageText = messageText,
        this.icon = icon,
        this.shouldIconPulse = shouldIconPulse,
        this.maxWidth = maxWidth,
        this.margin = margin,
        this.padding = padding,
        this.borderRadius = borderRadius,
        this.borderColor = borderColor,
        this.borderWidth = borderWidth,
        this.backgroundColor = backgroundColor,
        this.leftBarIndicatorColor = leftBarIndicatorColor,
        this.boxShadows = boxShadows,
        this.backgroundGradient = backgroundGradient,
        this.mainButton = mainButton,
        this.onTap = onTap,
        this.duration = duration,
        this.isDismissible = isDismissible,
        this.dismissDirection = dismissDirection,
        this.showProgressIndicator = showProgressIndicator,
        this.progressIndicatorController = progressIndicatorController,
        this.progressIndicatorBackgroundColor =
            progressIndicatorBackgroundColor,
        this.progressIndicatorValueColor = progressIndicatorValueColor,
        this.snackPosition = snackPosition,
        this.snackStyle = snackStyle,
        this.forwardAnimationCurve = forwardAnimationCurve,
        this.reverseAnimationCurve = reverseAnimationCurve,
        this.animationDuration = animationDuration,
        this.barBlur = barBlur,
        this.overlayBlur = overlayBlur,
        this.overlayColor = overlayColor,
        this.userInputForm = userInputForm,
        super(key: key) {
    this.onStatusChanged = onStatusChanged ?? (status) {};
  }

  /// A callback for you to listen to the different Snack status
  SnackStatusCallback onStatusChanged;

  /// The title displayed to the user
  final String title;

  /// The message displayed to the user.
  final String message;

  /// Replaces [title]. Although this accepts a [Widget], it is meant to receive [Text] or [RichText]
  final Widget titleText;

  /// Replaces [message]. Although this accepts a [Widget], it is meant to receive [Text] or  [RichText]
  final Widget messageText;

  /// Will be ignored if [backgroundGradient] is not null
  final Color backgroundColor;

  /// If not null, shows a left vertical colored bar on notification.
  /// It is not possible to use it with a [Form] and I do not recommend using it with [LinearProgressIndicator]
  final Color leftBarIndicatorColor;

  /// [boxShadows] The shadows generated by Snack. Leave it null if you don't want a shadow.
  /// You can use more than one if you feel the need.
  /// Check (this example)[https://github.com/flutter/flutter/blob/master/packages/flutter/lib/src/material/shadows.dart]
  final List<BoxShadow> boxShadows;

  /// Makes [backgroundColor] be ignored.
  final Gradient backgroundGradient;

  /// You can use any widget here, but I recommend [Icon] or [Image] as indication of what kind
  /// of message you are displaying. Other widgets may break the layout
  final Widget icon;

  /// An option to animate the icon (if present). Defaults to true.
  final bool shouldIconPulse;

  /// A [FlatButton] widget if you need an action from the user.
  final FlatButton mainButton;

  /// A callback that registers the user's click anywhere. An alternative to [mainButton]
  final OnTap onTap;

  /// How long until Snack will hide itself (be dismissed). To make it indefinite, leave it null.
  final Duration duration;

  /// True if you want to show a [LinearProgressIndicator].
  final bool showProgressIndicator;

  /// An optional [AnimationController] when you want to control the progress of your [LinearProgressIndicator].
  final AnimationController progressIndicatorController;

  /// A [LinearProgressIndicator] configuration parameter.
  final Color progressIndicatorBackgroundColor;

  /// A [LinearProgressIndicator] configuration parameter.
  final Animation<Color> progressIndicatorValueColor;

  /// Determines if the user can swipe or click the overlay (if [overlayBlur] > 0) to dismiss.
  /// It is recommended that you set [duration] != null if this is false.
  /// If the user swipes to dismiss or clicks the overlay, no value will be returned.
  final bool isDismissible;

  /// Used to limit Snack width (usually on large screens)
  final double maxWidth;

  /// Adds a custom margin to Snack
  final EdgeInsets margin;

  /// Adds a custom padding to Snack
  /// The default follows material design guide line
  final EdgeInsets padding;

  /// Adds a radius to all corners of Snack. Best combined with [margin].
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final double borderRadius;

  /// Adds a border to every side of Snack
  /// I do not recommend using it with [showProgressIndicator] or [leftBarIndicatorColor].
  final Color borderColor;

  /// Changes the width of the border if [borderColor] is specified
  final double borderWidth;

  /// Snack can be based on [SnackPosition.TOP] or on [SnackPosition.BOTTOM] of your screen.
  /// [SnackPosition.BOTTOM] is the default.
  final SnackPosition snackPosition;

  /// [SnackDismissDirection.VERTICAL] by default.
  /// Can also be [SnackDismissDirection.HORIZONTAL] in which case both left and right dismiss are allowed.
  final SnackDismissDirection dismissDirection;

  /// Snack can be floating or be grounded to the edge of the screen.
  /// If grounded, I do not recommend using [margin] or [borderRadius]. [SnackStyle.FLOATING] is the default
  /// If grounded, I do not recommend using a [backgroundColor] with transparency or [barBlur]
  final SnackStyle snackStyle;

  /// The [Curve] animation used when show() is called. [Curves.easeOut] is default
  final Curve forwardAnimationCurve;

  /// The [Curve] animation used when dismiss() is called. [Curves.fastOutSlowIn] is default
  final Curve reverseAnimationCurve;

  /// Use it to speed up or slow down the animation duration
  final Duration animationDuration;

  /// Default is 0.0. If different than 0.0, blurs only Snack's background.
  /// To take effect, make sure your [backgroundColor] has some opacity.
  /// The greater the value, the greater the blur.
  final double barBlur;

  /// Default is 0.0. If different than 0.0, creates a blurred
  /// overlay that prevents the user from interacting with the screen.
  /// The greater the value, the greater the blur.
  final double overlayBlur;

  /// Default is [Colors.transparent]. Only takes effect if [overlayBlur] > 0.0.
  /// Make sure you use a color with transparency here e.g. Colors.grey[600].withOpacity(0.2).
  final Color overlayColor;

  /// A [TextFormField] in case you want a simple user input. Every other widget is ignored if this is not null.
  final Form userInputForm;

  route.SnackRoute<T> _snackRoute;

  /// Show the snack. Kicks in [SnackStatus.IS_APPEARING] state followed by [SnackStatus.SHOWING]
  Future<T> show() async {
    _snackRoute = route.showSnack<T>(
      snack: this,
    );
    return await Get.key.currentState.push(_snackRoute);
  }

  /// Dismisses the snack causing is to return a future containing [result].
  /// When this future finishes, it is guaranteed that Snack was dismissed.
  Future<T> dismiss([T result]) async {
    // If route was never initialized, do nothing
    if (_snackRoute == null) {
      return null;
    }

    if (_snackRoute.isCurrent) {
      _snackRoute.navigator.pop(result);
      return _snackRoute.completed;
    } else if (_snackRoute.isActive) {
      // removeRoute is called every time you dismiss a Snack that is not the top route.
      // It will not animate back and listeners will not detect SnackStatus.IS_HIDING or SnackStatus.DISMISSED
      // To avoid this, always make sure that Snack is the top route when it is being dismissed
      _snackRoute.navigator.removeRoute(_snackRoute);
    }

    return null;
  }

  /// Checks if the snack is visible
  bool isShowing() {
    return _snackRoute?.currentStatus == SnackStatus.SHOWING;
  }

  /// Checks if the snack is dismissed
  bool isDismissed() {
    return _snackRoute?.currentStatus == SnackStatus.DISMISSED;
  }

  @override
  State createState() {
    return _GetBarState<T>();
  }
}

class _GetBarState<K extends Object> extends State<GetBar>
    with TickerProviderStateMixin {
  SnackStatus currentStatus;

  AnimationController _fadeController;
  Animation<double> _fadeAnimation;

  final Widget _emptyWidget = SizedBox(width: 0.0, height: 0.0);
  final double _initialOpacity = 1.0;
  final double _finalOpacity = 0.4;

  final Duration _pulseAnimationDuration = Duration(seconds: 1);

  bool _isTitlePresent;
  double _messageTopMargin;

  FocusScopeNode _focusNode;
  FocusAttachment _focusAttachment;

  @override
  void initState() {
    super.initState();

    assert(
        ((widget.userInputForm != null ||
            ((widget.message != null && widget.message.isNotEmpty) ||
                widget.messageText != null))),
        "A message is mandatory if you are not using userInputForm. Set either a message or messageText");

    _isTitlePresent = (widget.title != null || widget.titleText != null);
    _messageTopMargin = _isTitlePresent ? 6.0 : widget.padding.top;

    _configureLeftBarFuture();
    _configureProgressIndicatorAnimation();

    if (widget.icon != null && widget.shouldIconPulse) {
      _configurePulseAnimation();
      _fadeController?.forward();
    }

    _focusNode = FocusScopeNode();
    _focusAttachment = _focusNode.attach(context);
  }

  @override
  void dispose() {
    _fadeController?.dispose();

    widget.progressIndicatorController?.removeListener(_progressListener);
    widget.progressIndicatorController?.dispose();

    _focusAttachment.detach();
    _focusNode.dispose();
    super.dispose();
  }

  final Completer<Size> _boxHeightCompleter = Completer<Size>();

  void _configureLeftBarFuture() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        final keyContext = backgroundBoxKey.currentContext;

        if (keyContext != null) {
          final RenderBox box = keyContext.findRenderObject();
          _boxHeightCompleter.complete(box.size);
        }
      },
    );
  }

  void _configurePulseAnimation() {
    _fadeController =
        AnimationController(vsync: this, duration: _pulseAnimationDuration);
    _fadeAnimation = Tween(begin: _initialOpacity, end: _finalOpacity).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.linear,
      ),
    );

    _fadeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.reverse();
      }
      if (status == AnimationStatus.dismissed) {
        _fadeController.forward();
      }
    });

    _fadeController.forward();
  }

  Function _progressListener;

  void _configureProgressIndicatorAnimation() {
    if (widget.showProgressIndicator &&
        widget.progressIndicatorController != null) {
      _progressListener = () {
        setState(() {});
      };
      widget.progressIndicatorController.addListener(_progressListener);

      _progressAnimation = CurvedAnimation(
          curve: Curves.linear, parent: widget.progressIndicatorController);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      heightFactor: 1.0,
      child: Material(
        color: widget.snackStyle == SnackStyle.FLOATING
            ? Colors.transparent
            : widget.backgroundColor,
        child: SafeArea(
          minimum: widget.snackPosition == SnackPosition.BOTTOM
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom)
              : EdgeInsets.only(top: MediaQuery.of(context).viewInsets.top),
          bottom: widget.snackPosition == SnackPosition.BOTTOM,
          top: widget.snackPosition == SnackPosition.TOP,
          left: false,
          right: false,
          child: _getSnack(),
        ),
      ),
    );
  }

  Widget _getSnack() {
    Widget snack;

    if (widget.userInputForm != null) {
      snack = _generateInputSnack();
    } else {
      snack = _generateSnack();
    }

    return Stack(
      children: [
        FutureBuilder(
          future: _boxHeightCompleter.future,
          builder: (context, AsyncSnapshot<Size> snapshot) {
            if (snapshot.hasData) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: widget.barBlur, sigmaY: widget.barBlur),
                  child: Container(
                    height: snapshot.data.height,
                    width: snapshot.data.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                    ),
                  ),
                ),
              );
            } else {
              return _emptyWidget;
            }
          },
        ),
        snack,
      ],
    );
  }

  Widget _generateInputSnack() {
    return Container(
      key: backgroundBoxKey,
      constraints: widget.maxWidth != null
          ? BoxConstraints(maxWidth: widget.maxWidth)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor, width: widget.borderWidth)
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8.0, right: 8.0, bottom: 8.0, top: 16.0),
        child: FocusScope(
          child: widget.userInputForm,
          node: _focusNode,
          autofocus: true,
        ),
      ),
    );
  }

  CurvedAnimation _progressAnimation;
  GlobalKey backgroundBoxKey = GlobalKey();

  Widget _generateSnack() {
    return Container(
      key: backgroundBoxKey,
      constraints: widget.maxWidth != null
          ? BoxConstraints(maxWidth: widget.maxWidth)
          : null,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        gradient: widget.backgroundGradient,
        boxShadow: widget.boxShadows,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.borderColor != null
            ? Border.all(color: widget.borderColor, width: widget.borderWidth)
            : null,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.showProgressIndicator
              ? LinearProgressIndicator(
                  value: widget.progressIndicatorController != null
                      ? _progressAnimation.value
                      : null,
                  backgroundColor: widget.progressIndicatorBackgroundColor,
                  valueColor: widget.progressIndicatorValueColor,
                )
              : _emptyWidget,
          Row(
            mainAxisSize: MainAxisSize.max,
            children: _getAppropriateRowLayout(),
          ),
        ],
      ),
    );
  }

  List<Widget> _getAppropriateRowLayout() {
    double buttonRightPadding;
    double iconPadding = 0;
    if (widget.padding.right - 12 < 0) {
      buttonRightPadding = 4;
    } else {
      buttonRightPadding = widget.padding.right - 12;
    }

    if (widget.padding.left > 16.0) {
      iconPadding = widget.padding.left;
    }

    if (widget.icon == null && widget.mainButton == null) {
      return [
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: widget.padding.left,
                        right: widget.padding.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon != null && widget.mainButton == null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: 4.0,
                        right: widget.padding.left,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4.0,
                  right: widget.padding.right,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
      ];
    } else if (widget.icon == null && widget.mainButton != null) {
      return <Widget>[
        _buildLeftBarIndicator(),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: widget.padding.left,
                        right: widget.padding.right,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: widget.padding.left,
                  right: 8.0,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: buttonRightPadding),
          child: _getMainActionButton(),
        ),
      ];
    } else {
      return <Widget>[
        _buildLeftBarIndicator(),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 42.0 + iconPadding),
          child: _getIcon(),
        ),
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_isTitlePresent)
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: widget.padding.top,
                        left: 4.0,
                        right: 8.0,
                      ),
                      child: _getTitleText(),
                    )
                  : _emptyWidget,
              Padding(
                padding: EdgeInsets.only(
                  top: _messageTopMargin,
                  left: 4.0,
                  right: 8.0,
                  bottom: widget.padding.bottom,
                ),
                child: widget.messageText ?? _getDefaultNotificationText(),
              ),
            ],
          ),
        ),
        Padding(
              padding: EdgeInsets.only(right: buttonRightPadding),
              child: _getMainActionButton(),
            ) ??
            _emptyWidget,
      ];
    }
  }

  Widget _buildLeftBarIndicator() {
    if (widget.leftBarIndicatorColor != null) {
      return FutureBuilder(
        future: _boxHeightCompleter.future,
        builder: (BuildContext buildContext, AsyncSnapshot<Size> snapshot) {
          if (snapshot.hasData) {
            return Container(
              color: widget.leftBarIndicatorColor,
              width: 5.0,
              height: snapshot.data.height,
            );
          } else {
            return _emptyWidget;
          }
        },
      );
    } else {
      return _emptyWidget;
    }
  }

  Widget _getIcon() {
    if (widget.icon != null && widget.icon is Icon && widget.shouldIconPulse) {
      return FadeTransition(
        opacity: _fadeAnimation,
        child: widget.icon,
      );
    } else if (widget.icon != null) {
      return widget.icon;
    } else {
      return _emptyWidget;
    }
  }

  Widget _getTitleText() {
    return widget.titleText != null
        ? widget.titleText
        : Text(
            widget.title ?? "",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          );
  }

  Text _getDefaultNotificationText() {
    return Text(
      widget.message ?? "",
      style: TextStyle(fontSize: 14.0, color: Colors.white),
    );
  }

  FlatButton _getMainActionButton() {
    if (widget.mainButton != null) {
      return widget.mainButton;
    } else {
      return null;
    }
  }
}

/// Indicates if snack is going to start at the [TOP] or at the [BOTTOM]
enum SnackPosition { TOP, BOTTOM }

/// Indicates if snack will be attached to the edge of the screen or not
enum SnackStyle { FLOATING, GROUNDED }

/// Indicates the direction in which it is possible to dismiss
/// If vertical, dismiss up will be allowed if [SnackPosition.TOP]
/// If vertical, dismiss down will be allowed if [SnackPosition.BOTTOM]
enum SnackDismissDirection { HORIZONTAL, VERTICAL }

/// Indicates the animation status
/// [SnackStatus.SHOWING] Snack has stopped and the user can see it
/// [SnackStatus.DISMISSED] Snack has finished its mission and returned any pending values
/// [SnackStatus.IS_APPEARING] Snack is moving towards [SnackStatus.SHOWING]
/// [SnackStatus.IS_HIDING] Snack is moving towards [] [SnackStatus.DISMISSED]
enum SnackStatus { SHOWING, DISMISSED, IS_APPEARING, IS_HIDING }
