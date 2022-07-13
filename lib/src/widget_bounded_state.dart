import 'package:flutter/widgets.dart';

/// Define an State which is bounded to widget lifecycle
/// and provides [onResume(), [onReady() and [onPause()
abstract class WidgetBoundedState<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onPause();
    } else if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }

  /// Override this method in your concrete class if you need the callback
  void onResume() {}

  /// Override this method in your concrete class if you need the callback
  void onReady() {}

  /// Override this method in your concrete class if you need the callback
  void onPause() {}
}
