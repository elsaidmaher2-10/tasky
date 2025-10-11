import 'package:flutter/material.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/core/widgets/custom_form_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key, required this.name});
  final String name;
  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late TextEditingController username;
  late TextEditingController motivationqoute;

  @override
  void initState() {
    username = TextEditingController(text: widget.name);
    motivationqoute = TextEditingController(
      text: "One task at a time. One step closer.",
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User Name",
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8),
            CustomFormField(controller: username, hinttext: "Usama Elgendy"),
            SizedBox(height: 20),
            Text(
              "Motivation Quote",
              style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 8),
            CustomFormField(
              maxLines: 5,
              controller: motivationqoute,
              hinttext: "One task at a time. One step closer.",
            ),
            Spacer(),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(3430, 40),
                backgroundColor: Color(0xff15B86C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Color(0xffFFFCFC),
              ),
              onPressed: () async {
                 PrefrenceManager().setstring("username", username.text);
                 PrefrenceManager().setstring("mvQoute", motivationqoute.text);
                Navigator.pop(context);
              },
              label: Text(
                "Save Changes",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),

              icon: Icon(Icons.edit),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(
          "User Details",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
