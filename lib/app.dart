import 'package:flutter/material.dart';

import 'providers/screen_services.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
      builder: (context, child) => child ?? const Scaffold(),
    );
  }
}
