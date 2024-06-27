import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingPage extends ConsumerStatefulWidget {
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends ConsumerState<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
