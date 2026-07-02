import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../widgets/bottom_navbar.dart';

import '../dashboard/dashboard_screen.dart';
import '../activity/activity_screen.dart';
import '../statistics/statistics_screen.dart';

class WaterEntry {
  final int amount;
  final TimeOfDay time;

  WaterEntry({required this.amount, required this.time});

  String get formattedTime {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class WaterScreen extends StatefulWidget {
  const WaterScreen({super.key});

  @override
  State<WaterScreen> createState() => _WaterScreenState();
}

class _WaterScreenState extends State<WaterScreen> {
  static const int dailyTarget = 2000;
  static const int addAmount = 250;

  final List<WaterEntry> _history = [
    WaterEntry(amount: 250, time: const TimeOfDay(hour: 8, minute: 0)),
    WaterEntry(amount: 500, time: const TimeOfDay(hour: 10, minute: 30)),
    WaterEntry(amount: 250, time: const TimeOfDay(hour: 13, minute: 15)),
    WaterEntry(amount: 250, time: const TimeOfDay(hour: 15, minute: 45)),
  ];

  int get _total => _history.fold(0, (sum, e) => sum + e.amount);

  double get _percent => (_total / dailyTarget * 100).clamp(0, 100);

  void _addWater() {
    setState(() {
      _history.insert(0, WaterEntry(amount: addAmount, time: TimeOfDay.now()));
    });
  }

  void _resetHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Water Reminder',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.black87),
            onPressed: _resetHistory,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      'Daily Target',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      '2,000 ml',
                      style: TextStyle(
                        color: Color(0xFF4285F4),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: 260,
                      height: 260,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(260, 260),
                            painter: _ProgressRingPainter(percent: _percent),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$_total ml',
                                style: const TextStyle(
                                  color: Color(0xFF4285F4),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${_percent.round()}%',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _addWater,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E8E3E),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'ADD $addAmount ML',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text(
                    'History',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(height: 24, color: Color(0xFFEFEFEF)),
                  if (_history.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                          'No entries yet. Add some water!',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ..._history.map(
                      (entry) => Column(
                        children: [
                          _HistoryTile(entry: entry),
                          const Divider(height: 1, color: Color(0xFFF0F0F0)),
                        ],
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: 2,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
              break;

            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const ActivityScreen()),
              );
              break;

            case 2:
              // Sudah di Water
              break;

            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const StatisticsScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  final WaterEntry entry;

  const _HistoryTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFEFEFEF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.water_drop,
              color: Color(0xFF4285F4),
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Water',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.amount} ml',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                entry.formattedTime,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProgressRingPainter extends CustomPainter {
  final double percent;

  _ProgressRingPainter({required this.percent});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 22) / 2;

    final backgroundPaint = Paint()
      ..color = const Color(0xFFEEF2F6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 22
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = 2 * math.pi * (percent / 100);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ProgressRingPainter oldDelegate) {
    return oldDelegate.percent != percent;
  }
}
