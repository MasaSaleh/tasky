import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<String?> pick(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 70);
    return file?.path;
  }
}
