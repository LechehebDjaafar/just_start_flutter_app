import 'package:flutter/material.dart';
import '../data/just_start_data.dart';
import '../theme/app_theme.dart';
import '../widgets/python_terminal_card.dart';
import '../widgets/quick_order_sheet.dart';

class CoursesScreen extends StatefulWidget {
  final String? initialFilter;

  const CoursesScreen({super.key, this.initialFilter});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String _selectedCat = 'all';

  @override
  void initState() {
    super.initState();
    if (widget.initialFilter != null) {
      _selectedCat = widget.initialFilter!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = JustStartCatalog.courses.where((c) {
      return _selectedCat == 'all' || c.category == _selectedCat;
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
                '● أكاديمية Just Start للتدريب عن بُعد',
                style: TextStyle(
                  color: Color(0xFF38BDF8),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'تعلّم المهارات البرمجية والأكاديمية الأكثر طلباً',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'دورات تدريبية تطبيقية مصممة خصيصاً للطلبة الجامعيين والباحثين والمبتدئين في البرمجة بشرح مبسط ومرافقة خطوة بخطوة.',
                style: TextStyle(color: Color(0xFFCBD5E1), fontSize: 13),
              ),
              SizedBox(height: 14),
              PythonTerminalCard(fileName: 'python_academy.py'),
            ],
          ),
        ),
        const SizedBox(height: 14),

        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _filterChip('all', 'جميع الدورات (4)'),
              const SizedBox(width: 8),
              _filterChip('programming', 'البرمجة وتطوير الويب'),
              const SizedBox(width: 8),
              _filterChip('academic-tools', 'أدوات البحث العلمي LaTeX'),
              const SizedBox(width: 8),
              _filterChip('office', 'الأوفيس الأكاديمي'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        ...list.map(
          (course) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _buildCourseCard(context, course),
          ),
        ),

        const SizedBox(height: 12),
        const Text(
          '● منهجية التدريب',
          style: TextStyle(
            color: JustStartTheme.royalViolet,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
        const Text(
          'كيف تدرس معنا في دورات Just Start؟',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 10),
        _buildMethodologyCard(
          '01',
          'حصص مباشرة ومسجلة',
          'تجمع الدورات بين الشرح المباشر التفاعلي والتسجيلات التي يمكنك مراجعتها في أي وقت من هاتفك أو حاسوبك.',
        ),
        _buildMethodologyCard(
          '02',
          'تطبيقات وتمارين أسبوعية',
          'بعد كل محور تطبيقي، تنجز تمارين عملية يصححها معك المؤطر لضمان الفهم الحقيقي.',
        ),
        _buildMethodologyCard(
          '03',
          'مجموعة متابعة خاصة',
          'تواصل مباشر مع المدرب وزملائك في الدورة لطرح الأسئلة وحل المشكلات البرمجية والتقنية.',
        ),
        _buildMethodologyCard(
          '04',
          'مشروع ختامي تطبيقي',
          'تختتم كل دورة بإنجاز مشروع عملي متكامل يضاف إلى سيرتك الذاتية ومعرض أعمالك.',
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

  Widget _buildCourseCard(BuildContext context, CourseItem c) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Image.asset(
                c.imageAsset,
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
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: JustStartTheme.emeraldBadge,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    c.status,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: JustStartTheme.midnightNavy.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text(
                    c.level,
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  c.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  c.subtitle,
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: JustStartTheme.mutedSlate,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  children: [
                    Text(
                      '📡 ${c.mode}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: JustStartTheme.royalViolet,
                      ),
                    ),
                    Text(
                      '🗓 ${c.duration}',
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                        color: JustStartTheme.electricBlue,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'محاور الدورة:',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 6),
                ...c.topics.map(
                  (t) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_rounded,
                          size: 16,
                          color: JustStartTheme.emeraldBadge,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            t,
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: JustStartTheme.royalViolet.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '🎯 مخرجات الدورة: ${c.outcomes}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '✔ شهادة ومرافقة تطبيقية',
                      style: TextStyle(
                        color: JustStartTheme.emeraldBadge,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w800,
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
                          initialService: 'التسجيل في ${c.title}',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.how_to_reg_rounded, size: 18),
                        label: const Text(
                          'سجّل الآن',
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

  Widget _buildMethodologyCard(String numStr, String title, String desc) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: JustStartTheme.royalViolet.withOpacity(0.12),
          child: Text(
            numStr,
            style: const TextStyle(
              color: JustStartTheme.royalViolet,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14.5),
        ),
        subtitle: Text(desc, style: const TextStyle(fontSize: 12.5)),
      ),
    );
  }
}
