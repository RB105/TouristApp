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
}

class _TouristTickerState extends State<TouristTicker> {
  // Your specific list of texts and icons
  late final List<Map<String, dynamic>> _items;

  late FixedExtentScrollController _controller;
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _items = [
      {'text': 'ticker.cashback_bonuses'.tr(), 'icon': Assets.iconsTextBonus},
      {'text': 'ticker.safe_with_you'.tr(), 'icon': Assets.iconsTextSafe},
      {'text': 'ticker.worldwide_usage'.tr(), 'icon': Assets.iconsTextGlobe},
      {'text': 'ticker.fast_transfers'.tr(), 'icon': Assets.iconsTextCard},
      {'text': 'ticker.all_in_one'.tr(), 'icon': Assets.iconsTextWallet},
      {'text': 'ticker.fast_qr'.tr(), 'icon': Assets.iconsTextQr},
    ];

    _controller = FixedExtentScrollController();

    // Start the auto-scroll timer
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _currentIndex = (_currentIndex + 1) % _items.length;
      _controller.animateToItem(
        _currentIndex,
        duration: Duration(milliseconds: 800),
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
      child: ListWheelScrollView.useDelegate(
        controller: _controller,
        itemExtent: 50,
        physics: NeverScrollableScrollPhysics(),
        perspective: 0.00001,
        onSelectedItemChanged: (index) {
          setState(() => _currentIndex = index % _items.length);
        },
        childDelegate: ListWheelChildLoopingListDelegate(
          children: _items.map((item) {
            bool isActive =
                _items.indexOf(item) == (_currentIndex % _items.length);
            return Row(
              mainAxisAlignment: .start,
              crossAxisAlignment: .center,
              children: [
                AppAnimatedSwitcher(
                  reverseDuration: Duration(milliseconds: 100),
                  child: isActive
                      ? Row(
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
                      : SizedBox.shrink(),
                ),
                Text(
                  item['text'],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
                    color: isActive ? Colors.black : Colors.black26,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
