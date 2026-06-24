import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../widgets/language_dropdown.dart';
import 'feedback_screen.dart';
import 'plans_screen.dart';
import 'privacy_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.settings)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _SectionHeader(title: l.general),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(l.language),
            trailing: const LanguageDropdown(),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _SectionHeader(title: l.account),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: Text(l.plans),
            subtitle: Text(l.plansSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PlansScreen()),
            ),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _SectionHeader(title: l.support),
          ListTile(
            leading: const Icon(Icons.feedback_outlined),
            title: Text(l.sendFeedback),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const FeedbackScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(l.privacyPolicy),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PrivacyScreen()),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: Text(
              'Document Assistant v0.1.0',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
      ),
    );
  }
}
