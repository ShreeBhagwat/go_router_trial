import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBarProvider extends StateNotifier<int> {
  BottomNavBarProvider() : super(0);

  void updateIndex(int index) {
    state = index;
  }
}

final bottomNavBarProvider =
    StateNotifierProvider<BottomNavBarProvider, int>((ref) {
  return BottomNavBarProvider();
});
