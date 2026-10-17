import 'dart:async';
import 'package:flutter/material.dart';
import '../data/just_start_data.dart';
import '../services/order_dispatcher.dart';
import '../theme/app_theme.dart';
import '../widgets/image_lightbox_dialog.dart';
import '../widgets/python_terminal_card.dart';
import '../widgets/quick_order_sheet.dart';

class HomeScreen extends StatefulWidget {
  final void Function(int tabIndex, {String? filter}) onNavigateTab;

  const HomeScreen({super.key, required this.onNavigateTab});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _wordIndex = 0;
  Timer? _wordTimer;
  String _searchQuery = '';

  int _rateQuality = 5;
  int _rateSpeed = 5;
  int _rateService = 5;
  final _fbNameController = TextEditingController();
  final _fbCommentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _wordTimer = Timer.periodic(const Duration(milliseconds: 2800), (_) {
      if (!mounted) return;
      setState(() {
        _wordIndex = (_wordIndex + 1) % AppConfig.rotatingHeroWords.length;
      });
    });
  }

  @override
  void dispose() {
    _wordTimer?.cancel();
    _fbNameController.dispose();
    _fbCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredServices = JustStartCatalog.services.where((s) {
      if (_searchQuery.trim().isEmpty) return true;
      final q = _searchQuery.trim().toLowerCase();
      return s.title.toLowerCase().contains(q) ||
          s.shortDesc.toLowerCase().contains(q);
    }).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 100),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: JustStartTheme.darkStageGradient,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: JustStartTheme.royalViolet.withOpacity(0.25),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(99),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Text(
                  '✨ منصة الخدمات الرقمية والأكاديمية الأولى للطلبة وأصحاب المشاريع',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'من الفكرة إلى المناقشة، نُنجز لك',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 350),
                child: ShaderMask(
                  key: ValueKey<int>(_wordIndex),
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFFA78BFA), Color(0xFF38BDF8)],
                  ).createShader(bounds),
                  child: Text(
                    AppConfig.rotatingHeroWords[_wordIndex],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const Text(
                'بدقة واحترافية.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'نكتب ونصمم لك الملخصات ومذكرات التخرج وعروض PowerPoint والسيرة الذاتية وبوسترات LaTeX، ونبرمج موقعك وندربك في دوراتنا العملية.',
                style: TextStyle(
                  color: Color(0xFFE2E8F0),
                  fontSize: 13.5,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 16),

              TextField(
                onChanged: (val) => setState(() => _searchQuery = val),
                style: const TextStyle(color: JustStartTheme.midnightNavy),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'ابحث عن خدمة أو دورة (مذكرة، Python، CV، موقع)...',
                  hintStyle: const TextStyle(
                    color: JustStartTheme.mutedSlate,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: JustStartTheme.royalViolet,
                  ),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () => setState(() => _searchQuery = ''),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  'assets/img/banner.jpg',
                  height: 145,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _statBadge('+30', 'مشروع ومذكرة'),
                  const SizedBox(width: 8),
                  _statBadge('+2800', 'متابع يثق بنا'),
                  const SizedBox(width: 8),
                  _statBadge('7+', 'خدمات ودورات'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: JustStartTheme.brandGradient,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () => QuickOrderSheet.show(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        icon: const Icon(Icons.rocket_launch_rounded, size: 18),
                        label: const Text(
                          'اطلب عرض سعر الآن',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => widget.onNavigateTab(2),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 13,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'الدورات التدريبية',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),

        const Text(
          'التصنيفات السريعة',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: JustStartCatalog.quickCategories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, idx) {
              final cat = JustStartCatalog.quickCategories[idx];
              return ActionChip(
                avatar: Icon(
                  cat.icon,
                  size: 18,
                  color: JustStartTheme.royalViolet,
                ),
                label: Text(
                  cat.label,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                onPressed: () => widget.onNavigateTab(
                  cat.targetTabIndex,
                  filter: cat.filterCategory,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '● خدماتنا الاحترافية',
                    style: TextStyle(
                      color: JustStartTheme.royalViolet,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'كل ما يحتاجه الطالب والأستاذ وصاحب المشروع',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => widget.onNavigateTab(1),
              child: const Text(
                'عرض الكل (7) ←',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 365,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filteredServices.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final s = filteredServices[index];
              return SizedBox(
                width: 285,
                child: _buildServicePreviewCard(context, s),
              );
            },
          ),
        ),
        const SizedBox(height: 26),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: isDark ? JustStartTheme.darkCard : const Color(0xFF1E1B4B),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: JustStartTheme.emeraldBadge.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: const Text(
                  '🔥 الدورة الأكثر طلباً للطلبة',
                  style: TextStyle(
                    color: Color(0xFF34D399),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'تريد تعلم Python من الصفر؟',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'انضم إلى دورتنا التفاعلية عن بُعد وابدأ خطوة بخطوة من الأساسيات والمتغيرات والشروط والحلقات والدوال حتى بناء مشاريع حقيقية.',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13.5),
              ),
              const SizedBox(height: 14),
              const PythonTerminalCard(),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => QuickOrderSheet.show(
                        context,
                        initialService: 'التسجيل في دورة Python للمبتدئين',
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: JustStartTheme.electricBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.school_rounded, size: 18),
                      label: const Text(
                        'سجّل في دورة Python الآن',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  OutlinedButton(
                    onPressed: () => widget.onNavigateTab(2),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white38),
                      padding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('كل الدورات (4)'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 26),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '● منشوراتنا ونتائج الطلبة',
                  style: TextStyle(
                    color: JustStartTheme.royalViolet,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'أحدث المنشورات والعروض والأعمال',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            TextButton(
              onPressed: () => widget.onNavigateTab(3),
              child: const Text(
                'المعرض الكامل ←',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...JustStartCatalog.posts.take(3).map(
              (post) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildPostCard(context, post),
              ),
            ),
        const SizedBox(height: 20),

        const Text(
          '● خطوات واضحة',
          style: TextStyle(
            color: JustStartTheme.royalViolet,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Text(
          'كيف نعمل معك من أول رسالة حتى التسليم',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        _buildWorkflowSteps(),
        const SizedBox(height: 24),

        _buildDirectChannelsCard(context),
        const SizedBox(height: 24),

        _buildFeedbackCard(context),
        const SizedBox(height: 24),

        const Text(
          '● إجابات سريعة',
          style: TextStyle(
            color: JustStartTheme.royalViolet,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Text(
          'الأسئلة الشائعة',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        ...JustStartCatalog.faqs.map(
          (faq) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ExpansionTile(
              title: Text(
                faq['q']!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
              children: [
                Text(
                  faq['a']!,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: isDark ? Colors.white70 : JustStartTheme.mutedSlate,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _statBadge(String numText, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          children: [
            Text(
              numText,
              style: const TextStyle(
                color: Color(0xFF38BDF8),
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServicePreviewCard(BuildContext context, ServiceItem s) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: JustStartTheme.darkStageGradient,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: JustStartTheme.electricBlue.withOpacity(0.22),
              borderRadius: BorderRadius.circular(99),
            ),
            child: Text(
              s.badge,
              style: const TextStyle(
                color: Color(0xFF7DD3FC),
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            s.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            s.shortDesc,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 12.5),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              s.imageAsset,
              height: 125,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/img/banner.jpg',
                height: 125,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '⏱ ${s.turnaround}',
                style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 11.5),
              ),
              ElevatedButton.icon(
                onPressed: () => QuickOrderSheet.show(
                  context,
                  initialService: s.title,
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: JustStartTheme.electricBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(Icons.send_rounded, size: 15),
                label: const Text(
                  'اطلب الخدمة',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, PostItem post) {
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
                  height: 185,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Image.asset(
                    'assets/img/banner.jpg',
                    height: 185,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
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
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: const Text(
                      '🔍 تكبير الصورة',
                      style: TextStyle(color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
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
                    fontSize: 15.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  post.summary,
                  style: const TextStyle(
                    fontSize: 13,
                    color: JustStartTheme.mutedSlate,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () => QuickOrderSheet.show(
                        context,
                        initialService: post.serviceTarget,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: JustStartTheme.royalViolet,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        post.actionText,
                        style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w800,
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
                      icon: const Icon(Icons.zoom_in_rounded, size: 18),
                      label: const Text('عرض التفاصيل'),
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

  Widget _buildWorkflowSteps() {
    const steps = [
      {
        'num': '01',
        'title': 'راسلنا بفكرتك',
        'desc': 'أرسل تفاصيل طلبك أو مذكرتك عبر التطبيق إلى واتساب أو فيسبوك أو البريد.',
      },
      {
        'num': '02',
        'title': 'نتفق على التفاصيل',
        'desc': 'نحدد المطلوب بدقة والجدول الزمني ونقدم لك عرض سعر واضح ومناسب.',
      },
      {
        'num': '03',
        'title': 'ننجز ونراجع معك',
        'desc': 'تصلك مسودة أولية للاطلاع وإبداء ملاحظاتك قبل اعتماد النسخة النهائية.',
      },
      {
        'num': '04',
        'title': 'تستلم عملك جاهزاً',
        'desc': 'تستلم ملفاتك مفتوحة المصدر وجاهزة للطباعة أو المناقشة أو النشر الفوري.',
      },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: steps.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.25,
      ),
      itemBuilder: (context, i) {
        final st = steps[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  st['num']!,
                  style: const TextStyle(
                    color: JustStartTheme.electricBlue,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  st['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: Text(
                    st['desc']!,
                    style: const TextStyle(
                      fontSize: 11.5,
                      color: JustStartTheme.mutedSlate,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDirectChannelsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'قنوات التواصل المباشر',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            const Text(
              'فريقنا متواجد للرد السريع على استفساراتكم طوال أيام الأسبوع.',
              style: TextStyle(fontSize: 13, color: JustStartTheme.mutedSlate),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0x1F25D366),
                child: Icon(Icons.chat_rounded, color: JustStartTheme.whatsappGreen),
              ),
              title: const Text(
                'واتساب المباشر',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text(
                AppConfig.whatsappDisplay,
                textDirection: TextDirection.ltr,
              ),
              trailing: const Icon(Icons.open_in_new_rounded, size: 18),
              onTap: () => OrderDispatcher.openExternalUrl(
                'https://wa.me/${AppConfig.whatsappNumber}',
              ),
            ),
            const Divider(height: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0x1F1877F2),
                child: Icon(Icons.facebook_rounded, color: JustStartTheme.facebookBlue),
              ),
              title: const Text(
                'صفحة فيسبوك الرسمية',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text('Just Start - إبدأ الآن'),
              trailing: const Icon(Icons.open_in_new_rounded, size: 18),
              onTap: () => OrderDispatcher.openExternalUrl(AppConfig.facebookUrl),
            ),
            const Divider(height: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0x1F6D28D9),
                child: Icon(Icons.camera_alt_outlined, color: JustStartTheme.royalViolet),
              ),
              title: const Text(
                'حساب إنستغرام',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: const Text(
                AppConfig.instagramHandle,
                textDirection: TextDirection.ltr,
              ),
              trailing: const Icon(Icons.open_in_new_rounded, size: 18),
              onTap: () => OrderDispatcher.openExternalUrl(AppConfig.instagramUrl),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '● تقييم العملاء',
              style: TextStyle(
                color: JustStartTheme.royalViolet,
                fontSize: 12,
                fontWeight: FontWeight.w800,
              ),
            ),
            const Text(
              'رأيك يهمنا ⭐',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            const Text(
              'ملاحظاتك تساعدنا على تطوير خدماتنا ودوراتنا باستمرار.',
              style: TextStyle(fontSize: 13, color: JustStartTheme.mutedSlate),
            ),
            const SizedBox(height: 12),
            _starRow(
              'جودة الخدمة:',
              _rateQuality,
              (v) => setState(() => _rateQuality = v),
            ),
            _starRow(
              'سرعة التسليم:',
              _rateSpeed,
              (v) => setState(() => _rateSpeed = v),
            ),
            _starRow(
              'التعامل والتواصل:',
              _rateService,
              (v) => setState(() => _rateService = v),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fbNameController,
              decoration: const InputDecoration(
                hintText: 'اسمك الكريم (اختياري)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fbCommentController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'ما الذي أعجبك؟ وما الذي نستطيع تحسينه؟',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => OrderDispatcher.dispatchFeedback(
                      context: context,
                      channel: DispatchChannel.whatsapp,
                      qualityStars: _rateQuality,
                      speedStars: _rateSpeed,
                      serviceStars: _rateService,
                      userName: _fbNameController.text,
                      comment: _fbCommentController.text,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: JustStartTheme.whatsappGreen,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.chat_rounded, size: 17),
                    label: const Text(
                      'إرسال عبر واتساب',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () => OrderDispatcher.dispatchFeedback(
                    context: context,
                    channel: DispatchChannel.email,
                    qualityStars: _rateQuality,
                    speedStars: _rateSpeed,
                    serviceStars: _rateService,
                    userName: _fbNameController.text,
                    comment: _fbCommentController.text,
                  ),
                  icon: const Icon(Icons.mail_outline_rounded, size: 17),
                  label: const Text('بالبريد'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _starRow(String label, int current, ValueChanged<int> onSelect) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
          ),
          Row(
            children: List.generate(5, (idx) {
              final starVal = idx + 1;
              return IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => onSelect(starVal),
                icon: Icon(
                  starVal <= current
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: const Color(0xFFF59E0B),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
