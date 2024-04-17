import 'package:chahel_web_1/app.dart';
import 'package:chahel_web_1/src/features/add_banner/controller/banner_controller.dart';
import 'package:chahel_web_1/src/features/authentication/provider/auth_provider.dart';
import 'package:chahel_web_1/src/features/notification/controller/notification_controller.dart';
import 'package:chahel_web_1/src/features/payment_gateway/controller/payment_controller.dart';
import 'package:chahel_web_1/src/features/plans/controller/plan_controller.dart';
import 'package:chahel_web_1/src/features/sidebar/controller/nav_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/syllabus_controller.dart';
import 'package:chahel_web_1/src/features/syllabus/controller/zoom_live_controller.dart';
import 'package:chahel_web_1/src/features/users/controller/user_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDRR928prsWJlJKMdI4NcjIsWsOb_0C_Yo",
      authDomain: "chahele-learning-app.firebaseapp.com",
      projectId: "chahele-learning-app",
      storageBucket: "chahele-learning-app.appspot.com",
      messagingSenderId: "1010786257076",
      appId: "1:1010786257076:web:dfeb33260fd6ffd2426fe1",
      measurementId: "G-23GPKZ7RTZ",
    ),
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => NavigationController()),
    ChangeNotifierProvider(create: (context) => PaymentController()),
    ChangeNotifierProvider(create: (context) => BannerController()),
    ChangeNotifierProvider(create: (context) => PlanController()),
    ChangeNotifierProvider(create: (context) => SyllabusController()),
    ChangeNotifierProvider(create: (context) => NotificationController()),
    ChangeNotifierProvider(create: (context) => UserController()),
    ChangeNotifierProvider(create: (context) => ZoomLiveController()),
    ChangeNotifierProvider(create: (context) => AuthProvider()),
  ], child: const MyApp()));
}
