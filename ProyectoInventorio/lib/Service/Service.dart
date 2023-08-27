import 'package:invetariopersonal/Imports/import.dart';

class Start extends GetxService {
  checkuser() async {
    var inst = FirebaseAuth.instance;
    var userID = inst.currentUser?.uid;
    print(userID);
    if (userID?.isEmpty == false) {
      prefs?.setString("id", userID!);
      // Prefs?.setString(),
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkuser();
  }
}
