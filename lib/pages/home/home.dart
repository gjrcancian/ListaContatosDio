import 'dart:io';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/contact.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<dynamic> listContacts = [];
  Contact contacts = Contact();
  get cardA => null;
  @override
  void initState() {
    super.initState();

    fetchContactData();
  }

  fetchContactData() async {
    final headers = {
      'Content-Type': 'application/json',
      'X-Parse-Application-Id': '7nrcVlVgXcaLbKQfxz1sgpEqeeqGKcnJh22vGSq3',
      'X-Parse-REST-API-Key': 'MhJpnmwzNEpBjJhVf94jJC4t9OdZabAhxExgCXRG',
    };

    final response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/contacts'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        listContacts = data['results'];
      });
    } else {
      print('Erro ao buscar os dados do CEP: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: ListView.builder(
            itemCount: listContacts.length,
            itemBuilder: (context, index) {
              final contact = listContacts[index];

              final String name = contact['name'];
              String photo = contact['path_photo'];
              final String id = contact['objectId'];
              final String phone = contact['contact'].toString();
              final String firstLetter = name.substring(0, 1).toUpperCase();
              return Center(
                child: ExpansionTileCard(
                    key: cardA,
                    leading: CircleAvatar(
                      child: photo == ''
                          ? Text("$firstLetter")
                          : ClipOval(
                              child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Image.file(
                                    File(photo as String),
                                    fit: BoxFit.cover,
                                  )),
                            ),
                    ),
                    title: Text("$name"),
                    subtitle: Text("$phone"),
                    children: <Widget>[
                      const Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      contacts.deleteContact(id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Contato excluído com sucesso'),
                                        ),
                                      );
                                      setState(() {
                                        listContacts.removeWhere((contact) =>
                                            contact['objectId'] == id);
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors
                                          .red, // Define a cor de fundo do botão para vermelho
                                      onPrimary: Colors.white,
                                    ),
                                    child: Text("Excluir")),
                              ]),
                        ),
                      ),
                    ]),
              );
            }));
  }
}
