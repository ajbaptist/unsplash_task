import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../utils/keys.dart';
import '../model/image_model.dart';

class UnsplashRepository {
  static var client = http.Client();
  static Future<List<ImageModel>?> getImages() async {
    try {
      final response = await client.get(Uri.parse(
          'https://api.unsplash.com/photos/random/?client_id=$unsplashApiClientID&count=30'));

      print('res--?${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> result = jsonDecode(response.body);
        List<ImageModel> images =
            result.map((e) => ImageModel.fromJson(e)).toList();
        return images;
      } else {
        return null;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
      return null;
    }
  }

  static Future<List<ImageModel>?> searchImage({required query}) async {
    final response = await http.get(Uri.parse(
        'https://api.unsplash.com/photos/random/?client_id=$unsplashApiClientID&count=30&query=$query'));
    if (response.statusCode == 200) {
      List<dynamic> result = jsonDecode(response.body);
      List<ImageModel> images =
          result.map((e) => ImageModel.fromJson(e)).toList();
      return images;
    } else {
      return null;
    }
  }
}
