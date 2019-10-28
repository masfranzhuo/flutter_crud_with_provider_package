import 'package:flutter/material.dart';
import 'package:flutter_crud_with_provider_package/model/user_model.dart';
import 'package:flutter_crud_with_provider_package/provider/user_provider.dart';
import 'package:flutter_crud_with_provider_package/ui/shared/loading_widget.dart';
import 'package:provider/provider.dart';

class UserFormScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        userProvider.fetchUser(User());
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Consumer<UserProvider>(builder: (context, state, _) {
            return Text(
                state.user?.id == null ? 'Add' : 'Edit' + ' User');
          }),
        ),
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
                child: Consumer<UserProvider>(builder: (context, state, _) {
                User user = state.user == null ? User(name: '') : state.user;
                _nameController.value = _nameController.value.copyWith(text: user?.name ?? '');
                _usernameController.value = _usernameController.value.copyWith(text: user.username ?? '');
                _emailController.value = _emailController.value.copyWith(text: user.email ?? '');
                return Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                          controller: _nameController,
                          onChanged: (value) {
                            user?.name = value;
                          },
                          validator: (value) {
                            if (value.length < 1) {
                              return 'Name cannot be empty';
                            }
                            return null;
                          }),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username',
                          ),
                          controller: _usernameController,
                          onChanged: (value) {
                            user?.username = value;
                          },
                          validator: (value) {
                            if (value.length < 1) {
                              return 'Username cannot be empty';
                            }
                            return null;
                          }),
                      TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          controller: _emailController,
                          onChanged: (value) {
                            user?.email = value;
                          },
                          validator: (value) {
                            if (value.length < 1) {
                              return 'Email cannot be empty';
                            }
                            return null;
                          }),
                      RaisedButton(
                        child: Text('Submit'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            user?.id == null
                                ? userProvider.createUser(user)
                                : userProvider.updateUser(user);
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                );
            })),
          ),
        ),
      ),
    );
  }
}
