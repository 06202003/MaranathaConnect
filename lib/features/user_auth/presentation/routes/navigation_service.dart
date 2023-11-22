import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  void navigateToPage(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }
}
