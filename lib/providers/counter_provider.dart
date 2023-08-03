import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_second_day/repo.dart';

final counterProvider = StateProvider<int>((ref) => 0);
final repoProvider = Provider<Repository>(
  (ref) => Repository(),
);

final futureProvider = FutureProvider<String>((ref) {
  return ref.watch(shouldFetchDataProvider)
      ? ref.watch(repoProvider).fetchData()
      : ref.watch(repoProvider).initialData();
});

final streamProvider = StreamProvider.family<int, int>((ref, start) {
  return ref.watch(shouldFetchStreamProvider)
      ? ref.watch(repoProvider).fetchValues(start)
      : ref.watch(repoProvider).initialValue();
});
final shouldFetchStreamProvider = StateProvider<bool>((ref) => false);
final shouldFetchDataProvider = StateProvider<bool>((ref) => false);
