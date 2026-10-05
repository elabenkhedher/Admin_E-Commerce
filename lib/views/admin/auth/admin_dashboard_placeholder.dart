/// AdminDashboardPlaceholder — Minimal screen the login flow navigates to.
///
/// Replace this with the real dashboard once the UI is built.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/admin_auth_controller.dart';
import 'admin_login_screen.dart';

class AdminDashboardPlaceholder extends StatelessWidget {
  const AdminDashboardPlaceholder({super.key});

  static const routeName = '/admin/dashboard';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de bord Admin'),
        automaticallyImplyLeading: false,
        actions: [
          // ── Sign out ───────────────────────────────────────────────────────
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.dashboard_rounded,
              size: 80,
              color: theme.colorScheme.primary.withValues(alpha: 0.25),
            ),
            const SizedBox(height: 24),
            Text(
              'Tableau de bord Admin',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Ce tableau de bord sera implémenté prochainement.',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            FilledButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Se déconnecter'),
              onPressed: () => _logout(context),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    // TODO: connect to AuthController (Firebase Auth)
    await context.read<AdminAuthController>().logout();
    if (!context.mounted) return;
    Navigator.of(context)
        .pushReplacementNamed(AdminLoginScreen.routeName);
  }
}
