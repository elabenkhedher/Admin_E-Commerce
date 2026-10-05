/// Entry point — sets up Provider, theme and named routes.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/admin_auth_controller.dart';
import 'theme/app_theme.dart';
import 'views/admin/auth/admin_dashboard_placeholder.dart';
import 'views/admin/auth/admin_forgot_password_screen.dart';
import 'views/admin/auth/admin_login_screen.dart';

void main() {
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // Single instance of AdminAuthController for the whole app.
      create: (_) => AdminAuthController(),
      child: MaterialApp(
        title: 'Admin — Espace Administrateur',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,

        // ── Named routes ────────────────────────────────────────────────────
        initialRoute: AdminLoginScreen.routeName,
        routes: {
          AdminLoginScreen.routeName: (_) => const AdminLoginScreen(),
          AdminForgotPasswordScreen.routeName: (_) =>
              const AdminForgotPasswordScreen(),
          AdminDashboardPlaceholder.routeName: (_) =>
              const AdminDashboardPlaceholder(),
        },
      ),
    );
  }
}
