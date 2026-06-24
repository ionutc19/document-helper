import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../l10n/app_localizations.dart';
import '../models/explain_result.dart';
import '../services/service_locator.dart';
import '../widgets/file_upload_button.dart';
import '../widgets/loading_button.dart';
import '../widgets/section_card.dart';
import '../widgets/banner_ad_widget.dart';

class ExplainScreen extends StatefulWidget {
  const ExplainScreen({super.key});

  @override
  State<ExplainScreen> createState() => _ExplainScreenState();
}

class _ExplainScreenState extends State<ExplainScreen> {
  final _textController = TextEditingController();
  bool _loading = false;
  ExplainResult? _result;
  String? _error;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _analyze() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _result = null;
    });

    try {
      final locale = Localizations.localeOf(context).languageCode;
      ExplainResult result;

      if (AppConfig.useMockServices) {
        result = await ServiceLocator().mock.explainDocument(text, locale);
      } else {
        result = await ServiceLocator().api.explainDocument(text, locale);
      }

      if (mounted) setState(() => _result = result);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.explainModule)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.explainHint, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),
              FileUploadButton(
                label: l.uploadFile,
                targetController: _textController,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _textController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: l.pasteOrType,
                  border: const OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 16),
              LoadingButton(
                label: l.analyzeButton,
                isLoading: _loading,
                icon: Icons.auto_awesome,
                onPressed: _textController.text.trim().isEmpty ? null : _analyze,
              ),
              if (_error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _error!,
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              if (_result != null) ...[
                const SizedBox(height: 20),
                _ResultsView(result: _result!),
              ],
              const SizedBox(height: 20),
              const Center(child: BannerAdWidget()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResultsView extends StatelessWidget {
  final ExplainResult result;

  const _ResultsView({required this.result});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Column(
      children: [
        SectionCard(
          title: l.documentSummary,
          icon: Icons.summarize,
          child: Text(result.summary),
        ),
        if (result.keyPoints.isNotEmpty) ...[
          const SizedBox(height: 12),
          SectionCard(
            title: l.keyPoints,
            icon: Icons.list_alt,
            child: _BulletList(items: result.keyPoints),
          ),
        ],
        if (result.obligations.isNotEmpty) ...[
          const SizedBox(height: 12),
          SectionCard(
            title: l.obligations,
            icon: Icons.gavel,
            child: _BulletList(items: result.obligations),
          ),
        ],
        if (result.risks.isNotEmpty) ...[
          const SizedBox(height: 12),
          SectionCard(
            title: l.risks,
            icon: Icons.warning_amber,
            child: _BulletList(items: result.risks),
          ),
        ],
        if (result.actionItems.isNotEmpty) ...[
          const SizedBox(height: 12),
          SectionCard(
            title: l.actionItems,
            icon: Icons.check_circle_outline,
            child: _BulletList(items: result.actionItems),
          ),
        ],
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  final List<String> items;

  const _BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                    Expanded(child: Text(item)),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
