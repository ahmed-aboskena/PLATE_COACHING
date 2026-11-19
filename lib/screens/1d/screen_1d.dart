import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';
import 'controllers/call_controller.dart';
import 'widgets/call_widgets.dart';

class Screen1D extends StatefulWidget {
  const Screen1D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen1D> createState() => _Screen1DState();
}

class _Screen1DState extends State<Screen1D> {
  final _controller = CallController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => PhoneMockup(
    screenId: '1D',
    title: 'Voice / Video call',
    large: widget.large,
    child: SizedBox(
      height: _callAreaHeight(context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text(
                'Coach Mohamed',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 4),
              Text(
                '04:21 · Online plan',
                style: TextStyle(color: Color(0xFF6B7886), fontSize: 10),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: double.infinity,
                height: _controller.mode == 'Video' ? 200 : 108,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFD6F3EC),
                  borderRadius: BorderRadius.circular(
                    _controller.mode == 'Video' ? 24 : 100,
                  ),
                  border: Border.all(color: const Color(0xFFE3ECEA)),
                ),
                child: Container(
                  width: _controller.mode == 'Video' ? 96 : 72,
                  height: _controller.mode == 'Video' ? 96 : 72,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0x29F4877B),
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    'M',
                    style: TextStyle(
                      color: Color(0xFFF4877B),
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              if (_controller.mode == 'Video')
                Positioned(
                  top: 0,
                  right: 14,
                  child: Container(
                    width: 64,
                    height: 92,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: const Color(0xFFF4877B)),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Text(
                      'You',
                      style: TextStyle(color: Color(0xFF6B7886), fontSize: 9),
                    ),
                  ),
                ),
            ],
          ),
          CallSegmentedControl(
            mode: _controller.mode,
            onChanged: (value) => setState(() => _controller.setMode(value)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CallControlButton(
                icon: _controller.muted ? Icons.mic_off : Icons.mic,
                tooltip: _controller.muted
                    ? 'Unmute microphone'
                    : 'Mute microphone',
                onPressed: () => setState(() => _controller.toggleMuted()),
                active: _controller.muted,
              ),
              if (_controller.mode == 'Video') ...[
                const SizedBox(width: 9),
                CallControlButton(
                  icon: _controller.cameraOn
                      ? Icons.videocam
                      : Icons.videocam_off,
                  tooltip: _controller.cameraOn
                      ? 'Turn camera off'
                      : 'Turn camera on',
                  onPressed: () => setState(() => _controller.toggleCamera()),
                  active: !_controller.cameraOn,
                ),
              ],
              const SizedBox(width: 9),
              CallControlButton(
                icon: Icons.volume_up,
                tooltip: 'Speaker',
                onPressed: () => showAppNotice(context, 'Speaker is on'),
              ),
              const SizedBox(width: 9),
              CallControlButton(
                icon: Icons.call_end,
                tooltip: 'End call',
                onPressed: _endCall,
                danger: true,
              ),
            ],
          ),
          const SizedBox(height: 2),
        ],
      ),
    ),
  );

  double _callAreaHeight(BuildContext context) {
    if (!widget.large) return 435;
    final size = MediaQuery.sizeOf(context);
    final safeArea = MediaQuery.paddingOf(context).vertical;
    final height = size.height - safeArea - 26;
    if (height < 435) return 435;
    if (height > 620) return 620;
    return height;
  }

  void _endCall() {
    showAppNotice(context, 'Call ended · Session notes saved');
    Navigator.of(context).pushReplacementNamed('/2D');
  }
}
