import 'dart:math';

void main(List<String> args) {
  var e = Engine();
  e.generate();
}

class Engine {
  Engine() {
    init();
  }

  List? _list;

  List? get list => _list;

  void generate() {
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

    print(generators);

    // Creates a blank space on the board.
    int rand = Random().nextInt(15);
    var tilePosition = positions[rand];

    var left = tilePosition.left;
    var top = tilePosition.top;
    var index = tilePosition.index;

    unstructuredTiles.add(
      TileStructureModel(
        index: index,
      ),
    );

    positions.removeAt(rand);

    print(
      "blank    " +
          index.toString() +
          "    " +
          left.toString() +
          "    " +
          top.toString(),
    );

    print("**********************************");

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
        print(
          generated.spriteRoute +
              "    " +
              index.toString() +
              "    " +
              left.toString() +
              "    " +
              top.toString(),
        );
        positions.removeAt(rand2);

        generated.count++;
        count++;
      } else {
        generators.removeAt(rand1);
      }
    }
  }

  move() {}

  void init() {}
}

class TileGeneratorModel {
  double count;
  String spriteRoute;

  TileGeneratorModel({
    required this.count,
    required this.spriteRoute,
  });
}

class TilePositionModel {
  double left;
  double top;
  int index;

  TilePositionModel({
    required this.left,
    required this.top,
    required this.index,
  });
}

class TileStructureModel {
  int index;

  TileStructureModel({
    required this.index,
  });
}




