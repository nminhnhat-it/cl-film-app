import 'package:flutter/cupertino.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

const double _kItemExtent = 32.0;
const List<String> _gender = <String>[
  'Male',
  'Female',
];

class _AccountInfoScreenState extends State<AccountInfoScreen> {
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

  void _saveInfo() {
    print(_selectedGender);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Account'),
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            _saveInfo();
          },
          child: const Text('Save'),
        ),
      ),
      child: Center(
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(100),
                      child: Image.network(
                        'http://localhost:3000/public/uploads/sndyf24n24m.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CupertinoFormSection(
              margin: const EdgeInsets.only(left: 30, right: 30),
              header: const Text('Name'),
              backgroundColor: CupertinoColors.white,
              children: [
                CupertinoTextFormFieldRow(
                  initialValue: "User Name",
                ),
              ],
            ),
            CupertinoFormSection(
              margin: const EdgeInsets.only(left: 30, right: 30),
              header: const Text('Gender'),
              backgroundColor: CupertinoColors.white,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                      child: CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _showDialog(
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
                          style: const TextStyle(
                            color: CupertinoColors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
