import 'package:flutter/material.dart';
import 'package:flutter_crud_with_provider_package/model/user_model.dart';
import 'package:flutter_crud_with_provider_package/provider/user_provider.dart';
import 'package:flutter_crud_with_provider_package/ui/shared/no_data_widget.dart';
import 'package:flutter_crud_with_provider_package/ui/view/form_screen.dart';
import 'package:flutter_crud_with_provider_package/ui/shared/loading_widget.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _searchController = new TextEditingController();

  UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autocorrect: false,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                userProvider.fetchUsers(query: _searchController.text);
              },
            ),
            hintText: 'Search...',
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<UserFormScreen>(
                builder: (context) {
                  return ChangeNotifierProvider.value(
                    value: userProvider..fetchUser(User()),
                    child: UserFormScreen(),
                  );
                },
              ),
            );
          }),
      body: Center(
        child: Consumer<UserProvider>(
          builder: (context, state, _) {
            if (state.users != null) {
              return Container(
                child: (state.users.isNotEmpty)
                    ? ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          User user = state.users[index];
                          return _userCard(user, context);
                        },
                      )
                    : NoData(),
              );
            }
            return loading();
          },
        ),
      ),
    );
  }

  Card _userCard(User user, BuildContext context) {
    return Card(
        child: Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(padding: EdgeInsets.all(10), child: Text(user.name)),
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<UserFormScreen>(
                      builder: (context) {
                        return ChangeNotifierProvider.value(
                          value: userProvider..fetchUser(user),
                          child: UserFormScreen(),
                        );
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  userProvider.deleteUser(user);
                },
              )
            ],
          ),
        ],
      ),
    ));
  }
}
