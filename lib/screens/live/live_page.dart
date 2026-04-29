import 'dart:ui';
import '../../mock/mock_data.dart';
import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';

class LivePage extends StatelessWidget {
  const LivePage({super.key, required this.onBack});

  /// The left icon (Add) will trigger onBack so the user is not permanently trapped,
  /// even though the design strictly uses an Add/Menu layout without an explicit Back arrow.
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final device = MockData.connectedDevice;
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Provide a solid background since it's now a new route
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 12),
            _buildTopBar(context),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom + 24),
                child: Column(
                  children: [
                    _buildCameraBlock(context, device),
                    const SizedBox(height: 12),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            SizedBox(
              width: 48,
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
                  color: AppColors.textPrimary,
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      onBack();
                    }
                  },
                ),
              ),
            ),
            const Expanded(
              child: Text(
                'Live',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                  height: 32 / 24,
                ),
              ),
            ),
            const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraBlock(BuildContext context, MockDevice device) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Main Camera (Front)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: SizedBox(
              height: 192,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    device.frontCameraUrl ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: const Color(0xFFD9D9D9)),
                  ),
                  // Top Left: REC·4K Pill
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ADE80), // var(--color/accent/secondary)
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF8FAFC), // var(--color/text/inverse)
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'REC·4K',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFF8FAFC),
                              height: 16 / 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Top Right: LOGO
                  const Positioned(
                    top: 8,
                    right: 8,
                    child: Padding(
                      padding: EdgeInsets.only(top: 4, right: 4),
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                          fontFamily: 'monospace', // IBM Plex Mono equivalent
                          fontSize: 13,
                          color: Color(0xFFF8FAFC),
                        ),
                      ),
                    ),
                  ),
                  // Bottom Left: Timestamp & Speed
                  const Positioned(
                    bottom: 8,
                    left: 8,
                    child: Text(
                      '2026-03-08 09:40:00 65 KM/H',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // Bottom Right: Coordinates
                  const Positioned(
                    bottom: 8,
                    right: 8,
                    child: Text(
                      'N22.123450,E123.123450',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // "F" tag (positioned approx 48px from bottom as per Figma top-[144px])
                  Positioned(
                    bottom: 48,
                    left: 16,
                    child: _buildCameraTag('F'),
                  ),
                  // Expand icon for F
                  Positioned(
                    bottom: 48,
                    right: 16,
                    child: _buildExpandIcon(),
                  ),
                ],
              ),
            ),
          ),
          // Sub cameras Row
          Row(
            children: [
              // Left camera
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12)),
                  child: SizedBox(
                    height: 96,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          device.leftCameraUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: const Color(0xFFD9D9D9)),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: _buildCameraTag('L'),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: _buildExpandIcon(small: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Right camera
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(bottomRight: Radius.circular(12)),
                  child: SizedBox(
                    height: 96,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          device.rearCameraUrl ?? '',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(color: const Color(0xFFD9D9D9)),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: _buildCameraTag('R'),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: _buildExpandIcon(small: true),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCameraTag(String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          width: 21,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0x1F06B6D4), // rgba(6,182,212,0.12)
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 13,
              color: Color(0xFFF8FAFC),
              height: 15 / 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpandIcon({bool small = false}) {
    final size = small ? 20.0 : 32.0;
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            color: Color(0x8F0F172A), // rgba(15,23,42,0.56)
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              small ? Icons.open_in_new : Icons.fullscreen,
              color: const Color(0xFFF8FAFC),
              size: small ? 12 : 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButton(
              icon: Icons.camera_alt_outlined,
              label: 'Screenshot',
              isRecording: false,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildActionButton(
              icon: Icons.fiber_manual_record,
              label: 'Recording',
              isRecording: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isRecording,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // backdrop-blur-[2px]
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xD9FFFFFF), // rgba(255,255,255,0.85)
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD6DFEC)), // border-[#d6dfec]
          ),
          child: Opacity(
            opacity: isRecording ? 0.85 : 1.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: const Color(0xFF0F172A)),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF0F172A),
                    fontWeight: FontWeight.w400,
                    height: 24 / 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
