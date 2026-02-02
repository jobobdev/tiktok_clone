import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

import '../../constants/gaps.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime initialDate = DateTime(
    DateTime.now().year - 12, // 틱톡처럼 기본값을 과거 날짜로 하면 더 자연스러워요
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState(); // super.initstate()은 항상 젤 위에 둔다.
    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose(); // super.dispose()는 항상 마지막에 둔다, Controller는 항상 dispose한다.
  }

  void _onNextTap() {
    {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => InterestsScreen()));
    }
  } //stateful widget 안에서 함수를 생성할땐, context가 항상 사용가능하므로 _onNextTap(BuildContext context)를 할 필요가 없다

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdayController.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
        surfaceTintColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v16,
            Text(
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v6,
            Text(
              "Your birthday won't be shown publicly.",
              style: TextStyle(
                fontSize: Sizes.size14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
            Gaps.v20,
            TextField(
              readOnly: true,
              controller: _birthdayController,
              decoration: InputDecoration(
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
            Gaps.v32,
            GestureDetector(
              onTap: _onNextTap,
              child: FormButton(disabled: false),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300, // 높이를 조금 넉넉히 주면 더 예쁩니다
        color: Colors.white,
        child: CupertinoDatePicker(
          dateOrder: DatePickerDateOrder.dmy,
          maximumDate: initialDate, // 미래 날짜 선택 방지 (옵션)
          initialDateTime: initialDate, // 이 부분을 반드시 추가하세요!
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
