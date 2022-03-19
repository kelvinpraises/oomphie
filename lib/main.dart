import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:oomphie/api/engine.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends HookConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(engine).generate();
    final value = ref.watch(engine);

    return Scaffold(
      body: Center(
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 50),
            Center(
              child: Transform.scale(
                scale: .8,
                child: Stack(
                  children: [
                    const SizedBox(width: 700, height: 600),
                    Positioned(
                      left: 55,
                      top: 42,
                      child: Stack(
                        children: [
                          const SizedBox(width: 500, height: 600),
                          ...value.list,
                        ],
                      ),
                    ),
                    Positioned(
                      left: 55,
                      child: Container(
                        width: 432,
                        height: 56,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/frame-top.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 486,
                      left: 55,
                      child: Container(
                        width: 432,
                        height: 56,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/frame-bottom.png"),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1.5,
                      child: Container(
                        width: 55,
                        height: 540,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/frame-left.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 487,
                      top: 1.5,
                      child: Container(
                        width: 55,
                        height: 540,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/frame-right.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
