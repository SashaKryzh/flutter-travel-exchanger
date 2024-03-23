import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

typedef _L = LucideIcons;

abstract class AppIcons {
  static IconData columns({bool three = false}) => three ? _L.columns_3 : _L.columns_2;
  static const selected = _L.check;
  static const recent = _L.history;
  static const popular = _L.star;
  static const all = _L.list;
  static const editMoneyRate = _L.pencil;
  static const editTimeRate = _L.settings;
  static const settings = _L.settings;
  static const swap = _L.arrow_right_left;
  static const search = _L.search;
  static const rearrangeIndicator = _L.grip_vertical;
  static const darkMode = _L.moon;
  static const lightMode = _L.sun;
  static const systemMode = _L.sun_moon;
}
