import 'package:mk_academy/core/utils/assets_data.dart';
import 'package:mk_academy/core/utils/constats.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';
import 'package:mk_academy/core/widgets/custom_circual_progress_indicator.dart';
// import 'package:zein_store/Future/Home/Widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mk_academy/features/auth/presentation/view-model/token_cubit/token_cubit.dart';
import 'package:mk_academy/features/auth/presentation/views/login/login_page.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/splash";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late final Animation<double> _scaleAnimation =
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn);

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TokenCubit, TokenState>(
      listener: (context, state) async {
        await Future.delayed(const Duration(seconds: 1), () {
          if (state is IsVaildToken) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) {
              return const CustomBottomNavBar();
            }));
          } else if (state is IsFirstUseTrue) {
            isGuest = true;
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) {
              return const CustomBottomNavBar();
            }));
          } else if (state is IsNotVaildToken) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) {
              return LoginPage();
            }));
          } else if (state is TokenErrorState) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) {
              return LoginPage();
            }));
          }
        });
      },
      builder: (context, state) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              ScaleTransition(
                scale: _scaleAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Image.asset(
                    AssetsData.logoNoBg,
                    color: Colors.white,
                    // fit: BoxFit.cover,
                  ),
                ),
              ),
              const Spacer(flex: 1),
              const Center(child: CustomCircualProgressIndicator()),
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
              const Spacer(flex: 2),
            ],
          ),
        );
      },
    );
  }
}
