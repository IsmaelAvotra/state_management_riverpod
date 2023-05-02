import 'package:flutter/material.dart';

import 'data_model.dart';

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createOrUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog<Person?>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(nameController.text.isNotEmpty
            ? 'Update a person'
            : 'Create a Person'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Enter name here ...',
              ),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(
                labelText: 'Enter age here ...',
              ),
              onChanged: (value) => age = int.tryParse(value),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                if (existingPerson != null) {
                  //have a existing person
                  final newPerson = existingPerson.updated(
                    name,
                    age,
                  );
                  Navigator.of(context).pop(newPerson);
                } else {
                  //no existing person, create a new one
                  Navigator.of(context).pop(
                    Person(name: name!, age: age!),
                  );
                }
              } else {
                //no name or age
                Navigator.of(context).pop();
              }
            },
            child: Text(nameController.text.isNotEmpty ? 'Update' : 'Create'),
          ),
        ],
      );
    },
  );
}
