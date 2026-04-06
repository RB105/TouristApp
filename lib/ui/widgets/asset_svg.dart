/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;

class AssetSvg extends StatelessWidget {
  final String url;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const AssetSvg(
    this.url, {
    super.key,
    this.color,
    this.height,
    this.width,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      url,
      colorFilter: ColorFilter.mode(
        color ?? Color(0xff585858),
        BlendMode.srcIn,
      ),
      width: width,
      height: height,
    );
  }
}
