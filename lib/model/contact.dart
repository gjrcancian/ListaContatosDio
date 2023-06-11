import 'dart:convert';
import 'package:http/http.dart' as http;

class Contact {
  List<dynamic> list = [];


  final headers = {
    'Content-Type': 'application/json',
    'X-Parse-Application-Id': '7nrcVlVgXcaLbKQfxz1sgpEqeeqGKcnJh22vGSq3',
    'X-Parse-REST-API-Key': 'MhJpnmwzNEpBjJhVf94jJC4t9OdZabAhxExgCXRG',
  };

  fetchContactData() async {


    final response = await http.get(
      Uri.parse('https://parseapi.back4app.com/classes/contacts'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
        return(data);

    } else {
      print('Erro ao buscar os dados do CEP: ${response.statusCode}');
    }
  }

  Future<String> deleteContact(String objectId) async {
    final headers = {
      'Content-Type': 'application/json',
      'X-Parse-Application-Id': '7nrcVlVgXcaLbKQfxz1sgpEqeeqGKcnJh22vGSq3',
      'X-Parse-REST-API-Key': 'MhJpnmwzNEpBjJhVf94jJC4t9OdZabAhxExgCXRG',
    };

    try {
      final response = await http.delete(
        Uri.parse('https://parseapi.back4app.com/classes/contacts/$objectId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
          return("success");
      } else {
        return("error");
      }
    } catch (e) {
      return("error");
    }
  }

  Future<String> saveContact(String name, String contact, String path_photo) async {
    String result ="";
    final saveResponse = await http.post(
  Uri.parse('https://parseapi.back4app.com/classes/contacts'),
  headers: headers,
  body: jsonEncode({
  'name': name,
  'contact': contact,
  'path_photo': path_photo

  }),

  );
print(path_photo);
  if (saveResponse.statusCode == 201) {

 result = 'CEP salvo com sucesso no banco de dados';

  } else {

    result = 'Erro ao salvar CEP no banco de dados';

  }
  return(result);
  }
}
