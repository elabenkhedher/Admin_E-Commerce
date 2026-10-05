/// AdminLoginScreen — Admin sign-in form.
///
/// Uses [AdminAuthController] (Provider) for loading state and error messages.
/// No backend logic here — see controller for TODOs.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/admin_auth_controller.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/error_banner.dart';
import '../../../widgets/primary_button.dart';
import 'admin_dashboard_placeholder.dart';
import 'admin_forgot_password_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  static const routeName = '/admin/login';

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  //  Form infrastructure
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // ── Validation helpers ─────────────────────────────────────────────────────

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'L\'adresse e-mail est requise.';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Veuillez saisir une adresse e-mail valide.';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Le mot de passe est requis.';
    }
    if (value.length < 6) {
      return 'Le mot de passe doit contenir au moins 6 caractères.';
    }
    return null;
  }

  // ── Submit ─────────────────────────────────────────────────────────────────

  Future<void> _submit() async {
    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<AdminAuthController>();

    // TODO: connect to AuthController (Firebase Auth)
    final success = await controller.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacementNamed(
        AdminDashboardPlaceholder.routeName,
      );
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            // Max width 420 — centres the card on tablets / large screens
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Logo(),
                  const SizedBox(height: 32),
                  _LoginForm(
                    formKey: _formKey,
                    emailController: _emailController,
                    passwordController: _passwordController,
                    emailFocus: _emailFocus,
                    passwordFocus: _passwordFocus,
                    validateEmail: _validateEmail,
                    validatePassword: _validatePassword,
                    onSubmit: _submit,
                  ),
                  const SizedBox(height: 32),
                  _Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets (private — scoped to this screen)
// ─────────────────────────────────────────────────────────────────────────────

/// App logo placeholder + titles.
class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.30),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Icon(
            Icons.admin_panel_settings_rounded,
            size: 44,
            color: theme.colorScheme.onPrimary,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Espace Administrateur',
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Connectez-vous pour gérer la plateforme',
          style: theme.textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Form card containing fields, forgot-password link, submit button and error banner.
class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.emailFocus,
    required this.passwordFocus,
    required this.validateEmail,
    required this.validatePassword,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    // Watch controller for reactive loading / error states
    final controller = context.watch<AdminAuthController>();

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Error banner ───────────────────────────────────────────────────
          ErrorBanner(
            message: controller.errorMessage,
            onDismiss: () => context.read<AdminAuthController>().clearError(),
          ),
          if (controller.errorMessage != null) const SizedBox(height: 16),

          // ── Email field ────────────────────────────────────────────────────
          CustomTextField(
            controller: emailController,
            focusNode: emailFocus,
            nextFocusNode: passwordFocus,
            label: 'Adresse e-mail',
            hint: 'admin@exemple.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: validateEmail,
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 16),

          // ── Password field ─────────────────────────────────────────────────
          CustomTextField(
            controller: passwordController,
            focusNode: passwordFocus,
            label: 'Mot de passe',
            prefixIcon: Icons.lock_outline,
            obscureText: true,
            showObscureToggle: true,
            textInputAction: TextInputAction.done,
            validator: validatePassword,
            onFieldSubmitted: (_) => onSubmit(),
            autofillHints: const [AutofillHints.password],
          ),
          const SizedBox(height: 8),

          // ── Forgot password link ───────────────────────────────────────────
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: controller.isLoading
                  ? null
                  : () => Navigator.of(context)
                      .pushNamed(AdminForgotPasswordScreen.routeName),
              child: const Text('Mot de passe oublié ?'),
            ),
          ),
          const SizedBox(height: 20),

          // ── Submit button ──────────────────────────────────────────────────
          PrimaryButton(
            label: 'Se connecter',
            isLoading: controller.isLoading,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

/// Small footer disclaimer.
class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Accès réservé aux administrateurs',
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: TextAlign.center,
    );
  }
}
