import 'package:flutter/material.dart';

/// مركز البيانات المرن لتطبيق Just Start - إبدأ الآن
/// (المقابل المباشر لملف js/posts.js في الموقع)
class AppConfig {
  static const String appTitle = 'Just Start - إبدأ الآن';
  static const String brandName = 'Just Start';
  static const String tagline = 'إبدأ الآن · تعلّم · طوّر · أنجز';
  static const String location = 'تقرت، الجزائر (نخدمكم عن بُعد في كل الولايات)';
  static const String whatsappNumber = '213658301420';
  static const String whatsappDisplay = '0658 30 14 20';
  static const String facebookUrl =
      'https://www.facebook.com/profile.php?id=100083285199781';
  static const String messengerUrl = 'https://m.me/100083285199781';
  static const String instagramUrl = 'https://www.instagram.com/juststart02';
  static const String instagramHandle = '@juststart02';
  static const String email = 'support.juststart@gmail.com';

  static const List<String> rotatingHeroWords = [
    'مذكرات التخرج',
    'عروض PowerPoint',
    'دورة Python من الصفر',
    'تصميم السيرة الذاتية',
    'بوسترات LaTeX العلمية',
    'تطوير المواقع الإلكترونية',
  ];

  static const String pythonLiveSnippet = '''# دورة Python من الصفر مع Just Start
student = 'طالب جامعي طموح'
skills = ['أساسيات البرمجة', 'الشروط والحلقات', 'الدوال', 'مشاريع عملية']

def start_journey(name, topics):
    print(f'مرحباً {name} في أكاديمية Just Start!')
    for step, topic in enumerate(topics, 1):
        print(f'الخطوة {step}: إتقان {topic} ✔')
    return 'جاهز للانطلاق في عالم البرمجة 🚀'

print(start_journey(student, skills))''';
}

class ServiceItem {
  final String id;
  final String category;
  final String badge;
  final String title;
  final String shortDesc;
  final List<String> deliverables;
  final String turnaround;
  final String imageAsset;
  final String iconAsset;

  const ServiceItem({
    required this.id,
    required this.category,
    required this.badge,
    required this.title,
    required this.shortDesc,
    required this.deliverables,
    required this.turnaround,
    required this.imageAsset,
    required this.iconAsset,
  });
}

class CourseItem {
  final String id;
  final String category;
  final String status;
  final String level;
  final String mode;
  final String duration;
  final String title;
  final String subtitle;
  final String imageAsset;
  final List<String> topics;
  final String outcomes;

  const CourseItem({
    required this.id,
    required this.category,
    required this.status,
    required this.level,
    required this.mode,
    required this.duration,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.topics,
    required this.outcomes,
  });
}

class PostItem {
  final String id;
  final String category;
  final String categoryLabel;
  final String date;
  final String badge;
  final String title;
  final String summary;
  final String imageAsset;
  final String actionText;
  final String serviceTarget;

  const PostItem({
    required this.id,
    required this.category,
    required this.categoryLabel,
    required this.date,
    required this.badge,
    required this.title,
    required this.summary,
    required this.imageAsset,
    required this.actionText,
    required this.serviceTarget,
  });
}

class QuickCategoryChip {
  final String label;
  final IconData icon;
  final int targetTabIndex;
  final String? filterCategory;

  const QuickCategoryChip({
    required this.label,
    required this.icon,
    required this.targetTabIndex,
    this.filterCategory,
  });
}

class JustStartCatalog {
  static const List<QuickCategoryChip> quickCategories = [
    QuickCategoryChip(
      label: 'مذكرات التخرج',
      icon: Icons.school_rounded,
      targetTabIndex: 1,
      filterCategory: 'academic',
    ),
    QuickCategoryChip(
      label: 'ملخصات الدروس',
      icon: Icons.description_rounded,
      targetTabIndex: 1,
      filterCategory: 'academic',
    ),
    QuickCategoryChip(
      label: 'عروض PowerPoint',
      icon: Icons.slideshow_rounded,
      targetTabIndex: 1,
      filterCategory: 'academic',
    ),
    QuickCategoryChip(
      label: 'سيرة ذاتية CV',
      icon: Icons.badge_rounded,
      targetTabIndex: 1,
      filterCategory: 'career',
    ),
    QuickCategoryChip(
      label: 'بوسترات LaTeX',
      icon: Icons.science_rounded,
      targetTabIndex: 1,
      filterCategory: 'academic',
    ),
    QuickCategoryChip(
      label: 'برمجة المواقع',
      icon: Icons.code_rounded,
      targetTabIndex: 1,
      filterCategory: 'digital',
    ),
    QuickCategoryChip(
      label: 'دورة Python',
      icon: Icons.terminal_rounded,
      targetTabIndex: 2,
      filterCategory: 'programming',
    ),
    QuickCategoryChip(
      label: 'نتائجنا وأعمالنا',
      icon: Icons.workspace_premium_rounded,
      targetTabIndex: 3,
      filterCategory: 'results',
    ),
  ];

  static const List<ServiceItem> services = [
    ServiceItem(
      id: 'svc-thesis',
      category: 'academic',
      badge: 'الأكثر طلباً للطلبة',
      title: 'كتابة وتنسيق مذكرات التخرج',
      shortDesc:
          'مرافقة شاملة من اختيار الموضوع والخطة حتى التنسيق النهائي وجاهزية المناقشة.',
      deliverables: [
        'تنسيق احترافي بـ Word أو LaTeX',
        'فهرسة آلية للمراجع والجداول',
        'مراجعة لغوية ومنهجية شاملة',
        'نسخة PDF جاهزة للطباعة',
      ],
      turnaround: 'حسب حجم المذكرة',
      imageAsset: 'assets/img/services/mimear.webp',
      iconAsset: 'assets/img/icons/icon-thesis.jpg',
    ),
    ServiceItem(
      id: 'svc-cv',
      category: 'career',
      badge: 'تصميم احترافي ATS',
      title: 'تصميم السيرة الذاتية الاحترافية (CV)',
      shortDesc:
          'سيرة ذاتية عصرية تبرز مهاراتك وخبراتك وتجذب مسؤولي التوظيف باللغات الثلاث.',
      deliverables: [
        'تصميم أنيق ومنظم',
        'توافق مع أنظمة الفرز ATS',
        'متوفر بالعربية والفرنسية والإنجليزية',
        'تسليم بصيغة PDF + ملف قابل للتعديل',
      ],
      turnaround: '24 إلى 48 ساعة',
      imageAsset: 'assets/img/cv.webp',
      iconAsset: 'assets/img/icons/icon-web-cv.jpg',
    ),
    ServiceItem(
      id: 'svc-web',
      category: 'digital',
      badge: 'متجاوب 100% مع الهاتف',
      title: 'برمجة وتصميم المواقع الإلكترونية',
      shortDesc:
          'نصمم ونبرمج مواقع تعريفية ومتاجر ومشاريع تخرج سريعة وعصرية تعمل بامتياز على الهاتف.',
      deliverables: [
        'مواقع تعريفية ومواقع مشاريع ومتاجر',
        'تجاوب كامل مع الهاتف والحاسوب',
        'سرعة تصفح عالية وتجربة مستخدم سلسة',
        'دعم ومتابعة تقنية بعد التسليم',
      ],
      turnaround: '3 إلى 10 أيام',
      imageAsset: 'assets/img/web.jpg',
      iconAsset: 'assets/img/icons/icon-web-cv.jpg',
    ),
    ServiceItem(
      id: 'svc-ppt',
      category: 'academic',
      badge: 'عروض مناقشة تفاعلية',
      title: 'إعداد عروض PowerPoint الاحترافية',
      shortDesc:
          'عروض تقديمية منظمة وبصرية تدعم إلقاءك أمام لجنة المناقشة أو في الملتقيات.',
      deliverables: [
        'تصميم شرائح مخصص بهوية موحدة',
        'إنفوغرافيك ومخططات توضيحية',
        'أنميشن وانتقالات سلسة غير مشتتة',
        'ملف PPTX مفتوح + PDF',
      ],
      turnaround: '2 إلى 4 أيام',
      imageAsset: 'assets/img/services/service-ppt.webp',
      iconAsset: 'assets/img/icons/icon-office.jpg',
    ),
    ServiceItem(
      id: 'svc-latex',
      category: 'academic',
      badge: 'دقة أكاديمية عالية',
      title: 'بوسترات ومقالات علمية بـ LaTeX',
      shortDesc:
          'كتابة وتصميم البوسترات العلمية للمؤتمرات والملتقيات والمقالات الرياضية بدقة مطبعية.',
      deliverables: [
        'بوستر مؤتمرات مقاس A0/A1 عالي الدقة',
        'كتابة المعادلات الرياضية والخوارزميات',
        'قوالب Beamer للمناقشات العلمية',
        'ملف الكود المصدري .tex + PDF',
      ],
      turnaround: '2 إلى 5 أيام',
      imageAsset: 'assets/img/services/service-latex.jpg',
      iconAsset: 'assets/img/icons/icon-latex.jpg',
    ),
    ServiceItem(
      id: 'svc-summaries',
      category: 'academic',
      badge: 'للأساتذة والطلبة',
      title: 'كتابة ملخصات الدروس والمطبوعات',
      shortDesc:
          'تحويل المحاضرات والدروس الخطية إلى ملخصات ومطبوعات رقمية منظمة وجاهزة للطباعة.',
      deliverables: [
        'تنظيم العناوين والفقرات والجداول',
        'إضافة الرسوم التوضيحية والمخططات',
        'تنسيق مريح للقراءة والمراجعة',
        'تسليم بصيغة Word و PDF',
      ],
      turnaround: '2 إلى 6 أيام',
      imageAsset: 'assets/img/services/service-summaries.webp',
      iconAsset: 'assets/img/icons/icon-summaries.jpg',
    ),
    ServiceItem(
      id: 'svc-exams',
      category: 'academic',
      badge: 'نماذج جاهزة للطباعة',
      title: 'صياغة أسئلة الاختبارات والتمارين',
      shortDesc:
          'كتابة وتنسيق مواضيع الامتحانات وسلاسل التمارين مع الحلول النموذجية للأساتذة والمدارس.',
      deliverables: [
        'تنسيق أكاديمي رسمي مع ترويسة المؤسسة',
        'كتابة رموز ومعادلات دقيقة',
        'إمكانية إرفاق سلم التنقيط والحل',
        'جاهز للطباعة الفورية',
      ],
      turnaround: '24 إلى 72 ساعة',
      imageAsset: 'assets/img/services/service-exams.webp',
      iconAsset: 'assets/img/icons/icon-summaries.jpg',
    ),
  ];

  static const List<CourseItem> courses = [
    CourseItem(
      id: 'course-python',
      category: 'programming',
      status: 'التسجيل مفتوح الآن',
      level: 'مبتدئ (من الصفر)',
      mode: 'عن بُعد (أونلاين تفاعلي)',
      duration: '6 أسابيع · تطبيقات عملية',
      title: 'دورة تعلم لغة Python من الصفر للمبتدئين',
      subtitle:
          'انطلق في عالم البرمجة بخطوات واضحة ومبسطة حتى لو لم تكتب سطر كود من قبل.',
      imageAsset: 'assets/img/posts/python.webp',
      topics: [
        'أساسيات لغة Python وبيئة العمل',
        'المتغيرات وأنواع البيانات والعمليات الحسابية',
        'الجمل الشرطية (if / else) والتحكم في المسار',
        'الحلقات التكرارية (for / while) ومعالجة القوائم',
        'بناء الدوال (Functions) وتنظيم الكود',
        'تمارين ومشاريع تطبيقية لبناء الثقة العملية',
      ],
      outcomes:
          'كتابة برامج Python كاملة، حل الخوارزميات الأساسية، وبناء مشروع التخرج المصغر.',
    ),
    CourseItem(
      id: 'course-latex',
      category: 'academic-tools',
      status: 'دفعة جديدة قريباً',
      level: 'مبتدئ إلى متقدم',
      mode: 'عن بُعد (تطبيقي)',
      duration: '4 أسابيع · موجه للباحثين',
      title: 'دورة LaTeX الشاملة لطلبة الماستر والدكتوراه',
      subtitle:
          'احترف تنسيق المذكرات، الأطروحات، المقالات العلمية، وبوسترات المؤتمرات بدون أخطاء التنسيق التقليدية.',
      imageAsset: 'assets/img/icons/icon-latex.jpg',
      topics: [
        'مدخل إلى Overleaf وهيكلة مستند LaTeX',
        'كتابة المعادلات الرياضية والمصفوفات والخوارزميات',
        'إدراج الجداول والأشكال عالية الدقة',
        'إدارة المراجع والفهرسة الآلية بـ BibTeX',
        'تصميم عروض Beamer وبوسترات المؤتمرات العلمية',
      ],
      outcomes:
          'إعداد مذكرة تخرج أو ورقة بحثية كاملة جاهزة للنشر الأكاديمي.',
    ),
    CourseItem(
      id: 'course-office',
      category: 'office',
      status: 'التسجيل مفتوح',
      level: 'جميع المستويات',
      mode: 'عن بُعد (مسجل + مباشر)',
      duration: '3 أسابيع · مكثفة',
      title: 'دورة الأوفيس الأكاديمي (Word + PowerPoint + Excel)',
      subtitle:
          'كل المهارات الرقمية التي يحتاجها الطالب الجامعي لإنجاز بحوثه وعروضه وجداوله باحترافية وسرعة.',
      imageAsset: 'assets/img/icons/icon-office.jpg',
      topics: [
        'التنسيق الآلي للمذكرات والفهارس في Word',
        'تصميم عروض مناقشة تفاعلية وجذابة في PowerPoint',
        'تنظيم البيانات والرسوم البيانية في Excel',
        'اختصارات وأسرار توفير الوقت للطلبة',
      ],
      outcomes:
          'إتقان حزمة Microsoft Office لإنجاز البحوث والعروض في نصف الوقت المعتاد.',
    ),
    CourseItem(
      id: 'course-web',
      category: 'programming',
      status: 'التسجيل مفتوح',
      level: 'مبتدئ',
      mode: 'عن بُعد (عملي)',
      duration: '5 أسابيع · مشاريع حقيقية',
      title: 'ورشة تصميم وتطوير واجهات المواقع (HTML / CSS / JS)',
      subtitle:
          'تعلم كيف تبني مواقع إلكترونية عصرية ومتجاوبة مع الهاتف من الصفر وتطلق مشروعك على الإنترنت.',
      imageAsset: 'assets/img/web.jpg',
      topics: [
        'بناء هيكل الصفحات الدلالي باستخدام HTML5',
        'التصميم العصري والتجاوب مع الهاتف بـ CSS Grid & Flexbox',
        'إضافة الحركات والأنميشن والتفاعل بـ JavaScript',
        'نشر الموقع مجاناً على GitHub Pages',
      ],
      outcomes:
          'تصميم ونشر موقع شخصي أو صفحة هبوط متكاملة متجاوبة مع الهاتف.',
    ),
  ];

  static const List<PostItem> posts = [
    PostItem(
      id: 'post-1',
      category: 'services',
      categoryLabel: 'عروض الخدمات',
      date: 'أكتوبر 2026',
      badge: 'تصميم مواقع',
      title: 'هل تحتاج إلى موقع إلكتروني احترافي لمشروعك؟',
      summary:
          'نصمم لك موقعاً إلكترونياً يناسب احتياجاتك وطبيعة نشاطك: مواقع تعريفية، متاجر إلكترونية، ومواقع متجاوبة 100% مع الهاتف بواجهة مرتبة وسهلة الاستخدام.',
      imageAsset: 'assets/img/web.jpg',
      actionText: 'اطلب موقعك الآن',
      serviceTarget: 'برمجة وتصميم موقع إلكتروني',
    ),
    PostItem(
      id: 'post-2',
      category: 'services',
      categoryLabel: 'عروض الخدمات',
      date: 'أكتوبر 2026',
      badge: 'سيرة ذاتية CV',
      title: 'سيرة ذاتية احترافية — لأنك تستحق أن تُبرز مهاراتك',
      summary:
          'سيرتك الذاتية هي أول خطوة نحو فرصتك القادمة: تنظيم المعلومات، تصميم أنيق، إبراز المهارات، وملائمة تامة للوظيفة المستهدفة.',
      imageAsset: 'assets/img/cv.webp',
      actionText: 'اطلب تصميم سيرتك',
      serviceTarget: 'تصميم سيرة ذاتية احترافية (CV)',
    ),
    PostItem(
      id: 'post-3',
      category: 'results',
      categoryLabel: 'نتائج الطلبة',
      date: 'سبتمبر 2026',
      badge: 'نجاح وتميز',
      title: 'أكثر من 30 مذكرة ومشروع تخرج منجز بنجاح وتقدير ممتاز',
      summary:
          'فخورون بمرافقة طلبة الليسانس والماستر في مختلف التخصصات من كتابة وتنسيق المذكرة وترقيم الصفحات والجداول حتى تصميم عرض المناقشة التفاعلي.',
      imageAsset: 'assets/img/posts/mimear.webp',
      actionText: 'احجز مكانك لمذكرتك',
      serviceTarget: 'كتابة وتنسيق مذكرات التخرج',
    ),
    PostItem(
      id: 'post-4',
      category: 'courses',
      categoryLabel: 'أخبار الدورات',
      date: 'أكتوبر 2026',
      badge: 'دورة Python',
      title: 'انطلاق التسجيلات في دورة تعلم Python من الصفر للمبتدئين',
      summary:
          'دورة تطبيقية عن بُعد تأخذك خطوة بخطوة من المتغيرات والشروط والحلقات حتى كتابة الدوال وبناء تطبيقات عملية متكاملة.',
      imageAsset: 'assets/img/posts/python.webp',
      actionText: 'سجّل في الدورة',
      serviceTarget: 'التسجيل في دورة Python للمبتدئين',
    ),
    PostItem(
      id: 'post-5',
      category: 'services',
      categoryLabel: 'عروض الخدمات',
      date: 'أكتوبر 2026',
      badge: 'عروض PowerPoint',
      title: 'خدمة إعداد عرض PowerPoint بسيط ومرتب للطلبة والأساتذة',
      summary:
          'عندك عرض PowerPoint وتحب يكون جاهز ومرتب؟ تنظيم المحتوى، تنسيق الشرائح، إدراج النصوص والصور، وعرض واضح وسهل التقديم.',
      imageAsset: 'assets/img/posts/powerpoint.webp',
      actionText: 'اطلب عرضك الآن',
      serviceTarget: 'إعداد عروض PowerPoint الاحترافية',
    ),
    PostItem(
      id: 'post-6',
      category: 'services',
      categoryLabel: 'عروض الخدمات',
      date: 'سبتمبر 2026',
      badge: 'للأساتذة والمدارس',
      title: 'أستاذ(ة)؟ دع كتابة وتنسيق تمارينك واختباراتك علينا!',
      summary:
          'نقدم لك خدمة كتابة وتنسيق التمارين، الفروض والاختبارات، الدروس والملخصات، وكتابة المعادلات والرموز الرياضية بدقة عالية.',
      imageAsset: 'assets/img/posts/service-exams.webp',
      actionText: 'اطلب تنسيق تمارينك',
      serviceTarget: 'صياغة أسئلة الاختبارات والتمارين',
    ),
    PostItem(
      id: 'post-7',
      category: 'services',
      categoryLabel: 'عروض الخدمات',
      date: 'سبتمبر 2026',
      badge: 'ملخصات ومطبوعات',
      title: 'خدمة كتابة احترافية للمحتوى التعليمي والملخصات الجامعية',
      summary:
          'نكتب لك محتوى تعليمي منظم واحترافي: كتابة الدروس، إعداد الملخصات، حل التمارين، وإعداد الاختبارات والفروض بالتزام تام بالوقت.',
      imageAsset: 'assets/img/posts/write.webp',
      actionText: 'اطلب كتابة ملخصك',
      serviceTarget: 'كتابة ملخصات الدروس والمطبوعات',
    ),
    PostItem(
      id: 'post-8',
      category: 'results',
      categoryLabel: 'نتائج الطلبة',
      date: 'أغسطس 2026',
      badge: 'بوسترات LaTeX',
      title: 'تصميم بوسترات علمية للمؤتمرات الوطنية والدولية ببرنامج LaTeX',
      summary:
          'نماذج من أعمالنا في تنسيق البوسترات الأكاديمية والملصقات البحثية بدقة عالية وتنظيم بصري يبرز نتائج البحث العلمي.',
      imageAsset: 'assets/img/posts/service-latex.jpg',
      actionText: 'اطلب بوستر LaTeX',
      serviceTarget: 'بوسترات ومقالات علمية بـ LaTeX',
    ),
    PostItem(
      id: 'post-9',
      category: 'tips',
      categoryLabel: 'هوية Just Start',
      date: '2026',
      badge: 'ابدأ الآن',
      title: 'من فكرة صغيرة إلى مسار رقمي وتعليمي يرافق الطلبة وأصحاب المشاريع',
      summary:
          'نجمع لك بين إتقان Word وExcel وPowerPoint وLaTeX وبين برمجة المواقع والدورات التدريبية في منصة واحدة واضحة وسريعة.',
      imageAsset: 'assets/img/banner.jpg',
      actionText: 'تواصل معنا',
      serviceTarget: 'استشارة أو خدمة عامة',
    ),
  ];

  static const List<String> orderOptions = [
    'كتابة وتنسيق مذكرات التخرج',
    'تصميم السيرة الذاتية الاحترافية (CV)',
    'برمجة وتصميم المواقع الإلكترونية',
    'إعداد عروض PowerPoint الاحترافية',
    'بوسترات ومقالات علمية بـ LaTeX',
    'كتابة ملخصات الدروس والمطبوعات',
    'صياغة أسئلة الاختبارات والتمارين',
    'التسجيل في دورة Python للمبتدئين',
    'التسجيل في دورة LaTeX الشاملة للباحثين',
    'التسجيل في دورة الأوفيس الأكاديمي (Word/PPT/Excel)',
    'التسجيل في ورشة تصميم وتطوير المواقع',
    'استشارة أو خدمة عامة',
  ];

  static const List<Map<String, String>> faqs = [
    {
      'q': 'كيف أطلب خدمة أو أسجل في دورة عبر التطبيق؟',
      'a':
          'اضغط على زر (اطلب الخدمة) أو (سجّل الآن) على أي بطاقة لتفتح لك نافذة الطلب السريع، ثم أدخل اسمك وتفاصيلك واختر (واتساب أو فيسبوك أو البريد) ليتم تحويلك مباشرة برسالة جاهزة.',
    },
    {
      'q': 'ما نوع الملفات التي أستلمها عند انتهاء العمل؟',
      'a':
          'نعمل ببرامج Word وExcel وPowerPoint وLaTeX، وتستلم ملفات مفتوحة المصدر قابلة للتعديل بالإضافة إلى نسخة PDF عالية الدقة جاهزة للطباعة.',
    },
    {
      'q': 'هل الدورات التدريبية حضورية أم عن بُعد؟',
      'a':
          'جميع دوراتنا (مثل دورة Python ودورة LaTeX والأوفيس وتطوير الويب) تُقدَّم عن بُعد أونلاين بحصص تفاعلية وتطبيقات عملية ومرافقة مستمرة.',
    },
    {
      'q': 'هل تخدمون طلبة خارج ولاية تقرت؟',
      'a':
          'نعم بالتأكيد، مقرنا في تقرت ونخدم الطلبة والباحثين والأساتذة وأصحاب المشاريع في جميع ولايات الجزائر وخارجها عبر الإنترنت.',
    },
  ];
}
