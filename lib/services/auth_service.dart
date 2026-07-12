import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // ================= REGISTER =================
  Future<String?> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      await userCredential.user?.updateDisplayName(name.trim());
      await userCredential.user?.reload();

      await UserService().createUser(
        UserModel(
    uid: userCredential.user!.uid,
    name: name.trim(),
    email: email.trim(),
    gender: "",
    birthDate: "",
    weight: "",
    height: "",
    photoUrl: "",
  ),
);

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          return 'Email sudah digunakan';

        case 'invalid-email':
          return 'Format email tidak valid';

        case 'weak-password':
          return 'Password minimal 6 karakter';

        case 'operation-not-allowed':
          return 'Email/Password belum diaktifkan di Firebase';

        default:
          return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

  // ================= LOGIN =================
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Email tidak ditemukan';

        case 'wrong-password':
          return 'Password salah';

        case 'invalid-email':
          return 'Format email tidak valid';

        case 'invalid-credential':
          return 'Email atau password salah';

        default:
          return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }

 // ================= LOGIN GOOGLE =================
Future<String?> signInWithGoogle() async {
  try {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    await googleSignIn.signOut();

    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn();

    if (googleUser == null) {
      return "Login dibatalkan";
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    final user = userCredential.user!;

    if (!await UserService().userExists(user.uid)) {
      await UserService().createUser(
        UserModel(
          uid: user.uid,
          name: user.displayName ?? "",
          email: user.email ?? "",
          gender: "",
          birthDate: "",
          weight: "",
          height: "",
          photoUrl: user.photoURL ?? "",
        ),
      );
    }

    return null;
  } on FirebaseAuthException catch (e) {
    return e.message;
  } catch (e) {
    return e.toString();
  }
}
  // ================= RESET PASSWORD =================
  Future<String?> resetPassword({
    required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email.trim(),
      );

      return null;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'Email tidak terdaftar';

        case 'invalid-email':
          return 'Format email tidak valid';

        case 'missing-email':
          return 'Masukkan alamat email';

        default:
          return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }


Future<String?> changeEmail(String newEmail) async {
  try {
    final user = _auth.currentUser!;

    await user.verifyBeforeUpdateEmail(
      newEmail.trim(),
    );

    return null;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "email-already-in-use":
        return "Email sudah digunakan";

      case "invalid-email":
        return "Format email tidak valid";

      case "requires-recent-login":
        return "Silakan login ulang terlebih dahulu";

      default:
        return e.message ?? "Terjadi kesalahan";
    }
  } catch (e) {
    return e.toString();
  }
}
Future<String?> changePassword({
  required String currentPassword,
  required String newPassword,
}) async {
  try {
    final user = _auth.currentUser!;

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(
      credential,
    );

    await user.updatePassword(
      newPassword,
    );

    return null;
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "wrong-password":
      case "invalid-credential":
        return "Password lama salah";

      case "weak-password":
        return "Password minimal 6 karakter";

      case "requires-recent-login":
        return "Silakan login ulang";

      default:
        return e.message;
    }
  } catch (e) {
    return e.toString();
  }
}

  // ================= LOGOUT =================
 Future<void> logout() async {
  await GoogleSignIn().signOut();
  await _auth.signOut();
}

  // ================= CURRENT USER =================
  User? get currentUser => _auth.currentUser;
}