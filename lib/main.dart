import 'package:clientboard/custom_color.dart';
import 'package:clientboard/feature_auth/presentation/screen_signin.dart';
import 'package:clientboard/feature_auth/presentation/screen_signup.dart';
import 'package:clientboard/feature_auth/state/provider_auth.dart';
import 'package:clientboard/feature_global/helper/helper_sharedpref.dart';
import 'package:clientboard/feature_project/presentation/screen_home.dart';
import 'package:clientboard/feature_project/presentation/screen_chat.dart';
import 'package:clientboard/feature_project/presentation/screen_createproject.dart';
import 'package:clientboard/feature_project/presentation/screen_project_details.dart';
import 'package:clientboard/feature_project/state/provider_newproject.dart';
import 'package:clientboard/feature_project/state/provider_project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'feature_global/state/provider_app.dart';
import 'feature_project/state/provider_chat.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load the .env file
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HelperSharedPref.setInstance();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ProviderAuth()),
      ChangeNotifierProvider(create: (context) => ProviderApp()),
      ChangeNotifierProvider(create: (context) => ProviderProject()),
      ChangeNotifierProvider(create: (context) => ProviderChat()),
      ChangeNotifierProvider(create: (context) => ProviderNewProject())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  late ProviderApp providerApp;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (HelperSharedPref.getEmail() != null) {
      context.read<ProviderApp>().setOnlineStatus(true);
    } else {
      // UseCaseFetchOnline().fetchOnline((isOnline){
      //   providerApp.isOnline = isOnline;
      // });
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (HelperSharedPref.getEmail() != null) {
      if (state == AppLifecycleState.paused) {
        // app is moved to the background
        providerApp.setOnlineStatus(false);
      } else if (state == AppLifecycleState.resumed) {
        // App came back to the foreground
        providerApp.setOnlineStatus(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    providerApp = Provider.of<ProviderApp>(context);

    return SafeArea(
        child: Container(
      color: CustomColors.black,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(useMaterial3: true).copyWith(
            datePickerTheme: const DatePickerThemeData(
              surfaceTintColor: CustomColors.border,
            )),
        themeMode: ThemeMode.dark,
        initialRoute: HelperSharedPref.getEmail() == null
            ? HelperSharedPref.isSignedUp()
                ? "/signin"
                : "/signup"
            : "/home",
        routes: {
          "/signin": (context) => ScreenSignIn(),
          "/home": (context) => const ScreenHome(),
          "/signup": (context) => ScreenSignUp(),
          "/project_details": (context) => const ScreenProjectDetails(),
          "/chat": (context) => const ScreenChat(),
          "/new_project": (context) => const ScreenCreateProject(),
        },
      ),
    ));
  }
}
