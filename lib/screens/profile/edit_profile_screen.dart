import 'package:flutter/material.dart';

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

String gender = "";
String birthDate = "";

UserModel? user;

@override
void initState() {
  super.initState();
  loadUser();
}

Future<void> loadUser() async {
  final uid = AuthService().currentUser!.uid;

  print("UID LOGIN = $uid");

  final data = await UserService()
      .getUser(uid)
      .first;

  user = data;

  nameController.text = data.name;
  emailController.text = data.email;
  weightController.text = data.weight;
  heightController.text = data.height;
  birthDateController.text = data.birthDate;

  setState(() {
    gender = data.gender;
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
      ),
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

                const CircleAvatar(
                  radius: 70,
                  backgroundImage:
                      AssetImage(
                    "assets/images/profile.jpg",
                  ),
                ),

                Positioned(

                  right: 0,
                  bottom: 0,

                  child: CircleAvatar(

                    radius: 22,
                    backgroundColor:
                        const Color(0xff4F7F5D),

                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
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
                      const SizedBox(width:12),

                      SizedBox(

                        height:58,

                        child: ElevatedButton(

                          onPressed: () {},

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.grey.shade300,
                            elevation:0,
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
                        //================ UBAH PASSWORD =================

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
                    "UBAH PASSWORD",
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),

                  const SizedBox(height: 30),

                  ProfileTextField(
  controller: oldPasswordController,
  label: "Kata Sandi Lama",
  hint: "••••••••",
),

                  ProfileTextField(
  controller: newPasswordController,
  label: "Kata Sandi Baru",
  hint: "••••••••",
),

                  ProfileTextField(
  controller: confirmPasswordController,
  label: "Konfirmasi Kata Sandi Baru",
  hint: "••••••••",
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