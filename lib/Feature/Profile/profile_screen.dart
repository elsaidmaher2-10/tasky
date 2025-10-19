import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/constant/storage_keys.dart';
import 'package:tasky/core/services/prefrence_manager.dart';
import 'package:tasky/core/theme/themecontroller.dart';
import 'package:tasky/main.dart';
import 'package:tasky/Feature/Profile/user_details_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "";
  String mvQoute = "";
  File? selectedimage;
  bool isDrak = PrefrenceManager().getbool("theme") ?? false;

  Future<void> _loadusername() async {
    setState(() {
      name = PrefrenceManager().getstring(StorageKeys.username) ?? "";

      String? imagePath = PrefrenceManager().getstring("imageprofile");
      if (imagePath != null && imagePath.isNotEmpty) {
        selectedimage = File(imagePath);
      }
    });
  }

  Future<void> _loadMotivationQuote() async {
    setState(() {
      mvQoute =
          PrefrenceManager().getstring("mvQoute") ??
          "One task at a time. One step closer.";
    });
  }

  @override
  void initState() {
    _loadusername();
    _loadMotivationQuote();
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
              "My Profile",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: 20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 55,
                      backgroundImage: selectedimage == null
                          ? const AssetImage("assets/images/person.png")
                          : FileImage(selectedimage!) as ImageProvider,
                    ),
                    Positioned(
                      right: 2,
                      bottom: -3,
                      child: GestureDetector(
                        onTap: () async {
                          File? image = await imageDialogs(context);
                          if (image != null) {
                            await saveimage(image);
                            setState(() {
                              selectedimage = image;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Themecontroller.isDark() == true
                                  ? Colors.transparent
                                  : const Color(0xffD1DAD6),
                            ),
                            borderRadius: BorderRadius.circular(32),
                            color: Themecontroller.isDark() == true
                                ? const Color(0xff282828)
                                : const Color(0xffFFFFFF),
                          ),
                          child: Icon(
                            color: Themecontroller.isDark() == true
                                ? const Color(0xffFFFCFC)
                                : const Color(0xff161F1B),
                            Icons.camera_alt_outlined,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(mvQoute, style: Theme.of(context).textTheme.titleSmall),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              "Profile Info",
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontSize: 20),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/images/profile.svg",
                colorFilter: ColorFilter.mode(
                  Themecontroller.isDark()
                      ? const Color(0xffFFFCFC)
                      : const Color(0xff161F1B),
                  BlendMode.srcIn,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => UserDetailsScreen(name: name),
                  ),
                ).then((v) {
                  _loadusername();
                  _loadMotivationQuote();
                });
              },
              title: Text(
                "Profile",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 16),
              ),
              trailing: SvgPicture.asset(
                "assets/images/arrowback.svg",
                colorFilter: ColorFilter.mode(
                  Themecontroller.isDark()
                      ? const Color(0xffFFFCFC)
                      : const Color(0xff161F1B),
                  BlendMode.srcIn,
                ),
              ),
            ),
            const Divider(color: Color(0xff6E6E6E), thickness: 1),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/images/moon-01.svg",
                colorFilter: ColorFilter.mode(
                  Themecontroller.isDark()
                      ? const Color(0xffFFFCFC)
                      : const Color(0xff161F1B),
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                "Dark Mode",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 16),
              ),
              trailing: Switch(
                value: isDrak,
                onChanged: (change) async {
                  setState(() {
                    isDrak = change;
                    Themecontroller().toggel();
                  });
                },
              ),
            ),
            const Divider(color: Color(0xff6E6E6E), thickness: 1),
            ListTile(
              onTap: () async {
                PrefrenceManager().remove("username");
                PrefrenceManager().remove("mvQoute");
                PrefrenceManager().remove("task");
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (ctx) => const Tasky()),
                  (Route<dynamic> route) => false,
                );
              },
              contentPadding: EdgeInsets.zero,
              leading: SvgPicture.asset(
                "assets/images/log-out-01.svg",
                colorFilter: ColorFilter.mode(
                  Themecontroller.isDark()
                      ? const Color(0xffFFFCFC)
                      : const Color(0xff161F1B),
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                "Log Out",
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontSize: 16),
              ),
              trailing: SvgPicture.asset(
                "assets/images/arrowback.svg",
                colorFilter: ColorFilter.mode(
                  Themecontroller.isDark()
                      ? const Color(0xffFFFCFC)
                      : const Color(0xff161F1B),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveimage(File newfile) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final localimage = await newfile.copy(
      "${appDocumentsDir.path}/${basename(newfile.path)}",
    );
    PrefrenceManager().setstring("imageprofile", localimage.path);
  }

  Future<File?> imageDialogs(BuildContext ctx) async {
    File? selected;

    await showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: Text(
                "Choose Image Profile",
                style: Theme.of(context).textTheme.titleMedium,
              ),

              actions: [
                TextButton.icon(
                  onPressed: () async {
                    XFile? file = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );
                    if (file != null) {
                      setState(() {
                        selected = File(file.path);
                      });
                    }
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"),
                ),
                TextButton.icon(
                  onPressed: () async {
                    XFile? file = await ImagePicker().pickImage(
                      source: ImageSource.camera,
                    );
                    if (file != null) {
                      setState(() {
                        selected = File(file.path);
                      });
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Camera"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, selected);
                  },
                  child: const Text("Done"),
                ),
              ],
            );
          },
        );
      },
    );

    return selected;
  }
}
