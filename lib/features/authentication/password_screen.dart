import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/birthday_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';

import '../../constants/gaps.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();

  String _password = "";
  bool _obscureText = true;

  @override
  void initState() {
    super.initState(); // super.initstate()은 항상 젤 위에 둔다.
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose(); // super.dispose()는 항상 마지막에 둔다, Controller는 항상 dispose한다.
  }

  bool _isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BirthdayScreen()),
    );
  }

  void _onClearTap() {
    _passwordController.clear();
  }

  void _toggleObscureText() {
    _obscureText = !_obscureText;
    setState(() {}); //build를 트리거하는 것, 안에 아무것도 안넣어도 됨.
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(title: const Text("Sign up")),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v16,
              Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),

              Gaps.v20,
              TextField(
                controller: _passwordController,
                autocorrect: false,
                obscureText: _obscureText,
                onEditingComplete:
                    _onSubmit, //유저가 키보드에서 done(엔터)를 눌렀을 때 작동하는 함수임
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey.shade500,
                          size: Sizes.size16,
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          color: Colors.grey.shade500,
                          size: Sizes.size16,
                        ),
                      ),
                    ],
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                ),

                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v10,
              Text(
                'Your password mush have:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Sizes.size12,
                ),
              ),
              Gaps.v10,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size16,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade500,
                  ),
                  Gaps.h4,
                  Text(
                    '8 to 20 characters',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Sizes.size12,
                    ),
                  ),
                ],
              ),
              Gaps.v6,
              Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleCheck,
                    size: Sizes.size16,
                    color: _isPasswordValid()
                        ? Colors.green
                        : Colors.grey.shade500,
                  ),
                  Gaps.h4,
                  Text(
                    'Letters, numbers, and special characters',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: Sizes.size12,
                    ),
                  ),
                ],
              ),
              Gaps.v32,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(disabled: !_isPasswordValid()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
