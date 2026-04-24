import '../../theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../widgets/glass_container.dart';
import '../../widgets/gradient_background.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // ── Video Recording ──
  bool _recording = true;
  bool _audio = true;
  bool _timestamp = true;
  bool _speedWatermark = true;

  // ── Parking Monitor ──
  bool _parkingMonitor = false;
  bool _timelapse = false;
  bool _anomalyAlert = false;
  bool _lowFrameRate = false;
  bool _delayShutdown = false;
  bool _powerSaving = false;
  bool _nightVision = false;
  bool _noiseReduction = false;

  // ── ADAS ──
  bool _frontCarStart = false;
  bool _pedestrianWarning = false;
  bool _roadSignRecognition = false;
  bool _greenLightReminder = false;
  bool _fatigueReminder = false;

  // ── Sound & Display ──
  bool _keySound = true;
  bool _bootSound = true;
  bool _recordingSound = true;
  bool _voiceControl = false;
  bool _screenTimeout = true;

  // ── System & Network ──
  bool _autoConnectWifi = true;
  bool _autoSync = false;
  bool _gps = true;
  bool _format = false;
  bool _otaUpgrade = false;

  // ── Time & Language ──
  bool _syncTime = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTopBar(),
              Expanded(
                child: CustomScrollView(
                  physics: const ClampingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const SizedBox(height: 8),
                          _buildVideoRecordingSection(),
                          _buildParkingMonitorSection(),
                          _buildAdasSection(),
                          _buildEmergencyRecordingSection(),
                          _buildSoundDisplaySection(),
                          _buildSystemNetworkSection(),
                          _buildTimeLanguageSection(),
                          _buildStorageSection(),
                          _buildAiHighlightSection(),
                        ]),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).padding.bottom + 24,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────
  // Top Bar
  // ────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Center(
              child: Text(
                '设置',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Positioned(
              left: 0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                color: AppColors.textPrimary,
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
            Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.menu, size: 22),
                color: AppColors.textPrimary,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────
  // Reusable builders
  // ────────────────────────────────────────────────

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    // Interleave thin dividers between items
    final List<Widget> items = [];
    for (int i = 0; i < children.length; i++) {
      items.add(children[i]);
      if (i < children.length - 1) {
        items.add(Divider(
          height: 1,
          thickness: 0.5,
          indent: 12,
          endIndent: 12,
          color: AppColors.neutral200,
        ));
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textTertiary,
              ),
            ),
          ),
          GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Column(children: items),
          ),
        ],
      ),
    );
  }

  /// Navigation item – 44px tall, with optional description and chevron.
  Widget _buildNavItem(
    String label, {
    String? description,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? () {},
      child: SizedBox(
        height: 44,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ),
              const Icon(
                Icons.chevron_right,
                size: 20,
                color: AppColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Toggle item – 38px tall, CupertinoSwitch on the right.
  Widget _buildToggleItem(
    String label, {
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SizedBox(
      height: 38,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Transform.scale(
              scale: 0.75,
              child: CupertinoSwitch(
                value: value,
                activeTrackColor: AppColors.primary,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Toggle item with an extra description line.
  Widget _buildToggleItemWithDesc(
    String label, {
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SizedBox(
      height: 52,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Transform.scale(
              scale: 0.75,
              child: CupertinoSwitch(
                value: value,
                activeTrackColor: AppColors.primary,
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ────────────────────────────────────────────────
  // Sections
  // ────────────────────────────────────────────────

  Widget _buildVideoRecordingSection() {
    return _buildSection(
      title: '视频录制设置',
      children: [
        _buildNavItem('录制分辨率', description: '1920x1080'),
        _buildNavItem('录制帧率', description: '30fps'),
        _buildNavItem('录制码率', description: '20Mbps / H265'),
        _buildToggleItem('录像',
            value: _recording,
            onChanged: (v) => setState(() => _recording = v)),
        _buildToggleItem('录音',
            value: _audio,
            onChanged: (v) => setState(() => _audio = v)),
        _buildToggleItem('时间戳',
            value: _timestamp,
            onChanged: (v) => setState(() => _timestamp = v)),
        _buildToggleItem('速度水印',
            value: _speedWatermark,
            onChanged: (v) => setState(() => _speedWatermark = v)),
      ],
    );
  }

  Widget _buildParkingMonitorSection() {
    return _buildSection(
      title: '停车监控设置',
      children: [
        _buildToggleItem('停车监控',
            value: _parkingMonitor,
            onChanged: (v) => setState(() => _parkingMonitor = v)),
        _buildNavItem('灵敏度'),
        _buildNavItem('预录时间'),
        _buildNavItem('录像时长'),
        _buildToggleItem('缩时录影',
            value: _timelapse,
            onChanged: (v) => setState(() => _timelapse = v)),
        _buildToggleItem('异常提醒',
            value: _anomalyAlert,
            onChanged: (v) => setState(() => _anomalyAlert = v)),
        _buildToggleItem('低帧率',
            value: _lowFrameRate,
            onChanged: (v) => setState(() => _lowFrameRate = v)),
        _buildToggleItem('延迟关机',
            value: _delayShutdown,
            onChanged: (v) => setState(() => _delayShutdown = v)),
        _buildToggleItem('节能模式',
            value: _powerSaving,
            onChanged: (v) => setState(() => _powerSaving = v)),
        _buildToggleItem('夜视增强',
            value: _nightVision,
            onChanged: (v) => setState(() => _nightVision = v)),
        _buildToggleItem('降噪',
            value: _noiseReduction,
            onChanged: (v) => setState(() => _noiseReduction = v)),
      ],
    );
  }

  Widget _buildAdasSection() {
    return _buildSection(
      title: 'ADAS设置',
      children: [
        _buildNavItem('校准设置'),
        _buildNavItem('前车碰撞预警'),
        _buildNavItem('车道偏离'),
        _buildToggleItem('前车起步',
            value: _frontCarStart,
            onChanged: (v) => setState(() => _frontCarStart = v)),
        _buildToggleItem('行人碰撞预警',
            value: _pedestrianWarning,
            onChanged: (v) => setState(() => _pedestrianWarning = v)),
        _buildToggleItem('前方路标识别',
            value: _roadSignRecognition,
            onChanged: (v) => setState(() => _roadSignRecognition = v)),
        _buildToggleItem('绿灯提醒',
            value: _greenLightReminder,
            onChanged: (v) => setState(() => _greenLightReminder = v)),
        _buildToggleItemWithDesc(
          '疲劳驾驶提醒',
          description: '开启后将在检测到疲劳驾驶时发出提醒',
          value: _fatigueReminder,
          onChanged: (v) => setState(() => _fatigueReminder = v),
        ),
        _buildNavItem('ADAS音量', description: '3'),
      ],
    );
  }

  Widget _buildEmergencyRecordingSection() {
    return _buildSection(
      title: '紧急录像设置',
      children: [
        _buildNavItem('灵敏度设置'),
      ],
    );
  }

  Widget _buildSoundDisplaySection() {
    return _buildSection(
      title: '声音与显示设置',
      children: [
        _buildNavItem('提示音'),
        _buildNavItem('音量设置'),
        _buildNavItem('亮度'),
        _buildToggleItem('按键音',
            value: _keySound,
            onChanged: (v) => setState(() => _keySound = v)),
        _buildToggleItem('开机音',
            value: _bootSound,
            onChanged: (v) => setState(() => _bootSound = v)),
        _buildToggleItem('录像声音',
            value: _recordingSound,
            onChanged: (v) => setState(() => _recordingSound = v)),
        _buildToggleItem('语音控制',
            value: _voiceControl,
            onChanged: (v) => setState(() => _voiceControl = v)),
        _buildToggleItem('屏幕超时',
            value: _screenTimeout,
            onChanged: (v) => setState(() => _screenTimeout = v)),
      ],
    );
  }

  Widget _buildSystemNetworkSection() {
    return _buildSection(
      title: '系统与网络设置',
      children: [
        _buildNavItem('WiFi设置'),
        _buildNavItem('蓝牙设置'),
        _buildNavItem('移动网络'),
        _buildToggleItem('自动连接WiFi',
            value: _autoConnectWifi,
            onChanged: (v) => setState(() => _autoConnectWifi = v)),
        _buildToggleItem('自动同步',
            value: _autoSync,
            onChanged: (v) => setState(() => _autoSync = v)),
        _buildToggleItem('GPS',
            value: _gps,
            onChanged: (v) => setState(() => _gps = v)),
        _buildToggleItem('格式化',
            value: _format,
            onChanged: (v) => setState(() => _format = v)),
        _buildToggleItem('OTA升级',
            value: _otaUpgrade,
            onChanged: (v) => setState(() => _otaUpgrade = v)),
      ],
    );
  }

  Widget _buildTimeLanguageSection() {
    return _buildSection(
      title: '时间与语言设置',
      children: [
        _buildNavItem('日期格式'),
        _buildNavItem('时区'),
        _buildNavItem('语言'),
        _buildToggleItem('同步时间',
            value: _syncTime,
            onChanged: (v) => setState(() => _syncTime = v)),
      ],
    );
  }

  Widget _buildStorageSection() {
    return _buildSection(
      title: '存储设置',
      children: [
        _buildNavItem('存储管理'),
        _buildNavItem('自动覆盖'),
      ],
    );
  }

  Widget _buildAiHighlightSection() {
    return _buildSection(
      title: 'AI高光场景设置',
      children: [
        _buildNavItem('高光场景设置'),
      ],
    );
  }
}
