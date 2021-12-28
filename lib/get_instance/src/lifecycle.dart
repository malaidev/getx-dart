import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// The [GetLifeCycle]
///
/// ```dart
/// class SomeController with GetLifeCycle {
///   SomeController() {
///     configureLifeCycle();
///   }
/// }
/// ```
mixin GetLifeCycleBase {
  /// Called immediately after the widget is allocated in memory.
  /// You might use this to initialize something for the controller.
  @protected
  @mustCallSuper
  void onInit() {}

  /// Called 1 frame after onInit(). It is the perfect place to enter
  /// navigation events, like snackbar, dialogs, or a new route, or
  /// async request.
  void onReady() {}

  /// Called before [onDelete] method. [onClose] might be used to
  /// dispose resources used by the controller. Like closing events,
  /// or streams before the controller is destroyed.
  /// Or dispose objects that can potentially create some memory leaks,
  /// like TextEditingControllers, AnimationControllers.
  /// Might be useful as well to persist some data on disk.
  void onClose() {}

  bool _initialized = false;

  /// Checks whether the controller has already been initialized.
  bool get initialized => _initialized;

  /// Called at the exact moment the widget is allocated in memory.
  /// It uses an internal "callable" type, to avoid any @overrides in subclases.
  /// This method should be internal and is required to define the
  /// lifetime cycle of the subclass.
  // @protected
  @mustCallSuper
  void onStart() {
    // _checkIfAlreadyConfigured();
    if (_initialized) return;
    onInit();
    _initialized = true;
  }

  bool _isClosed = false;

  /// Checks whether the controller has already been closed.
  bool get isClosed => _isClosed;

  // Called when the controller is removed from memory.
  @mustCallSuper
  void onDelete() {
    if (_isClosed) return;
    _isClosed = true;
    onClose();
  }

//   void _checkIfAlreadyConfigured() {
//     if (_initialized) {
//       throw """You can only call configureLifeCycle once.
// The proper place to insert it is in your class's constructor
// that inherits GetLifeCycle.""";
//     }
//   }
}

abstract class GetLifeCycle with GetLifeCycleBase {
  @override
  void onInit() {
    SchedulerBinding.instance?.addPostFrameCallback((_) => onReady());
    super.onInit();
  }
}

/// Allow track difference between GetxServices and GetxControllers
mixin GetxServiceMixin {}
