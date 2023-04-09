import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitfn);
  final void Function(
      String email, String username, String password, bool islogin) submitfn;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final formkey = GlobalKey<FormState>();
  String email = '';
  String user = '';
  String password = '';
  bool islogin = true;

  void trysubmit() {
    final isvalid = formkey.currentState!.validate();
    // Focus.of(context).unfocus();
    if (isvalid) {
      formkey.currentState!.save();
      widget.submitfn(email.trim(), user.trim(), password.trim(), islogin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      // border: InputBorder(borderSide: BorderSide.none),
                      hintText: "Enter email",
                      labelText: "Email Address"),
                  onSaved: (value) {
                    email = value.toString();
                  },
                ),
                if (!islogin)
                  TextFormField(
                    key: ValueKey('username'),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 3) {
                        return "Enter valid username";
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "UserName", labelText: "UserName"),
                    onSaved: (value) {
                      user = value.toString();
                    },
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 7) {
                      return "Enter Valid password";
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Password", labelText: "Password"),
                  obscureText: true,
                  onSaved: (value) {
                    password = value.toString();
                  },
                ),
                ElevatedButton(
                  onPressed: () => trysubmit(),
                  child: Text(islogin ? "Login" : "Signup"),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      islogin = !islogin;
                    });
                  },
                  child: Text(islogin
                      ? "Create new Account"
                      : "Already created account"),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
