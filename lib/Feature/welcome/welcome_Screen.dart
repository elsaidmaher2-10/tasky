import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/core/widgets/custom_form_field.dart';
import 'package:tasky/Feature/main/main_screen.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Image(image: AssetImage("assets/images/logo.png")),
                    SizedBox(width: 8),
                    Text(
                      "Tasky",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),

                SizedBox(height: 118),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome To Tasky ",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),

                    Image(image: AssetImage("assets/images/waving_hand.png")),
                  ],
                ),
                SizedBox(height: 8),

                Column(
                  children: [
                    Text(
                      "Your productivity journey starts here.",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 24),

                    SvgPicture.asset(
                      "assets/images/pana.svg",
                      width: 215,
                      height: 204,
                    ),
                    SizedBox(height: 24),
                  ],
                ),

                Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    "Full Name",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.labelSmall!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                CustomFormField(
                  controller: controller,
                  hinttext: "e.g. Sarah Khalid",
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Please Enetr Your Full Name";
                    }
                    return null;
                  },
                ),

                SizedBox(height: 24),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(3430, 40),
                    backgroundColor: Color(0xff15B86C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    foregroundColor: Color(0xffFFFCFC),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      PrefrenceManager().setstring(
                        StorageKeys.username,
                        controller.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (ctx) => MainScreen()),
                      );
                    }
                  },
                  child: Text(
                    "Let’s Get Started",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
