/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';

import '../../../../utils/extensions/context_extensions.dart' show ContextExtensions;

typedef KeyboardTapCallback = void Function(String text);

class PinCodeKeyboard extends StatefulWidget {
  final TextStyle? textStyle;

  final Icon? rightIcon;

  final void Function()? rightButtonFn;

  final Widget? leftIcon;

  final void Function()? leftButtonFn;

  final KeyboardTapCallback onKeyboardTap;

  final MainAxisAlignment mainAxisAlignment;

  /// Keyboard for Pincode page
  const PinCodeKeyboard({
    super.key,
    required this.onKeyboardTap,
    this.rightButtonFn,
    this.rightIcon,
    this.leftButtonFn,
    this.leftIcon,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.textStyle,
  });

  @override
  State<StatefulWidget> createState() {
    return _PinCodeKeyboardState();
  }
}

class _PinCodeKeyboardState extends State<PinCodeKeyboard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OverflowBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('1'),
            _calcButton('2'),
            _calcButton('3'),
          ],
        ),
        context.szBoxHeight12,
        OverflowBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('4'),
            _calcButton('5'),
            _calcButton('6'),
          ],
        ),
        context.szBoxHeight12,
        OverflowBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('7'),
            _calcButton('8'),
            _calcButton('9'),
          ],
        ),
        context.szBoxHeight12,
        OverflowBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(45),
              onTap: widget.leftButtonFn,
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: widget.leftIcon,
              ),
            ),
            _calcButton('0'),
            InkWell(
              borderRadius: BorderRadius.circular(45),
              onTap: widget.rightButtonFn,
              child: Container(
                alignment: Alignment.center,
                width: 50,
                height: 50,
                child: widget.rightIcon,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _calcButton(String value) {
    return InkWell(
      borderRadius: BorderRadius.circular(45),
      onTap: () => widget.onKeyboardTap(value),
      child: Container(
        alignment: Alignment.center,
        width: 54,
        height: 54,
        child: Text(value, style: context.boldDisplayMd),
      ),
    );
  }
}
