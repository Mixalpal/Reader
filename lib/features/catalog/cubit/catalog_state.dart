part of 'catalog_cubit.dart';

class CatalogState extends Equatable {
  const CatalogState({
    this.storeBooks = const [],
    this.filters = const Filters(),
    this.isLoading = true,
  });

  final List<StoreBook> storeBooks;
  final Filters filters;
  final bool isLoading;

  CatalogState copyWith({
    List<StoreBook>? storeBooks,
    Filters? filters,
    bool? isLoading,
  }) {
    return CatalogState(
      storeBooks: storeBooks ?? this.storeBooks,
      filters: filters ?? this.filters,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [storeBooks, filters];
}

class CatalogInitial extends CatalogState {}

class Filters {
  const Filters();
}
