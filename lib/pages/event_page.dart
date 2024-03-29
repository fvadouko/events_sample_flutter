import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  

  @override
  Widget build(BuildContext context) {
    return Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Events').orderBy('date', descending: true).snapshots(), 
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if(!snapshot.hasData) {
                  return const Text('Aucune conférence');
                }
                List<dynamic> events = [];
                snapshot.data!.docs.forEach((event) {
                  events.add(event.data());
                });
                return ListView.builder(
                        itemCount: events.length,
                        itemBuilder: (context, index) {
                          final event = events[index];
                          final avatar = event['avatar'].toString().toLowerCase();
                          final Timestamp timestamp = event['date'] as Timestamp;
                          final String date = DateFormat.yMd().add_jm().format(timestamp.toDate());
                          final speaker = event['speaker'];
                          final subject = event['subject']!;

                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/${event['avatar']}.jpg'),
                              ),
                              title: Text("$speaker ($date)"),
                              subtitle: Text("$subject"),
                              trailing: const Icon(Icons.info),
                            ),
                          );
                        },
                      );
              }
            )
        );
  }
}
