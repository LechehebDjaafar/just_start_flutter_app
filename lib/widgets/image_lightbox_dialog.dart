import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'quick_order_sheet.dart';

class ImageLightboxDialog extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String description;
  final String serviceTarget;

  const ImageLightboxDialog({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.description,
    required this.serviceTarget,
  });

  static Future<void> show(
    BuildContext context, {
    required String imageAsset,
    required String title,
    required String description,
    required String serviceTarget,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.88),
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: ImageLightboxDialog(
          imageAsset: imageAsset,
          title: title,
          description: description,
          serviceTarget: serviceTarget,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: JustStartTheme.midnightNavy,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: JustStartTheme.electricBlue.withOpacity(0.35),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Image.asset(
                    imageAsset,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Image.asset(
                      'assets/img/banner.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: const TextStyle(color: Color(0xFFCBD5E1), fontSize: 13.5),
            ),
            const SizedBox(height: 14),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: JustStartTheme.brandGradient,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  QuickOrderSheet.show(
                    context,
                    initialService: serviceTarget,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.rocket_launch_rounded, size: 18),
                label: const Text(
                  'اطلب خدمة مماثلة الآن',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
