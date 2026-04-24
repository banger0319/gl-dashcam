import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../settings/settings_page.dart';
import '../../widgets/gradient_background.dart';

class DeviceWizardPage extends StatelessWidget {
  const DeviceWizardPage({super.key});

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
                  child: Column(
                    children: [
                      const SizedBox(height: 32),
                      // Illustration
                      Center(
                        child: Container(
                          width: 216,
                          height: 216,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/images/wizard_step1.png',
                              width: 192,
                              height: 192,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),
                      // Instructions text
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '1.请接通外部电源',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本辅助文本',
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Next Button at bottom
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 42),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                       // Move to settings for now or next wizard step
                       Navigator.of(context).pushReplacement(
                         MaterialPageRoute(builder: (_) => const SettingsPage()),
                       );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryLight,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.close, size: 24),
            onPressed: () => Navigator.of(context).pop(),
            color: AppColors.textPrimary,
          ),
          const Text(
            '配置向导',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
             icon: const Icon(Icons.more_horiz, size: 24),
             onPressed: () {},
             color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}
