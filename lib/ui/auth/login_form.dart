import 'package:ct484_project/models/user.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final User _user = User(
    usName: "",
    usEmail: "",
    usPassword: "",
    usGender: "",
    usImage: "",
  );

  void closeAuth() {
    Navigator.of(context).pop();
  }

  void _showAlertDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Invalid credential!'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future<void> verifyCredential(User data) async {
    bool result = await context.read<AuthManager>().verifyCredential(data);
    if (result) {
      closeAuth();
    } else {
      _showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoFormSection(
          header: const Text('Email'),
          margin: const EdgeInsets.only(left: 30, right: 30),
          children: [
            CupertinoTextFormFieldRow(
              onChanged: (value) {
                {
                  setState(() {
                    _user.usEmail = value;
                  });
                }
              },
              placeholder: 'Email',
            )
          ],
        ),
        CupertinoFormSection(
          header: const Text('Password'),
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          children: [
            CupertinoTextFormFieldRow(
              onChanged: (value) {
                {
                  setState(() {
                    _user.usPassword = value;
                  });
                }
              },
              placeholder: 'Password',
              obscureText: true,
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                child: CupertinoButton(
                  color: const Color.fromARGB(255, 51, 161, 204),
                  child: const Text('Sign In'),
                  onPressed: () => {
                    verifyCredential(_user),
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
