/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart' show ContextExtensions;

typedef KeyboardTapCallback = void Function(String text);

class CustomKeyboard extends StatefulWidget {
  final TextStyle? textStyle;

  final Widget? rightIcon;

  final void Function()? rightButtonFn;

  final Widget? leftIcon;

  final void Function()? leftButtonFn;

  final KeyboardTapCallback onKeyboardTap;

  final MainAxisAlignment mainAxisAlignment;

  final double? width;
  final double? height;

  final Color? color;

  /// Keyboard for Pincode page
  const CustomKeyboard({
    super.key,
    required this.onKeyboardTap,
    this.rightButtonFn,
    this.rightIcon,
    this.leftButtonFn,
    this.leftIcon,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.textStyle, this.width, this.height, this.color,
  });

  @override
  State<StatefulWidget> createState() {
    return _CustomKeyboardState();
  }
}

class _CustomKeyboardState extends State<CustomKeyboard> {
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
        context.szBoxHeight8,
        OverflowBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('4'),
            _calcButton('5'),
            _calcButton('6'),
          ],
        ),
        context.szBoxHeight8,
        OverflowBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            _calcButton('7'),
            _calcButton('8'),
            _calcButton('9'),
          ],
        ),
        context.szBoxHeight8,
        OverflowBar(
          alignment: widget.mainAxisAlignment,
          children: <Widget>[
            InkWell(
              borderRadius: BorderRadius.circular(45),
              onTap: widget.leftButtonFn,
              child: Container(
                alignment: Alignment.center,
                width: widget.width ?? 50,
                height: widget.height ?? 50,
                child: widget.leftIcon,
              ),
            ),
            _calcButton('0'),
            InkWell(
              borderRadius: BorderRadius.circular(45),
              onTap: widget.rightButtonFn,
              child: Container(
                alignment: Alignment.center,
                width: widget.width ?? 50,
                height: widget.height ?? 50,
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
        width: widget.width ?? 50,
        height: widget.height ?? 50,
        decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle
        ),
        child: Text(
          value,
          style: widget.textStyle ?? TextStyle(
            fontSize: 32,
            fontFamily: "ClashDisplay",
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
