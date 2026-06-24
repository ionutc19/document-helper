import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.privacyPolicy)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Section(
              title: l.privacyIntroTitle,
              body: l.privacyIntroBody,
            ),
            _Section(
              title: l.privacyDataTitle,
              body: l.privacyDataBody,
            ),
            _Section(
              title: l.privacyUploadTitle,
              body: l.privacyUploadBody,
            ),
            _Section(
              title: l.privacyStorageTitle,
              body: l.privacyStorageBody,
            ),
            _Section(
              title: l.privacyContactTitle,
              body: l.privacyContactBody,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                l.privacyLastUpdated,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String body;

  const _Section({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(body, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
