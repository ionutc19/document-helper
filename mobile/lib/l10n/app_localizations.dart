import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ro'),
  ];

  String get languageCode => locale.languageCode;

  String get(String key) => _localizedValues[locale.languageCode]?[key] ?? _localizedValues['en']![key] ?? key;

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': _en,
    'ro': _ro,
  };

  // Common
  String get appName => get('appName');
  String get appTitle => get('appName');
  String get appSubtitle => get('landingSubtitle');
  String get getStarted => get('getStarted');
  String get settings => get('settings');
  String get version => get('version');
  String get language => get('language');
  String get english => get('english');
  String get romanian => get('romanian');
  String get home => get('home');
  String get general => get('general');
  String get goBack => get('goBack');

  // Landing
  String get landingSubtitle => get('landingSubtitle');
  String get landingFeature1 => get('landingFeature1');
  String get landingFeature2 => get('landingFeature2');
  String get landingFeature3 => get('landingFeature3');

  // Home
  String get whatToDo => get('whatToDo');
  String get homeGreeting => get('homeGreeting');
  String get homeSubtitle => get('homeSubtitle');
  String get explainDocument => get('explainDocument');
  String get explainModule => get('explainDocument');
  String get explainDescription => get('explainDescription');
  String get explainModuleDesc => get('explainDescription');
  String get createDocument => get('createDocument');
  String get createModule => get('createDocument');
  String get createDescription => get('createDescription');
  String get createModuleDesc => get('createDescription');
  String get sendFeedback => get('sendFeedback');

  // Explain
  String get explainInstructions => get('explainInstructions');
  String get explainHint => get('explainInstructions');
  String get documentText => get('documentText');
  String get documentTextHint => get('documentTextHint');
  String get pasteOrType => get('documentTextHint');
  String get analyzeDocument => get('analyzeDocument');
  String get analyzeButton => get('analyzeDocument');
  String get uploadFile => get('uploadDocument');
  String get documentSummary => get('documentSummary');
  String get keyPoints => get('keyPoints');
  String get obligations => get('obligations');
  String get risks => get('risks');
  String get actionItems => get('actionItems');
  String get minCharsError => get('minCharsError');
  String get copy => get('copy');
  String get copyText => get('copy');
  String get copiedToClipboard => get('copiedToClipboard');
  String get noItemsFound => get('noItemsFound');

  // Create
  String get createInstructions => get('createInstructions');
  String get createHint => get('createInstructions');
  String get sourceDocument => get('sourceDocument');
  String get sourceDocumentHint => get('sourceDocumentHint');
  String get contextLabel => get('sourceDocument');
  String get contextHint => get('sourceDocumentHint');
  String get uploadContext => get('uploadContext');
  String get outputType => get('outputType');
  String get documentType => get('outputType');
  String get outputTypeComplaint => get('outputTypeComplaint');
  String get outputTypeRequest => get('outputTypeRequest');
  String get outputTypeReply => get('outputTypeReply');
  String get outputTypeEmail => get('outputTypeEmail');
  String get outputTypeDraft => get('outputTypeDraft');
  String get outputTypeOther => get('outputTypeOther');
  String get userInstructions => get('userInstructions');
  String get userInstructionsHint => get('userInstructionsHint');
  String get instructionsHint => get('userInstructionsHint');
  String get generateDocument => get('generateDocument');
  String get generateButton => get('generateDocument');
  String get generatedResult => get('generatedResult');

  // Settings
  String get appInfo => get('appInfo');
  String get mockServices => get('mockServices');
  String get enabled => get('enabled');
  String get disabled => get('disabled');
  String get backend => get('backend');
  String get baseUrl => get('baseUrl');
  String get connectionStatus => get('connectionStatus');
  String get connected => get('connected');
  String get notChecked => get('notChecked');
  String get test => get('test');
  String get backendReachable => get('backendReachable');
  String get backendNotReachable => get('backendNotReachable');
  String get support => get('support');
  String get account => get('account');
  String get userId => get('userId');

  // Feedback
  String get feedbackInstructions => get('feedbackInstructions');
  String get feedbackCategory => get('category');
  String get feedbackCategoryFeedback => get('feedback');
  String get feedbackCategoryBug => get('bug');
  String get feedbackCategoryFeature => get('feature');
  String get feedbackSubject => get('title');
  String get feedbackBody => get('description');
  String get feedbackSent => get('feedbackSubmitted');
  String get feedbackThanks => get('feedbackThanks');
  String get category => get('category');
  String get bug => get('bug');
  String get feature => get('feature');
  String get feedback => get('feedback');
  String get title => get('title');
  String get titleHint => get('titleHint');
  String get description => get('description');
  String get descriptionHint => get('descriptionHint');
  String get emailOptional => get('emailOptional');
  String get emailHint => get('emailHint');
  String get submitFeedback => get('submitFeedback');
  String get feedbackSubmitted => get('feedbackSubmitted');
  String get feedbackOffline => get('feedbackOffline');
  String get titleMinChars => get('titleMinChars');
  String get descriptionMinChars => get('descriptionMinChars');

  // Loading
  String get processing => get('processing');
  String get error => get('error');

  // Plans
  String get plans => get('plans');
  String get choosePlan => get('choosePlan');
  String get plansSubtitle => get('plansSubtitle');
  String get currentPlan => get('currentPlan');
  String get recommended => get('recommended');
  String get selectPlan => get('selectPlan');
  String get planSubtitle => get('plansSubtitle');
  String get freePlan => get('planFree');
  String get freePlanPrice => get('planFreePrice');
  String get freePlanFeature1 => get('planFreeAds');
  String get freePlanFeature2 => get('planFreeRequests');
  String get freePlanFeature3 => get('planFreeModules');
  String get premiumPlan => get('planPremium');
  String get premiumPlanPrice => get('planPremiumPrice');
  String get premiumPlanFeature1 => get('planPremiumNoAds');
  String get premiumPlanFeature2 => get('planPremiumRequests');
  String get premiumPlanFeature3 => get('planPremiumModules');
  String get proPlan => get('planPro');
  String get proPlanPrice => get('planProPrice');
  String get proPlanFeature1 => get('planProNoAds');
  String get proPlanFeature2 => get('planProRequests');
  String get proPlanFeature3 => get('planProModules');
  String get planFree => get('planFree');
  String get planFreePrice => get('planFreePrice');
  String get planFreeAds => get('planFreeAds');
  String get planFreeRequests => get('planFreeRequests');
  String get planFreeModules => get('planFreeModules');
  String get planPremium => get('planPremium');
  String get planPremiumPrice => get('planPremiumPrice');
  String get planPremiumNoAds => get('planPremiumNoAds');
  String get planPremiumRequests => get('planPremiumRequests');
  String get planPremiumModules => get('planPremiumModules');
  String get planPro => get('planPro');
  String get planProPrice => get('planProPrice');
  String get planProNoAds => get('planProNoAds');
  String get planProRequests => get('planProRequests');
  String get planProModules => get('planProModules');
  String get planProFairUse => get('planProFairUse');
  String upgradeTo(String plan) => get('upgradeTo').replaceAll('{plan}', plan);
  String get planUpgradeCta => get('planUpgradeCta');
  String get restorePurchases => get('restorePurchases');
  String get restoringPurchases => get('restoringPurchases');
  String get billingUnavailable => get('billingUnavailable');

  // File upload
  String get uploadDocument => get('uploadDocument');
  String get extractingText => get('extractingText');
  String get removeFile => get('removeFile');
  String get replaceFile => get('replaceFile');
  String get fileTooLarge => get('fileTooLarge');
  String get fileConsentTitle => get('fileConsentTitle');
  String get fileConsentPicker => get('fileConsentPicker');
  String get fileConsentSelected => get('fileConsentSelected');
  String get fileConsentTemporary => get('fileConsentTemporary');
  String get fileConsentNoStorage => get('fileConsentNoStorage');
  String get fileConsentContinue => get('fileConsentContinue');
  String get fileUploadError => get('fileUploadError');

  // Legal
  String get termsOfService => get('termsOfService');
  String get viewOnline => get('viewOnline');

  // Privacy
  String get privacyPolicy => get('privacyTitle');
  String get privacyTitle => get('privacyTitle');
  String get privacyIntroTitle => get('privacyDataProcessing');
  String get privacyIntroBody => get('privacyDataProcessingBody');
  String get privacyDataTitle => get('privacyAiUsage');
  String get privacyDataBody => get('privacyAiUsageBody');
  String get privacyUploadTitle => get('privacyDataStorage');
  String get privacyUploadBody => get('privacyDataStorageBody');
  String get privacyStorageTitle => get('privacySubscriptions');
  String get privacyStorageBody => get('privacySubscriptionsBody');
  String get privacyContactTitle => get('privacyContact');
  String get privacyDataProcessing => get('privacyDataProcessing');
  String get privacyDataProcessingBody => get('privacyDataProcessingBody');
  String get privacyAiUsage => get('privacyAiUsage');
  String get privacyAiUsageBody => get('privacyAiUsageBody');
  String get privacyDataStorage => get('privacyDataStorage');
  String get privacyDataStorageBody => get('privacyDataStorageBody');
  String get privacySubscriptions => get('privacySubscriptions');
  String get privacySubscriptionsBody => get('privacySubscriptionsBody');
  String get privacyThirdParty => get('privacyThirdParty');
  String get privacyThirdPartyBody => get('privacyThirdPartyBody');
  String get privacyContact => get('privacyContact');
  String get privacyContactBody => get('privacyContactBody');
  String get privacyLastUpdated => get('privacyLastUpdated');

  static const Map<String, String> _en = {
    'appName': 'Document Assistant',
    'getStarted': 'Get Started',
    'settings': 'Settings',
    'version': 'Version',
    'language': 'Language',
    'english': 'English',
    'romanian': 'Română',

    'home': 'Home',
    'general': 'General',
    'goBack': 'Go Back',
    'recommended': 'Recommended',
    'selectPlan': 'Select Plan',
    'landingSubtitle': 'Your AI-powered document companion.\nUnderstand any document and generate useful outputs.',
    'landingFeature1': 'Understand documents instantly with AI-powered analysis',
    'landingFeature2': 'Generate complaints, requests, emails, and more',
    'landingFeature3': 'Your documents are never stored — privacy first',
    'homeGreeting': 'Welcome',
    'homeSubtitle': 'What would you like to do today?',
    'uploadContext': 'Upload context document',

    'whatToDo': 'What would you like to do?',
    'explainDocument': 'Explain Document',
    'explainDescription': 'Summarize, extract key points, and highlight obligations or risks',
    'createDocument': 'Create Document',
    'createDescription': 'Generate requests, replies, emails, complaints, and more',
    'sendFeedback': 'Send Feedback',

    'explainInstructions': 'Upload or paste your document to get a clear summary, key points, and action items.',
    'documentText': 'Document Text',
    'documentTextHint': 'Paste your document content here...',
    'analyzeDocument': 'Analyze Document',
    'documentSummary': 'Summary',
    'keyPoints': 'Key Points',
    'obligations': 'Obligations',
    'risks': 'Risks',
    'actionItems': 'Action Items',
    'minCharsError': 'Please enter at least 10 characters',
    'copy': 'Copy',
    'copiedToClipboard': 'Copied to clipboard',
    'noItemsFound': 'None identified',

    'createInstructions': 'Generate a document based on your instructions. Optionally upload a source document for context.',
    'sourceDocument': 'Source Document (optional)',
    'sourceDocumentHint': 'Paste source document for context...',
    'outputType': 'Document Type',
    'outputTypeComplaint': 'Complaint',
    'outputTypeRequest': 'Request',
    'outputTypeReply': 'Official Reply',
    'outputTypeEmail': 'Email',
    'outputTypeDraft': 'Draft / Form',
    'outputTypeOther': 'Other',
    'userInstructions': 'Instructions',
    'userInstructionsHint': 'Describe what you need generated...',
    'generateDocument': 'Generate Document',
    'generatedResult': 'Generated Document',

    'appInfo': 'App Info',
    'mockServices': 'Mock Services',
    'enabled': 'Enabled',
    'disabled': 'Disabled',
    'backend': 'Backend',
    'baseUrl': 'Base URL',
    'connectionStatus': 'Connection Status',
    'connected': 'Connected',
    'notChecked': 'Not checked',
    'test': 'Test',
    'backendReachable': 'Backend is reachable',
    'backendNotReachable': 'Backend is not reachable',
    'support': 'Support',
    'account': 'Account',
    'userId': 'User ID',

    'feedbackInstructions': 'Help us improve Document Assistant. Report bugs, request features, or share feedback.',
    'category': 'Category',
    'bug': 'Bug',
    'feature': 'Feature',
    'feedback': 'Feedback',
    'title': 'Title',
    'titleHint': 'Brief summary...',
    'description': 'Description',
    'descriptionHint': 'Describe the issue or suggestion in detail...',
    'emailOptional': 'Email (optional)',
    'emailHint': 'For follow-up if needed',
    'submitFeedback': 'Submit Feedback',
    'feedbackSubmitted': 'Feedback Sent!',
    'feedbackThanks': 'Thank you! Your feedback has been submitted and will help us improve.',
    'feedbackOffline': 'Feedback received (offline mode).',
    'titleMinChars': 'Title must be at least 3 characters',
    'descriptionMinChars': 'Please provide at least 10 characters',

    'processing': 'Processing...',
    'error': 'Error',

    'plans': 'Plans',
    'choosePlan': 'Choose Your Plan',
    'plansSubtitle': 'Select the plan that fits your document needs.',
    'currentPlan': 'Current',
    'planFree': 'Free',
    'planFreePrice': '\$0 / month',
    'planFreeAds': 'Ads supported',
    'planFreeRequests': '5 requests per month per module',
    'planFreeModules': 'Both modules included',
    'planPremium': 'Premium',
    'planPremiumPrice': '\$3.99 / month',
    'planPremiumNoAds': 'No ads',
    'planPremiumRequests': '20 requests per day per module',
    'planPremiumModules': 'Both modules included',
    'planPro': 'Pro',
    'planProPrice': '\$9.99 / month',
    'planProNoAds': 'No ads',
    'planProRequests': 'Unlimited access',
    'planProModules': 'Both modules included',
    'planProFairUse': 'Fair use policy applies',
    'upgradeTo': 'Upgrade to {plan}',
    'planUpgradeCta': 'Upgrade for more daily analyses',
    'restorePurchases': 'Restore Purchases',
    'restoringPurchases': 'Restoring...',
    'billingUnavailable': 'In-app purchases are not available on this device',

    'uploadDocument': 'Upload',
    'extractingText': 'Extracting...',
    'removeFile': 'Remove',
    'replaceFile': 'Replace',
    'fileTooLarge': 'File exceeds 10 MB limit',
    'fileConsentTitle': 'Upload a Document',
    'fileConsentPicker': 'Your device\'s file picker will open so you can choose a file.',
    'fileConsentSelected': 'Only the file you select will be accessed.',
    'fileConsentTemporary': 'File content is processed temporarily for this request only.',
    'fileConsentNoStorage': 'Your file is not stored — it is discarded after processing.',
    'fileConsentContinue': 'Choose File',
    'fileUploadError': 'Could not extract text from this file.',

    'termsOfService': 'Terms of Service',
    'viewOnline': 'View online',

    'privacyTitle': 'Privacy & Legal',
    'privacyDataProcessing': 'Data Processing',
    'privacyDataProcessingBody': 'When you use Document Assistant, your input (document text, uploaded files) is sent to our backend server for processing. This data is transmitted securely and used solely to generate your requested analysis or document.',
    'privacyAiUsage': 'AI-Powered Results',
    'privacyAiUsageBody': 'Document Assistant uses artificial intelligence models to generate results. Your input is forwarded to the AI model as part of the request. The AI processes your data in real time and does not retain it after generating a response.',
    'privacyDataStorage': 'Data Storage',
    'privacyDataStorageBody': 'Document Assistant does not permanently store your document text, uploaded file content, or generated results on our servers. Input data is processed in memory and discarded after the response is delivered. Your language preference and a stable app user ID are stored locally on your device. Usage counters, subscription status, and entitlement data are stored on the server to enforce plan limits.',
    'privacySubscriptions': 'Subscriptions & Entitlements',
    'privacySubscriptionsBody': 'If you subscribe to a paid plan, your subscription status and usage data (request counts, tier information) may be processed and stored to enforce plan limits. Payment processing is handled by third-party billing providers.',
    'privacyThirdParty': 'Third-Party Services & Advertising',
    'privacyThirdPartyBody': 'The free tier includes advertisements served by third-party ad networks. These services may collect device identifiers and usage data according to their own privacy policies.',
    'privacyContact': 'Contact',
    'privacyContactBody': 'If you have questions about how your data is handled, please use the Send Feedback feature in the app or contact us through the app settings.',
    'privacyLastUpdated': 'Last updated: June 2026',
  };

  static const Map<String, String> _ro = {
    'appName': 'Document Assistant',
    'getStarted': 'Începe',
    'settings': 'Setări',
    'version': 'Versiune',
    'language': 'Limbă',
    'english': 'English',
    'romanian': 'Română',

    'home': 'Acasă',
    'general': 'General',
    'goBack': 'Înapoi',
    'recommended': 'Recomandat',
    'selectPlan': 'Selectează',
    'landingSubtitle': 'Asistentul tău AI pentru documente.\nÎnțelege orice document și generează documente utile.',
    'landingFeature1': 'Înțelege documente instant cu analiză AI',
    'landingFeature2': 'Generează sesizări, cereri, emailuri și altele',
    'landingFeature3': 'Documentele tale nu sunt stocate — confidențialitate pe primul loc',
    'homeGreeting': 'Bun venit',
    'homeSubtitle': 'Ce dorești să faci astăzi?',
    'uploadContext': 'Încarcă document context',

    'whatToDo': 'Ce dorești să faci?',
    'explainDocument': 'Explică Document',
    'explainDescription': 'Rezumă, extrage puncte cheie și evidențiază obligații sau riscuri',
    'createDocument': 'Creează Document',
    'createDescription': 'Generează cereri, răspunsuri, emailuri, sesizări și altele',
    'sendFeedback': 'Trimite Feedback',

    'explainInstructions': 'Încarcă sau lipește documentul tău pentru a obține un rezumat clar, puncte cheie și pași de urmat.',
    'documentText': 'Text Document',
    'documentTextHint': 'Lipește conținutul documentului aici...',
    'analyzeDocument': 'Analizează Documentul',
    'documentSummary': 'Rezumat',
    'keyPoints': 'Puncte Cheie',
    'obligations': 'Obligații',
    'risks': 'Riscuri',
    'actionItems': 'Pași de Urmat',
    'minCharsError': 'Introduceți cel puțin 10 caractere',
    'copy': 'Copiază',
    'copiedToClipboard': 'Copiat în clipboard',
    'noItemsFound': 'Nu au fost identificate',

    'createInstructions': 'Generează un document pe baza instrucțiunilor tale. Opțional, încarcă un document sursă pentru context.',
    'sourceDocument': 'Document Sursă (opțional)',
    'sourceDocumentHint': 'Lipește documentul sursă pentru context...',
    'outputType': 'Tip Document',
    'outputTypeComplaint': 'Sesizare',
    'outputTypeRequest': 'Cerere',
    'outputTypeReply': 'Răspuns Oficial',
    'outputTypeEmail': 'Email',
    'outputTypeDraft': 'Draft / Formular',
    'outputTypeOther': 'Altele',
    'userInstructions': 'Instrucțiuni',
    'userInstructionsHint': 'Descrie ce dorești să fie generat...',
    'generateDocument': 'Generează Documentul',
    'generatedResult': 'Document Generat',

    'appInfo': 'Informații Aplicație',
    'mockServices': 'Servicii Mock',
    'enabled': 'Activat',
    'disabled': 'Dezactivat',
    'backend': 'Backend',
    'baseUrl': 'URL Bază',
    'connectionStatus': 'Stare Conexiune',
    'connected': 'Conectat',
    'notChecked': 'Neverificat',
    'test': 'Testează',
    'backendReachable': 'Backend-ul este accesibil',
    'backendNotReachable': 'Backend-ul nu este accesibil',
    'support': 'Suport',
    'account': 'Cont',
    'userId': 'ID Utilizator',

    'feedbackInstructions': 'Ajută-ne să îmbunătățim Document Assistant. Raportează erori, solicită funcționalități sau trimite feedback.',
    'category': 'Categorie',
    'bug': 'Eroare',
    'feature': 'Funcționalitate',
    'feedback': 'Feedback',
    'title': 'Titlu',
    'titleHint': 'Rezumat scurt...',
    'description': 'Descriere',
    'descriptionHint': 'Descrie problema sau sugestia în detaliu...',
    'emailOptional': 'Email (opțional)',
    'emailHint': 'Pentru follow-up dacă este necesar',
    'submitFeedback': 'Trimite Feedback',
    'feedbackSubmitted': 'Feedback Trimis!',
    'feedbackThanks': 'Mulțumim! Feedback-ul tău a fost trimis și ne va ajuta să îmbunătățim aplicația.',
    'feedbackOffline': 'Feedback primit (mod offline).',
    'titleMinChars': 'Titlul trebuie să aibă cel puțin 3 caractere',
    'descriptionMinChars': 'Introduceți cel puțin 10 caractere',

    'processing': 'Se procesează...',
    'error': 'Eroare',

    'plans': 'Planuri',
    'choosePlan': 'Alege Planul Tău',
    'plansSubtitle': 'Selectează planul potrivit pentru nevoile tale de documente.',
    'currentPlan': 'Curent',
    'planFree': 'Gratuit',
    'planFreePrice': '\$0 / lună',
    'planFreeAds': 'Cu reclame',
    'planFreeRequests': '5 cereri pe lună per modul',
    'planFreeModules': 'Ambele module incluse',
    'planPremium': 'Premium',
    'planPremiumPrice': '\$3,99 / lună',
    'planPremiumNoAds': 'Fără reclame',
    'planPremiumRequests': '20 cereri pe zi per modul',
    'planPremiumModules': 'Ambele module incluse',
    'planPro': 'Pro',
    'planProPrice': '\$9,99 / lună',
    'planProNoAds': 'Fără reclame',
    'planProRequests': 'Acces nelimitat',
    'planProModules': 'Ambele module incluse',
    'planProFairUse': 'Se aplică politica de utilizare corectă',
    'upgradeTo': 'Treci la {plan}',
    'planUpgradeCta': 'Upgradează pentru mai multe analize zilnice',
    'restorePurchases': 'Restaurează Achizițiile',
    'restoringPurchases': 'Se restaurează...',
    'billingUnavailable': 'Achizițiile din aplicație nu sunt disponibile pe acest dispozitiv',

    'uploadDocument': 'Încarcă',
    'extractingText': 'Se extrage...',
    'removeFile': 'Elimină',
    'replaceFile': 'Înlocuiește',
    'fileTooLarge': 'Fișierul depășește limita de 10 MB',
    'fileConsentTitle': 'Încarcă un Document',
    'fileConsentPicker': 'Se va deschide selectorul de fișiere al dispozitivului tău.',
    'fileConsentSelected': 'Doar fișierul pe care îl selectezi va fi accesat.',
    'fileConsentTemporary': 'Conținutul fișierului este procesat temporar, doar pentru această cerere.',
    'fileConsentNoStorage': 'Fișierul tău nu este stocat — este eliminat după procesare.',
    'fileConsentContinue': 'Alege Fișierul',
    'fileUploadError': 'Nu s-a putut extrage textul din acest fișier.',

    'termsOfService': 'Termeni și Condiții',
    'viewOnline': 'Vezi online',

    'privacyTitle': 'Confidențialitate și Legal',
    'privacyDataProcessing': 'Procesarea Datelor',
    'privacyDataProcessingBody': 'Când folosești Document Assistant, datele introduse (text document, fișiere încărcate) sunt trimise către serverul nostru pentru procesare. Aceste date sunt transmise securizat și utilizate exclusiv pentru a genera analiza sau documentul solicitat.',
    'privacyAiUsage': 'Rezultate Generate de AI',
    'privacyAiUsageBody': 'Document Assistant folosește modele de inteligență artificială pentru a genera rezultate. Datele introduse sunt transmise modelului AI ca parte a cererii. AI-ul procesează datele în timp real și nu le reține după generarea răspunsului.',
    'privacyDataStorage': 'Stocarea Datelor',
    'privacyDataStorageBody': 'Document Assistant nu stochează permanent textul documentelor, conținutul fișierelor încărcate sau rezultatele generate pe serverele noastre. Datele introduse sunt procesate în memorie și eliminate după livrarea răspunsului. Preferința de limbă și un ID stabil de utilizator sunt stocate local pe dispozitivul tău. Contoarele de utilizare, statusul abonamentului și datele de drepturi sunt stocate pe server pentru aplicarea limitelor planului.',
    'privacySubscriptions': 'Abonamente și Drepturi',
    'privacySubscriptionsBody': 'Dacă te abonezi la un plan plătit, statusul abonamentului și datele de utilizare (număr de cereri, informații despre plan) pot fi procesate și stocate pentru aplicarea limitelor planului. Procesarea plăților este gestionată de furnizori terți de facturare.',
    'privacyThirdParty': 'Servicii Terțe și Publicitate',
    'privacyThirdPartyBody': 'Planul gratuit include reclame difuzate de rețele publicitare terțe. Aceste servicii pot colecta identificatori de dispozitiv și date de utilizare conform propriilor politici de confidențialitate.',
    'privacyContact': 'Contact',
    'privacyContactBody': 'Dacă ai întrebări despre modul în care sunt gestionate datele tale, te rugăm să folosești funcția Trimite Feedback din aplicație sau să ne contactezi prin setările aplicației.',
    'privacyLastUpdated': 'Ultima actualizare: iunie 2026',
  };
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      AppLocalizations.supportedLocales.map((l) => l.languageCode).contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async => AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
