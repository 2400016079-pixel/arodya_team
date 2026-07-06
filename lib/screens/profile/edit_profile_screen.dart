import 'package:flutter/material.dart';

import '../../widgets/profile_textfield.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

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

                  const ProfileTextField(
                    label: "Nama Lengkap",
                    hint: "Aria Chen",
                  ),

                  Row(

                    children: [

                      const Expanded(

                        child: ProfileTextField(
                          label: "Email",
                          hint:
                              "aria.chen@example.com",
                          readOnly: true,
                          suffix: Icon(
                            Icons.lock_outline,
                          ),
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
                    value: "Wanita",

                    decoration: InputDecoration(
                      labelText: "Jenis Kelamin",
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(18),
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

                    onChanged: (value) {},
                  ),

                  const SizedBox(height:24),

                  TextField(
                    decoration: InputDecoration(
                      labelText: "Tanggal Lahir",
                      hintText: "05/14/1992",
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  const SizedBox(height:24),

                  const ProfileTextField(
                    label: "Berat Badan (kg)",
                    hint: "62",
                  ),

                  const ProfileTextField(
                    label: "Tinggi Badan (cm)",
                    hint: "168",
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

                  const ProfileTextField(
                    label: "Kata Sandi Lama",
                    hint: "••••••••",
                  ),

                  const ProfileTextField(
                    label: "Kata Sandi Baru",
                    hint: "••••••••",
                  ),

                  const ProfileTextField(
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

                onPressed: () {},

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