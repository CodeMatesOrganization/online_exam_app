import 'package:flutter/material.dart';
import 'package:online_exam/Features/Profile/ui/ProfilePage/ProfileScreen.dart';
import 'package:online_exam/Features/Subject/ui/Subjects/SubjectScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = "/home";


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _pages = [];

  @override
  Widget build(BuildContext context) {
    _pages.clear();
    _pages.addAll([
      SubjectScreen(),
      Center(child: Text("Result Page", style: Theme.of(context).textTheme.headlineMedium)),
      ProfileScreen()
    ]);

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), label: "Result"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }

}
