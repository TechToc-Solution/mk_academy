import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mk_academy/core/shared/cubits/download_handler/download_handler_cubit.dart';
import 'package:mk_academy/core/shared/cubits/solve_quizzes/solve_quizzes_cubit.dart';
import 'package:mk_academy/core/shared/repos/solve_quizzes/solve_quizzes_repo.dart';
// import 'package:mk_academy/core/notification_services/notification.dart';
import 'package:mk_academy/core/utils/app_localizations.dart';
import 'package:mk_academy/core/locale/locale_cubit.dart';
import 'package:mk_academy/core/utils/cache_helper.dart';
import 'package:mk_academy/core/utils/colors.dart';
import 'package:mk_academy/core/utils/functions.dart';
import 'package:mk_academy/core/utils/routs.dart';
import 'package:mk_academy/core/utils/secure_storage.dart';
import 'package:mk_academy/core/utils/services_locater.dart';
import 'package:mk_academy/core/utils/styles.dart';
import 'package:mk_academy/features/auth/data/repos/delete_account_repo.dart/delete_account_repo.dart';
import 'package:mk_academy/features/auth/presentation/view-model/delete_account/delete_account_cubit.dart';
import 'package:mk_academy/features/auth/presentation/view-model/reset_password_cubit/reset_password_cubit.dart';
import 'package:mk_academy/features/courses/data/repo/courses_repo.dart';
import 'package:mk_academy/features/courses/presentation/view_model/courses%20cubit/courses_cubit.dart';
import 'package:mk_academy/features/courses/presentation/view_model/videos_cubit/videos_cubit.dart';
import 'package:mk_academy/features/show_video/presentation/views-model/cubit/manager/download_manager_cubit.dart';
import 'package:mk_academy/firebase_options.dart';
import 'package:mk_academy/splash_screen.dart';
import 'core/shared/cubits/subjects/subjects_cubit.dart';
import 'core/shared/repos/download_handler/download_handler_repo.dart';
import 'core/shared/repos/subjects/subjects_repo.dart';
import 'core/utils/constats.dart';
import 'features/auth/data/repos/logout_repo/logout_repo.dart';
import 'features/auth/data/repos/register_repo/register_repo.dart';
import 'features/auth/data/repos/reset_password_repo/reset_password_repo.dart';
import 'features/auth/presentation/view-model/logout_cubit/logout_cubit.dart';
import 'features/auth/presentation/view-model/register_cubit/register_cubit.dart';
import 'features/home/data/repo/ads/ads.dart';
import 'features/home/presentation/views-model/ads/ads_cubit.dart';
import 'features/leaderboard/data/repos/leaderboard_repo.dart';
import 'features/leaderboard/presentation/views-model/leaderboard_cubit.dart';
import 'features/profile/data/repos/profile_repo.dart';
import 'features/profile/presentation/views-model/profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await blockIfDebugOrEmulator();
  await CacheHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await generateAndStoreKey();
  setupLocatorServices();
  enableScreenshot();
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
            create: (context) => VideosCubit(getit.get<CoursesRepo>())),
        BlocProvider(
            create: (context) => RegisterCubit(getit.get<RegisterRepo>())),
        BlocProvider(
            create: (context) =>
                ResetPasswordCubit(getit.get<ResetPasswordRepo>())),
        BlocProvider(
            create: (context) =>
                DeleteAccountCubit(getit.get<DeleteAccountRepo>())),
        BlocProvider(
            create: (context) => CoursesCubit(getit.get<CoursesRepo>())),
        BlocProvider(
            create: (context) => LeaderboardCubit(getit.get<LeaderboardRepo>())
              ..getLeaderboard()),
        BlocProvider(
            create: (context) =>
                SubjectsCubit(getit.get<SubjectsRepo>())..getSubjects()),
        BlocProvider(
            create: (context) => AdsCubit(getit.get<AdsRepo>())..getAllAds()),
        BlocProvider(
            create: (context) =>
                ProfileCubit(getit.get<ProfileRepo>())..getProfile()),
        BlocProvider(
            create: (context) =>
                SolveQuizzesCubit(getit.get<SolveQuizzesRepo>())),
        BlocProvider(
            create: (context) =>
                DownloadCubit(repo: getit.get<DownloadHandlerRepo>())),
        BlocProvider<DownloadManagerCubit>(
          create: (_) => DownloadManagerCubit()..scanExistingDownloads(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, ChangeLocaleState>(
        builder: (context, state) {
          return MaterialApp(
            navigatorKey: navigatorKey,
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
            initialRoute: SplashScreen.routeName,
            routes: Routes.routes,
          );
        },
      ),
    );
  }
}
