import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  String _editedName = "";
  int _selectedGender = 0;
  File? _selectedImage;

  Future pickFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = File(returnImage!.path);
    });
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

  void saveName(value) {
    setState(() {
      _editedName = value;
    });
  }

  void _saveInfo() {
    print(_editedName);
    print(_selectedGender);
    print(_selectedImage);
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
            Navigator.of(context).pop();
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
                      child: GestureDetector(
                        onTap: () {
                          pickFromGallery();
                        },
                        child: _selectedImage == null
                            ? Image.network(
                                'http://localhost:3000/public/uploads/sndyf24n24m.png',
                                fit: BoxFit.cover,
                              )
                            : Image.file(_selectedImage as File),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CupertinoFormSection(
              margin: const EdgeInsets.only(left: 30, right: 30),
              header: const Text('Name'),
              backgroundColor: CupertinoColors.systemBackground,
              children: [
                CupertinoTextFormFieldRow(
                  onChanged: (value) {
                    saveName(value);
                  },
                  initialValue: "User Name",
                ),
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
          ],
        ),
      ),
    );
  }
}
