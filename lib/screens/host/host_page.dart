import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';
import '../../widgets/glass_container.dart';

class HostPage extends StatelessWidget {
  const HostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            // Top action icons
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.ios_share_rounded, color: AppColors.neutral700, size: 24),
                      onPressed: () {},
                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                      padding: EdgeInsets.zero,
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: AppColors.neutral700, size: 24),
                      onPressed: () {},
                      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
            
            // Profile Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Avatar with glowing ring
                    Container(
                      width: 124,
                      height: 124,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.textInverse, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryLight.withValues(alpha: 0.2),
                            blurRadius: 4,
                            spreadRadius: 4,
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 25,
                            offset: const Offset(0, 20),
                            spreadRadius: -5,
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/user_profile.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Alexander Sterling',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        fontSize: 24,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This is a personal profile, primarily intended for future community features.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Top action buttons (News Center & Device Manage)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: _buildActionCard(
                      context, 
                      icon: Icons.notifications_outlined, 
                      title: 'News Center', 
                      badge: '99+',
                    )),
                    const SizedBox(width: 12),
                    Expanded(child: _buildActionCard(
                      context, 
                      icon: Icons.camera_alt_outlined, 
                      title: 'Device Manage',
                      isFaded: true,
                    )),
                  ],
                ),
              ),
            ),

            // Large First List Group
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      _buildListItem(context, '使用帮助'),
                      _buildListItem(context, '意见反馈'),
                      _buildListItem(context, '在线客服'),
                      _buildListItem(context, '关于我们'),
                      _buildListItem(context, '隐私协议'),
                      _buildListItem(context, '用户协议'),
                      _buildListItem(context, '法律声明'),
                      _buildListItem(context, '高光误报反馈纠正'),
                    ],
                  ),
                ),
              ),
            ),

            // App Version Group
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Column(
                    children: [
                      _buildListItem(
                        context, 
                        'APP版本',
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 6),
                            const Text('v1.1.0', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildActionCard(BuildContext context, {required IconData icon, required String title, String? badge, bool isFaded = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            offset: const Offset(0, 8),
            blurRadius: 24,
          )
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Opacity(
        opacity: isFaded ? 0.85 : 1.0,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(icon, size: 28, color: AppColors.textPrimary),
                if (badge != null)
                  Positioned(
                    top: -4,
                    right: -12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        badge,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, String title, {Widget? trailing}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              if (trailing != null) trailing,
              if (trailing == null)
                const Icon(Icons.chevron_right, size: 20, color: AppColors.neutral400),
            ],
          ),
        ),
      ),
    );
  }
}
