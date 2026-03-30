/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/main/logic/cubit/home/home_cubit.dart';
import 'package:touristapp/ui/home/main/ui/widgets/main_last_tr_widget.dart';
import 'package:touristapp/ui/home/main/ui/widgets/main_total_balance_widget.dart';
import 'package:touristapp/ui/widgets/primary_container.dart'
    show PrimaryContainer;
import 'package:touristapp/ui/widgets/scale_widget_anim.dart';
import 'package:touristapp/utils/di/di.dart';
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
          title: Text("home.main_title".tr(), style: context.semiboldMd),
          actions: [
            IconButton(
              onPressed: () {
                // ModalSheets.showQrCheque(
                //   context,
                //   transaction: TransactionResult.sample(),
                // );
                // StatefulNavigationShell.of(context).goBranch(2);
              },
              icon: Icon(Icons.notifications),
            ),
          ],
        ),
        floatingActionButton: ScaleWidgetAnim(
          onPressed: () => Future.delayed(
            Duration(milliseconds: 500),
            // ignore: use_build_context_synchronously
            () => ModalSheets.showQrScanner(context),
          ),
          child: SizedBox(
            width: 64,
            height: 64,
            child: SvgPicture.asset(Assets.iconsQrButton),
          ),
        ),
        body: RefreshIndicator.adaptive(
          onRefresh: () => _homeCubit.getHomeDetails(),
          child: ListView(
            children: [
              Column(
                children: [
                  MainTotalBalanceWidget(
                    balance: state.details?.wallet.first.getBalance() ?? "",
                  ),
                  context.szBoxHeight20,
                  Padding(
                    padding: context.k16horizontalPadding,
                    child: Row(
                      children: [
                        _buildBox(Assets.iconsRightTrailing, "main.top_up".tr(), () {}),
                        context.szBoxWidth16,
                        _buildBox(Assets.iconsP2p, "main.send_money".tr(), () {}),
                        context.szBoxWidth16,
                        _buildBox(Assets.iconsWallet, "main.payments".tr(), () {
                          // context.push('/main/payments');
                          PaymentsRoute().push(context);
                        }),
                      ],
                    ),
                  ),
                  context.szBoxHeight20,
                  MainLastTrWidget(historyGroups: state.details?.history ?? []),
                ],
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
