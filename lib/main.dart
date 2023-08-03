import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_second_day/providers/counter_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'Riverpod',
          style: TextStyle(color: Colors.blueGrey.shade100),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer(
              builder: (context, ref, child) {
                AsyncValue<String> asyncData = ref.watch(futureProvider);
                return asyncData.map(
                  data: (data) => Text(
                    data.value,
                    style:
                        const TextStyle(color: Colors.blueGrey, fontSize: 35),
                  ),
                  error: (error) => Text('${error.error}'),
                  loading: (loading) => CircularProgressIndicator(
                    color: Colors.blueGrey.shade100,
                    backgroundColor: Colors.blueGrey,
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                var asyncValue = ref.watch(streamProvider(5));
                return asyncValue.when(
                  skipLoadingOnRefresh: false,
                  data: (data) => Text(
                    '$data',
                    style:
                        const TextStyle(color: Colors.blueGrey, fontSize: 35),
                  ),
                  error: (error, stackTrace) => Text(error.toString()),
                  loading: () => CircularProgressIndicator(
                    color: Colors.blueGrey.shade100,
                    backgroundColor: Colors.blueGrey,
                  ),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              isExtended: true,
              tooltip: 'Fetch Stream',
              child: Icon(
                Icons.stream_rounded,
                color: Colors.blueGrey.shade100,
              ),
              onPressed: () {
                ref
                    .read(shouldFetchStreamProvider.notifier)
                    .update((state) => state ? false : true);
              }),
          FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              isExtended: true,
              tooltip: 'Fetch Data',
              child: Icon(
                Icons.data_array_rounded,
                color: Colors.blueGrey.shade100,
              ),
              onPressed: () {
                ref
                    .read(shouldFetchDataProvider.notifier)
                    .update((state) => state ? false : true);
              })
        ],
      ),
    );
  }
}
