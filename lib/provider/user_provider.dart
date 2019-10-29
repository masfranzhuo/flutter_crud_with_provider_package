import 'package:flutter/widgets.dart';
import 'package:flutter_crud_with_provider_package/model/user_model.dart';
import 'package:flutter_crud_with_provider_package/repository/user_repository.dart';

class UserProvider with ChangeNotifier {
  final _userRepository = UserRepository();
  List<User> users;
  User user;
  User prevUser;

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
    this.prevUser = user;
    notifyListeners();
  }

  Future<void> createUser(User user) async {
    users.add(await _userRepository.createUser(user));
    notifyListeners();
  }

  Future<void> updateUser(User user) async {
    this.user = await _userRepository.updateUser(user);
    users[this.users.indexOf(this.prevUser)] = this.user;
    notifyListeners();
  }

  Future<void> deleteUser(User user) async {
    await _userRepository.deleteUser(user.id);
    users.removeAt(this.users.indexOf(user));
    notifyListeners();
  }
}