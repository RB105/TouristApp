/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:touristapp/ui/home/main/logic/cubit/carusel/carusel_cubit.dart';
import 'package:touristapp/utils/di/di.dart';

import '../../../../../../generated/assets.dart' show Assets;
import '../../../../../../utils/extensions/color_extension.dart'
    show ColorExtension;
import '../../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../../../../utils/extensions/dialog_ext.dart' show DialogExt;
import '../../../../../../utils/extensions/text_styles_extension.dart'
    show TextStyles;
import '../../../../../../utils/router/app_router.dart'
    show BankLauncherScreenRoute;
import '../../../../../widgets/custom_button.dart' show CustomButton;
import '../../../../../widgets/custom_keyboard.dart' show CustomKeyboard;

class AmountScreen extends StatefulWidget {
  const AmountScreen({super.key});

  @override
  State<AmountScreen> createState() => _AmountScreenState();

  static const routeName = '/amount-screen';
}

class _AmountScreenState extends State<AmountScreen> {
  final _caruselCubit = getIt<CaruselCubit>();
  String _amount = "0";

  final double minAmount = 1;
  final double maxAmount = 10000;

  final double minFontSize = 28;
  final double maxFontSize = 48;

  double get _parsedAmount =>
      double.tryParse(_amount.isEmpty ? "0" : _amount) ?? 0;

  double get _calculatedFontSize {
    final value = _parsedAmount.clamp(minAmount, maxAmount);

    final percent = (value - minAmount) / (maxAmount - minAmount);

    return maxFontSize - (maxFontSize - minFontSize) * percent;
  }

  void _onKeyboardTap(String text) {
    setState(() {
      _amount += text;
    });
  }

  void _onBackspace() {
    if (_amount.isEmpty) return;

    setState(() {
      _amount = _amount.substring(0, _amount.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _caruselCubit,
    child: Scaffold(
      appBar: AppBar(title: const Text("Top up my wallet")),
      body: BlocListener<CaruselCubit, CaruselState>(
        listener: (context, state) {
          if (state.transferCreateStatus == .loading) {
            context.showLoading();
          } else if (state.transferCreateStatus == .error) {
            context.showErrorDialog(title: state.transferCreateError);
          } else if (state.transferCreateStatus == .success) {
            context.hideDialog();
            BankLauncherScreenRoute(
              sbpQrResult: state.transferCreateSbpResult!,
            ).push(context);
          }
        },
        child: Padding(
          padding: context.k16Padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Enter amount",
                style: context.mediumMd.copyWith(color: context.textSecondary),
              ),
              context.szBoxHeight32,

              ///
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                style: context.boldDisplayXl.copyWith(
                  fontSize: _calculatedFontSize,
                ),
                child: Text("${_amount.isEmpty ? "0" : _amount} RUB"),
              ),

              context.szBoxHeight36,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Wallet balance: "),
                  Text(
                    "100.00",
                    style: context.semiboldSm.copyWith(color: context.primary),
                  ),
                ],
              ),
              context.szBoxHeight16,
              const Divider(),
              context.szBoxHeight16,
              const Text("Commission (1.5%)"),
              context.szBoxHeight16,
              const Text("0.00 USD"),
              context.szBoxHeight8,
              const Divider(),
              Spacer(),
              CustomKeyboard(
                onKeyboardTap: _onKeyboardTap,
                height: 60,
                width: 60,
                leftButtonFn: () {
                  if (!_amount.contains(".")) {
                    setState(() => _amount += ".");
                  }
                },
                leftIcon: SizedBox(
                  width: 7,
                  height: 34,
                  child: SvgPicture.asset(Assets.iconsDot),
                ),
                rightButtonFn: _onBackspace,
                rightIcon: SizedBox(
                  height: 33,
                  width: 24,
                  child: SvgPicture.asset(Assets.iconsArrowBack),
                ),
                textStyle: context.semiboldDisplaySm.copyWith(
                  color: context.textSecondary,
                ),
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  _caruselCubit.transferSbpCreate(int.tryParse(_amount) ?? 0);
                },
                text: "Continue",
              ),
              context.szBoxHeight20,
            ],
          ),
        ),
      ),
    ),
  );
}
