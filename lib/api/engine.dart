import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:oomphie/models/tile_generator.dart';
import 'package:oomphie/models/tile_position.dart';
import 'package:oomphie/models/tile_structure.dart';
import 'package:oomphie/widgets/blank.dart';
import 'package:oomphie/widgets/tile.dart';

class Engine with ChangeNotifier {
  List<Widget> _list = [];
  List<Widget> get list => _list;

  double _blankTop = 0;
  double get blankTop => _blankTop;
  set blankTop(double blankTop) {
    _blankTop = blankTop;
    notifyListeners();
  }

  double _blankLeft = 0;
  double get blankLeft => _blankLeft;
  set blankLeft(double blankLeft) {
    _blankLeft = blankLeft;
    notifyListeners();
  }

  int _blankIndex = 0;
  int get blankIndex => _blankIndex;
  set blankIndex(int blankIndex) {
    _blankIndex = blankIndex;
    notifyListeners();
  }

  List<double> _movable = [];
  List<double> get movable => _movable;

  bool init = false;

  void generate() {
    if (init) return;

    init = true;
    int count = 0;

    List<TileStructureModel> unstructuredTiles = [];

    List<TileGeneratorModel> generators = [
      TileGeneratorModel(count: 0, spriteRoute: "assets/tile-pink.png"),
      TileGeneratorModel(count: 0, spriteRoute: "assets/tile-turquoise.png"),
      TileGeneratorModel(count: 0, spriteRoute: "assets/tile-blue.png"),
      TileGeneratorModel(count: 0, spriteRoute: "assets/tile-purple.png"),
    ];

    List<TilePositionModel> positions = [
      TilePositionModel(left: 324, top: 0, index: 15),
      TilePositionModel(left: 216, top: 0, index: 14),
      TilePositionModel(left: 108, top: 0, index: 13),
      TilePositionModel(left: 0, top: 0, index: 12),
      TilePositionModel(left: 324, top: 108, index: 11),
      TilePositionModel(left: 216, top: 108, index: 10),
      TilePositionModel(left: 108, top: 108, index: 9),
      TilePositionModel(left: 0, top: 108, index: 8),
      TilePositionModel(left: 324, top: 216, index: 7),
      TilePositionModel(left: 216, top: 216, index: 6),
      TilePositionModel(left: 108, top: 216, index: 5),
      TilePositionModel(left: 0, top: 216, index: 4),
      TilePositionModel(left: 324, top: 324, index: 3),
      TilePositionModel(left: 216, top: 324, index: 2),
      TilePositionModel(left: 108, top: 324, index: 1),
      TilePositionModel(left: 0, top: 324, index: 0),
    ];

    // Creates a blank space on the board.
    int rand = Random().nextInt(15);
    var position = positions[rand];

    var left = position.left;
    var top = position.top;
    var index = position.index;

    unstructuredTiles.add(
      TileStructureModel(
        index: index,
        widget: Blank(
          left: left,
          top: top,
          index: index,
        ),
      ),
    );

    positions.removeAt(rand);

    while (count <= 14) {
      int max1 = generators.length;
      int rand1 = Random().nextInt(max1);
      TileGeneratorModel generated = generators[rand1];

      int max2 = positions.length;
      int rand2 = Random().nextInt(max2);
      TilePositionModel position = positions[rand2];
      double left = position.left;
      double top = position.top;
      int index = position.index;

      if (generated.count < 4) {
        unstructuredTiles.add(
          TileStructureModel(
            index: index,
            widget: Tile(
              left: left,
              top: top,
              index: index,
              spriteRoute: generated.spriteRoute,
            ),
          ),
        );

        positions.removeAt(rand2);
        generated.count++;
        count++;
      } else {
        generators.removeAt(rand1);
      }
    }

    List<Widget> tile = [];

    for (var i = 0; i < 16; i++) {
      for (var e in unstructuredTiles) {
        if (e.index == i) {
          tile.add(e.widget);
        }
      }
    }

    _list = tile;
  }

  change(
    int tileIndex,
    double tileLeft,
    double tileTop,
    String tileSpriteRoute,
    int blankIndex,
    double blankLeft,
    double blankTop,
  ) {
    Widget blank = Blank(
      left: tileLeft,
      top: tileTop,
      index: tileIndex,
    );

    Widget tile = Tile(
      left: blankLeft,
      top: blankTop,
      index: blankIndex,
      spriteRoute: tileSpriteRoute,
    );

    _list[tileIndex] = blank;
    _list[blankIndex] = tile;

    notifyListeners();
  }

  updateMovable(int index) {
    switch (index) {
      case 0:
        _movable = [4, 1];
        break;
      case 1:
        _movable = [0, 5, 2];
        break;
      case 2:
        _movable = [1, 6, 3];
        break;
      case 3:
        _movable = [2, 7];
        break;
      case 4:
        _movable = [8, 5, 0];
        break;
      case 5:
        _movable = [9, 6, 1, 4];
        break;
      case 6:
        _movable = [10, 7, 2, 5];
        break;
      case 7:
        _movable = [11, 3, 6];
        break;
      case 8:
        _movable = [12, 9, 4];
        break;
      case 9:
        _movable = [13, 10, 5, 8];
        break;
      case 10:
        _movable = [14, 11, 6, 9];
        break;
      case 11:
        _movable = [15, 7, 10];
        break;
      case 12:
        _movable = [13, 8];
        break;
      case 13:
        _movable = [14, 9, 12];
        break;
      case 14:
        _movable = [15, 10, 13];
        break;
      case 15:
        _movable = [11, 14];
        break;
      default:
    }
    notifyListeners();
  }
}

final engine = ChangeNotifierProvider<Engine>((ref) => Engine());
