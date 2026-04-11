// ignore_for_file: use_build_context_synchronously

/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:convert' show jsonEncode, jsonDecode;

import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/cupertino.dart' show CupertinoSearchTextField;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:size_config/size_config.dart' show SizeExtention;
import 'package:touristapp/ui/home/main/logic/model/transfer_create_sbp_result.dart';
import 'package:touristapp/utils/extensions/color_extension.dart';
import 'package:touristapp/utils/router/app_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../generated/assets.dart' show Assets;
import '../../../../../../utils/extensions/context_extensions.dart'
    show ContextExtensions;
import '../../../../../../utils/extensions/dialog_ext.dart' show DialogExt;
import '../../../../../../utils/extensions/primary_decoration_ext.dart'
    show PrimaryDecorationExt;
import '../../../../../../utils/extensions/string_ext.dart' show StringExt;
import '../../../../../../utils/extensions/text_styles_extension.dart'
    show TextStyles;
import '../../../../../widgets/asset_svg.dart' show AssetSvg;
import '../../../logic/service/bank_list_service.dart' show BankListService;
import '../../../logic/service/launch_app_service.dart' show LaunchAppInStoreService;

class BankLauncherScreen extends StatefulWidget {
  final TransferCreateSbpResult sbpQrResult;

  const BankLauncherScreen({super.key, required this.sbpQrResult});

  static const String routeName = '/bankLauncher';

  @override
  State<BankLauncherScreen> createState() => _BankLauncherScreenState();
}

class _BankLauncherScreenState extends State<BankLauncherScreen> {
  List<BankInfo> allBanks = [];
  List<BankInfo> sortedBanks = [];
  String? url;
  BankInfo? selectedBank;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    url = widget.sbpQrResult.formUrl?.replaceAll('https', '');

    allBanks = BankListService().sortBanksTop30First(
      widget.sbpQrResult.banks ?? [],
    );
    sortedBanks = allBanks;
    setState(() {});
    super.initState();
  }

  Future<void> openApp(Uri uri, BankInfo bank, BuildContext ctx) async {
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (launched) {
      // App opened successfully
      GetStorage().write('recently_used', jsonEncode(bank.toJson()));
      SbpChequesScreenRoute(extId: widget.sbpQrResult.extId ?? "").go(context);
      return;
    }

    // App not installed → show dialog
    context.showConfirmDialog(
      iconUrl: Assets.imagesAppNotInstalled,
      title: "The selected bank app is not installed.",
      message: "The selected bank app is not installed on your device. To continue, please install it from the official app store.",
      buttonText: "Install app",
      onConfirm: () {
        LaunchAppInStoreService().launchAvailableStore(bank: bank).then((v) {
          // hideLoadingDialog();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    BankInfo? recentlyUsed = "recently_used".read != null
        ? BankInfo.fromJson(jsonDecode("recently_used".read))
        : null;
    if (recentlyUsed != null) {
      allBanks.removeWhere((element) => element.code == recentlyUsed.code);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose a bank app",
          style: context.mediumMd,
        ),
        centerTitle: false,
        titleSpacing: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.szBoxHeight16,
              Padding(
                padding: context.k16horizontalPadding,
                child: CupertinoSearchTextField(
                  controller: controller,
                  onChanged: (v) {
                    setState(() {
                      sortedBanks = controller.text.isEmpty
                          ? allBanks
                          : allBanks.where((element) {
                              final n = BankListService().normalizeText(
                                element.name ?? "",
                              );
                              final q = BankListService().normalizeText(
                                controller.text,
                              );
                              return n.contains(q);
                            }).toList();
                    });
                  },

                  style: context.mediumMd,
                ),
              ),
              if (recentlyUsed != null) context.szBoxHeight20,
              if (recentlyUsed != null)
                Padding(
                  padding: context.k16horizontalPadding,
                  child: Text(
                    "Recently used app",
                    style: context.mediumMd,
                  ),
                ),
              if (recentlyUsed != null) context.szBoxHeight20,
              if (recentlyUsed != null)
                _Item(
                  bank: recentlyUsed,
                  onTap: (v) async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    openApp(
                      Uri.parse("${recentlyUsed.code}$url"),
                      recentlyUsed,
                      context,
                    );
                  },
                ),
              context.szBoxHeight12,
              Padding(
                padding: context.k16horizontalPadding,
                child: Text(
                  "Installed bank apps",
                  style: context.mediumMd,
                ),
              ),
              context.szBoxHeight20,
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: sortedBanks.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return _Item(
                      bank: sortedBanks[index],
                      onTap: (v) async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        openApp(
                          Uri.parse("${sortedBanks[index].code}$url"),
                          sortedBanks[index],
                          context,
                        );
                      },
                    );
                  },
                ),
              ),
              context.szNavbarHeight,
            ],
          ),
        ),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final BankInfo bank;

  final Function(BankInfo bank) onTap;

  const _Item({required this.bank, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap.call(bank),
      child: Container(
        decoration: context.decoration,
        padding: EdgeInsets.all(8.sp),
        margin: EdgeInsets.only(
          bottom: context.v8,
          left: context.h16,
          right: context.h16,
        ),
        child: Row(
          children: [
            context.szBoxWidth4,
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                width: 40.sp,
                height: 40.sp,
                imageUrl: "https://qr.nspk.ru/proxyapp/logo/${bank.code}.png",
                placeholder: (context, url) => SvgPicture.asset(
                  Assets.iconsBankLogo,
                  width: 32.sp,
                  height: 32.sp,
                ),
                errorWidget: (_, _, _) {
                  return SvgPicture.asset(
                    Assets.iconsBankLogo,
                    width: 32.sp,
                    height: 32.sp,
                  );
                },
              ),
            ),
            context.szBoxWidth16,
            Expanded(
              child: Text(
                bank.name ?? "",
                style: context.mediumMd,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            AssetSvg(Assets.iconsLaunch, color: context.textSecondary),
          ],
        ),
      ),
    );
  }
}
