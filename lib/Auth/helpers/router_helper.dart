import 'package:flutter/cupertino.dart';

class RouterHelper {
  RouterHelper._();
  static RouterHelper router = RouterHelper._();
  GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  goPage(String screenRoute) {
    navKey.currentState.pushNamed(screenRoute);
  }

  goReplacementPage(String screenRoute) {
    navKey.currentState.pushReplacementNamed(screenRoute);
  }

  back() {
    navKey.currentState.pop();
  }
}
