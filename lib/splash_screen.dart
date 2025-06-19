import 'dart:io';

import 'package:mk_academy/core/shared/cubits/app_version/app_version_cubit.dart';
import 'package:mk_academy/core/shared/cubits/app_version/app_version_state.dart';
import 'package:mk_academy/core/shared/repos/app_version/pay_repo.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
// import 'package:zein_store/Future/Home/Widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/auth/data/repos/token_repo/token_repo.dart';
import 'package:mk_academy/features/auth/presentation/view-model/token_cubit/token_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> _scaleAnimation;
  bool _hasShownDialog = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  void _navigateBasedOnTokenState(TokenState state) {
    // log(state.toString());
    if (state is IsVaildToken || state is IsFirstUseTrue) {
      if (state is IsFirstUseTrue) isGuest = true;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const CustomBottomNavBar()),
      );
    } else {
      if (state is! TokenLoadingState && state is! TokenInitial) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppVersionCubit(getit.get<AppVersionRepo>())
            ..checkAppVersion(context),
        ),
        BlocProvider(create: (context) => TokenCubit(getit.get<TokenRepo>()))
      ],
      child: BlocListener<AppVersionCubit, AppVersionState>(
        listener: (context, state) {
          if (state is AppVersionInRange) {
            context.read<TokenCubit>().cheackToken();
          }
        },
        child: BlocBuilder<AppVersionCubit, AppVersionState>(
          builder: (context, appVersionState) {
            if (appVersionState is AppVersionOutdated) {
              if (!_hasShownDialog) {
                _hasShownDialog = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showCustomDialog(
                      oneButton: true,
                      icon: Icons.security_update,
                      title: "version".tr(context),
                      description: "outdated_description".tr(context),
                      context: context,
                      primaryButtonText: "",
                      secondaryButtonText: 'update'.tr(context),
                      onSecondaryAction: () => _launchUpdateUrl(
                          context,
                          Platform.isAndroid
                              ? appVersionState.version.android ?? ""
                              : appVersionState.version.ios ?? ""),
                      onPrimaryAction: () {});
                });
              }
            } else if (appVersionState is AppVersionError) {
              if (!_hasShownDialog) {
                _hasShownDialog = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showCustomDialog(
                      oneButton: true,
                      icon: Icons.nearby_error,
                      title: "error_title".tr(context),
                      description: appVersionState.message.isNotEmpty
                          ? appVersionState.message
                          : "error_description_fallback".tr(context),
                      context: context,
                      secondaryButtonText: 'try_again'.tr(context),
                      onSecondaryAction: () {
                        Navigator.pop(context);
                        if (mounted) {
                          setState(() {
                            _hasShownDialog = false;
                          });
                        }
                        context
                            .read<AppVersionCubit>()
                            .checkAppVersion(context);
                      },
                      primaryButtonText: '',
                      onPrimaryAction: () {});
                });
              }
            } else if (appVersionState is AppVersionInRange ||
                appVersionState is AppVersionUnsupported) {
              if (appVersionState is AppVersionUnsupported &&
                  !_hasShownDialog) {
                _hasShownDialog = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  showCustomDialog(
                      icon: Icons.security_update_warning,
                      title: "version".tr(context),
                      description: "unsupported_description".tr(context),
                      context: context,
                      primaryButtonText: 'update'.tr(context),
                      onPrimaryAction: () => _launchUpdateUrl(
                          context,
                          Platform.isAndroid
                              ? appVersionState.version.android ?? ""
                              : appVersionState.version.ios ?? ""),
                      secondaryButtonText: "later".tr(context),
                      onSecondaryAction: () {
                        Navigator.pop(context);
                        context.read<TokenCubit>().cheackToken();
                      });
                });
              }
              return BlocBuilder<TokenCubit, TokenState>(
                builder: (context, tokenState) {
                  Future.delayed(const Duration(milliseconds: 800), () {
                    _navigateBasedOnTokenState(tokenState);
                  });
                  return _buildSplashContent();
                },
              );
            }
            return _buildSplashContent();
          },
        ),
      ),
    );
  }

  Widget _buildSplashContent() {
    return Scaffold(
      backgroundColor: AppColors.textColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),
          ScaleTransition(
            scale: _scaleAnimation,
            child: Padding(
              padding: const EdgeInsets.all(60.0),
              child: Image.asset(
                width: MediaQuery.sizeOf(context).width * 0.4,
                height: MediaQuery.sizeOf(context).height * 0.3,
                AssetsData.logoNoBg,
              ),
            ),
          ),
          const Spacer(flex: 1),
          Center(
              child: CustomCircualProgressIndicator(
            color: AppColors.backgroundColor,
          )),
          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Future<void> _launchUpdateUrl(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      messages(context, 'error_open_update_url'.tr(context), Colors.red);
    }
  }
}
          // state is IsFirstUseTrue
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           ElevatedButton(
          //               onPressed: () {
          //                 context.read<LocaleCubit>().changeLanguage("en");
          //                 Navigator.pushReplacement(context,
          //                     MaterialPageRoute(builder: (builder) {
          //                   return ConditionsScreen(
          //                     home: false,
          //                   );
          //                 }));
          //               },
          //               child: Text(
          //                 "English",
          //                 style: TextStyle(fontWeight: FontWeight.bold),
          //               )),
          //           ElevatedButton(
          //               onPressed: () {
          //                 context.read<LocaleCubit>().changeLanguage("ar");
          //                 Navigator.pushReplacement(context,
          //                     MaterialPageRoute(builder: (builder) {
          //                   return ConditionsScreen(
          //                     home: false,
          //                   );
          //                 }));
          //               },
          //               child: Text(
          //                 "العربية",
          //                 style: TextStyle(fontWeight: FontWeight.bold),
          //               ))
          //         ],
          //       )
          //     : const Center(child: CustomCircularProgressIndicator()),