import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final events = [
    {
      "speaker": 'Damien',
      'date': '13 à 13h30',
      'subject': 'Le code legacy',
      'avatar': 'damien'
    },
    {
      "speaker": 'Lior Chamla',
      'date': '12 à 14h30',
      'subject': 'git blame --no-offense',
      'avatar': 'lior'
    },
    {
      "speaker": 'Defence Intelligence',
      'date': '18 à 18h30',
      'subject': 'IA générative',
      'avatar': 'defendintelligence'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final speaker = event['speaker']!;

        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  AssetImage('assets/images/${event['avatar']}.jpg'),
            ),
            title: Text(speaker),
            subtitle: Text(event['date']!),
            trailing: const Icon(Icons.info),
          ),
        );
      },
    ));
  }
}
