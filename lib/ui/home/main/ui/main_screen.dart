/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/main/logic/cubit/home/home_cubit.dart';
import 'package:touristapp/ui/home/main/logic/model/transaction_result.dart';
import 'package:touristapp/ui/widgets/primary_container.dart'
    show PrimaryContainer;
import 'package:touristapp/ui/widgets/scale_widget_anim.dart';
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/extensions/color_extension.dart'
    show ColorExtension;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;
import 'package:touristapp/utils/modal/modal_sheets.dart';
import 'package:touristapp/utils/router/app_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HomeCubit _homeCubit = getIt<HomeCubit>();

  @override
  void initState() {
    _homeCubit.getHomeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _homeCubit,
    child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Main", style: context.semiboldMd),
          actions: [
            IconButton(
              onPressed: () {
                ModalSheets.showQrCheque(
                  context,
                  transaction: TransactionResult.sample(),
                );
              },
              icon: Icon(Icons.notifications),
            ),
          ],
        ),
        floatingActionButton: ScaleWidgetAnim(
          // ignore: use_build_context_synchronously
          onPressed: () => Future.delayed(Duration(milliseconds: 500), () => ModalSheets.showQrScanner(context)),
          child: SizedBox(
            width: 64,
            height: 64,
            child: SvgPicture.asset(Assets.iconsQrButton),
          ),
        ),
        body: Padding(
          padding: context.k16Padding,
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 150,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: context.borderRadius24,
                    image: DecorationImage(
                      image: AssetImage(Assets.iconsWalletBg),
                      fit: .cover,
                    ),
                  ),
                  child: Padding(
                    padding: context.k16Padding,
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: .end,
                      children: [
                        Text(
                          "Total balance",
                          style: context.semiboldMutedXs.copyWith(
                            color: context.textDisabled,
                          ),
                        ),
                        Text(
                          state.details?.wallet.first.getBalance() ?? "",
                          style: context.semiboldDisplaySm.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              context.szBoxHeight20,
              Row(
                children: [
                  _buildBox(Assets.iconsRightTrailing, "Top Up", () {}),
                  context.szBoxWidth16,
                  _buildBox(Assets.iconsP2p, "Send money", () {}),
                  context.szBoxWidth16,
                  _buildBox(Assets.iconsWallet, "Payments", () {
                    // context.push('/main/payments');
                    PaymentsRoute().push(context);
                  }),
                ],
              ),
              context.szBoxHeight20,
              Row(
                crossAxisAlignment: .center,
                children: [
                  Text("History", style: context.semiboldMd),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
              context.szBoxHeight12,
              Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(Assets.iconsEmptyBox),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _buildBox(String iconPath, String label, VoidCallback onTap) {
    return Expanded(
      child: InkWell(
        borderRadius: context.borderRadius16,
        onTap: onTap,
        child: PrimaryContainer(
          padding: context.k12Padding,
          children: [
            SizedBox(width: 24, height: 24, child: SvgPicture.asset(iconPath)),
            context.szBoxHeight16,
            Text(label, style: context.mediumXs),
          ],
        ),
      ),
    );
  }
}
