import 'package:image_picker/image_picker.dart';

Future<XFile?> pickAnImageFromGallery() async {
  XFile? avatar = await ImagePicker().pickImage(
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 100,
      source: ImageSource.gallery);
  return avatar;
}
