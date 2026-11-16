import 'package:flutter/material.dart';

import '../../widgets/coaching_widgets.dart';
import '../../widgets/phone_mockup.dart';

class Screen1D extends StatefulWidget {
  const Screen1D({this.large = false, super.key});

  final bool large;

  @override
  State<Screen1D> createState() => _Screen1DState();
}

class _Screen1DState extends State<Screen1D> {
  String _mode = 'Video';
  bool _muted = false;
  bool _cameraOn = true;

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
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: double.infinity,
            height: _mode == 'Video' ? 200 : 108,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: const Color(0xFFD6F3EC),
              borderRadius: BorderRadius.circular(_mode == 'Video' ? 24 : 100),
              border: Border.all(color: const Color(0xFFE3ECEA)),
            ),
            child: Container(
              width: _mode == 'Video' ? 96 : 72,
              height: _mode == 'Video' ? 96 : 72,
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
          if (_mode == 'Video')
            const Align(
              alignment: Alignment.centerRight,
              child: Chip(
                label: Text('You', style: TextStyle(fontSize: 9)),
                visualDensity: VisualDensity.compact,
              ),
            ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE3ECEA)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                for (final type in ['Voice', 'Video'])
                  Expanded(
                    child: TextButton(
                      onPressed: () => setState(() => _mode = type),
                      style: TextButton.styleFrom(
                        backgroundColor: _mode == type
                            ? const Color(0xFF5FD0BF)
                            : Colors.transparent,
                        foregroundColor: _mode == type
                            ? Colors.white
                            : const Color(0xFF6B7886),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                      child: Text(type),
                    ),
                  ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _controlButton(
                _muted ? Icons.mic_off : Icons.mic,
                _muted ? 'Unmute microphone' : 'Mute microphone',
                () => setState(() => _muted = !_muted),
                active: _muted,
              ),
              if (_mode == 'Video') ...[
                const SizedBox(width: 9),
                _controlButton(
                  _cameraOn ? Icons.videocam : Icons.videocam_off,
                  _cameraOn ? 'Turn camera off' : 'Turn camera on',
                  () => setState(() => _cameraOn = !_cameraOn),
                  active: !_cameraOn,
                ),
              ],
              const SizedBox(width: 9),
              _controlButton(
                Icons.volume_up,
                'Speaker',
                () => showAppNotice(context, 'Speaker is on'),
              ),
              const SizedBox(width: 9),
              _controlButton(
                Icons.call_end,
                'End call',
                _endCall,
                danger: true,
              ),
            ],
          ),
          if (_muted || !_cameraOn)
            Text(
              _muted ? 'Microphone muted' : 'Camera off',
              style: const TextStyle(color: Color(0xFF6B7886), fontSize: 10),
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

  Widget _controlButton(
    IconData icon,
    String label,
    VoidCallback onPressed, {
    bool active = false,
    bool danger = false,
  }) => Tooltip(
    message: label,
    child: Material(
      color: danger
          ? const Color(0xFFD9483B)
          : active
          ? const Color(0x29F4877B)
          : Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 43,
          height: 43,
          child: Icon(
            icon,
            color: danger ? Colors.white : const Color(0xFF1D2733),
            size: 18,
          ),
        ),
      ),
    ),
  );
}
