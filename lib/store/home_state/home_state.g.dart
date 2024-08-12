// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeState on _HomeState, Store {
  late final _$hasScrollToggleAtom =
      Atom(name: '_HomeState.hasScrollToggle', context: context);

  @override
  bool get hasScrollToggle {
    _$hasScrollToggleAtom.reportRead();
    return super.hasScrollToggle;
  }

  @override
  set hasScrollToggle(bool value) {
    _$hasScrollToggleAtom.reportWrite(value, super.hasScrollToggle, () {
      super.hasScrollToggle = value;
    });
  }

  late final _$productsAtom =
      Atom(name: '_HomeState.products', context: context);

  @override
  ObservableList<ProductModel> get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(ObservableList<ProductModel> value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$getProductsAsyncAction =
      AsyncAction('_HomeState.getProducts', context: context);

  @override
  Future<void> getProducts() {
    return _$getProductsAsyncAction.run(() => super.getProducts());
  }

  @override
  String toString() {
    return '''
hasScrollToggle: ${hasScrollToggle},
products: ${products}
    ''';
  }
}
