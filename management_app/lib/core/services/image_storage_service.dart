import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageStorageService {
  static Future<String?> uploadAvatarImage(XFile? imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dyhjqna2u/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'fabqagch';
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    }
    return null;
  }

  static Future<String?> uploadFoodImage(XFile? imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dyhjqna2u/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'prb8aqbx';
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    }
    return null;
  }

  static Future<String?> uploadIngredientImage(XFile? imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dyhjqna2u/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'axinoztf';
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    }
    return null;
  }

  static Future<String?> uploadCategoryImage(XFile? imageFile) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dyhjqna2u/upload');
    final request = http.MultipartRequest('POST', url);
    request.fields['upload_preset'] = 'category';
    request.files
        .add(await http.MultipartFile.fromPath('file', imageFile!.path));
    final response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonMap = jsonDecode(responseString);
      return jsonMap['url'];
    }
    return null;
  }
}
