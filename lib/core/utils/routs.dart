import 'package:flutter/material.dart';
import 'package:mk_academy/main.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> routes = {
    MyHomePage.routeName: (context) => const MyHomePage(title: 'MK Academy')
  };
}
