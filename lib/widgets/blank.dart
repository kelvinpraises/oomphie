import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oomphie/api/engine.dart';

class Blank extends HookConsumerWidget {
  final double left;
  final double top;
  final int index;

  const Blank({
    Key? key,
    required this.left,
    required this.top,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(engine);

    value.blankLeft = left;
    value.blankTop = top;
    value.blankIndex = index;
    value.updateMovable(index);

    

    return Positioned(
      left: left,
      top: top,
      child: const SizedBox(
        width: 120,
        height: 120,
      ),
    );
  }
}
