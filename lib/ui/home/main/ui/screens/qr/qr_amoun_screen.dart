/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/home/main/logic/cubit/qr_cubit.dart';
import 'package:touristapp/ui/home/main/logic/model/qr_check_result.dart';
import 'package:touristapp/ui/widgets/custom_button.dart';
import 'package:touristapp/ui/widgets/custom_keyboard.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/enums/api_status.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/dialog_ext.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';
import 'package:touristapp/utils/router/app_router.dart';

class QrAmounScreen extends StatefulWidget {
  final QrCheckResult qrCheckResult;

  const QrAmounScreen({super.key, required this.qrCheckResult});

  @override
  State<QrAmounScreen> createState() => _QrAmounScreenState();
}

class _QrAmounScreenState extends State<QrAmounScreen> {
  String _amount = "0";

  final double minAmount = 1;
  final double maxAmount = 10000;

  final double minFontSize = 28;
  final double maxFontSize = 48;

  final QrCubit _qrCubit = getIt<QrCubit>();

  double get _parsedAmount =>
      double.tryParse(_amount.isEmpty ? "0" : _amount) ?? 0;

  double get _calculatedFontSize {
    final value = _parsedAmount.clamp(minAmount, maxAmount);

    final percent = (value - minAmount) / (maxAmount - minAmount);

    return maxFontSize - (maxFontSize - minFontSize) * percent;
  }

  void _onKeyboardTap(String text) {
    if (_amount.length == 1 && _amount == '0') {
      _amount = '';
    }
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
  void initState() {
    if (widget.qrCheckResult.amount != 0) {
      _amount = widget.qrCheckResult.amount.toStringAsFixed(2);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Pay")),
    body: BlocProvider.value(
      value: _qrCubit,
      child: BlocConsumer<QrCubit, QrState>(
        listener: (context, state) {
          if (state.paymentCreateStatus == .loading) {
            context.showLoading();
          } else if (state.paymentCreateStatus == .error) {
            context.showErrorDialog(title: state.paymentCreateError);
            debugPrint("Payment Create Error: ${state.paymentCreateError}");
          } else if (state.paymentCreateStatus == .success) {
            context.hideDialog();
            if (state.paymentCreateResult?.otpRequired ?? false) {
              QrOtpScreenRoute(
                paymentCreateResult: state.paymentCreateResult!,
              ).push(context);
              return;
            }
            SbpChequesScreenRoute(extId: state.paymentCreateResult?.extId ?? "" ).go(context);
            return;
          }
        },
        builder: (context, state) => Padding(
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
                child: Text("${_amount.isEmpty ? "0" : _amount} uzs"),
              ),

              context.szBoxHeight36,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Merchant: "),
                  Text(
                    widget.qrCheckResult.merchant,
                    style: context.semiboldSm.copyWith(color: context.primary),
                  ),
                ],
              ),
              context.szBoxHeight16,
              Visibility(
                visible: widget.qrCheckResult.amount == 0,
                child: Column(
                  children: [
                    const Divider(),
                    context.szBoxHeight16,
                    Text('${widget.qrCheckResult.minAmount} - ${widget.qrCheckResult.maxAmount} ${widget.qrCheckResult.settlementCurrency}'),
                    context.szBoxHeight16,
                    const Divider(),
                  ],
                ),
              ),
              Spacer(),
              Visibility(
                visible: widget.qrCheckResult.amount == 0,
                child: CustomKeyboard(
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
              ),
              const Spacer(),
              CustomButton(
                onPressed: () {
                  if (state.paymentCreateStatus != ApiStatus.loading) {
                    _qrCubit.createPayment(
                      extId: widget.qrCheckResult.extId,
                      amount: double.parse(_amount),
                    );
                  }
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
