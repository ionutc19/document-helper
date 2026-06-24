import '../models/explain_result.dart';
import '../models/create_result.dart';

class MockService {
  Future<ExplainResult> explainDocument({
    required String documentText,
    String language = 'en',
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final isRo = language == 'ro';
    return ExplainResult(
      summary: isRo
          ? 'Documentul conține informații importante referitoare la termeni și condiții. Au fost identificate mai multe obligații și termene limită care necesită atenție.'
          : 'The document contains important information regarding terms and conditions. Several obligations and deadlines have been identified that require attention.',
      keyPoints: isRo
          ? [
              'Documentul stabilește termenii unui acord între părți',
              'Sunt menționate termene limită specifice',
              'Se aplică condiții financiare și penalități',
              'Sunt incluse clauze de confidențialitate',
            ]
          : [
              'The document establishes the terms of an agreement between parties',
              'Specific deadlines are mentioned',
              'Financial conditions and penalties apply',
              'Confidentiality clauses are included',
            ],
      obligations: isRo
          ? [
              'Respectarea termenelor limită menționate',
              'Conformarea cu cerințele de raportare',
              'Menținerea confidențialității informațiilor',
            ]
          : [
              'Compliance with the mentioned deadlines',
              'Conformity with reporting requirements',
              'Maintaining confidentiality of information',
            ],
      risks: isRo
          ? [
              'Penalități pentru nerespectarea termenelor',
              'Posibile implicații legale în caz de neconformare',
            ]
          : [
              'Penalties for missing deadlines',
              'Possible legal implications in case of non-compliance',
            ],
      actionItems: isRo
          ? [
              'Revizuiți toate termenele limită și adăugați-le în calendar',
              'Consultați un specialist juridic pentru clarificări',
              'Pregătiți documentele necesare pentru conformare',
            ]
          : [
              'Review all deadlines and add them to your calendar',
              'Consult a legal specialist for clarifications',
              'Prepare the necessary documents for compliance',
            ],
    );
  }

  Future<CreateResult> createDocument({
    String documentText = '',
    required String outputType,
    required String instructions,
    String language = 'en',
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    final isRo = language == 'ro';

    String generated;
    if (outputType == 'complaint' || outputType == 'sesizare') {
      generated = isRo
          ? 'Către,\n\n[Instituția/Organizația]\n\nSubsemnatul/Subsemnata, [Nume], cu domiciliul în [Adresă], vă adresez prezenta sesizare prin care vă aduc la cunoștință următoarea situație:\n\n$instructions\n\nVă rog să luați măsurile necesare pentru remedierea situației descrise.\n\nCu stimă,\n[Nume]\n[Data]'
          : 'To,\n\n[Institution/Organization]\n\nI, [Name], residing at [Address], hereby submit this complaint to bring to your attention the following situation:\n\n$instructions\n\nI kindly request that you take the necessary measures to address the described situation.\n\nSincerely,\n[Name]\n[Date]';
    } else if (outputType == 'email') {
      generated = isRo
          ? 'Subiect: [Subiect]\n\nStimate/Stimată [Destinatar],\n\n$instructions\n\nVă mulțumesc pentru atenția acordată.\n\nCu stimă,\n[Nume]'
          : 'Subject: [Subject]\n\nDear [Recipient],\n\n$instructions\n\nThank you for your attention.\n\nBest regards,\n[Name]';
    } else {
      generated = isRo
          ? 'Către,\n\n[Destinatar]\n\n$instructions\n\nCu stimă,\n[Nume]\n[Data]'
          : 'To,\n\n[Recipient]\n\n$instructions\n\nSincerely,\n[Name]\n[Date]';
    }

    return CreateResult(
      generatedText: generated,
      outputType: outputType,
    );
  }

  Future<bool> submitFeedback({
    required String category,
    required String title,
    required String description,
    String email = '',
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return true;
  }
}
