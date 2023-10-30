import 'package:flutter/foundation.dart';

class CountController extends ValueNotifier<int> {
  CountController(int count) : super(count);

  void increment() {
    value++;
    notifyListeners();
  }

  void decrement() {
    value--;
    notifyListeners();
  }
  void incremcent(int price) {
    value += (price ) as int; // Increment based on the price (assuming price is in dollars)
    notifyListeners();
  }
}
