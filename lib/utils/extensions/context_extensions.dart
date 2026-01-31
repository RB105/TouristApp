import 'package:flutter/material.dart';

import '../config/size_config.dart';

extension ContextExtensions on BuildContext {
  /// Border radius for rounded corners
  BorderRadius get borderRadius12 => BorderRadius.circular(SizeConfig.w(12));
  BorderRadius get borderRadius16 => BorderRadius.circular(SizeConfig.w(16));
  BorderRadius get borderRadius24 => BorderRadius.circular(SizeConfig.w(24));
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  double get statusBarHeight => MediaQuery.of(this).padding.top;
  double get navBarHeight => MediaQuery.of(this).padding.bottom;
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;


  // SizedBox for Space
  SizedBox get szBoxHeight4 => SizedBox(height: v4);
  SizedBox get szBoxHeight8 => SizedBox(height: v8);
  SizedBox get szBoxHeight12 => SizedBox(height: v12);
  SizedBox get szBoxHeight16 => SizedBox(height: v16);
  SizedBox get szBoxHeight20 => SizedBox(height: v20);
  SizedBox get szBoxHeight24 => SizedBox(height: v24);
  SizedBox get szBoxHeight32 => SizedBox(height: v32);
  SizedBox get szNavbarHeight => SizedBox(height: navBarHeight);

  SizedBox get szBoxWidth2 => SizedBox(width: h2);
  SizedBox get szBoxWidth4 => SizedBox(width: h4);
  SizedBox get szBoxWidth8 => SizedBox(width: h8);
  SizedBox get szBoxWidth12 => SizedBox(width: h12);
  SizedBox get szBoxWidth16 => SizedBox(width: h16);
  SizedBox get szBoxWidth24 => SizedBox(width: h24);

  /// Padding for standard spacing vertically
  double get v2 => SizeConfig.h(2);
  double get v4 => SizeConfig.h(4);
  double get v6 => SizeConfig.h(6);
  double get v8 => SizeConfig.h(8);
  double get v10 => SizeConfig.h(10);
  double get v12 => SizeConfig.h(12);
  double get v14 => SizeConfig.h(14);
  double get v16 => SizeConfig.h(16);
  double get v18 => SizeConfig.h(18);
  double get v20 => SizeConfig.h(20);
  double get v24 => SizeConfig.h(24);
  double get v32 => SizeConfig.h(32);
  double get v40 => SizeConfig.h(40);


  /// Padding for standard spacing horizontally
  double get h2 => SizeConfig.w(2);
  double get h4 => SizeConfig.w(4);
  double get h5 => SizeConfig.w(5);
  double get h6 => SizeConfig.w(6);
  double get h8 => SizeConfig.w(8);
  double get h9 => SizeConfig.w(9);
  double get h10 => SizeConfig.w(10);
  double get h12 => SizeConfig.w(12);
  double get h15 => SizeConfig.w(15);
  double get h16 => SizeConfig.w(16);
  double get h17 => SizeConfig.w(17);
  double get h20 => SizeConfig.w(20);
  double get h24 => SizeConfig.w(24);
  double get h32 => SizeConfig.w(32);

  /// decoration for container


  /// padding for standard spacing
  EdgeInsets get padding32 => EdgeInsets.symmetric(horizontal: h32);
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  // Horizontal
  EdgeInsets get k6horizontalPadding => EdgeInsets.symmetric(horizontal: 6);
  EdgeInsets get k8horizontalPadding => EdgeInsets.symmetric(horizontal: 8);
  EdgeInsets get k10horizontalPadding => EdgeInsets.symmetric(horizontal: 10);
  EdgeInsets get k12horizontalPadding => EdgeInsets.symmetric(horizontal: 12);
  EdgeInsets get k14horizontalPadding => EdgeInsets.symmetric(horizontal: 14);
  EdgeInsets get k16horizontalPadding => EdgeInsets.symmetric(horizontal: 16);
  EdgeInsets get k20horizontalPadding => EdgeInsets.symmetric(horizontal: 20);
  EdgeInsets get k32horizontalPadding => EdgeInsets.symmetric(horizontal: 32);
  EdgeInsets get k16Padding => EdgeInsets.all(16);
  EdgeInsets get k12Padding => EdgeInsets.all(12);
  EdgeInsets get k8Padding => EdgeInsets.all(8);
  EdgeInsets get k4Padding => EdgeInsets.all(4);

  // Vertical
  EdgeInsets get k6verticalPadding => EdgeInsets.symmetric(vertical: 6);
  EdgeInsets get k8verticalPadding => EdgeInsets.symmetric(vertical: 8);
  EdgeInsets get k12verticalPadding => EdgeInsets.symmetric(vertical: 12);
  EdgeInsets get k14verticalPadding => EdgeInsets.symmetric(vertical: 14);
  EdgeInsets get k16verticalPadding => EdgeInsets.symmetric(vertical: 16);
  EdgeInsets get k20verticalPadding => EdgeInsets.symmetric(vertical: 20);
}
