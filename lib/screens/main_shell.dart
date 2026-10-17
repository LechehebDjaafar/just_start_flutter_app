import 'package:flutter/material.dart';
import '../data/just_start_data.dart';
import '../theme/app_theme.dart';
import '../widgets/quick_order_sheet.dart';
import 'courses_screen.dart';
import 'home_screen.dart';
import 'portfolio_screen.dart';
import 'services_screen.dart';

class MainShell extends StatefulWidget {
  final VoidCallback onToggleTheme;
  final bool isDarkMode;

  const MainShell({
    super.key,
    required this.onToggleTheme,
    required this.isDarkMode,
  });

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  String? _activeFilter;

  void _navigateToTab(int index, {String? filter}) {
    setState(() {
      _currentIndex = index;
      _activeFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onNavigateTab: _navigateToTab),
      ServicesScreen(
        initialFilter: _currentIndex == 1 ? _activeFilter : null,
      ),
      CoursesScreen(
        initialFilter: _currentIndex == 2 ? _activeFilter : null,
      ),
      PortfolioScreen(
        initialFilter: _currentIndex == 3 ? _activeFilter : null,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        title: Row(
          children: [
            Hero(
              tag: 'just-start-logo',
              child: ClipOval(
                child: Image.asset(
                  'assets/img/logo.png',
                  width: 38,
                  height: 38,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              AppConfig.brandName,
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 19),
            ),
            const SizedBox(width: 5),
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: JustStartTheme.electricBlue,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'تبديل الوضع الليلي والنهاري',
            onPressed: widget.onToggleTheme,
            icon: Icon(
              widget.isDarkMode
                  ? Icons.wb_sunny_rounded
                  : Icons.nightlight_round,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: JustStartTheme.brandGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton.icon(
                onPressed: () => QuickOrderSheet.show(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
                icon: const Icon(Icons.send_rounded, size: 15),
                label: const Text(
                  'اطلب الآن',
                  style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => QuickOrderSheet.show(context),
        backgroundColor: JustStartTheme.royalViolet,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.rocket_launch_rounded),
        label: const Text(
          'اطلب خدمة / دورة',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => _navigateToTab(idx),
        indicatorColor: JustStartTheme.royalViolet.withOpacity(0.16),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(
              Icons.home_rounded,
              color: JustStartTheme.royalViolet,
            ),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(
              Icons.grid_view_rounded,
              color: JustStartTheme.royalViolet,
            ),
            label: 'الخدمات',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(
              Icons.school_rounded,
              color: JustStartTheme.royalViolet,
            ),
            label: 'الدورات',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_mosaic_outlined),
            selectedIcon: Icon(
              Icons.auto_awesome_mosaic_rounded,
              color: JustStartTheme.royalViolet,
            ),
            label: 'المنشورات',
          ),
        ],
      ),
    );
  }
}
