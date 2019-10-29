import 'package:dio/dio.dart';
import 'package:flutter_crud_with_provider_package/model/user_model.dart';

class UserApi {
  final String mainUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> getUsers({List<String> columns, String query}) async {
    try {
      Map<String, dynamic> params = (query != null && query != '') ? {'name': query} : {};
      Response response = await Dio().get(mainUrl, queryParameters: params);

      List result = response.data as List;
      List<User> users = result.isNotEmpty ? result.map((user) => User.fromJson(user)).toList() : [];

      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<User> getUser({List<String> columns, int id}) async {
    try {
      Response response = await Dio().get(mainUrl, queryParameters: {'id': id});

      List result = response.data as List;
      List<User> users = result.isNotEmpty ? result.map((user) => User.fromJson(user)).toList() : [];
      User user = users.isNotEmpty ? users[0] : null;

      return user;
    } catch (e) {
      print(e);
      return User();
    }
  }

  Future<User> createUser(User user) async {
    try {
      Response response = await Dio().post(mainUrl, data: user.toJson());

      user = User.fromJson(response.data);

      return user;
    } catch (e) {
      print(e);
      return User();
    }
  }

  Future<User> updateUser(User user) async {
    try {
      Response response = await Dio().post(mainUrl, data: user.toJson(), queryParameters: {'id': user.id});

      user = User.fromJson(response.data);

      return user;
    } catch (e) {
      print(e);
      return User();
    }
  }

  Future deleteUser(int id) async {
    try {
      await Dio().get(mainUrl, queryParameters: {'id': id});
      print(id.toString() + ' deleted');
    } catch (e) {
      print(e);
    }
  }
}
