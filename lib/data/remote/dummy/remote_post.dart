import 'package:get/get.dart';
import 'package:hedma/app/utils/constants.dart';
import 'package:hedma/data/remote/dio_client.dart';

class RemotePost {
  RemotePost(this._dioClient);

  static RemotePost get find => RemotePost(Get.find<DioClient>());

  final DioClient _dioClient;

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? variables,
    required Map<String, dynamic> dummyJson,
  }) async {
    if (!Constants.useRemoteApi) {
      return dummyJson;
    }

    final json = await _dioClient.post(path, variables: variables);
    if (_isSuccess(json)) return json;
    return dummyJson;
  }

  bool _isSuccess(Map<String, dynamic> json) {
    final statusCode = json['statusCode'] as int?;
    if (statusCode != 200) return false;
    if (!json.containsKey('data')) return true;
    final data = json['data'];
    if (data is List) return data.isNotEmpty;
    return data != null;
  }
}
