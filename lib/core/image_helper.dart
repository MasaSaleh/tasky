import 'package:image_picker/image_picker.dart';

class ImageHelper {
  // بترجع مسار الصورة كنص (زي ما حكينا بالمحاضرة: بنخزّن المسار مش الصورة)
  // أو null إذا المستخدم سكّر بدون ما يختار
  static Future<String?> pick(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 70);
    return file?.path;
  }
}
