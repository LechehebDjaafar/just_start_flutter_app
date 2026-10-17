import 'package:flutter/material.dart';
import '../data/just_start_data.dart';
import '../theme/app_theme.dart';
import '../widgets/image_lightbox_dialog.dart';
import '../widgets/quick_order_sheet.dart';

class PortfolioScreen extends StatefulWidget {
  final String? initialFilter;

  const PortfolioScreen({super.key, this.initialFilter});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
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
  Widget build(BuildContext context) {
    final list = JustStartCatalog.posts.where((p) {
      final matchCat = _selectedCat == 'all' || p.category == _selectedCat;
      final q = _searchQuery.trim().toLowerCase();
      final matchQ = q.isEmpty ||
          p.title.toLowerCase().contains(q) ||
          p.summary.toLowerCase().contains(q) ||
          p.badge.toLowerCase().contains(q);
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
                '● معرض المنشورات والنتائج المرن',
                style: TextStyle(
                  color: Color(0xFF38BDF8),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'منشوراتنا، عروضنا، ونتائج الطلبة',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'اضغط على أي صورة لتكبيرها بملء الشاشة وتقريبها بالإصبعين، أو اطلب خدمة مماثلة بضغطة واحدة.',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        TextField(
          onChanged: (v) => setState(() => _searchQuery = v),
          decoration: const InputDecoration(
            hintText: 'ابحث في المنشورات والنتائج (مذكرة، Python، CV، تمرين)...',
            prefixIcon: Icon(Icons.search_rounded),
          ),
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _filterChip('all', 'جميع المنشورات (${JustStartCatalog.posts.length})'),
              const SizedBox(width: 8),
              _filterChip('results', 'نتائج الطلبة وأعمالنا'),
              const SizedBox(width: 8),
              _filterChip('services', 'عروض الخدمات'),
              const SizedBox(width: 8),
              _filterChip('courses', 'أخبار الدورات'),
              const SizedBox(width: 8),
              _filterChip('tips', 'هوية المنصة'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        ...list.map(
          (p) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _buildPortfolioCard(context, p),
          ),
        ),
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

  Widget _buildPortfolioCard(BuildContext context, PostItem post) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => ImageLightboxDialog.show(
              context,
              imageAsset: post.imageAsset,
              title: post.title,
              description: post.summary,
              serviceTarget: post.serviceTarget,
            ),
            child: Stack(
              children: [
                Image.asset(
                  post.imageAsset,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/img/banner.jpg',
                    height: 220,
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
                      post.categoryLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.68),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: const Text(
                      '🔍 اضغط لتكبير الصورة',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      post.badge,
                      style: const TextStyle(
                        color: JustStartTheme.royalViolet,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      post.date,
                      style: const TextStyle(
                        color: JustStartTheme.mutedSlate,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  post.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  post.summary,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: JustStartTheme.mutedSlate,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: JustStartTheme.brandGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () => QuickOrderSheet.show(
                          context,
                          initialService: post.serviceTarget,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.send_rounded, size: 16),
                        label: Text(
                          post.actionText,
                          style: const TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () => ImageLightboxDialog.show(
                        context,
                        imageAsset: post.imageAsset,
                        title: post.title,
                        description: post.summary,
                        serviceTarget: post.serviceTarget,
                      ),
                      icon: const Icon(Icons.fullscreen_rounded),
                      label: const Text('معاينة كاملة'),
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
