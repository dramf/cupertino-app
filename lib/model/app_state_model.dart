import 'package:flutter/foundation.dart' as foundation;

import '../model/product.dart';
import '../model/product_repository.dart';

double _salesTaxRate = 0.06;
double _shippingCostPerItem = 7;

class AppStateModel extends foundation.ChangeNotifier {
  List<Product> _availableProducts = [];
  Category _selectedCategory = Category.all;
  final _productsInCart = <int, int>{};

  Map<int, int> get productsInCart => Map.from(_productsInCart);

  int get totalCartQuantity => _productsInCart.values
      .fold(0, (previousValue, element) => previousValue + element);

  Category get selectedCategory => _selectedCategory;

  double get subtotalCost => _productsInCart.keys
      .map((id) => getProductById(id).price * _productsInCart[id]!)
      .fold(0, (previousValue, element) => previousValue + element);

  double get tax => subtotalCost * _salesTaxRate;

  double get totalCost => subtotalCost + shippingCost * tax;

  double get shippingCost =>
      _shippingCostPerItem *
      _productsInCart.values
          .fold(0.0, (accumulator, itemCount) => accumulator + itemCount);

  //  double get shippingCost =>
  List<Product> getProducts() {
    if (_selectedCategory == Category.all) {
      return List.from(_availableProducts);
    } else {
      return _availableProducts
          .where((p) => p.category == _selectedCategory)
          .toList();
    }
  }

  List<Product> search(String searchTerms) => getProducts()
      .where((product) =>
          product.name.toLowerCase().contains(searchTerms.toLowerCase()))
      .toList();

  void addProductToCart(int productId) {
    if (!_productsInCart.containsKey(productId)) {
      _productsInCart[productId] = 1;
    } else {
      _productsInCart[productId] = _productsInCart[productId]! + 1;
    }
  }

  void removeItemFromCart(int productId) {
    if (_productsInCart.containsKey(productId)) {
      if (_productsInCart[productId] == 1) {
        _productsInCart.remove(productId);
      } else {
        _productsInCart[productId] = _productsInCart[productId]! - 1;
      }
    }
  }

  Product getProductById(int id) {
    return _availableProducts.firstWhere((p) => p.id == id);
  }

  void clearChart() {
    _productsInCart.clear();
    notifyListeners();
  }

  void loadProducts() {
    _availableProducts = ProductsRepository.loadProducts(_selectedCategory);
    notifyListeners();
  }

  void setCategory(Category newCategory) {
    _selectedCategory = newCategory;
    notifyListeners();
  }
}
