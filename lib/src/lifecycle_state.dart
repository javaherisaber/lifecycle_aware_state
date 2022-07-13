import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/src/widget_bounded_state.dart';

/// Define an State which is lifecycle aware and can provide callbacks for
/// navigation and widget events, also you can tune in logging
abstract class LifecycleAwareState<T extends StatefulWidget>
    extends WidgetBoundedState<T> with RouteAware {
  /// Register this routeObserver in your MaterialApp's [navigatorObservers]
  /// to be able to receive callbacks for your routes
  static final RouteObserver<PageRoute> routeObserver = RouteObserver();

  /// Enable/Disable logging lifecycle events
  static bool enableLogEvents = true;

  /// Log lifecycle events only for suffixes provided in [logClassSuffixes]
  static bool logSuffixedClassesOnly = false;

  /// Filter logs for only specific classes that end's with these suffixes
  static List<String> logClassSuffixes = ['Page'];

  /// Tag message to be added before every log message
  static String logTag = 'LifecycleAwareState =>';

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    _printEvent('building widget...');
    return Scaffold(
      appBar: AppBar(title: const Text('Lifecycle Aware State Page')),
      body: const Center(
        child: Text("You haven't implemented your page yet"),
      ),
    );
  }

  String get _widgetName => widget.toStringShort();

  void _printEvent(String message) {
    if (logSuffixedClassesOnly &&
        !logClassSuffixes.any((c) => _widgetName.endsWith(c))) {
      return;
    }
    if (enableLogEvents) {
      debugPrint('$logTag $_widgetName: $message');
    }
  }

  @override
  void dispose() {
    _printEvent('dispose()');
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    _printEvent('initState()');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _printEvent('didChangeDependencies()');
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    _printEvent('didUpdateWidget()');
    super.didUpdateWidget(oldWidget);
  }

  @override
  @mustCallSuper
  void onResume() {
    _printEvent('onResume()');
  }

  @override
  @mustCallSuper
  void onPause() {
    _printEvent('onPause()');
  }

  @override
  @mustCallSuper
  void onReady() {
    _printEvent('onReady()');
  }

  @override
  @mustCallSuper
  void didPush() {
    _printEvent('didPush()');
  }

  @override
  @mustCallSuper
  void didPushNext() {
    _printEvent('didPushNext()');
  }

  @override
  @mustCallSuper
  void didPop() {
    _printEvent('didPop()');
  }

  @override
  @mustCallSuper
  void didPopNext() {
    _printEvent('didPopNext()');
  }
}
