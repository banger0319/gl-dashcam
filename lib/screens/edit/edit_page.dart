import '../../mock/mock_data.dart';
import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';

class EditPage extends StatelessWidget {
  const EditPage({super.key});

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
                child: Text('Edit', style: Theme.of(context).textTheme.headlineLarge),
              ),
            ),
            // Function Entry Cards
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: _buildFunctionCards(context),
              ),
            ),
            // Recent Edits Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 16, 8),
                child: Text('最近编辑', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
              ),
            ),
            // Recent edits grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _buildRecentEdits(context),
              ),
            ),
            // Templates Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 16, 8),
                child: Text('模板', style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                )),
              ),
            ),
            // Templates grid
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 32),
                child: _buildTemplates(context),
              ),
            ),
          ],
        ),
      );
  }

  Widget _buildFunctionCards(BuildContext context) {
    return SizedBox(
      height: 139,
      child: Row(
        children: [
          // Video Trim - Large card
          Expanded(
            flex: 3,
            child: _buildFunctionCard(
              context,
              icon: Icons.movie_edit,
              title: 'Video Trim',
              gradient: [
                AppColors.primaryLighter.withValues(alpha: 0.4),
                AppColors.primaryLightest.withValues(alpha: 0.6),
              ],
              height: 139,
              iconSize: 48,
              titleSize: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Right column
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: _buildFunctionCard(
                    context,
                    icon: Icons.merge_type,
                    title: 'Video Merge',
                    gradient: [
                      AppColors.primaryLightest.withValues(alpha: 0.5),
                      AppColors.neutral100,
                    ],
                    iconSize: 24,
                    titleSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: _buildFunctionCard(
                    context,
                    icon: Icons.view_in_ar,
                    title: 'AR Rendering',
                    gradient: [
                      AppColors.primaryLightest.withValues(alpha: 0.5),
                      AppColors.neutral100,
                    ],
                    iconSize: 24,
                    titleSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required List<Color> gradient,
    double height = double.infinity,
    double iconSize = 32,
    double titleSize = 16,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDefault.withValues(alpha: 0.5)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: iconSize, color: AppColors.primary.withValues(alpha: 0.7)),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: titleSize,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentEdits(BuildContext context) {
    final clips = MockData.editHistory;
    return Column(
      children: [
        // First row: small + large
        SizedBox(
          height: 204,
          child: Row(
            children: [
              // Left column: two small
              SizedBox(
                width: 107,
                child: Column(
                  children: [
                    _buildEditThumbnail(clips[0].thumbnailUrl, 96),
                    const SizedBox(height: 12),
                    _buildEditThumbnail(clips[2].thumbnailUrl, 96),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              // Large card
              Expanded(
                child: _buildEditThumbnail(clips[1].thumbnailUrl, 204),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Second row: three equal
        SizedBox(
          height: 96,
          child: Row(
            children: [
              Expanded(child: _buildEditThumbnail(clips[3].thumbnailUrl, 96)),
              const SizedBox(width: 12),
              Expanded(child: _buildEditThumbnail(clips[4].thumbnailUrl, 96)),
              const SizedBox(width: 12),
              Expanded(child: _buildEditThumbnail(clips[5].thumbnailUrl, 96)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditThumbnail(String url, double height) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            color: AppColors.neutral200,
            child: const Center(
              child: Icon(Icons.image, color: AppColors.neutral400, size: 32),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplates(BuildContext context) {
    final templates = MockData.templates;
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildTemplateThumbnail(templates[0])),
            const SizedBox(width: 12),
            Expanded(child: _buildTemplateThumbnail(templates[1])),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildTemplateThumbnail(templates[2])),
            const SizedBox(width: 12),
            Expanded(child: _buildTemplateThumbnail(templates[3])),
          ],
        ),
      ],
    );
  }

  Widget _buildTemplateThumbnail(MockEditTemplate template) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 96,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              template.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.neutral200,
                child: const Center(child: Icon(Icons.image, color: AppColors.neutral400)),
              ),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.5),
                  ],
                ),
              ),
            ),
            // Title
            Positioned(
              bottom: 8,
              left: 8,
              child: Text(
                template.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
