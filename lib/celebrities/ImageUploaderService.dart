import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUploader extends StatefulWidget {
  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String _serverUrl = "https://demo.infoskaters.com/api/upload.php";

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No image selected."),
        ),
      );
      return;
    }

    var request = http.MultipartRequest('POST', Uri.parse(_serverUrl));
    request.files.add(await http.MultipartFile.fromPath('image', _selectedImage!.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      var json = jsonDecode(responseData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(json['message']),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to upload image."),
        ),
      );
    }
  }

  Future<void> _fetchImages() async {
    var response = await http.get(Uri.parse(_serverUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['images']);
    } else {
      print("Failed to fetch images.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Uploader")),
      body: Column(
        children: [
          if (_selectedImage != null) Image.file(_selectedImage!),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _pickImage,
                child: Text("Pick Image"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text("Upload Image"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _fetchImages,
                child: Text("Fetch Images"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
