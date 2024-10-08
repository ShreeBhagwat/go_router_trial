import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// /// A scope that provides [StreamAuth] for the subtree.
class StreamAuthScope extends InheritedNotifier<StreamAuthNotifier> {
  /// Creates a [StreamAuthScope] sign in scope.
  StreamAuthScope({
    super.key,
    required super.child,
  }) : super(notifier: StreamAuthNotifier());

  /// Gets the [StreamAuth].
  static StreamAuth of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<StreamAuthScope>()!
        .notifier!
        .streamAuth;
  }
}

/// A class that converts [StreamAuth] into a [ChangeNotifier].
class StreamAuthNotifier extends ChangeNotifier {
  /// Creates a [StreamAuthNotifier].
  StreamAuthNotifier() : streamAuth = StreamAuth() {
    streamAuth.onCurrentUserChanged.listen((String? string) {
      notifyListeners();
    });
  }

  /// The stream auth client.
  final StreamAuth streamAuth;
}

/// An asynchronous log in services mock with stream similar to google_sign_in.
///
/// This class adds an artificial delay of 3 second when logging in an user, and
/// will automatically clear the login session after [refreshInterval].
class StreamAuth {
  /// Creates an [StreamAuth] that clear the current user session in
  /// [refeshInterval] second.
  StreamAuth() : _userStreamController = StreamController<String?>.broadcast() {
    _userStreamController.stream.listen((String? currentUser) async {
      _currentUser = currentUser;
    });
  }

  /// The current user.
  String? get currentUser => _currentUser;
  String? _currentUser;

  /// Checks whether current user is signed in with an artificial delay to mimic
  /// async operation.
  Future<bool> isSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    await Future<void>.delayed(const Duration(seconds: 1));
    final username = prefs.getString('username');
    return username != null;
  }

  /// A stream that notifies when current user has changed.
  Stream<String?> get onCurrentUserChanged => _userStreamController.stream;
  final StreamController<String?> _userStreamController;

  /// Signs in a user with an artificial delay to mimic async operation.
  Future<void> signIn(String newUserName) async {
    final prefs = await SharedPreferences.getInstance();
    await Future<void>.delayed(const Duration(seconds: 3));
    await prefs.setString('username', newUserName);
    _userStreamController.add(newUserName);
  }

  /// Signs out the current user.
  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    _userStreamController.add(null);
  }
}
