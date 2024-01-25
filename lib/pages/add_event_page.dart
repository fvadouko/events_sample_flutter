import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  const AddEventPage({super.key});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {

  final _formKey = GlobalKey<FormState>();

  final confNameController = TextEditingController();
  final speakerNameController = TextEditingController();
  final dateController = TextEditingController();
  final subjectController = TextEditingController();
  String selectedConfType = 'talk';
  DateTime selectedConfDate = DateTime.now();

  @override
  void dispose() {
    super.dispose();

    confNameController.dispose();
    speakerNameController.dispose();
    dateController.dispose();
    subjectController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom:10.0),
              child:
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nom conférence',
                    hintText: 'Entrer le nom de la conférence',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom de la conférence';
                    }
                    return null;
                  },
                  controller: confNameController,
                ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom:10.0),
              child:
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nom du speaker',
                    hintText: 'Entrer le nom complet du speaker',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer le nom de la conférence';
                    }
                    return null;
                  },
                   controller: speakerNameController,
                ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom:10.0),
              child: DropdownButtonFormField(
                            items: const [
                              DropdownMenuItem(
                                value: 'talk',
                                child: Text('Talk show'),
                              ),
                              DropdownMenuItem(
                                value: 'demo',
                                child: Text('Demo Code'),
                              ),
                              DropdownMenuItem(
                                value: 'partner',
                                child: Text('Partner'),
                              )
                            ], 
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedConfType = value.toString();
                              });
                            },
                            value: selectedConfType,
                          )
            ),
            Container(
              margin: const EdgeInsets.only(bottom:10.0),
              child:DateTimeField(
                    decoration: 
                      const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.redAccent),
                        labelText: 'Choisissez la date de la conférence',
                        suffixIcon: Icon(Icons.event_note),
                        border: OutlineInputBorder(),
                      ),
                    
                    selectedDate: selectedConfDate,
                    mode: DateTimeFieldPickerMode.dateAndTime,
                    onDateSelected: (DateTime? value) {
                      setState(() {
                        selectedConfDate = value ?? DateTime.now();
                      });
                    },
        ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final confName = confNameController.text;
                    final speakerName = speakerNameController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ajout de la conférence'))
                    );

                    print("Conférence : $confName | Speaker : $speakerName");
                    print("Type : $selectedConfType");
                    print("Date : ${selectedConfDate.toIso8601String()}");

                    //add in a collection
                    CollectionReference eventsRef = FirebaseFirestore.instance.collection('Events');
                    eventsRef.add({
                      'speaker': speakerName,
                      'date': selectedConfDate,
                      'subject': confName,
                      'type': selectedConfType,
                      'avatar': 'lior',
                    });
                  }
                },
                child: const Text('Ajouter'),
              )
            )
          ]
        ),
      )
    );
  }
}