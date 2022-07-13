# lifecycle_aware_state
[![pub package](https://img.shields.io/pub/v/lifecycle_aware_state.svg)](https://pub.dev/packages/lifecycle_aware_state)

Lifecycle callbacks to be aware of different events in the route navigation and state lifecycle in a flutter project

## Usage

To use this plugin, add [lifecycle_aware_state](https://pub.dev/packages/lifecycle_aware_state/install) as a dependency in your pubspec.yaml file.

```yaml
dependencies:
  lifecycle_aware_state: ^lastVersion
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:lifecycle_aware_state/lifecycle_aware_state.dart';

void main() {
  LifecycleAwareState.logClassSuffixes = ['Page'];
  LifecycleAwareState.logSuffixedClassesOnly = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LifecycleAwareState Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [LifecycleAwareState.routeObserver],
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends LifecycleAwareState<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('LifecycleAwareState Demo')),
      body: const Center(
        child: Text('Hello Lifecycle'),
      ),
    );
  }

  @override
  void onPause() {
    // Widget is not visible to the user
    super.onPause();
  }

  @override
  void onResume() {
    // Widget becomes visible to the user
    super.onResume();
  }

  @override
  void onReady() {
    // Widget is now built and visible
    super.onReady();
  }

  @override
  void didPop() {
    // This route is popped from navigator
    super.didPop();
  }

  @override
  void didPopNext() {
    // top route has been popped off, and the current route shows up
    super.didPopNext();
  }

  @override
  void didPush() {
    // Called when the current route has been pushed.
    super.didPush();
  }

  @override
  void didPushNext() {
    // Called when a new route has been pushed, and the current route is no longer visible.
    super.didPushNext();
  }
}
```
