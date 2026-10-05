/// AdminAuthController — MVC Controller (stub, no backend yet)
///
/// Extend this class once you're ready to wire Firebase Auth.
/// The UI already listens to [isLoading] and [errorMessage] via Provider.
library;

import 'package:flutter/foundation.dart';

class AdminAuthController extends ChangeNotifier {
  // ── State ──────────────────────────────────────────────────────────────────

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // ── Internal helpers ───────────────────────────────────────────────────────

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  /// Clears any displayed error banner.
  void clearError() => _setError(null);

  // ── Auth actions ───────────────────────────────────────────────────────────

  /// Sign in with [email] and [password].
  ///
  /// TODO: connect to AuthController (Firebase Auth)
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: connect to AuthController (Firebase Auth)
      // Example:
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //   email: email,
      //   password: password,
      // );

      // Simulate network delay for UI demonstration
      await Future.delayed(const Duration(seconds: 2));

      _setLoading(false);
      return true; // replace with actual success check
    } catch (_) {
      // TODO: connect to AuthController (Firebase Auth) — handle FirebaseAuthException
      _setError('Email ou mot de passe incorrect.');
      _setLoading(false);
      return false;
    }
  }

  /// Send password-reset e-mail to [email].
  ///
  /// TODO: connect to AuthController (Firebase Auth)
  Future<bool> sendPasswordReset(String email) async {
    _setLoading(true);
    _setError(null);

    try {
      // TODO: connect to AuthController (Firebase Auth)
      // Example:
      // await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      await Future.delayed(const Duration(seconds: 2));

      _setLoading(false);
      return true;
    } catch (_) {
      // TODO: connect to AuthController (Firebase Auth) — handle FirebaseAuthException
      _setError('Impossible d\'envoyer l\'e-mail. Vérifiez l\'adresse saisie.');
      _setLoading(false);
      return false;
    }
  }

  /// Sign out the current admin user.
  ///
  /// TODO: connect to AuthController (Firebase Auth)
  Future<void> logout() async {
    // TODO: connect to AuthController (Firebase Auth)
    // Example:
    // await FirebaseAuth.instance.signOut();
  }
}
