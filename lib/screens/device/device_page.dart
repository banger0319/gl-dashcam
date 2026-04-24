import 'add_device_page.dart';
import '../../mock/mock_data.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import 'package:flutter/material.dart';
import '../settings/settings_page.dart';

class DevicePage extends StatelessWidget {
  final VoidCallback? onNavigateToLive;
  
  const DevicePage({super.key, this.onNavigateToLive});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            // App Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Device', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.qr_code_scanner, size: 24),
                          onPressed: () {},
                          color: const Color(0xFF1E293B),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add, size: 24),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => const AddDevicePage()),
                            );
                          },
                          color: const Color(0xFF1E293B),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // Connected Device Card
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildDeviceCard(context),
              ),
            ),
            // Function Buttons
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildFunctionButtons(context),
              ),
            ),
            // Recent Clips
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildRecentClips(context),
              ),
            ),
            // Setting Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                child: _buildSettingButton(context),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildDeviceCard(BuildContext context) {
    final device = MockData.connectedDevice;
    return Container(
      width: 343,
      height: 288,
      decoration: BoxDecoration(
        color: const Color(0xD9FFFFFF), // rgba(255,255,255,0.85)
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Device info header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        device.name,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildConnectionBadge(Icons.wifi, 'Link', const Color(0xFF2F6BFF), Colors.white),
                          const SizedBox(width: 8),
                          _buildStatusBadge(Icons.signal_cellular_alt, device.hasSignal),
                          const SizedBox(width: 8),
                          _buildStatusBadge(Icons.bluetooth, device.hasBluetooth),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.menu),
                  color: const Color(0xFF1E293B).withValues(alpha: 0.4),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          // Camera image
          Expanded(
            child: Center(
              child: Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/images/device_camera.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildConnectionBadge(IconData icon, String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(fontSize: 12, color: textColor, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(IconData icon, bool active) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF2FF),
        borderRadius: BorderRadius.circular(AppSpacing.radiusPill),
      ),
      child: Icon(icon, size: 16, color: active ? const Color(0xFF2F6BFF) : const Color(0xFF64748B)),
    );
  }

  Widget _buildFunctionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onNavigateToLive,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCFCE7), // #dcfce7
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.videocam_outlined, color: Color(0xFF22C55E), size: 24),
                  ),
                  const SizedBox(height: 16),
                  const Text('Live', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  const Text('Real-time\nStreaming',
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.photo_library_outlined, color: Color(0xFF22C55E), size: 24),
                ),
                const SizedBox(height: 16),
                const Text('Album', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                const SizedBox(height: 4),
                const Text('124 Saved Clips &\nPhotos',
                  style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentClips(BuildContext context) {
    return Column(
      children: MockData.recentClips.map((clip) {
        final isEmergency = clip.type == 'emergency';
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: isEmergency ? const Color(0xFFEF4444) : Colors.transparent,
                    width: isEmergency ? 2 : 0, // Make the border slightly thicker for visibility
                  ),
                )
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      clip.thumbnailUrl,
                      width: 81,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 81,
                        height: 56,
                        color: AppColors.neutral200,
                        child: const Icon(Icons.image, color: AppColors.neutral400),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(clip.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                        const SizedBox(height: 4),
                        const Text('03/25 2026 00:24', style: TextStyle(fontSize: 12, color: Color(0xFF64748B))),
                        const SizedBox(height: 2),
                        const Text('03/25 00:24-03/25 00:25', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                      ],
                    ),
                  ),
                  // Close button
                  IconButton(
                    icon: const Icon(Icons.close, size: 16, color: Color(0xFF94A3B8)),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }


  Widget _buildSettingButton(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const SettingsPage()),
          );
        },
        icon: const Icon(Icons.settings_outlined, size: 20, color: AppColors.textSecondary),
        label: Text('Setting', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
      ),
    );
  }
}
