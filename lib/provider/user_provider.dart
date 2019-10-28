import 'package:flutter/widgets.dart';
import 'package:flutter_crud_with_provider_package/model/user_model.dart';
import 'package:flutter_crud_with_provider_package/repository/user_repository.dart';

class UserProvider with ChangeNotifier {
  final _userRepository = UserRepository();
  List<User> users;
  User user;

  UserProvider({this.users, this.user});

  getUsers() => this.users;
  setUsers(List<User> users) => this.users = users;

  getUser() => this.user;
  setUser(User user) => this.user = user;

  Future<void> fetchUsers({String query}) async {
    this.users = await _userRepository.getUsers(query: query);
    notifyListeners();
  }

  Future<void> fetchUser({User user}) async {
    this.user = await _userRepository.getUser(user?.id);
    notifyListeners();
  }

  Future<void> createUser(User user) async {
    user.id = await _userRepository.createUser(user);
    users.add(user);
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    await _userRepository.updateUser(user);
    fetchUsers();
  }

  Future<void> deleteUser(User user) async {
    await _userRepository.deleteUser(user.id);
    users.removeAt(this.users.indexOf(user));
    notifyListeners();
  }
}