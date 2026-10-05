/// AdminForgotPasswordScreen — Send a password-reset link.
///
/// Shows a success state in-place once the link is sent.
/// No backend logic — see AdminAuthController for TODOs.
library;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/admin_auth_controller.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/error_banner.dart';
import '../../../widgets/primary_button.dart';

class AdminForgotPasswordScreen extends StatefulWidget {
  const AdminForgotPasswordScreen({super.key});

  static const routeName = '/admin/forgot-password';

  @override
  State<AdminForgotPasswordScreen> createState() =>
      _AdminForgotPasswordScreenState();
}

class _AdminForgotPasswordScreenState
    extends State<AdminForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // ── Validation ─────────────────────────────────────────────────────────────

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

  // ── Submit ─────────────────────────────────────────────────────────────────

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final controller = context.read<AdminAuthController>();

    // TODO: connect to AuthController (Firebase Auth)
    final success =
        await controller.sendPasswordReset(_emailController.text.trim());

    if (!mounted) return;

    if (success) {
      setState(() => _emailSent = true);
    }
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final controller = context.watch<AdminAuthController>();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Réinitialiser le mot de passe'),
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: _emailSent
                  ? _SuccessPanel(email: _emailController.text.trim())
                  : _ResetForm(
                      theme: theme,
                      formKey: _formKey,
                      emailController: _emailController,
                      validateEmail: _validateEmail,
                      controller: controller,
                      onSubmit: _submit,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets (private)
// ─────────────────────────────────────────────────────────────────────────────

/// Form: email field + submit button + error banner.
class _ResetForm extends StatelessWidget {
  const _ResetForm({
    required this.theme,
    required this.formKey,
    required this.emailController,
    required this.validateEmail,
    required this.controller,
    required this.onSubmit,
  });

  final ThemeData theme;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final String? Function(String?) validateEmail;
  final AdminAuthController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Icon ─────────────────────────────────────────────────────────
          Center(
            child: Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                Icons.lock_reset_rounded,
                size: 38,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // ── Explanation ───────────────────────────────────────────────────
          Text(
            'Saisissez l\'adresse e-mail associée à votre compte administrateur. '
            'Vous recevrez un lien pour réinitialiser votre mot de passe.',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),

          // ── Error banner ──────────────────────────────────────────────────
          ErrorBanner(
            message: controller.errorMessage,
            onDismiss: () =>
                context.read<AdminAuthController>().clearError(),
          ),
          if (controller.errorMessage != null) const SizedBox(height: 16),

          // ── Email field ───────────────────────────────────────────────────
          CustomTextField(
            controller: emailController,
            label: 'Adresse e-mail',
            hint: 'admin@exemple.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            validator: validateEmail,
            onFieldSubmitted: (_) => onSubmit(),
            autofillHints: const [AutofillHints.email],
          ),
          const SizedBox(height: 24),

          // ── Submit button ─────────────────────────────────────────────────
          PrimaryButton(
            label: 'Envoyer le lien',
            isLoading: controller.isLoading,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}

/// Shown after the reset link has been sent successfully.
class _SuccessPanel extends StatelessWidget {
  const _SuccessPanel({required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 24),
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.mark_email_read_rounded,
            size: 38,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'E-mail envoyé !',
          style: theme.textTheme.headlineMedium?.copyWith(
            color: const Color(0xFF2E7D32),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Un e-mail de réinitialisation a été envoyé à\n$email',
          style: theme.textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          'Vérifiez votre boîte de réception et suivez les instructions.',
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          label: const Text('Retour à la connexion'),
        ),
      ],
    );
  }
}
