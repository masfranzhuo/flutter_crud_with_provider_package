

import 'package:flutter_crud_with_provider_package/dao/user_api.dart';
import 'package:flutter_crud_with_provider_package/model/user_model.dart';

class UserRepository {
  final userApi = UserApi();

  Future getUsers({String query}) => userApi.getUsers(query: query);

  Future getUser(int id) => userApi.getUser(id: id);

  Future createUser(User user) => userApi.createUser(user);

  Future updateUser(User user) => userApi.updateUser(user);

  Future deleteUser(int id) => userApi.deleteUser(id);
  
  // final userDao = UserDao();

  // Future getUsers({String query}) => userDao.getUsers(query: query);

  // Future getUser(int id) => userDao.getUser(id: id);

  // Future createUser(User user) => userDao.createUser(user);

  // Future updateUser(User user) => userDao.updateUser(user);

  // Future deleteUser(int id) => userDao.deleteUser(id);
}