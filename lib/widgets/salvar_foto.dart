import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SalvarFoto extends StatefulWidget {
  final void Function(String path)? onPhotoSelected;

  const SalvarFoto({Key? key, this.onPhotoSelected}) : super(key: key);

  @override
  State<SalvarFoto> createState() => _SalvarFotoState();
}

class _SalvarFotoState extends State<SalvarFoto> {
  String path_foto ="";

  get path_provider => null;

  get path => null;

  int verificador = 0;

  Future<void> _handleImageSelection(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      final String fileName = basename(pickedImage.path);
      final Directory appDir = await getApplicationDocumentsDirectory();
      final String filePath = '${appDir.path}/$fileName';

      await pickedImage.saveTo(filePath);
      await GallerySaver.saveImage(filePath);

      setState(() {
        verificador=1;
        path_foto = filePath;
      });

      if (widget.onPhotoSelected != null) {

        widget.onPhotoSelected!(path_foto!);
      }
    }
  }
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Como você prefere enviar a foto'),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('(X)'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 16.0,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                        _handleImageSelection(ImageSource.camera);

                        Navigator.of(context).pop();

                        },

                                icon: Icon(Icons.camera_alt, color: Colors.grey),
                              ),
                              ElevatedButton(

                                onPressed: () {
                      _handleImageSelection(ImageSource.camera);

                      Navigator.of(context).pop();

                      },
                        style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.green,
                                ),
                                child: Text(
                                  "Câmera",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 16.0,
                          ),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _handleImageSelection(ImageSource.gallery);

                                  Navigator.of(context).pop();

                                },

                                icon: Icon(Icons.photo_album, color: Colors.grey),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _handleImageSelection(ImageSource.gallery);

                                  Navigator.of(context).pop();

                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  onPrimary: Colors.green,
                                ),
                                child: Text(
                                  "Galeria",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    File imageFile = File(path_foto);

    Image image = Image(image: FileImage(imageFile));
    return verificador == 0 ? IconButton(
      onPressed: () => _showModalBottomSheet(context),
      icon: Icon(
        Icons.photo,
        size: 50,
        color: Colors.white,
      ),
    ):GestureDetector(
      onTap: () => _showModalBottomSheet(context),
      child: Container(
        width: 100,
        height: 100,

        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(imageFile),
            fit: BoxFit.cover,

          ),
        ),
      ),
    );

  }
}
