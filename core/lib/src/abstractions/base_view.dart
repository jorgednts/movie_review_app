import 'package:core/core.dart';
import 'package:flutter/material.dart';

abstract class BaseView<T extends BaseChangeNotifierViewModel>
    extends StatefulWidget {
  final T viewModel;

  const BaseView({super.key, required this.viewModel});

  @override
  State<BaseView<T>> createState() => _BaseViewState<T>();

  Widget build(BuildContext context, T viewModel);
}

class _BaseViewState<T extends BaseChangeNotifierViewModel>
    extends State<BaseView<T>> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();

    if (!_initialized) {
      widget.viewModel.onInit();
      _initialized = true;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.viewModel.onReady();
    });
  }

  @override
  void dispose() {
    widget.viewModel.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.build(context, widget.viewModel);
  }
}
