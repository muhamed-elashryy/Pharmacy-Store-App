import 'package:amazon_app/constants/global_variables.dart';
import 'package:amazon_app/features/auth/screens/auth_screen.dart';
import 'package:amazon_app/features/auth/services/auth_services.dart';
import 'package:amazon_app/features/home/screens/home_screen.dart';
import 'package:amazon_app/providers/user_provider.dart';
import 'package:amazon_app/router.dart';
import 'package:amazon_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'common/widgets/bottom_bar.dart';
import 'common/widgets/new_bottom_bar.dart';
import 'features/admin/screens/admin_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'صيدلية بدون خجل',
      theme: ThemeData(
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          )),
      onGenerateRoute: (settings) => generateRoute(settings),
    //  initialRoute: AuthScreen.routeName,
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
          ? const HomeScreen()
          : const AdminScreen()
          : const AuthScreen(),
     // getPages: AppRoutes.routes,
    );
  }
}
