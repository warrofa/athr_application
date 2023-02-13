import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simpleui/community%20system/modules/screens/splash_screen/splash_screen.dart';
import 'package:simpleui/community%20system/modules/screens/sign_screens/cubit/signCubit.dart';
import 'package:simpleui/community%20system/shared/constants.dart';
import 'package:simpleui/community%20system/shared/local_network.dart';
import 'package:simpleui/community%20system/shared/style/colors.dart';
import 'certificate/Services/FactoryContract.dart';
import 'certificate/services/provider/home_provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'community system/layout/cubit/bloc_observer.dart';
import 'community system/layout/cubit/layout_cubit.dart';


var prKey;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prKey = prefs.getString("privateKey");
  Bloc.observer = MyBlocObserver();
  await CacheHelper.cacheInit();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  userID = CacheHelper.getCacheData(key: 'uid') ?? "";
  debugPrint("User ID is $userID");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context , child) {
          return MultiBlocProvider(
            providers:
            [
              BlocProvider(create: (context) => SignCubit()),
              BlocProvider(create: (context) => LayoutCubit()..getMyData()..getMyAllCommunitiesData()),
            ],
            
            child: MultiBlocProvider(
              providers: [
                ChangeNotifierProvider(create: (_) => HomeProvider()),
                ChangeNotifierProvider(create: (_) => FactoryContract())
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  appBarTheme: const AppBarTheme(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      foregroundColor: mainColor,
                      iconTheme: IconThemeData(color: Colors.black)
                  ),
                  // Todo: add u font here fontFamily: "Cairo",
                  textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp,bodyColor: Colors.black,displayColor: Colors.black),
                ),
                home: child,
                routes: appRoutes
              ),
            ),
          );
        },
        child: const SplashScreen()
    );
  }
}
