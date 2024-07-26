import 'package:clothing_store/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dark_mode/theme_notifier.dart';
import 'pages/home_page.dart';
import 'pages/favorite_page.dart';
import 'pages/cart/cart_page.dart';
import 'pages/account_widget/account_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:clothing_store/model/cart/getCart.dart';
import 'dart:convert';
import 'provider/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'model/payment/screenPayment.dart';


int? idNguoiDung;
void main() {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeNotifier()),
          ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ],
      child: const MyApp(),
    )
    // ChangeNotifierProvider(
    //     create: (_) => ThemeNotifier(),
    //     child: const MyApp(),
    //
    // )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: MyHomePage(),
    //   // home: LoginPage(),
    // );
    return Consumer2<ThemeNotifier, LanguageProvider>(
      builder: (context, themeNotifier, languageProvider, child) {
        return MaterialApp(
          theme:  themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          locale: languageProvider.locale,
          supportedLocales: const [
            Locale('en', ''),
            Locale('vi', ''),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: MyHomePage(),

        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  bool isLoggedIn = true;
  @override
  void initState() {
    super.initState();
  }

List<Widget> pages = [
    HomePage(),
    // PaymentMethodsPage(),
    FavoritePage(),
    CartPage(),
    AccountPage(),

  ];

  void _onTabTapped(int index) async {
    if (index == 2) {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      bool? checkk = sharedPreferences.getBool('isLogin') ?? false;
      if (checkk == true) {
        setState(() {
          currentIndex = index;
        });
      }
      else {
        _showLoginAlertDialog();
      }
    } else{
      setState(() {
        currentIndex = index;
      });
    }

  }

  void _showAlertDialog(String ggg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('notification') ?? ''),
          content: Text(ggg),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)?.translate('close') ?? ''),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
              },
            ),
          ],
        );
      },
    );
  }
  void _showLoginAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)?.translate('notification') ?? ''),
          content: Text(AppLocalizations.of(context)?.translate('xxx') ?? ''),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)?.translate('close') ?? ''),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppLocalizations.of(context)?.translate('home') ?? '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: AppLocalizations.of(context)?.translate('favorite') ?? '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: AppLocalizations.of(context)?.translate('cart') ?? '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: AppLocalizations.of(context)?.translate('account') ?? '',
          ),
        ],
      ),
    );
  }
}

