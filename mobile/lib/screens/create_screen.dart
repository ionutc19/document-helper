import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/app_config.dart';
import '../l10n/app_localizations.dart';
import '../models/create_result.dart';
import '../services/service_locator.dart';
import '../widgets/file_upload_button.dart';
import '../widgets/loading_button.dart';
import '../widgets/section_card.dart';
import '../widgets/banner_ad_widget.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _contextController = TextEditingController();
  final _instructionsController = TextEditingController();
  String _selectedType = 'complaint';
  bool _loading = false;
  CreateResult? _result;
  String? _error;

  static const _outputTypes = [
    'complaint',
    'request',
    'reply',
    'email',
    'draft',
    'other',
  ];

  String _localizedType(String type, AppLocalizations l) {
    switch (type) {
      case 'complaint':
        return l.outputTypeComplaint;
      case 'request':
        return l.outputTypeRequest;
      case 'reply':
        return l.outputTypeReply;
      case 'email':
        return l.outputTypeEmail;
      case 'draft':
        return l.outputTypeDraft;
      case 'other':
        return l.outputTypeOther;
      default:
        return type;
    }
  }

  @override
  void dispose() {
    _contextController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  Future<void> _generate() async {
    final context = _contextController.text.trim();
    if (context.isEmpty) return;

    setState(() {
      _loading = true;
      _error = null;
      _result = null;
    });

    try {
      final locale = Localizations.localeOf(this.context).languageCode;
      final instructions = _instructionsController.text.trim();
      CreateResult result;

      if (AppConfig.useMockServices) {
        result = await ServiceLocator().mock.createDocument(
          context,
          _selectedType,
          instructions.isEmpty ? null : instructions,
          locale,
        );
      } else {
        result = await ServiceLocator().api.createDocument(
          context,
          _selectedType,
          instructions.isEmpty ? null : instructions,
          locale,
        );
      }

      if (mounted) setState(() => _result = result);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _copyResult() {
    if (_result == null) return;
    Clipboard.setData(ClipboardData(text: _result!.generatedText));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context).copiedToClipboard)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.createModule)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l.createHint, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Text(l.documentType, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _outputTypes
                    .map((type) => ChoiceChip(
                          label: Text(_localizedType(type, l)),
                          selected: _selectedType == type,
                          onSelected: (selected) {
                            if (selected) setState(() => _selectedType = type);
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 20),
              Text(l.contextLabel, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              FileUploadButton(
                label: l.uploadContext,
                targetController: _contextController,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _contextController,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: l.contextHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(l.userInstructions, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              TextField(
                controller: _instructionsController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: l.instructionsHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              LoadingButton(
                label: l.generateButton,
                isLoading: _loading,
                icon: Icons.edit_document,
                onPressed: _contextController.text.trim().isEmpty ? null : _generate,
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
                SectionCard(
                  title: _localizedType(_result!.outputType, l),
                  icon: Icons.article_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SelectableText(_result!.generatedText),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: _copyResult,
                          icon: const Icon(Icons.copy, size: 18),
                          label: Text(l.copyText),
                        ),
                      ),
                    ],
                  ),
                ),
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
