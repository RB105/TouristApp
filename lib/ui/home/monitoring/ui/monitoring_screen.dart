/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:touristapp/generated/assets.dart';
import 'package:touristapp/ui/home/monitoring/logic/cubit/monitoring_cubit.dart';
import 'package:touristapp/ui/home/monitoring/ui/widgets/monitoring_empty_skeleton.dart';
import 'package:touristapp/ui/home/monitoring/ui/widgets/monitoring_item.dart'
    show MonitoringItem;
import 'package:touristapp/ui/widgets/animation_list.dart';
import 'package:touristapp/ui/home/monitoring/ui/widgets/monitoring_shimmer_loading.dart'
    show MonitoringShimmerLoading;
import 'package:touristapp/utils/di/di.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/extensions/context_extensions.dart';
import 'package:touristapp/utils/extensions/text_styles_extension.dart'
    show TextStyles;

import '../logic/model/monitoring_result.dart';

class MonitoringScreen extends StatefulWidget {
  const MonitoringScreen({super.key});

  @override
  State<MonitoringScreen> createState() => _MonitoringScreenState();
}

class _MonitoringScreenState extends State<MonitoringScreen> {
  final _monitoringCubit = getIt<MonitoringCubit>();

  @override
  void initState() {
    _monitoringCubit.getMonitoring(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _monitoringCubit,
    child: Scaffold(
      backgroundColor: context.bgMain,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: context.bgMain,
        title: Text("home.monitoring_title".tr(), style: context.semiboldMd),
        actions: [
          Row(
            children: [
              Text("Filter".tr(), style: context.semiboldSm),
              const SizedBox(width: 4),
              SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(Assets.iconsFilter),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: BlocBuilder<MonitoringCubit, MonitoringState>(
        builder: (context, state) {
          if (state.getMonitoringStatus == .loading) {
            return const MonitoringShimmerLoading();
          }
          if (state.getMonitoringStatus == .success) {
            final groups = state.getMonitoringResult?.groupAsNestedList ?? [];
            if (groups.isEmpty) {
              return MonitoringEmptySkeleton();
            }
            return RefreshIndicator.adaptive(
              onRefresh: () => _monitoringCubit.getMonitoring(1),
              child: AnimationList(
                padding: context.k16verticalPadding,
                children: List.generate(groups.length, (index) {
                  final date = groups[index].first.formatCreateDate();
                  return Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: context.bgElevated),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ),
                            child: Row(
                              children: [Text(date, style: context.semiboldMd)],
                            ),
                          ),
                        ),
                      ),
                      _MonitoringGroupBuilder(history: groups[index]),
                    ],
                  );
                }),
              ),
            );
          }
          return SizedBox();
        },
      ),
    ),
  );
}

class _MonitoringGroupBuilder extends StatelessWidget {
  final List<MonitoringHistory> history;

  const _MonitoringGroupBuilder({required this.history});

  @override
  Widget build(BuildContext context) {
    // OpenContainer(
    //   transitionType: ContainerTransitionType.fade,
    //   transitionDuration: Duration(seconds: 1),
    //   closedColor: context.bgDefault,
    //   openBuilder: (context, _) => ChequeScreen(tr: transactions[index]),
    //   closedElevation: 0,
    //   closedShape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(16),
    //   ),
    //   closedBuilder:
    //       (context, _) => Padding(
    //     padding: EdgeInsets.symmetric(vertical: 8.0),
    //     child: MonitoringItem(tr: transactions[index]),
    //   ),
    // )
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: history.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          // ModalSheets.showMonitoringCheck(context, transactions[index]);
        },
        child: MonitoringItem(item: history[index]),
      ),
    );
  }
}
