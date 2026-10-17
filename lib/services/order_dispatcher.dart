import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/just_start_data.dart';
import '../theme/app_theme.dart';

enum DispatchChannel { whatsapp, facebook, email }

class OrderDispatcher {
  static String buildOrderMessage({
    required String name,
    required String serviceOrCourse,
    String? details,
    String? deadline,
  }) {
    final buffer = StringBuffer()
      ..writeln('مرحباً فريق Just Start 👋')
      ..writeln('• الاسم: ${name.trim()}')
      ..writeln('• الطلب: ${serviceOrCourse.trim()}');

    if (details != null && details.trim().isNotEmpty) {
      buffer.writeln('• التفاصيل: ${details.trim()}');
    }
    if (deadline != null && deadline.trim().isNotEmpty) {
      buffer.writeln('• الموعد المفضل: ${deadline.trim()}');
    }
    return buffer.toString().trim();
  }

  static Future<void> dispatchOrder({
    required BuildContext context,
    required DispatchChannel channel,
    required String name,
    required String serviceOrCourse,
    String? details,
    String? deadline,
  }) async {
    final message = buildOrderMessage(
      name: name,
      serviceOrCourse: serviceOrCourse,
      details: details,
      deadline: deadline,
    );

    await Clipboard.setData(ClipboardData(text: message));

    try {
      if (channel == DispatchChannel.whatsapp) {
        final encoded = Uri.encodeComponent(message);
        final waUri = Uri.parse(
          'https://wa.me/${AppConfig.whatsappNumber}?text=$encoded',
        );
        final launched = await launchUrl(
          waUri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched && context.mounted) {
          _showSnack(
            context,
            'تم نسخ رسالتك! افتح واتساب وألصقها لإرسالها إلى ${AppConfig.whatsappDisplay}',
            JustStartTheme.whatsappGreen,
          );
        }
      } else if (channel == DispatchChannel.facebook) {
        if (context.mounted) {
          _showSnack(
            context,
            'تم نسخ تفاصيل طلبك تلقائياً! الصقها الآن في محادثة فيسبوك 💬',
            JustStartTheme.facebookBlue,
          );
        }
        final fbUri = Uri.parse(AppConfig.facebookUrl);
        await launchUrl(
          fbUri,
          mode: LaunchMode.externalApplication,
        );
      } else if (channel == DispatchChannel.email) {
        final subject = Uri.encodeComponent('طلب خدمة — $serviceOrCourse');
        final body = Uri.encodeComponent(message);
        final mailUri = Uri.parse(
          'mailto:${AppConfig.email}?subject=$subject&body=$body',
        );
        final launched = await launchUrl(
          mailUri,
          mode: LaunchMode.externalApplication,
        );
        if (!launched && context.mounted) {
          _showSnack(
            context,
            'تم نسخ تفاصيل طلبك! أرسلها إلى ${AppConfig.email}',
            JustStartTheme.emailRed,
          );
        }
      }
    } catch (_) {
      if (context.mounted) {
        _showSnack(
          context,
          'تم نسخ نص الطلب إلى الحافظة بنجاح! يمكنك لصقه مباشرة في المحادثة.',
          JustStartTheme.royalViolet,
        );
      }
    }
  }

  static Future<void> dispatchFeedback({
    required BuildContext context,
    required DispatchChannel channel,
    required int qualityStars,
    required int speedStars,
    required int serviceStars,
    String? userName,
    String? comment,
  }) async {
    final nameText =
        (userName == null || userName.trim().isEmpty) ? 'طالب / عميل' : userName.trim();
    final commentText = (comment == null || comment.trim().isEmpty)
        ? 'شكراً لكم على الخدمة المميزة'
        : comment.trim();

    final text = [
      'تقييم خدمات Just Start ⭐',
      '• الاسم: $nameText',
      '• جودة الخدمة: $qualityStars/5',
      '• سرعة التسليم: $speedStars/5',
      '• التعامل والتواصل: $serviceStars/5',
      '• الملاحظات: $commentText',
    ].join('');

    await Clipboard.setData(ClipboardData(text: text));

    if (channel == DispatchChannel.whatsapp) {
      final uri = Uri.parse(
        'https://wa.me/${AppConfig.whatsappNumber}?text=${Uri.encodeComponent(text)}',
      );
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      final uri = Uri.parse(
        'mailto:${AppConfig.email}?subject=${Uri.encodeComponent("تقييم خدمات Just Start")}&body=${Uri.encodeComponent(text)}',
      );
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Future<void> openExternalUrl(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static void _showSnack(BuildContext context, String text, Color bg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: bg,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
