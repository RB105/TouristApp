/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/home/main/logic/cubit/qr_cubit.dart';
import 'package:touristapp/ui/home/main/logic/model/payment_create_result.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart';
import 'package:touristapp/utils/modal/modal_dialogs.dart';
import 'package:touristapp/utils/modal/modal_sheets.dart';
import 'package:touristapp/utils/styled_text_parser.dart' show StyledTextParser;

class QrOtpScreen extends StatefulWidget {
  final PaymentCreateResult paymentCreateResult;

  const QrOtpScreen({super.key, required this.paymentCreateResult});

  @override
  State<QrOtpScreen> createState() => _QrOtpScreenState();
}

class _QrOtpScreenState extends State<QrOtpScreen> {
  final _otpController = TextEditingController();
  final _focusNode = FocusNode();

  final QrCubit _qrCubit = getIt<QrCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _qrCubit,
      child: BlocConsumer<QrCubit,QrState>(
        listener: (context, state) {
          if (state.paymentConfirmStatus == .loading) {
            ModalDialogs.showLoader(context);
          } else if (state.paymentConfirmStatus == .error) {
            ModalDialogs.dismissCurrentDialog();
            ModalDialogs.showErrorDialog(context, title: state.paymentConfirmError);
          } else if (state.paymentConfirmStatus == .success) {
            ModalDialogs.dismissCurrentDialog();
            // show check screen
            ModalSheets.showQrCheque(context, transaction: state.transaction!);
            debugPrint("Payment confirmed successfully");
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(title: Text("Transfer confirmation")),
          body: Padding(
            padding: context.k16Padding,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Spacer(),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: SvgPicture.asset(Assets.iconsTgLogo),
                ),
                context.szBoxHeight24,
                Text(
                  "auth.verification_code".tr(),
                  style: context.boldDisplayXs,
                ),
                context.szBoxHeight24,
                RichText(
                  text: StyledTextParser.parse(
                    'auth.verification_message'.tr(),
                    placeholders: {'phone': widget.paymentCreateResult.phoneNumber},
                    tagStyles: {
                      'bold': (style) => style.copyWith(fontWeight: FontWeight.bold),
                    }, defaultStyle: context.textSm,
                  ),
                ),
                context.szBoxHeight24,
                Pinput(
                  controller: _otpController,
                  focusNode: _focusNode,
                  length: 6,
                  onCompleted: (value) => _qrCubit.confirmPayment(
                      extId: widget.paymentCreateResult.extId,
                      otpCode: _otpController.text,
                    ),
                  separatorBuilder: (index) {
                    if (index == 2) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '-',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    return const SizedBox(width: 8);
                  },
                ),
                context.szBoxHeight24
              ],
            ),
          ),
        ),
      ),
    );
  }
}
