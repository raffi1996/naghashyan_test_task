import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task_naghashyan/enums/sort_types.dart';
import 'package:test_task_naghashyan/store/home_state/home_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../http/repositories/product_repo.dart';
import 'widgets/product_item.dart';

@RoutePage<void>()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeState _homeState = HomeState(
    productRepository: ImplProductRepository(),
  );

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _homeState.getProducts();
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
              _homeState.onTapSort(type);
            },
            padding: EdgeInsets.zero,
            // initialValue: choices[_selection],
            itemBuilder: (BuildContext context) {
              return popUpMenuItems;
            },
          )
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Observer(builder: (context) {
                if (_homeState.loadingState.isLoading &&
                    _homeState.products.isEmpty) {
                  return const CupertinoActivityIndicator();
                } else if (_homeState.products.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Products',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  controller: _controller,
                  padding: EdgeInsets.only(
                    right: 10,
                    left: 10,
                    bottom: MediaQuery.of(context).padding.bottom + 10,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == _homeState.products.length - 1) {
                      _homeState.getProducts();
                    }
                    final product = _homeState.products[index];
                    return ProductItem(
                      product: product,
                    );
                  },
                  itemCount: _homeState.products.length,
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: Observer(
        builder: (context) {
          if (_homeState.hasScrollToggle) {
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
      _homeState.hasScrollToggle = true;
    } else {
      _homeState.hasScrollToggle = false;
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
