// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../enums/sort_types.dart';

abstract class ProductEvent {}

class GetProducts extends ProductEvent {
  GetProducts();
}

class OnSortTap extends ProductEvent {
  final SortType sortType;
  OnSortTap({
    required this.sortType,
  });
}
