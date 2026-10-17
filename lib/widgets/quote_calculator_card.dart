import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quick_order_sheet.dart';

class QuoteCalculatorCard extends StatefulWidget {
  const QuoteCalculatorCard({super.key});

  @override
  State<QuoteCalculatorCard> createState() => _QuoteCalculatorCardState();
}

class _QuoteCalculatorCardState extends State<QuoteCalculatorCard> {
  static const List<String> _calcServices = [
    'كتابة وتنسيق مذكرة تخرج (Word / LaTeX)',
    'تصميم سيرة ذاتية احترافية (CV)',
    'برمجة وتصميم موقع إلكتروني متجاوب',
    'تصميم عرض مناقشة PowerPoint',
    'تصميم بوستر علمي للمؤتمرات بـ LaTeX',
    'كتابة وتنسيق ملخصات دروس أو امتحانات',
  ];

  String _selectedService = _calcServices.first;
  double _pageCount = 30;
  String _urgency = 'موعد عادي (مرن)';

  String get _summaryText =>
      'الخدمة: $_selectedService | الحجم التقريبي: ${_pageCount.round()} صفحة/شريحة | الأولوية: $_urgency';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: JustStartTheme.royalViolet.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Text(
                    '● أداة تفاعلية ذكية',
                    style: TextStyle(
                      color: JustStartTheme.royalViolet,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'مُجهّز طلب الخدمة السريع',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              'حدد الخدمة وحجم العمل والأولوية الزمنية لتجهيز طلب مخصص فوراً.',
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : JustStartTheme.mutedSlate,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              '1. اختر نوع الخدمة',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedService,
              isExpanded: true,
              items: _calcServices
                  .map((s) => DropdownMenuItem(
                        value: s,
                        child: Text(s, style: const TextStyle(fontSize: 13.5)),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedService = val);
              },
            ),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '2. الحجم التقريبي (صفحة / شريحة)',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    gradient: JustStartTheme.brandGradient,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    '${_pageCount.round()} صفحة / شريحة',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Slider(
              value: _pageCount,
              min: 1,
              max: 150,
              divisions: 149,
              activeColor: JustStartTheme.royalViolet,
              inactiveColor: JustStartTheme.electricBlue.withOpacity(0.2),
              onChanged: (val) => setState(() => _pageCount = val),
            ),
            const SizedBox(height: 8),

            const Text(
              '3. أولوية التسليم',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('موعد عادي (مرن)')),
                    selected: _urgency == 'موعد عادي (مرن)',
                    onSelected: (_) => setState(() => _urgency = 'موعد عادي (مرن)'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ChoiceChip(
                    label: const Center(child: Text('مستعجل (أولوية قصوى)')),
                    selected: _urgency == 'مستعجل (أولوية قصوى)',
                    onSelected: (_) =>
                        setState(() => _urgency = 'مستعجل (أولوية قصوى)'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: JustStartTheme.royalViolet.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: JustStartTheme.royalViolet.withOpacity(0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ملخص طلبك الجاهز:',
                    style: TextStyle(
                      color: JustStartTheme.royalViolet,
                      fontWeight: FontWeight.w800,
                      fontSize: 12.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _summaryText,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            DecoratedBox(
              decoration: BoxDecoration(
                gradient: JustStartTheme.brandGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  QuickOrderSheet.show(
                    context,
                    initialService: _selectedService,
                    initialDetails:
                        'الحجم التقريبي: ${_pageCount.round()} صفحة/شريحة — الأولوية: $_urgency',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.send_rounded, size: 18),
                label: const Text(
                  'اطلب عرض السعر لهذه المواصفات',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
