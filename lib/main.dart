import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:mk_academy/core/notification_services/notification.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/locale/locale_cubit.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/routs.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/core/widgets/custom_bottom_nav_bar.dart';
import 'package:mk_academy/features/auth/data/repos/login_repo/login_repo.dart';
import 'package:mk_academy/features/auth/data/repos/register_repo/register_repo.dart';
import 'package:mk_academy/features/auth/presentation/view-model/login_cubit/login_cubit.dart';
import 'package:mk_academy/features/auth/presentation/view-model/register_cubit/register_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  setupLocatorServices();
  // await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..getSaveLanguage()),
        BlocProvider(create: (context) => LoginCubit(getit.get<LoginRepo>())),
        BlocProvider(
            create: (context) => RegisterCubit(getit.get<RegisterRepo>())),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            // locale: state.locale,
            locale: Locale("ar"),
            supportedLocales: const [
              Locale("en"),
              Locale("ar"),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (deviceLocal, supportedLocales) {
              for (var locale in supportedLocales) {
                if (deviceLocal != null &&
                    deviceLocal.languageCode == locale.languageCode) {
                  return deviceLocal;
                }
              }
              return supportedLocales.first;
            },
            title: 'MK Academy',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              appBarTheme: AppBarTheme(
                  backgroundColor: AppColors.backgroundColor,
                  scrolledUnderElevation: 0,
                  centerTitle: true,
                  elevation: 0,
                  titleTextStyle: Styles.textStyle18
                      .copyWith(color: AppColors.backgroundColor)),
              fontFamily: "cocon-next-arabic",
              scaffoldBackgroundColor: AppColors.backgroundColor,
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryColors),
              useMaterial3: true,
            ),
            initialRoute: CustomBottomNavBar.routeName,
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}
