import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'http/repositories/product_repo.dart';
import 'providers/screen_services.dart';
import 'store/bloc/product_bloc/product_bloc.dart';
import 'store/bloc/scrolling_bloc/scrolling_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: router.defaultRouteParser(),
      routerDelegate: router.delegate(),
      builder: (_, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(
              ImplProductRepository(),
            ),
          ),
          BlocProvider(
            create: (context) => ScrollingBloc(),
          ),
        ],
        child: child!,
      ),
    );
  }
}
