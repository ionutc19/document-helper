import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../l10n/app_localizations.dart';
import '../services/service_locator.dart';
import '../widgets/loading_button.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _subjectController = TextEditingController();
  final _bodyController = TextEditingController();
  String _category = 'feedback';
  bool _loading = false;
  bool _sent = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _subjectController.addListener(() => setState(() {}));
    _bodyController.addListener(() => setState(() {}));
  }

  static const _categories = ['feedback', 'bug', 'feature'];

  String _localizedCategory(String cat, AppLocalizations l) {
    switch (cat) {
      case 'feedback':
        return l.feedbackCategoryFeedback;
      case 'bug':
        return l.feedbackCategoryBug;
      case 'feature':
        return l.feedbackCategoryFeature;
      default:
        return cat;
    }
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final subject = _subjectController.text.trim();
    final body = _bodyController.text.trim();
    if (subject.isEmpty || body.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      if (!AppConfig.useMockServices) {
        await ServiceLocator().api.submitFeedback(
          category: _category,
          title: subject,
          description: body,
        );
      }
      if (mounted) setState(() => _sent = true);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    if (_sent) {
      return Scaffold(
        appBar: AppBar(title: Text(l.sendFeedback)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, size: 64, color: Theme.of(context).colorScheme.primary),
                const SizedBox(height: 16),
                Text(
                  l.feedbackSent,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  l.feedbackThanks,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l.goBack),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l.sendFeedback)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l.feedbackCategory, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: _categories
                  .map((cat) => ChoiceChip(
                        label: Text(_localizedCategory(cat, l)),
                        selected: _category == cat,
                        onSelected: (s) {
                          if (s) setState(() => _category = cat);
                        },
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _subjectController,
              decoration: InputDecoration(
                labelText: l.feedbackSubject,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              maxLines: 6,
              decoration: InputDecoration(
                labelText: l.feedbackBody,
                border: const OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 16),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  _error!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ),
            LoadingButton(
              label: l.submitFeedback,
              isLoading: _loading,
              icon: Icons.send,
              onPressed: (_subjectController.text.trim().isEmpty || _bodyController.text.trim().isEmpty)
                  ? null
                  : _submit,
            ),
          ],
        ),
      ),
    );
  }
}
