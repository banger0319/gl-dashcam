class MockDevice {
  final String name;
  final String model;
  final bool isConnected;
  final String connectionType; // wifi, bluetooth, 4g
  final bool hasSignal;
  final bool hasBluetooth;
  final String? frontCameraUrl;
  final String? rearCameraUrl;
  final String? leftCameraUrl;

  MockDevice({
    required this.name,
    required this.model,
    this.isConnected = false,
    this.connectionType = 'wifi',
    this.hasSignal = true,
    this.hasBluetooth = true,
    this.frontCameraUrl,
    this.rearCameraUrl,
    this.leftCameraUrl,
  });
}

class MockVideoClip {
  final String title;
  final String thumbnailUrl;
  final String dateRange;
  final String duration;
  final String type; // emergency, highlight, normal
  final DateTime createdAt;

  MockVideoClip({
    required this.title,
    required this.thumbnailUrl,
    required this.dateRange,
    required this.duration,
    required this.type,
    required this.createdAt,
  });
}

class MockEditTemplate {
  final String title;
  final String thumbnailUrl;
  final String description;

  MockEditTemplate({
    required this.title,
    required this.thumbnailUrl,
    required this.description,
  });
}

class MockData {
  static final MockDevice connectedDevice = MockDevice(
    name: 'GL Dashcam10',
    model: 'GL-DC10',
    isConnected: true,
    connectionType: 'wifi',
    hasSignal: true,
    hasBluetooth: true,
    frontCameraUrl: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400&h=300&fit=crop',
    rearCameraUrl: 'https://images.unsplash.com/photo-1476186726489-37d42d27e14a?w=400&h=300&fit=crop',
    leftCameraUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=400&h=300&fit=crop',
  );

  static final List<MockVideoClip> recentClips = [
    MockVideoClip(
      title: '紧急视频',
      thumbnailUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=200&h=120&fit=crop',
      dateRange: '03/25 00:24 - 03/25 00:25',
      duration: '00:01:00',
      type: 'emergency',
      createdAt: DateTime(2026, 3, 25, 0, 24),
    ),
    MockVideoClip(
      title: '高光视频',
      thumbnailUrl: 'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=200&h=120&fit=crop',
      dateRange: '03/25 00:24 - 03/25 00:25',
      duration: '00:01:00',
      type: 'highlight',
      createdAt: DateTime(2026, 3, 25, 0, 24),
    ),
  ];

  static final List<MockVideoClip> editHistory = [
    MockVideoClip(
      title: 'Trip 1',
      thumbnailUrl: 'https://images.unsplash.com/photo-1518069002340-788e93c89677?w=200&h=200&fit=crop',
      dateRange: '03/25',
      duration: '00:05:22',
      type: 'normal',
      createdAt: DateTime(2026, 3, 25),
    ),
    MockVideoClip(
      title: 'Highway Drive',
      thumbnailUrl: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=400&h=400&fit=crop',
      dateRange: '03/24',
      duration: '00:12:35',
      type: 'normal',
      createdAt: DateTime(2026, 3, 24),
    ),
    MockVideoClip(
      title: 'Night Drive',
      thumbnailUrl: 'https://images.unsplash.com/photo-1475070929565-c985b2ea2e0b?w=200&h=200&fit=crop',
      dateRange: '03/23',
      duration: '00:08:11',
      type: 'normal',
      createdAt: DateTime(2026, 3, 23),
    ),
    MockVideoClip(
      title: 'Forest Road',
      thumbnailUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=200&h=200&fit=crop',
      dateRange: '03/22',
      duration: '00:03:45',
      type: 'normal',
      createdAt: DateTime(2026, 3, 22),
    ),
    MockVideoClip(
      title: 'City Skyline',
      thumbnailUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=200&h=200&fit=crop',
      dateRange: '03/21',
      duration: '00:06:12',
      type: 'normal',
      createdAt: DateTime(2026, 3, 21),
    ),
    MockVideoClip(
      title: 'Sunset Drive',
      thumbnailUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=200&h=200&fit=crop',
      dateRange: '03/20',
      duration: '00:04:30',
      type: 'normal',
      createdAt: DateTime(2026, 3, 20),
    ),
  ];

  static final List<MockEditTemplate> templates = [
    MockEditTemplate(
      title: 'Road Trip',
      thumbnailUrl: 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300&h=200&fit=crop',
      description: 'Perfect road trip compilation',
    ),
    MockEditTemplate(
      title: 'City Drive',
      thumbnailUrl: 'https://images.unsplash.com/photo-1449824913935-59a10b8d2000?w=300&h=200&fit=crop',
      description: 'Urban driving highlights',
    ),
    MockEditTemplate(
      title: 'Night Scene',
      thumbnailUrl: 'https://images.unsplash.com/photo-1475070929565-c985b2ea0e0b?w=300&h=200&fit=crop',
      description: 'Night driving atmosphere',
    ),
    MockEditTemplate(
      title: 'Nature Drive',
      thumbnailUrl: 'https://images.unsplash.com/photo-1441974231531-c6227db76b6e?w=300&h=200&fit=crop',
      description: 'Scenic routes compilation',
    ),
  ];

  // Settings data
  static const Map<String, dynamic> videoRecordingSettings = {
    '录制分辨率': '1920x1080',
    '录制帧率': '30fps',
    '录制码率': '20Mbps / H265',
    '录像': true,
    '录音': true,
    '时间戳': true,
    '速度水印': true,
  };

  static const Map<String, dynamic> parkingMonitorSettings = {
    '停车监控': 'Toggle',
    '灵敏度': 'Navigate',
    '预录时间': 'Navigate',
    '录像时长': 'Navigate',
    '缩时录影': 'Toggle',
    '异常提醒': 'Toggle',
    '低帧率': 'Toggle',
    '延迟关机': 'Toggle',
    '节能模式': 'Toggle',
    '夜视增强': 'Toggle',
    '降噪': 'Toggle',
  };

  static const Map<String, dynamic> adasSettings = {
    '校准设置': 'Navigate',
    '前车碰撞预警': 'Navigate',
    '车道偏离': 'Navigate',
    '前车起步': 'Toggle',
    '行人碰撞预警': 'Toggle',
    '前方路标识别': 'Toggle',
    '绿灯提醒': 'Toggle',
    '疲劳驾驶提醒': 'Description',
    'ADAS音量': '3',
  };
}
