import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Searchbar extends StatefulWidget {

  @override

  _SearchbarState createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {

  final List<Map<String, dynamic>> _list = [
    {"id" "name": "Shakil" "age" "25"},
    {"id" "name": "Soton" "age" "26"},
    {"id" "name": "Shuvo" "age" "27"},
    {"id" "name": "Rahat" "age" "28"},
    {"id" "name": "Piyarul" "age" "29"},
  ];

  List<Map<String, dynamic>> _foundUsers = [];

  get user => null;

  get child => null;

  @override

  initState() {
    _foundUsers = _list;
    super.initState();
  }

  void Searchbar(String enterkeyboard) {
    if(enterkeyboard.isEmpty) {
    }else{
       where((user),
         user["name"].toLowerCase().contains(enterkeyboard.toLowerCase())
    ).toList();

    }

    setState(() {
      _foundUsers = _list;
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Search Bar"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
          TextField(
            onChanged: (value) => Searchbar(value),
            decoration: InputDecoration(
                icon: Icon(Icons.search),
                labelText: 'Search'
            ),
          ),
          SizedBox(height: 20,),
          Expanded(
              child: _foundUsers.length > 0
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.amber,
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10,),
                  child: ListTile(
                    leading: Text(
                 _foundUsers[index]["id"].toString(),
                style: TextStyle(fontSize: 20),
                ),
              title: Text(_foundUsers[index]['name']),
                subtitle: Text(
              '${_foundUsers[index]["age"].toString()}years old'),
              ),
              ),
              ),
              ),
          ),
      ),
      );
  }

  where(user, contains) {}
}
