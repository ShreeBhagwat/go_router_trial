class RouteNames {
  static const String initialRoute = 'root';
  static const String homeRoute = 'home';
  static const String loginRoute = 'login';
  static const String registerRoute = 'register';
  static const String profileRoute = 'profile';
  static const String settingsRoute = 'settings';
  static const String aboutRoute = 'about';
  static const String contactRoute = 'contact';
  static const String errorRoute = 'error';
  static const String splashRoute = 'splash';
  static const String editProfile = 'editProfile';
  static const String searchRoute = 'search';
}

extension RoutePath on String {
  String path() => '/$this';
}
