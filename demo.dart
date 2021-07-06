KINDACODE
HOME
FLUTTER
REACT
REACT NATIVE
NODE
PHP
PYTHON
WORDPRESS
CSS
DOCKER
Home » Mobile » Flutter » How to create a Filter/Search ListView in Flutter (2021)
How to create a Filter/Search ListView in Flutter (2021)
Last updated on April 16, 2021
A Goodman
Oop!
4 comments
Flutter

( 256 Articles)


Working with ElevatedButton in Flutter (2021)
March 4, 2021


Flutter fatal error: ‘Flutter/Flutter.h’ file not found
May 21, 2021


Flutter: GridView.builder() Example
March 23, 2021


Flutter + Firebase Storage: Upload, Retrieve, and Delete files
June 24, 2021


Flutter and Firestore Database: CRUD example (null safety)
June 24, 2021


Flutter: Adding a Header to a ListView
January 25, 2021


Flutter: ListTile examples
March 20, 2021


2 Ways to Add Multiple Floating Buttons in Flutter (2021)
April 6, 2021

More


This article is about making a filter/search ListView in Flutter. We will take a quick look at the approach to get the job done then go through a concrete and complete example of applying that approach. No third-party packages are required.

Table of Contents
Overview
Example
Preview
The Code
Conclusion
Overview
We will create a function to filter the results and this function will be called when the text field changes (onChanged). The search algorithm can be different on a case-by-case basis, but the simplest and most popular is to use the following methods:

where(): Returns a new lazy Iterable with all elements that satisfy one or many conditions.
contains(): Used to determine whether a string contains another string (you can try other string methods like startsWith(), endsWith(), etc).
toLowerCase(): This string method will convert all characters in this string to lower case so that it doesn’t matter whether the search keyword is uppercase or lowercase.
These words can be confusing. See the example for more clarity.

Example
Let’s say we have a list of users with some information including id, name, and age. In the beginning, all of these users are shown in a ListView. If you type something into the search field, only users whose names match the keyword will be displayed. If you clear the search field, the full list of users will appear again.

Preview
The Code
The full source code in lib/main.dart with explanations in the comments:

// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Kindacode.com',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This holds a list of fiction users
  // You can use data fetched from a database or cloud as well
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.length > 0
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.amberAccent,
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: Text(
                      _foundUsers[index]["id"].toString(),
                      style: TextStyle(fontSize: 24),
                    ),
                    title: Text(_foundUsers[index]['name']),
                    subtitle: Text(
                        '${_foundUsers[index]["age"].toString()} years old'),
                  ),
                ),
              )
                  : Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}