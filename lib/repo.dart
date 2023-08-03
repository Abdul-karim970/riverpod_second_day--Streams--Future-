import 'dart:async';

class Repository {
  Future<String> fetchData() async {
    await Future.delayed(
      const Duration(seconds: 3),
    );
    return 'AK';
  }

  Stream<int> fetchValues(int start) async* {
    await Future.delayed(Duration(seconds: 3));
    for (var event = start; event < 50; event++) {
      await Future.delayed(const Duration(seconds: 1));
      yield event;
    }
  }

  Stream<int> initialValue() async* {
    yield 0;
  }

  Future<String> initialData() async {
    return Future.delayed(
      const Duration(seconds: 0),
      () => 'No Data',
    );
  }
}
