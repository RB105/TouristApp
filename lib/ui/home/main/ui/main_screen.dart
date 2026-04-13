/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;
import 'package:touristapp/generated/assets.dart' show Assets;
import 'package:touristapp/ui/home/main/logic/cubit/carusel/carusel_cubit.dart'
    show CaruselCubit, CaruselState;
import 'package:touristapp/ui/home/main/logic/cubit/home/home_cubit.dart'
    show HomeCubit, HomeState;
import 'package:touristapp/ui/home/main/ui/widgets/main_last_tr_widget.dart'
    show MainLastTrWidget;
import 'package:touristapp/ui/home/main/ui/widgets/main_total_balance_widget.dart'
    show MainTotalBalanceWidget;
import 'package:touristapp/ui/widgets/primary_container.dart'
    show PrimaryContainer;
import 'package:touristapp/ui/widgets/scale_widget_anim.dart'
    show ScaleWidgetAnim;
import 'package:touristapp/utils/di/di.dart' show getIt;
import 'package:touristapp/utils/extensions/context_extensions.dart'
    show ContextExtensions;
import 'package:touristapp/utils/extensions/dialog_ext.dart' show DialogExt;
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;
import 'package:touristapp/utils/modal/modal_sheets.dart' show ModalSheets;
import 'package:touristapp/utils/router/app_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final HomeCubit _homeCubit = getIt<HomeCubit>();
  final CaruselCubit _caruselCubit = getIt<CaruselCubit>();

  @override
  void initState() {
    _homeCubit.getHomeDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _homeCubit),
      BlocProvider.value(value: _caruselCubit),
    ],
    child: BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("home.main_title".tr(), style: context.semiboldMd),
          actions: [
            IconButton(
              onPressed: () {
                // StatefulNavigationShell.of(context).goBranch(2);
                // context.showLoading();
                // context.showErrorDialog(title: "Hello World");
                // SbpChequesScreenRoute(extId: "tourist_ap_ext_id_mts_sbpa2d6c553-a14e-4ea4-a952-7948e277d87b").push(context);
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
              MainTotalBalanceWidget(
                balance: state.details?.getBalance() ?? "",
                isLoading: state.homeDetailsStatus == .loading,
              ),
              context.szBoxHeight20,
              Padding(
                padding: context.k16horizontalPadding,
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      BlocListener<CaruselCubit, CaruselState>(
                        listener: _caruselListener,
                        child: _buildBox(
                          Assets.iconsRightTrailing,
                          "main.top_up".tr(),
                          () {
                            HapticFeedback.mediumImpact();
                            _caruselCubit.getTransferServices();
                          },
                        ),
                      ),
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
              ),
              context.szBoxHeight20,
              MainLastTrWidget(
                history: state.details?.history ?? [],
                isLoading: state.homeDetailsStatus == .loading,
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

  void _caruselListener(BuildContext context, CaruselState state) {
    if (state.transferServiceStatus == .loading) {
      context.showLoading();
    } else if (state.transferServiceStatus == .error) {
      context.showErrorDialog(title: state.transferServiceError);
    } else if (state.transferServiceStatus == .success) {
      HapticFeedback.mediumImpact();
      context.showTopUpSheet(
        services: state.transferServiceResult?.services,
        onSelected: (service) {
          try {
            AmountScreenRoute().push(context);
          // ignore: unused_catch_clause
          } on Exception catch (e) {
            // print("Hello");
          }
        },
      );
    }
  }
}
