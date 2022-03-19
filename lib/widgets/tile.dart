import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oomphie/api/engine.dart';

class Tile extends HookConsumerWidget {
  final double left;
  final double top;
  final int index;
  final String spriteRoute;

  const Tile({
    Key? key,
    required this.left,
    required this.top,
    required this.index,
    required this.spriteRoute,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(engine);

    final controller = () {
      AnimationController controller =
          useAnimationController(duration: const Duration(milliseconds: 600));

      return controller;
    }();

    double lerp(double min, double max) =>
        lerpDouble(min, max, controller.value)!;

    void toggle() {
      var movable = value.movable.contains(index);
      if (movable) {
        final bool isOpen = controller.status == AnimationStatus.completed;
        controller.fling(velocity: isOpen ? -1 : 1);
        value.change(
          index,
          left,
          top,
          spriteRoute,
          value.blankIndex,
          value.blankLeft,
          value.blankTop,
        );
      }
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          left: lerp(left, value.blankLeft),
          top: lerp(top, value.blankTop),
          child: GestureDetector(
            onTap: toggle,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(spriteRoute),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
