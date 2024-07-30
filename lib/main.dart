import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(MaterialApp(
    title: 'IO',
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: const Text('Read/write'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(13.4),
        alignment: Alignment.topCenter,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(labelText: 'Write Something'),
            keyboardType: TextInputType.text,
          ),
          subtitle:Expanded(
            child: TextButton(
            
              onPressed: (){
                writeData(_enterDataField.text);
            
              },
              style: TextButton.styleFrom(
               // Text color
                backgroundColor: Colors.red,
                // Button background color
              ),
              child: Column(
            
                children: [
                  const Text('Save Data',),
                  const Padding(padding: EdgeInsets.all(14.5),),
                  FutureBuilder(future: readData(),
                      builder: (BuildContext context, AsyncSnapshot <String> data){
                        return Text(data.data.toString(),
                          style: const TextStyle(color: Colors.white70),
                        );
                      })
            
                ],
              ),
            ),
          )
          )
        ),
      );

  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/data.txt'); // Corrected extension to .txt
  }

  Future<File> writeData(String message) async {
    final file = await _localFile;
    return file.writeAsString('$message'); // Write the counter as string
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;
      String data = await file.readAsString();
      return data;
    } catch (e) {
      return 'Nothing save yet!'; // If encountering an error, return 0
    }
  }
}
