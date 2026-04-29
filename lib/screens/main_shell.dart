import 'edit/edit_page.dart';
import 'host/host_page.dart';
import 'live/live_page.dart';
import 'device/device_page.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import '../widgets/gradient_background.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  /// Drives [PageTransitionSwitcher.reverse] so “back” (lower tab / leave Live) feels correct.
  bool _shellTransitionReverse = false;

  void _navigateToLive() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LivePage(
          onBack: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  void _selectTab(int index) {
    setState(() {
      _shellTransitionReverse = index < _currentIndex;
      _currentIndex = index;
    });
  }

  Widget _buildPage() {
    switch (_currentIndex) {
      case 0:
        return DevicePage(key: const ValueKey('DevicePage'), onNavigateToLive: _navigateToLive);
      case 1:
        return const EditPage(key: ValueKey('EditPage'));
      case 2:
        return const HostPage(key: ValueKey('HostPage'));
      default:
        return DevicePage(key: const ValueKey('DevicePage'), onNavigateToLive: _navigateToLive);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: GradientBackground(
        child: Scaffold(
        backgroundColor: Colors.transparent, // Background comes from GradientBackground
        extendBody: false, // Fix scrolling obstruction naturally
        body: PageTransitionSwitcher(
          duration: const Duration(milliseconds: 380),
          reverse: _shellTransitionReverse,
          transitionBuilder: (
            Widget child,
            Animation<double> primaryAnimation,
            Animation<double> secondaryAnimation,
          ) {
            return SharedAxisTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              transitionType: SharedAxisTransitionType.horizontal,
              fillColor: Colors.transparent,
              child: child,
            );
          },
          child: _buildPage(),
        ),
        bottomNavigationBar: _buildCustomBottomBar(context),
      ),
      ),
    );
  }

  // Main bottom bar matching Figma design
  Widget _buildCustomBottomBar(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final contentTop = 21.0;

    final screenWidth = MediaQuery.of(context).size.width;
    final tabWidth = screenWidth / 3;

    final activeIndex = _currentIndex;
    final labels = const ['Device', 'Edit', 'Host'];
    final icons = const [
      Icons.camera_alt_outlined,
      Icons.content_cut_rounded,
      Icons.person_outline_rounded,
    ];

    final double targetDx = tabWidth * (activeIndex + 0.5);

    return SizedBox(
      height: 70.0 + bottomPadding,
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: targetDx, end: targetDx),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        builder: (context, dx, child) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: NavBarPainter(dx),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: bottomPadding,
                child: Stack(
                  children: List.generate(3, (i) {
                    final isActive = activeIndex == i;
                    return Positioned(
                      left: tabWidth * i,
                      width: tabWidth,
                      top: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () => _selectTab(i),
                        behavior: HitTestBehavior.opaque,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              top: contentTop,
                              left: 0,
                              right: 0,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: isActive ? 0.0 : 1.0,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      icons[i],
                                      color: const Color(0xFFF8FAFC).withValues(alpha: 0.6),
                                      size: 24,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      labels[i],
                                      style: TextStyle(
                                        color: const Color(0xFFF8FAFC).withValues(alpha: 0.6),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        height: 16.0 / 12.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: contentTop + 28.0,
                              left: 0,
                              right: 0,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 200),
                                opacity: isActive ? 1.0 : 0.0,
                                child: Text(
                                  labels[i],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFFF8FAFC),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 16.0 / 12.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Positioned(
                left: dx - 24,
                top: -3.0,
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4ADE80),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4ADE80).withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      icons[activeIndex],
                      key: ValueKey(activeIndex),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class NavBarPainter extends CustomPainter {
  final double dx;

  NavBarPainter(this.dx);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color(0xFF0F172A)
      ..style = PaintingStyle.fill;

    Path path = Path();
    const double yBase = 0.0;
    const double cornerRadius = 20.0;

    path.moveTo(0, yBase + cornerRadius);
    path.quadraticBezierTo(0, yBase, cornerRadius, yBase);

    final leftBumpBase = math.max(cornerRadius, dx - 38);
    final rightBumpBase = math.min(size.width - cornerRadius, dx + 38);

    path.lineTo(leftBumpBase, yBase);
    path.cubicTo(
      dx - 25, yBase,
      dx - 22, -13.0,
      dx, -13.0,
    );
    path.cubicTo(
      dx + 22, -13.0,
      dx + 25, yBase,
      rightBumpBase, yBase,
    );

    path.lineTo(size.width - cornerRadius, yBase);
    path.quadraticBezierTo(size.width, yBase, size.width, yBase + cornerRadius);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant NavBarPainter oldDelegate) => oldDelegate.dx != dx;
}
