import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../services/billing_service.dart';

class PlansScreen extends StatefulWidget {
  const PlansScreen({super.key});

  @override
  State<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends State<PlansScreen> {
  bool _purchasing = false;

  Future<void> _purchase(String productId) async {
    setState(() => _purchasing = true);
    try {
      await BillingService().purchase(productId);
    } finally {
      if (mounted) setState(() => _purchasing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l.plans)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              l.choosePlan,
              style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              l.planSubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _PlanCard(
              title: l.freePlan,
              price: l.freePlanPrice,
              features: [
                l.freePlanFeature1,
                l.freePlanFeature2,
                l.freePlanFeature3,
              ],
              isCurrent: true,
              onSelect: null,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            _PlanCard(
              title: l.premiumPlan,
              price: l.premiumPlanPrice,
              features: [
                l.premiumPlanFeature1,
                l.premiumPlanFeature2,
                l.premiumPlanFeature3,
              ],
              isCurrent: false,
              isRecommended: true,
              isPurchasing: _purchasing,
              onSelect: () => _purchase('docassist_premium_monthly'),
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            _PlanCard(
              title: l.proPlan,
              price: l.proPlanPrice,
              features: [
                l.proPlanFeature1,
                l.proPlanFeature2,
                l.proPlanFeature3,
              ],
              isCurrent: false,
              isPurchasing: _purchasing,
              onSelect: () => _purchase('docassist_pro_monthly'),
              color: theme.colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool isCurrent;
  final bool isRecommended;
  final bool isPurchasing;
  final VoidCallback? onSelect;
  final Color color;

  const _PlanCard({
    required this.title,
    required this.price,
    required this.features,
    required this.isCurrent,
    this.isRecommended = false,
    this.isPurchasing = false,
    required this.onSelect,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: isRecommended ? BorderSide(color: color, width: 2) : BorderSide.none,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                ),
                if (isRecommended) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      l.recommended,
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 4),
            Text(
              price,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, size: 18, color: color),
                      const SizedBox(width: 8),
                      Expanded(child: Text(f, style: Theme.of(context).textTheme.bodySmall)),
                    ],
                  ),
                )),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: isCurrent
                  ? OutlinedButton(
                      onPressed: null,
                      child: Text(l.currentPlan),
                    )
                  : FilledButton(
                      onPressed: isPurchasing ? null : onSelect,
                      style: FilledButton.styleFrom(backgroundColor: color),
                      child: isPurchasing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : Text(l.selectPlan),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
