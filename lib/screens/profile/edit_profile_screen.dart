import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../services/cloudinary_service.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../services/auth_service.dart';

import '../../widgets/profile_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() =>
      _EditProfileScreenState();
}

class _EditProfileScreenState
    extends State<EditProfileScreen> {
      final nameController = TextEditingController();
final emailController = TextEditingController();
final weightController = TextEditingController();
final heightController = TextEditingController();

final oldPasswordController = TextEditingController();
final newPasswordController = TextEditingController();
final confirmPasswordController = TextEditingController();
final birthDateController = TextEditingController();
final ImagePicker picker = ImagePicker();

String gender = "";
String birthDate = "";

UserModel? user;

@override
void initState() {
  super.initState();
  loadUser();
}

Future<void> loadUser() async {
  final firebaseUser = AuthService().currentUser!;

  // Ambil email terbaru dari Firebase Auth
  await firebaseUser.reload();

  final uid = firebaseUser.uid;

  print("UID LOGIN = $uid");

  final data = await UserService()
      .getUser(uid)
      .first;

  // Sinkronkan email Firestore jika berbeda
  if (firebaseUser.email != null &&
      firebaseUser.email != data.email) {
    await UserService().updateEmail(
      uid,
      firebaseUser.email!,
    );
  }

  // Ambil ulang data setelah update
  final newData = await UserService()
      .getUser(uid)
      .first;

  user = newData;

  nameController.text = newData.name;
  emailController.text = newData.email;
  weightController.text = newData.weight;
  heightController.text = newData.height;
  birthDateController.text = newData.birthDate;

  setState(() {
    gender = newData.gender;
  });
}
Future<void> saveProfile() async {
  try {
    print("Tombol Simpan ditekan");

    final uid = AuthService().currentUser!.uid;
    print("UID: $uid");

    await UserService().updateUser(
      UserModel(
  uid: uid,
  name: nameController.text.trim(),
  email: emailController.text.trim(),
  gender: gender,
  birthDate: birthDateController.text.trim(),
  weight: weightController.text.trim(),
  height: heightController.text.trim(),
  photoUrl: user?.photoUrl ?? "",

  dailyWaterTarget: user?.dailyWaterTarget ?? 2000,
  dailyStepTarget: user?.dailyStepTarget ?? 10000,
  autoRecommendation: user?.autoRecommendation ?? true,

  hydrationReminder: user?.hydrationReminder ?? true,
  reminderInterval: user?.reminderInterval ?? 1,
  activityReminder: user?.activityReminder ?? false,
  quietStart: user?.quietStart ?? "22:00",
  quietEnd: user?.quietEnd ?? "06:00",

  dayStreak: user?.dayStreak ?? 0,
  avgDaily: user?.avgDaily ?? 0,
  todaySteps: user?.todaySteps ?? 0,
)
    );

    print("Berhasil update Firestore");

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Profil berhasil diperbarui"),
      ),
    );

    Navigator.pop(context);

  } catch (e) {
    print("ERROR: $e");
  }
}

Future<void> pickImage() async {
  final XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 70,
  );

  if (image == null) return;

  final imageUrl = await CloudinaryService().uploadImage(
    File(image.path),
  );

  if (imageUrl == null) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Upload foto gagal"),
      ),
    );
    return;
  }

  final uid = AuthService().currentUser!.uid;

  final updatedUser = UserModel(
  uid: uid,
  name: nameController.text,
  email: emailController.text,
  gender: gender,
  birthDate: birthDateController.text,
  weight: weightController.text,
  height: heightController.text,
  photoUrl: imageUrl,

  dailyWaterTarget: user?.dailyWaterTarget ?? 2000,
  dailyStepTarget: user?.dailyStepTarget ?? 10000,
  autoRecommendation: user?.autoRecommendation ?? true,

  hydrationReminder: user?.hydrationReminder ?? true,
  reminderInterval: user?.reminderInterval ?? 1,
  activityReminder: user?.activityReminder ?? false,
  quietStart: user?.quietStart ?? "22:00",
  quietEnd: user?.quietEnd ?? "06:00",

  dayStreak: user?.dayStreak ?? 0,
  avgDaily: user?.avgDaily ?? 0,
  todaySteps: user?.todaySteps ?? 0,
);

  await UserService().updateUser(updatedUser);

  setState(() {
    user = updatedUser;
  });

  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("Foto profil berhasil diperbarui"),
    ),
  );
}

Future<void> _showChangeEmailDialog() async {
  final controller = TextEditingController(
    text: emailController.text,
  );

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Ganti Email"),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: "Email Baru",
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
       ElevatedButton(
  onPressed: () async {
    final result = await AuthService().changeEmail(
      controller.text.trim(),
    );

    if (result == null) {
      emailController.text = controller.text.trim();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Link verifikasi telah dikirim ke email baru",
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
        ),
      );
    }
  },
  child: const Text("Simpan"),
)
      ],
    ),
  );
}


Future<void> _showChangePasswordDialog() async {
  oldPasswordController.clear();
  newPasswordController.clear();
  confirmPasswordController.clear();

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Ganti Password"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Lama",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Password Baru",
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Konfirmasi Password",
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Batal"),
        ),
        ElevatedButton(
          onPressed: () async {
            if (newPasswordController.text !=
                confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Konfirmasi password tidak sama"),
                ),
              );
              return;
            }

            final result = await AuthService().changePassword(
              currentPassword: oldPasswordController.text,
              newPassword: newPasswordController.text,
            );

            if (result == null) {
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Password berhasil diubah"),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result)),
              );
            }
          },
          child: const Text("Simpan"),
        ),
      ],
    ),
  );
}

@override
void dispose() {
  nameController.dispose();
  emailController.dispose();
  weightController.dispose();
  heightController.dispose();

  birthDateController.dispose();

  oldPasswordController.dispose();
  newPasswordController.dispose();
  confirmPasswordController.dispose();

  super.dispose();
}

@override
Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xffF8FAF9),

      appBar: AppBar(

        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),

        centerTitle: true,

        title: const Text(
          "Pengaturan akun",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(24),

        child: Column(

          children: [

            const SizedBox(height:20),

           //================ FOTO =================

Stack(
  children: [

    CircleAvatar(
      radius: 70,
      backgroundImage:
          (user != null && user!.photoUrl.isNotEmpty)
              ? NetworkImage(user!.photoUrl)
              : const AssetImage(
                  "assets/images/profile.jpg",
                ) as ImageProvider,
    ),

    Positioned(
      right: 0,
      bottom: 0,

      child: GestureDetector(
        onTap: pickImage,
        child: const CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xff4F7F5D),
          child: Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
      ),
    ),

  ],
),

const SizedBox(height:35),
            //================ INFORMASI =================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(30),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                    offset: const Offset(0,8),
                  ),

                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "INFORMASI PRIBADI",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height:30),
ProfileTextField(
  controller: nameController,
  label: "Nama Lengkap",
  hint: "Masukkan nama lengkap",
),

                  Row(
  children: [
    Expanded(
      child: ProfileTextField(
        controller: emailController,
        label: "Email",
        hint: "Email",
        readOnly: true,
        suffix: const Icon(Icons.lock_outline),
      ),
    ),
    const SizedBox(width: 12),
    SizedBox(
      height: 58,
      child: ElevatedButton(
        onPressed: _showChangeEmailDialog,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade300,
          elevation: 0,
        ),
        child: const Text(
          "Ubah",
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
      ),
    ),
  ],
),

const SizedBox(height: 20),

ListTile(
  contentPadding: EdgeInsets.zero,
  leading: const Icon(
    Icons.lock_outline,
    color: Color(0xff35694A),
  ),
  title: const Text("Password"),
  subtitle: const Text("••••••••"),
  trailing: ElevatedButton(
    onPressed: _showChangePasswordDialog,
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade300,
      elevation: 0,
    ),
    child: const Text(
      "Ubah",
      style: TextStyle(
        color: Colors.black87,
      ),
    ),
  ),
),

                ],
              ),
            ),

            const SizedBox(height:30),
                        //================ DATA FISIK =================

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(24),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.05),
                    blurRadius: 15,
                    offset: const Offset(0,8),
                  ),
                ],
              ),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    "DATA FISIK",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height:30),

                  DropdownButtonFormField<String>(
  value: gender.isEmpty ? null : gender,

  decoration: InputDecoration(
    labelText: "Jenis Kelamin",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),

  items: const [
    DropdownMenuItem(
      value: "Pria",
      child: Text("Pria"),
    ),
    DropdownMenuItem(
      value: "Wanita",
      child: Text("Wanita"),
    ),
  ],

  onChanged: (value) {
    setState(() {
      gender = value!;
    });
  },
),

                  const SizedBox(height:24),

                 TextField(
  controller: birthDateController,
  readOnly: true,
  onTap: () async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      birthDateController.text =
          "${picked.day}/${picked.month}/${picked.year}";
    }
  },
  decoration: InputDecoration(
    labelText: "Tanggal Lahir",
    suffixIcon: const Icon(
      Icons.calendar_month,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
  ),
),

                  const SizedBox(height:24),

                  ProfileTextField(
  controller: weightController,
  label: "Berat Badan (kg)",
  hint: "0",
),

                 ProfileTextField(
  controller: heightController,
  label: "Tinggi Badan (cm)",
  hint: "0",
),

                ],
              ),
            ),

            const SizedBox(height:30),
                        const SizedBox(height: 30),

Container(
  width: double.infinity,
  padding: const EdgeInsets.all(24),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 15,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Text(
        "KEAMANAN AKUN",
        style: TextStyle(
          color: Colors.grey.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),

      const SizedBox(height: 25),

      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(
          Icons.email_outlined,
          color: Color(0xff35694A),
        ),
        title: const Text("Email"),
        subtitle: Text(
          emailController.text,
        ),
        trailing: ElevatedButton(
          onPressed: () {
            _showChangeEmailDialog();
          },
          child: const Text("Ubah"),
        ),
      ),

      const Divider(),

      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: const Icon(
          Icons.lock_outline,
          color: Color(0xff35694A),
        ),
        title: const Text("Password"),
        subtitle: const Text("••••••••"),
        trailing: ElevatedButton(
          onPressed: () {
            _showChangePasswordDialog();
          },
          child: const Text("Ubah"),
        ),
      ),
    ],
  ),
),

const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(

                onPressed: saveProfile,

                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff35694A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  elevation: 4,
                ),

                

                child: const Text(
                  "Simpan Perubahan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

          ],
        ),
      ),
    );
  }
}