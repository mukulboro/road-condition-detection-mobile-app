import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:road_condition_mapping/screens/MapScreen.dart';
import 'package:road_condition_mapping/screens/CameraScreen.dart';
import 'package:road_condition_mapping/screens/RegisterScreen.dart';
import 'package:road_condition_mapping/screens/UserScreen.dart';
import 'package:road_condition_mapping/screens/SettingsScreen.dart';
import 'package:road_condition_mapping/screens/LoginScreen.dart';
import 'package:road_condition_mapping/screens/WelcomeScreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Road Condition Mapping',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        themeMode: ThemeMode.dark,
        initialRoute: "/welcome",
        routes: {
          "/welcome": (context) => const WelcomeScreen(),
          "/login": (context) => const LoginScreen(),
          "/register": (context) => const RegisterScreen(),
          "/home": (context) => const HomePage()
        });
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const MapScreen(),
      const CameraScreen(),
      const UserScreen(),
      const SettingsScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.map),
        title: ("Map"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black45,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.camera_alt),
        title: ("Camera"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black45,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("User"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black45,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black45,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.deepPurple,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.deepPurple,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style9,
    );
  }
}
