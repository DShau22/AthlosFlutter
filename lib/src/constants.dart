// keys for local storage
import 'package:flutter/material.dart';

const USER_ID_KEY = 'userId';
const TOKEN_KEY = 'token';
const RUN_DATA_KEY = 'run data key';
const SWIM_DATA_KEY = 'swim data key';
const JUMP_DATA_KEY = 'jump data key';
const USER_DATA_KEY = 'user data key';

// color themes
// https://www.color-hex.com/color-palette/18676
const JELLYFISH = {
  1: Color(0xff0449c7),
  2: Color(0xff045869),
  3: Color(0xff046c12),
  4: Color(0xff04ec7a),
  5: Color(0xff04b4d4),
};
const TROPIC = {
  1: Color(0xff04ade2),
  2: Color(0xff04a1b4f),
  3: Color(0xff2aded4),
  4: Color(0xff0485a2),
  5: Color(0xffa6f2d2),
};
const AURORA = {
  1: Color(0xff05e4be),
  2: Color(0xff2bb789),
  3: Color(0xff284b52),
  4: Color(0xff141210),
  5: Color(0xff238182),
};

// nice gradients: https://digitalsynopsis.com/design/beautiful-gradient-color-palettes/
const List<Color> RUN_GRADIENT = [
  Color(0xffeebd89),
  Color(0xffd13abd)
];

const List<Color> SWIM_GRADIENT = [
  Color(0xff23b6e6),
  Color(0xff02d39a),
];

const List<Color> JUMP_GRADIENT = [
  Color(0xff9fa5d5),
  Color(0xfff2bae8),
];

final Color PRIMARY = Color(0x66ffff);
final Color TEXT_COLOR = Colors.black;
final Color TEXT_COLOR_LIGHT = Colors.black38;