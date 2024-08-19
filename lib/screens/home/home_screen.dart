import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../enums/sort_types.dart';
import '../../store/bloc/product_bloc/product_bloc.dart';
import '../../store/bloc/product_bloc/product_event.dart';
import '../../store/bloc/product_bloc/product_state.dart';
import '../../store/bloc/scrolling_bloc/scrolling_bloc.dart';
import '../../store/bloc/scrolling_bloc/scrolling_state.dart';
import 'widgets/product_item.dart';

@RoutePage<void>()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(
          GetProducts(),
        );
    _controller.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Task'),
        elevation: 0,
        centerTitle: false,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (type) {
              context.read<ProductBloc>().add(
                    OnSortTap(
                      sortType: type,
                    ),
                  );
            },
            padding: EdgeInsets.zero,
            // initialValue: choices[_selection],
            itemBuilder: (context) {
              return popUpMenuItems;
            },
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is Loading) {
                    return const CupertinoActivityIndicator();
                  } else if (state is LoadedProducts &&
                      state.products.isEmpty) {
                    return const Center(
                      child: Text(
                        'No Products',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    );
                  } else if (state is LoadedProducts) {
                    return ListView.builder(
                      controller: _controller,
                      padding: EdgeInsets.only(
                        right: 10,
                        left: 10,
                        bottom: MediaQuery.of(context).padding.bottom + 10,
                      ),
                      itemBuilder: (context, index) {
                        if (index == state.products.length - 1) {
                          context.read<ProductBloc>().add(GetProducts());
                        }
                        final product = state.products[index];
                        return ProductItem(
                          product: product,
                        );
                      },
                      itemCount: state.products.length,
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ScrollingBloc, ScrollingState>(
        builder: (context, state) {
          if (state is ShowScrollToTopButton) {
            return GestureDetector(
              onTap: () {
                _controller.animateTo(
                  0,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.ease,
                );
              },
              child: Container(
                width: 50,
                height: 50,
                color: Colors.blueAccent,
                child: const Center(
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  void scrollListener() {
    if (_controller.position.pixels > 300) {
      context.read<ScrollingBloc>().add(true);
    } else {
      context.read<ScrollingBloc>().add(false);
    }
  }

  List<PopupMenuItem> get popUpMenuItems => [
        const PopupMenuItem<SortType>(
          value: SortType.A_Z,
          child: Text('Name A-Z'),
        ),
        const PopupMenuItem<SortType>(
          value: SortType.Z_A,
          child: Text('Name Z-A'),
        ),
        const PopupMenuItem<SortType>(
          value: SortType.PRICE_ASCENDING,
          child: Text('Price ascending'),
        ),
        const PopupMenuItem<SortType>(
          value: SortType.PRICE_DESCENDING,
          child: Text('Price descending'),
        ),
        const PopupMenuItem<SortType>(
          value: SortType.LATEST,
          child: Text('Latest'),
        ),
      ];
}
