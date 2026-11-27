import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:darago_app/app/routes/app_pages.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  static const double _buttonWidth = 260.0;
  static const double _thumbSize = 56.0;
  late final double _maxDrag;

  @override
  void initState() {
    super.initState();
    _maxDrag = _buttonWidth - _thumbSize - 12; // padding margin
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(0.0, _maxDrag);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (_dragPosition >= _maxDrag * 0.7) {
      // Swipe berhasil, langsung arahkan ke Login
      Get.offNamed(Routes.LOGIN);
    } else {
      // Kembalikan ke posisi awal jika swipe belum selesai
      setState(() {
        _dragPosition = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const deepBlue = Color(0xFF10192D); // Warna biru tua
    const navyAccent = Color(0xFF1A2644);

    return Scaffold(
      backgroundColor: deepBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Brand Title
              const Text(
                'DaraGo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 36),

              // Headline Text
              const Text(
                'Nikmati\nPerjalanan Wisata\nLebih Aman',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.w700,
                  height: 1.25,
                ),
              ),

              // Area Tengah Kosong Warna Biru Tua
              const Expanded(
                child: SizedBox(),
              ),

              // Swipe Bar Animation di bagian bawah
              Center(
                child: Container(
                  width: _buttonWidth,
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: navyAccent.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(36),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                      width: 1,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      // Instruksi Teks Geser
                      Positioned.fill(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 48),
                            Text(
                              'Start  >>>',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.85),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Tombol Swipe Lingkaran Putih (Play Icon)
                      Positioned(
                        left: _dragPosition,
                        child: GestureDetector(
                          onHorizontalDragUpdate: _onHorizontalDragUpdate,
                          onHorizontalDragEnd: _onHorizontalDragEnd,
                          child: Container(
                            width: _thumbSize,
                            height: _thumbSize,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: Color(0xFF10192D),
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
