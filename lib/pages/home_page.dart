import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/event_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/images/logo.svg', color: Colors.blue),
        const Text(
          'Conférence Flutter',
          style: TextStyle(
            fontSize: 42,
            fontFamily: 'Poppins',
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          'Salon virtuel',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsets>(
                const EdgeInsets.all(16),
              )),
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EventPage()),
            )
          },
          label: const Text('Voir les evenements'),
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    ));
  }
}
