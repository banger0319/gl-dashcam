import 'dart:math';
import 'device_wizard_page.dart';
import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/gradient_background.dart';

class AddDevicePage extends StatefulWidget {
  const AddDevicePage({super.key});

  @override
  State<AddDevicePage> createState() => _AddDevicePageState();
}

class _AddDevicePageState extends State<AddDevicePage>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();
    _pulseAnimation = CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      _buildScanningArea(),
                      const SizedBox(height: 24),
                      const Text(
                        'Scanning for nearby Bluetooth devices...',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 36),
                      _buildManualSection(context),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 20),
            onPressed: () => Navigator.of(context).pop(),
            color: AppColors.textPrimary,
          ),
          const Expanded(
            child: Text(
              'Add Device',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, size: 22),
            onPressed: () {},
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }

  // --------------- Scanning Animation Area ---------------

  Widget _buildScanningArea() {
    return SizedBox(
      width: 220,
      height: 220,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          final t = _pulseAnimation.value;
          return Stack(
            alignment: Alignment.center,
            children: [
              // Outermost ring
              _buildRippleRing(200, 0.08 + 0.06 * sin(t * pi * 2)),
              // Middle ring
              _buildRippleRing(150, 0.12 + 0.08 * sin((t + 0.33) * pi * 2)),
              // Inner ring
              _buildRippleRing(100, 0.18 + 0.10 * sin((t + 0.66) * pi * 2)),
              // Centre dot
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              // Sparkle dots
              _buildSparkleDot(offset: Offset(70, -50), delay: 0.0, t: t),
              _buildSparkleDot(offset: Offset(-65, 40), delay: 0.33, t: t),
              _buildSparkleDot(offset: Offset(30, 75), delay: 0.66, t: t),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRippleRing(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: opacity),
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildSparkleDot({
    required Offset offset,
    required double delay,
    required double t,
  }) {
    final phase = ((t + delay) % 1.0);
    final alpha = (sin(phase * pi)).clamp(0.0, 1.0);
    final scale = 0.6 + 0.4 * alpha;

    return Positioned(
      left: 110 + offset.dx - 5,
      top: 110 + offset.dy - 5,
      child: Transform.scale(
        scale: scale,
        child: Transform.rotate(
          angle: pi / 4,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: alpha),
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryLight.withValues(alpha: alpha * 0.6),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --------------- Manual Section ---------------

  Widget _buildManualSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ADD DEVICE MANUALLY',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.0,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Navigate to SettingsPage directly per user request
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const DeviceWizardPage()),
                  );
                },
                child: _buildDeviceCard(
                  name: 'Dashcamname',
                  model: 'AXT 400 4K',
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const DeviceWizardPage()),
                  );
                },
                child: _buildDeviceCard(
                  name: 'Dashcamname',
                  model: 'AXT 600 2K',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeviceCard({required String name, required String model}) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        children: [
          // Camera lens illustration replaced by new unified asset
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              'assets/images/device_camera.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            model,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
