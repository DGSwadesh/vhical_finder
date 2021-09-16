import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil_init.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'Controller/application_starter_controller.dart';
import 'View/DashBoard/Dashboard.dart';
import 'View/SigninSignUp/SplashScreen.dart';
import 'View/SigninSignUp/login.dart';
import 'util/sharePreference_instance.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // DashboardBinding().dependencies();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) async {
    sharePrefereceInstance.init();
    runApp(
      StartApp(),
    );
  });
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(accentColor: Colors.black),
      debugShowCheckedModeBanner: false,
      // initialBinding: DashboardBinding(),
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // var returnWidget1 = WelcomeScreen();

  var scafoldKey = GlobalKey<FormState>();
  var InternetStatus = "Unknown";
  var contentmessage = "Unknown";
  final applicationStarterController = Get.put(ApplicationStarterController());
  @override
  void initState() {
    // checkConnection(context);
    super.initState();
  }

  @override
  void dispose() {
    // listener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ScreenUtilInit(
      designSize: Size(width, height),
      allowFontScaling: false,
      builder: () => Obx(() {
        print('main.dart');
        var applicationState = applicationStarterController.state.value;
        // return Container();
        if (applicationState == ApplicationState.LoggedIn) {
          return LoginScreen();
        } else if (applicationState == ApplicationState.LoggedOut) {
          return LoginScreen();
        } else {
          return LoginScreen();
        }
      }),
    );
  }

//   checkConnection(BuildContext context) async {
//     listener = DataConnectionChecker().onStatusChange.listen((status) {
//       switch (status) {
//        case DataConnectionStatus.connected:
//          InternetStatus = "Connected to the Internet";
//          contentmessage = "Connected to the Internet";
//          _showDialog(InternetStatus, contentmessage, context);
//          showToast(InternetStatus, red);
//          break;
//         case DataConnectionStatus.disconnected:
//           InternetStatus = "You are disconnected to the Internet. ";
//            contentmessage = "Please check your internet connection";
//            _showDialog(InternetStatus, contentmessage, context);

//            showToast(InternetStatus, red);
//           break;
//       }
//     });
//     return await DataConnectionChecker().connectionStatus;
//   }
}
