import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/src/fetchNumberStream.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestPage extends ConsumerWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String data = ref.read<String>(stringProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(counterStateProvider.state).state++;
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            int count = ref.watch(counterStateProvider);
            // var number =ref.watch(numberProvider);

            return Column(
              children: [
                Text(count.toString()),
                ref.watch(weatherFutureProvider).when(data: (data) {
                  return Text(data);
                }, error: (error, stackTrace) {
                  return Text(error.toString());
                }, loading: () {
                  return CircularProgressIndicator();
                }),
                ref.watch(numberProvider).when(data: (int data) {
                  return Text(data.toString());
                }, error: (Object error, StackTrace stackTrace) {
                  return Text(error.toString());
                }, loading: () {
                  return CircularProgressIndicator();
                })
              ],
            );
          },
        ),
      ),
    );
  }
}
