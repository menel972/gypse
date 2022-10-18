import 'package:flutter/material.dart';

import 'bloc.dart';

class BlocProvider<T extends Bloc> extends StatefulWidget {
  final T bloc;
  final Widget child;
  const BlocProvider({
    Key? key,
    required this.bloc,
    required this.child,
  }) : super(key: key);

  static T of<T extends Bloc>(BuildContext context) {
    final BlocProvider<T> provider =
        context.findAncestorWidgetOfExactType<BlocProvider<T>>()!;

    return provider.bloc;
  }

  @override
  State<BlocProvider> createState() => _BlocProviderState();
}

class _BlocProviderState extends State<BlocProvider> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
