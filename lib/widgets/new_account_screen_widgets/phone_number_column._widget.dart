import 'package:dating_made_better/utils/call_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';

import '../../providers/first_screen_state_providers.dart';
import '../../providers/profile.dart';

// ignore: must_be_immutable
class PhoneNumberColumnWidget extends StatefulWidget {
  Size deviceSize;
  PhoneNumberColumnWidget(this.deviceSize, {super.key});

  @override
  State<PhoneNumberColumnWidget> createState() => _PhoneNumberColumnWidget();
}

class _PhoneNumberColumnWidget extends State<PhoneNumberColumnWidget> {
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'IN');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'IN';
  String phoneNumberValue = "";
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Container(
            margin: EdgeInsets.only(top: widget.deviceSize.height / 8),
            child: Text(
              'Stumble',
              style: GoogleFonts.sacramento(
                fontSize: 60.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: widget.deviceSize.height / 4,
        ),
        Container(
          margin: EdgeInsets.only(
              left: widget.deviceSize.width / 16,
              right: widget.deviceSize.width / 16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InternationalPhoneNumberInput(
                  cursorColor: Colors.white,
                  onInputChanged: (PhoneNumber number) {
                    phoneNumberValue = number.phoneNumber!;
                  },
                  onInputValidated: (bool value) {},
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DIALOG,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.always,
                  selectorTextStyle: const TextStyle(color: Colors.white),
                  initialValue: number,
                  textFieldController: controller,
                  textStyle: const TextStyle(color: Colors.white),
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: const OutlineInputBorder(),
                  onFieldSubmitted: (value) {
                    phoneNumberValue = value;
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: widget.deviceSize.height / 8,
        ),
        ElevatedButton(
          onPressed: () {
            sendOtpApi(phoneNumberValue);
            setState(() {
              Provider.of<FirstScreenStateProviders>(context, listen: false)
                  .setNextScreenActive();
              Provider.of<Profile>(context, listen: false).setPhoneNumber =
                  phoneNumberValue;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(230, 230, 250, 0.5),
            minimumSize: Size(
                widget.deviceSize.width / 2, widget.deviceSize.height / 16),
          ),
          child: const Text(
            "Send OTP",
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
