import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/favorite_page.dart';
import 'pages/cart_page.dart';

import 'pages/register_page.dart';
import 'pages/login_page.dart';
import 'show_user.dart';
import 'pages/account_page.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      // home: LoginPage(),
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

  final List<Widget> pages = [
    HomePage(),
    FavoritePage(),
    //HomeScreen(),
    CartPage(),
    AccountPage(),
    // RegisterPage(),
    // LoginPage(),

  ];
  // void _onTabTapped (int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }

  //
  void _onTabTapped(int index) {
    setState(() {
      if (index == 3) {
        // Nếu người dùng chọn tab "Tài khoản"
        if (isLoggedIn) {
          // Nếu đã đăng nhập, thay đổi currentIndex và không cần hiển thị dialog
          currentIndex = index;
        } else {
          // Nếu chưa đăng nhập, hiển thị AlertDialog
          _showLoginAlertDialog();
        }
      } else {
        // Nếu người dùng chọn các tab khác
        currentIndex = index;
      }
    });
  }
  //
  void _showLoginAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Thông báo'),
          content: Text('Bạn cần đăng nhập để truy cập vào tài khoản.'),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
              },
            ),
            TextButton(
              child: Text('Đến trang đăng nhập'),
              onPressed: () {
                Navigator.pop(context); // Đóng AlertDialog
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage())); // Điều hướng đến trang đăng nhập
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label:'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label:'Yêu thích',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label:'Giỏ hàng',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label:'Tài khoản',
          ),
        ],
      ),
    );
  }
}

