import 'package:ct484_project/models/user.dart';
import 'package:ct484_project/ui/auth/auth_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

const double _kItemExtent = 32.0;
const List<String> _gender = <String>[
  'Male',
  'Female',
];

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final User _user = User(
    usName: "",
    usEmail: "",
    usPassword: "",
    usGender: "male",
    usImage: "",
  );

  void closeAuth() {
    Navigator.of(context).pop();
  }

  int _selectedGender = 0;

  void _showAlertDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Null field detected!'),
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

  Future<void> createUser(User data) async {
    data.usGender = _selectedGender == 0 ? 'male' : 'female';
    
    bool result = await context.read<AuthManager>().createUser(data);
    if (result) {
      closeAuth();
    } else {
      _showAlertDialog();
    }
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoFormSection(
          header: const Text('Name'),
          margin: const EdgeInsets.only(left: 30, right: 30),
          children: [
            CupertinoTextFormFieldRow(
              placeholder: 'Name',
              onChanged: (value) {
                {
                  setState(() {
                    _user.usName = value;
                  });
                }
              },
            )
          ],
        ),
        CupertinoFormSection(
          header: const Text('Email'),
          margin: const EdgeInsets.only(left: 30, right: 30),
          children: [
            CupertinoTextFormFieldRow(
              placeholder: 'Email',
            onChanged: (value) {
                {
                  setState(() {
                    _user.usEmail = value;
                  });
                }
              },
            )
          ],
        ),
        CupertinoFormSection(
          header: const Text('Password'),
          margin: const EdgeInsets.only(left: 30, right: 30),
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
        CupertinoFormSection(
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          header: const Text('Gender'),
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 14, bottom: 14),
                  child: GestureDetector(
                    onTap: () => _showDialog(
                      CupertinoPicker(
                        magnification: 1,
                        squeeze: 1,
                        useMagnifier: true,
                        itemExtent: _kItemExtent,
                        scrollController: FixedExtentScrollController(
                          initialItem: _selectedGender,
                        ),
                        onSelectedItemChanged: (int selectedItem) {
                          setState(() {
                            _selectedGender = selectedItem;
                          });
                        },
                        children: List<Widget>.generate(
                          _gender.length,
                          (int index) {
                            return Text(_gender[index]);
                          },
                        ),
                      ),
                    ),
                    child: Text(
                      _gender[_selectedGender],
                    ),
                  ),
                ),
              ],
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
                  child: const Text('Register'),
                  onPressed: () {
                    createUser(_user);
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
