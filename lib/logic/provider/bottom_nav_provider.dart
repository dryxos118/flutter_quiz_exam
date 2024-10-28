import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavIndexNotifier extends StateNotifier<int> {
  BottomNavIndexNotifier() : super(0);

  void updateIndex(int index) => state = index;
}

// Provider pour exposer BottomNavIndexNotifier
final bottomNavIndexProvider =
    StateNotifierProvider<BottomNavIndexNotifier, int>(
  (ref) => BottomNavIndexNotifier(),
);
