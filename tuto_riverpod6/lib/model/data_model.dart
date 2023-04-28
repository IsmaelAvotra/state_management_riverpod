import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;
  Person({required this.name, required this.age, String? uuid})
      : uuid = uuid ?? const Uuid().v4();

  Person updated([String? name, int? age]) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      uuid: uuid,
    );
  }

  String get displayName => '$name ($age years old)';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;
}

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];

  int get peopleCount => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void add(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void remove(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void update(Person updatedPerson, [String? name, int? age]) {
    final index = _people.indexOf(updatedPerson);
    final oldPerson = _people[index];
    if (oldPerson.name != updatedPerson.name ||
        oldPerson.age != updatedPerson.age) {
      _people[index] = updatedPerson.updated(
        updatedPerson.name,
        updatedPerson.age,
      );
      notifyListeners();
    }
  }
}
