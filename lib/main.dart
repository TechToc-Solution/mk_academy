import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mk_academy/core/shared/cubits/subjects/subjects_cubit.dart';
// import 'package:mk_academy/core/notification_services/notification.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/locale/locale_cubit.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/routs.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/features/auth/presentation/view-model/reset_password_cubit/reset_password_cubit.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';
import 'package:mk_academy/features/courses/presentation/view_model/courses_cubit.dart';
import 'package:mk_academy/features/home/data/repo/ads.dart';
import 'package:mk_academy/features/home/presentation/views-model/ads/ads_cubit.dart';
import 'package:mk_academy/features/leaderboard/data/repos/leaderboard_repo.dart';
import 'package:mk_academy/features/leaderboard/presentation/views-model/leaderboard_cubit.dart';
import 'package:mk_academy/features/profile/data/repos/profile_repo.dart';
import 'package:mk_academy/features/profile/presentation/views-model/profile_cubit.dart';

import 'core/shared/repos/subjects/subjects_repo.dart';
import 'core/widgets/custom_bottom_nav_bar.dart';
import 'features/auth/data/repos/logout_repo/logout_repo.dart';
import 'features/auth/data/repos/register_repo/register_repo.dart';
import 'features/auth/data/repos/reset_password_repo/reset_password_repo.dart';
import 'features/auth/presentation/view-model/logout_cubit/logout_cubit.dart';
import 'features/auth/presentation/view-model/register_cubit/register_cubit.dart';

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
        BlocProvider(create: (context) => LogoutCubit(getit.get<LogoutRepo>())),
        BlocProvider(
            create: (context) => RegisterCubit(getit.get<RegisterRepo>())),
        BlocProvider(
            create: (context) =>
                ResetPasswordCubit(getit.get<ResetPasswordRepo>())),
        BlocProvider(
            create: (context) =>
                SubjectsCubit(getit.get<SubjectsRepo>())..getSubjects()),
        BlocProvider(
            create: (context) => LeaderboardCubit(getit.get<LeaderboardRepo>())
              ..getLeaderbord()),
        BlocProvider(create: (context) => AdsCubit(getit.get<AdsRepo>())),
        BlocProvider(
            create: (context) => CoursesCubit(getit.get<CoursesRepo>())),
        BlocProvider(
            create: (context) =>
                ProfileCubit(getit.get<ProfileRepo>())..getProfile()),
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
            initialRoute: CustomBottomNavBar.routeName, //LoginPage.routeName,
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}
