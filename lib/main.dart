import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/add_event_page.dart';
import 'package:flutter_application_1/pages/event_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _currentIndex = 0;

  setCurrentIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: [
              const Text('Accueil'),
              const Text('Evènements'),
              const Text("Ajout d'un évènement")
            ][_currentIndex],
          ),
          body: [
            const HomePage(),
            const EventPage(),
            const AddEventPage()
          ][_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (value) => setCurrentIndex(value),
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            elevation: 10,
            iconSize: 32,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Accueil',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event),
                label: 'Evènements',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: 'Ajout',
              )
            ]
          ),
        )
      ); 
  }
}



