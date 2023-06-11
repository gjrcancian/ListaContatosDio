
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import 'package:list_contacts_dio/main.dart';
import 'package:list_contacts_dio/widgets/salvar_foto.dart';
import 'package:list_contacts_dio/model/contact.dart';

import '../home/home.dart';

class SaveContacts extends StatefulWidget {
  const SaveContacts({Key? key}) : super(key: key);

  @override
  State<SaveContacts> createState() => _SaveContactsState();
}

class _SaveContactsState extends State<SaveContacts> {
  String nome_contato = "";
  String fone_contato = "";
  String path_foto = "";
  int existe_foto = 0;
  Contact contact = Contact();

  Future<Directory?>? _tempDirectory;
  Future<Directory?>? _appSupportDirectory;
  Future<Directory?>? _appLibraryDirectory;
  Future<Directory?>? _appDocumentsDirectory;
  Future<Directory?>? _externalDocumentsDirectory;
  Future<List<Directory>?>? _externalStorageDirectories;
  Future<List<Directory>?>? _externalCacheDirectories;
  Future<Directory?>? _downloadsDirectory;
  get formatter => null;


  get path_provider => null;

  @override




  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('Salvar um novo contato')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "ADCIONANDO UM NOVO CONTATO",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 80, // largura do botão em pixels
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue, // cor de fundo do botão
                borderRadius:
                    BorderRadius.circular(50), // borda arredondada do botão
                border: Border.all(
                  color: Colors.blue, // cor da borda do botão
                  width: 2, // espessura da borda do botão
                ),
              ),
              child: SalvarFoto(
            onPhotoSelected: (value) {
      setState(() {
      path_foto = value;
      existe_foto =1;
      });
      },
      ),


            ),
            Text(
              "Inclua uma foto",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.all(32),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                  hintText: "Digite o seu nome",
                  prefixIcon: Icon(Icons.person),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    nome_contato = value;
                  });
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(32),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Telefone',
                  hintText: "(DDD + Telefone)",
                  prefixIcon: Icon(Icons.person),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter(),
                ],
                onChanged: (value) {
                  setState(() {
                    fone_contato = value.replaceAll(RegExp(r'[^0-9]'), '');
                  });
                },
              ),
            ),

            Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8, // 80% da largura do dispositivo
                  child: ElevatedButton(
                    onPressed: () async{
                     if(nome_contato != "" && fone_contato != ""){

                     String value= await contact.saveContact(nome_contato, fone_contato, path_foto);
                     nome_contato ="";
                     fone_contato ="";
                     Navigator.pop(context);
                     Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => HomePage()),
                     );
                     }else{
                       AlertDialog(
                           title: Text('Sucesso'),
                           content: Text('Contato salvo com sucesso.'),
                           actions: [
                           TextButton(
                           onPressed: () {
                         Navigator.of(context).pop();
                       },
                      child: Text('OK'),
                      ),
                      ]
                      );

                     }



                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // Cor de fundo azul
                    ),
                    child: Text('Adcionar Contato'),
                  ),
                ),

              ],
            )


          ],
        ),
      ),
    );
  }
}
