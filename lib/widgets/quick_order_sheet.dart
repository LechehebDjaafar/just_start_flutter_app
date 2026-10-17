import 'package:flutter/material.dart';
import '../data/just_start_data.dart';
import '../services/order_dispatcher.dart';
import '../theme/app_theme.dart';

class QuickOrderSheet extends StatefulWidget {
  final String? initialService;
  final String? initialDetails;

  const QuickOrderSheet({
    super.key,
    this.initialService,
    this.initialDetails,
  });

  static Future<void> show(
    BuildContext context, {
    String? initialService,
    String? initialDetails,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: QuickOrderSheet(
          initialService: initialService,
          initialDetails: initialDetails,
        ),
      ),
    );
  }

  @override
  State<QuickOrderSheet> createState() => _QuickOrderSheetState();
}

class _QuickOrderSheetState extends State<QuickOrderSheet> {
  final _nameController = TextEditingController();
  late final TextEditingController _serviceController;
  late final TextEditingController _detailsController;
  final _deadlineController = TextEditingController();
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _serviceController = TextEditingController(
      text: widget.initialService ?? JustStartCatalog.orderOptions.first,
    );
    _detailsController = TextEditingController(
      text: widget.initialDetails ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _serviceController.dispose();
    _detailsController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _handleSend(DispatchChannel channel) async {
    final name = _nameController.text.trim();
    final service = _serviceController.text.trim();

    if (name.isEmpty || service.isEmpty) {
      setState(() {
        _errorMsg = 'يرجى إدخال الاسم الكامل وتحديد الخدمة أو الدورة المطلوبة أولاً.';
      });
      return;
    }

    setState(() => _errorMsg = null);

    await OrderDispatcher.dispatchOrder(
      context: context,
      channel: channel,
      name: name,
      serviceOrCourse: service,
      details: _detailsController.text,
      deadline: _deadlineController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.only(
        top: 12,
        right: 20,
        left: 20,
        bottom: bottomInset + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? JustStartTheme.darkCard : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 44,
                height: 5,
                margin: const EdgeInsets.only(bottom: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: JustStartTheme.brandGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.rocket_launch_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Text(
                    'طلب خدمة أو تسجيل سريع',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'أدخل بياناتك وسيتم تجهيز رسالتك مباشرة للإرسال عبر واتساب أو فيسبوك أو البريد الإلكتروني.',
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : JustStartTheme.mutedSlate,
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              '1. الاسم الكامل *',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _nameController,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'اكتب اسمك الكريم',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              '2. الخدمة أو الدورة المطلوبة *',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _serviceController,
              decoration: InputDecoration(
                hintText: 'مثال: كتابة مذكرة تخرج / دورة Python',
                prefixIcon: const Icon(Icons.layers_outlined),
                suffixIcon: PopupMenuButton<String>(
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  tooltip: 'اختر من القائمة',
                  onSelected: (val) => setState(() => _serviceController.text = val),
                  itemBuilder: (_) => JustStartCatalog.orderOptions
                      .map((opt) => PopupMenuItem(value: opt, child: Text(opt)))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              '3. تفاصيل طلبك (اختياري)',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _detailsController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'اذكر التخصص، عدد الصفحات أو الشرائح، أو أي ملاحظة...',
              ),
            ),
            const SizedBox(height: 12),

            const Text(
              '4. الموعد المطلوب (اختياري)',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: _deadlineController,
              decoration: const InputDecoration(
                hintText: 'مثال: خلال أسبوعين / مستعجل',
                prefixIcon: Icon(Icons.schedule_rounded),
              ),
            ),

            if (_errorMsg != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorMsg!,
                style: const TextStyle(
                  color: Color(0xFFE11D48),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
            const SizedBox(height: 18),

            ElevatedButton.icon(
              onPressed: () => _handleSend(DispatchChannel.whatsapp),
              style: ElevatedButton.styleFrom(
                backgroundColor: JustStartTheme.whatsappGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.chat_rounded),
              label: const Text(
                'إرسال فوري عبر واتساب',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _handleSend(DispatchChannel.facebook),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: JustStartTheme.facebookBlue,
                      side: const BorderSide(
                        color: JustStartTheme.facebookBlue,
                        width: 1.4,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.facebook_rounded, size: 20),
                    label: const Text(
                      'فيسبوك',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _handleSend(DispatchChannel.email),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: JustStartTheme.emailRed,
                      side: const BorderSide(
                        color: JustStartTheme.emailRed,
                        width: 1.4,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.mail_outline_rounded, size: 20),
                    label: const Text(
                      'البريد الإلكتروني',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
