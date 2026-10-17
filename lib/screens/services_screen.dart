import 'package:flutter/material.dart';
import '../data/just_start_data.dart';
import '../theme/app_theme.dart';
import '../widgets/image_lightbox_dialog.dart';
import '../widgets/quick_order_sheet.dart';
import '../widgets/quote_calculator_card.dart';

class ServicesScreen extends StatefulWidget {
  final String? initialFilter;

  const ServicesScreen({super.key, this.initialFilter});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String _selectedCat = 'all';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    if (widget.initialFilter != null) {
      _selectedCat = widget.initialFilter!;
    }
  }

  @override
  void didUpdateWidget(covariant ServicesScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialFilter != null &&
        widget.initialFilter != oldWidget.initialFilter) {
      setState(() => _selectedCat = widget.initialFilter!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = JustStartCatalog.services.where((s) {
      final matchCat = _selectedCat == 'all' || s.category == _selectedCat;
      final q = _searchQuery.trim().toLowerCase();
      final matchQ = q.isEmpty ||
          s.title.toLowerCase().contains(q) ||
          s.shortDesc.toLowerCase().contains(q);
      return matchCat && matchQ;
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: JustStartTheme.darkStageGradient,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '● دليل الخدمات الشامل',
                style: TextStyle(
                  color: Color(0xFF38BDF8),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'خدمات رقمية وأكاديمية مصممة لنجاحك',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'اختر الخدمة المناسبة لك، أو استعمل حاسبة الطلب الذكية بالأسفل لتحديد تفاصيل مشروعك وإرساله في ثوانٍ.',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        TextField(
          onChanged: (v) => setState(() => _searchQuery = v),
          decoration: const InputDecoration(
            hintText: 'ابحث في الخدمات (مذكرة، CV، PowerPoint، LaTeX)...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _filterChip('all', 'كل الخدمات (7)'),
              const SizedBox(width: 8),
              _filterChip('academic', 'مذكرات وملخصات وعروض'),
              const SizedBox(width: 8),
              _filterChip('digital', 'برمجة وتصميم المواقع'),
              const SizedBox(width: 8),
              _filterChip('career', 'السيرة الذاتية CV'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        ...list.map(
          (s) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _buildFullServiceCard(context, s),
          ),
        ),

        const SizedBox(height: 12),
        const QuoteCalculatorCard(),
      ],
    );
  }

  Widget _filterChip(String key, String label) {
    final active = _selectedCat == key;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: active ? Colors.white : null,
        ),
      ),
      selected: active,
      selectedColor: JustStartTheme.royalViolet,
      onSelected: (_) => setState(() => _selectedCat = key),
    );
  }

  Widget _buildFullServiceCard(BuildContext context, ServiceItem s) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => ImageLightboxDialog.show(
              context,
              imageAsset: s.imageAsset,
              title: s.title,
              description: s.shortDesc,
              serviceTarget: s.title,
            ),
            child: Stack(
              children: [
                Image.asset(
                  s.imageAsset,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/img/banner.jpg',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: JustStartTheme.brandGradient,
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      s.badge,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  s.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  s.shortDesc,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: JustStartTheme.mutedSlate,
                  ),
                ),
                const SizedBox(height: 12),
                ...s.deliverables.map(
                  (d) => Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          size: 17,
                          color: JustStartTheme.emeraldBadge,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            d,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(height: 22),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '⏱ مدة الإنجاز: ${s.turnaround}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: JustStartTheme.mutedSlate,
                      ),
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: JustStartTheme.brandGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () => QuickOrderSheet.show(
                          context,
                          initialService: s.title,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                        ),
                        icon: const Icon(Icons.send_rounded, size: 16),
                        label: const Text(
                          'اطلب الخدمة',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
