import 'dart:async';
import 'package:flutter/material.dart';
import '../data/just_start_data.dart';
import '../theme/app_theme.dart';

class PythonTerminalCard extends StatefulWidget {
  final String fileName;

  const PythonTerminalCard({
    super.key,
    this.fileName = 'just_start_python.py',
  });

  @override
  State<PythonTerminalCard> createState() => _PythonTerminalCardState();
}

class _PythonTerminalCardState extends State<PythonTerminalCard> {
  int _charCount = 0;
  Timer? _timer;
  final String _fullCode = AppConfig.pythonLiveSnippet;

  @override
  void initState() {
    super.initState();
    _startTyping();
  }

  void _startTyping() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (!mounted) return;
      if (_charCount < _fullCode.length) {
        setState(() => _charCount++);
      } else {
        timer.cancel();
        Future.delayed(const Duration(seconds: 4), () {
          if (!mounted) return;
          setState(() => _charCount = 0);
          _startTyping();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: JustStartTheme.electricBlue.withOpacity(0.35),
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: const BoxDecoration(
              color: Color(0xFF1E293B),
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.fileName,
                  style: const TextStyle(
                    color: Color(0xFFCBD5E1),
                    fontSize: 12,
                    fontFamily: 'monospace',
                  ),
                ),
                Row(
                  children: [
                    _dot(const Color(0xFF22C55E)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFFEAB308)),
                    const SizedBox(width: 6),
                    _dot(const Color(0xFFEF4444)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                '${_fullCode.substring(0, _charCount)}▋',
                style: const TextStyle(
                  color: Color(0xFF38BDF8),
                  fontFamily: 'monospace',
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
