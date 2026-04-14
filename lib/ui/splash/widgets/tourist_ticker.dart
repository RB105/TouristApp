/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:async' show Timer;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:easy_localization/easy_localization.dart';
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/widgets/animated_switcher.dart' show AppAnimatedSwitcher;

class TouristTicker extends StatefulWidget {
  const TouristTicker({super.key});

  @override
  State<TouristTicker> createState() => _TouristTickerState();
}class _TouristTickerState extends State<TouristTicker> {
  late final List<Map<String, dynamic>> _items;
  late PageController _controller;
  Timer? _timer;
  int _absoluteIndex = 0;

  static const int _startOffset = 30000;

  @override
  void initState() {
    super.initState();
    _items = [
      {'text': 'ticker.cashback_bonuses'.tr(), 'icon': Assets.iconsTextBonus},
      {'text': 'ticker.safe_with_you'.tr(),    'icon': Assets.iconsTextSafe},
      {'text': 'ticker.worldwide_usage'.tr(),  'icon': Assets.iconsTextGlobe},
      {'text': 'ticker.fast_transfers'.tr(),   'icon': Assets.iconsTextCard},
      {'text': 'ticker.all_in_one'.tr(),       'icon': Assets.iconsTextWallet},
      {'text': 'ticker.fast_qr'.tr(),          'icon': Assets.iconsTextQr},
    ];


    _absoluteIndex = _startOffset;

    _controller = PageController(
      initialPage: _absoluteIndex,
      viewportFraction: 50 / 150,
    );

    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      _absoluteIndex++;
      _controller.animateToPage(
        _absoluteIndex,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final page = _controller.hasClients
              ? (_controller.page ?? _absoluteIndex.toDouble())
              : _absoluteIndex.toDouble();

          return PageView.builder(
            controller: _controller,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final realIndex = index % _items.length;
              final item = _items[realIndex];

              final isActive = (index - page).abs() < 0.5;

              return Row(
                children: [
                  AppAnimatedSwitcher(
                    reverseDuration: const Duration(milliseconds: 100),
                    child: isActive
                        ? Row(
                      key: ValueKey(realIndex),
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Center(
                            child: SvgPicture.asset(item['icon']),
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                    )
                        : const SizedBox.shrink(),
                  ),
                  Text(
                    item['text'],
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                      isActive ? FontWeight.bold : FontWeight.w400,
                      color:
                      isActive ? Colors.black : Colors.black26,
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}