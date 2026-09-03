/// 数据层：自定义菜谱图片的本地存取（拍照/相册 → 压缩 → App 私有目录）
library;

import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class RecipeImageStore {
  static final ImagePicker _picker = ImagePicker();

  static Future<Directory> _dir() async {
    final doc = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(doc.path, 'recipe_images'));
    if (!dir.existsSync()) dir.createSync(recursive: true);
    return dir;
  }

  /// 拍照
  static Future<XFile?> takePhoto() => _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

  /// 相册选图
  static Future<XFile?> pickFromGallery() => _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

  /// 把选中的图压缩后拷进 App 私有目录，返回 [绝对路径, 文件名]
  static Future<({String path, String fileName})> saveRecipeImage(
      XFile picked, String recipeSeed) async {
    final dir = await _dir();
    final ext = p.extension(picked.path).replaceAll('.', '');
    final fileName = 'custom_${recipeSeed}.$ext';
    final target = p.join(dir.path, fileName);

    // 再压缩一轮到 ~720px 宽（cover 大图足够）
    final compressed = await FlutterImageCompress.compressAndGetFile(
      picked.path,
      target,
      quality: 80,
      minWidth: 720,
      keepExif: false,
    );
    if (compressed == null) {
      // 压缩失败兜底：直接拷原文件
      await File(picked.path).copy(target);
    }
    return (path: target, fileName: fileName);
  }

  /// 删除自定义菜谱的图片（不存在则忽略）
  static Future<void> deleteImage(String? fileNameOrPath) async {
    if (fileNameOrPath == null || fileNameOrPath.isEmpty) return;
    try {
      final f = fileNameOrPath.contains('/')
          ? File(fileNameOrPath)
          : File(p.join((await _dir()).path, fileNameOrPath));
      if (f.existsSync()) await f.delete();
    } catch (_) {/* 清理失败不影响主流程 */}
  }

  /// 由文件名解析出完整路径（UI 层 Image.file 用）
  static Future<String> resolvePath(String fileName) async =>
      p.join((await _dir()).path, fileName);
}
