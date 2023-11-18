import 'package:flutter/cupertino.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

const double _kItemExtent = 32.0;
const List<String> _gender = <String>[
  'Male',
  'Female',
];

class _AuthScreenState extends State<AuthScreen> {
  bool _isRegister = false;

  void changeMode(newValue) {
    setState(() {
      _isRegister = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(),
      child: Center(
        child: !_isRegister
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      'http://localhost:3000/public/uploads/logo-with-brand.png'),
                  const LoginForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('New here?'),
                      CupertinoButton(
                        onPressed: () => {changeMode(true)},
                        child: const Text("Register"),
                      ),
                    ],
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      'http://localhost:3000/public/uploads/logo-with-brand.png'),
                  const RegisterForm(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have account?'),
                      CupertinoButton(
                        onPressed: () => {changeMode(false)},
                        child: const Text("Log In"),
                      ),
                    ],
                  )
                ],
              ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoFormSection(
          header: const Text('Email'),
          margin: const EdgeInsets.only(left: 30, right: 30),
          children: [
            CupertinoTextFormFieldRow(
              placeholder: 'Email',
            )
          ],
        ),
        CupertinoFormSection(
          header: const Text('Password'),
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          children: [
            CupertinoTextFormFieldRow(
              placeholder: 'Password',
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
                  onPressed: () => const Text('data'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  int _selectedGender = 0;

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
            )
          ],
        ),
        CupertinoFormSection(
          header: const Text('Email'),
          margin: const EdgeInsets.only(left: 30, right: 30),
          children: [
            CupertinoTextFormFieldRow(
              placeholder: 'Email',
            )
          ],
        ),
        CupertinoFormSection(
          header: const Text('Password'),
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          children: [
            CupertinoTextFormFieldRow(
              placeholder: 'Password',
            )
          ],
        ),
        CupertinoFormSection(
          margin: const EdgeInsets.only(left: 30, right: 30),
          header: const Text('Gender'),
          backgroundColor: CupertinoColors.systemBackground,
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
                  onPressed: () => const Text('data'),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
