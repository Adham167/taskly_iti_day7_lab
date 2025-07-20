import 'package:flutter/material.dart';
import 'package:multi_creen_flutter_app/services/shared_preferences_service.dart';
import 'package:multi_creen_flutter_app/views/splash_view.dart';
import 'package:multi_creen_flutter_app/widgets/home_tap.dart';
import 'package:multi_creen_flutter_app/widgets/profile_tap.dart';
import 'package:multi_creen_flutter_app/widgets/task_tap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String userFirstName = "Adham";
  String userlastName = "Abdelsalam";
  String userJopTitle = "Flutter Developer";
  int _selectedIndex = 0;
  final List<Widget> _screens = [HomeTap(), TasksTap(), ProfileTap()];

  void _ontapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _loadUserName();
    super.initState();
  }

  Future<void> _loadUserName() async {
    final pref = await SharedPreferences.getInstance();
    final firstname = pref.getString("firstName") ?? "";
    final lastname = pref.getString("lastName") ?? "";
    final joptitle = pref.getString("jobTitle") ?? "";
    setState(() {
      userFirstName = firstname;
      userlastName = lastname;
      userJopTitle = joptitle;
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, '/splash');
  }

  void _navigateToDrawerPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context);
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Home';
      case 1:
        return 'Tasks';
      case 2:
        return 'Profile';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(), style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueGrey[900],
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey[500]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$userFirstName $userlastName",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(userJopTitle, style: TextStyle(fontSize: 24)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.task),
              title: Text("Tasks"),
              onTap: () => _navigateToDrawerPage(1),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),
              onTap: () => _navigateToDrawerPage(2),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () async {
                await SharedPreferencesService.clearUserData(); 
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SplashView()),
                );
              },
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _ontapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: "Task"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

class TaskTap {}
