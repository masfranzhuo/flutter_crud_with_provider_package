import 'package:dio/dio.dart';
import 'package:flutter_crud_with_provider_package/model/user_model.dart';
import 'package:flutter_crud_with_provider_package/config/constant/api_url.dart';

class UserApi {
  static String mainUrl = API.MAIN_URL;
  static String userModel = '/users';

  static BaseOptions options = new BaseOptions(
    baseUrl: API.MAIN_URL,
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );
  Dio dio = new Dio(options);

  Future<List<User>> getUsers({List<String> columns, String query}) async {
    try {
      Map<String, dynamic> params =
          (query != null && query != '') ? {'name': query} : {};
      Response response = await dio.get(userModel, queryParameters: params);

      List result = response.data as List;
      List<User> users = result.isNotEmpty
          ? result.map((user) => User.fromJson(user)).toList()
          : [];

      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<User> getUser({List<String> columns, int id}) async {
    try {
      Response response = await dio.get(userModel, queryParameters: {'id': id});

      List result = response.data as List;
      List<User> users = result.isNotEmpty
          ? result.map((user) => User.fromJson(user)).toList()
          : [];
      User user = users.isNotEmpty ? users[0] : null;

      return user;
    } catch (e) {
      print(e);
      return User();
    }
  }

  Future<User> createUser(User user) async {
    try {
      Response response = await dio.post(userModel, data: user.toJson());

      user = User.fromJson(response.data);

      return user;
    } catch (e) {
      print(e);
      return User();
    }
  }

  Future<User> updateUser(User user) async {
    try {
      Response response = await dio
          .post(userModel, data: user.toJson(), queryParameters: {'id': user.id});

      user = User.fromJson(response.data);

      return user;
    } catch (e) {
      print(e);
      return User();
    }
  }

  Future deleteUser(int id) async {
    try {
      await dio.get(userModel, queryParameters: {'id': id});
      print(id.toString() + ' deleted');
    } catch (e) {
      print(e);
    }
  }
}
