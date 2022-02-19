import 'package:cadevo/constants/firebase.dart';
import 'package:cadevo/helpers/showLoading.dart';
import 'package:cadevo/models/user.dart';
import 'package:cadevo/screens/authentication/auth.dart';
import 'package:cadevo/screens/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class automatically extends GetxController {
   //comment 1 : here call our AuthController that created in constants/controllers.dart
  static automatically instance = Get.find();
    //comment 2 : define 3 TextEditingController for our TexFields
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String userCollection = "users";
  String _userId;
    //comment 3 : here define isLoggedIn for if user not login , check it at first else got to home screen without authentication screen 
  RxBool isLoggedIn = false.obs;
    //comment 4 : create instance of userModel here as userModel
  Rx<UserModel> userModel = UserModel().obs;
    //comment 5 :  create instance of userModel here as firebaseUser
  Rx<User> firebaseUser;

  @override
   //comment 6 : onReady is like inState(){}
  void onReady() {
    super.onReady();
     //comment 7 : it's check auth of user that open the app
    firebaseUser = Rx<User>(auth.currentUser);
     //comment 8 :bind status of auth of user to app
    firebaseUser.bindStream(auth.userChanges());
     //comment 9 :ever() : this method call every time that any changes happen till it's return true and for second arguments execution any function
    ever(firebaseUser, _setInitialScreen);
    debugPrint(ever(firebaseUser, _setInitialScreen).toString());
  }
//comment 10 : it's check user has login account or not
  _setInitialScreen(User user) {
    if (user == null) {
      Get.offAll(() => AuthenticationScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }
//comment 10 : build 3 functions : sign in,sign up,sign out and bind them later to each button that's need
  void signIn() async {
    ShowLoading();
    //comment 11 : it's logic for login user that get username and password from user to login
    //and after execute important functions at .then()
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
            //comment 12 : before user can be login first check id of user that stored in firebase :(uid)
        _userId = result.user.uid;
        ////comment 13 : if _userId was in firebase then execute these functions else show error
        _initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      dismissLoadingWidget();
      debugPrint(e.toString());
      Get.snackbar('Signing Failed', 'Try again');
    }
  }
//comment 14 : signUp function is exactly similar sign in
  void signUp() async {
    ShowLoading();
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) {
            //comment 15 : create _addToFirestore to add this undefined _userId as new user and add it to firebase
        _userId = result.user.uid;
        _addToFirestore(_userId);
        _initializeUserModel(_userId);
        _clearControllers();
      });
    } catch (e) {
      dismissLoadingWidget();
      debugPrint(e.toString());
      Get.snackbar('Signing up Failed', 'Try again');
    }
  }

  void signOut() async {
    await auth.signOut();
  }
//comment 16 : here create new user function that get userId
//and pass that to collection , collection is to get keys of firebase map inside firebase automatically 
//users insert in "users" key that I call it in line 17 and put in userCollection
//after that call doc() method and set() new user data to our firebase
  _addToFirestore(String userId) {
    firebaseFirestore.collection(userCollection).doc(userId).set({
      "name": name.text.trim(),
      "id": userId,
      "email": email.text.trim(),
     
    });
  }
//comment 17 : for each login after sign up
//get userId and get that id user data if there is in firebase
  _initializeUserModel(String userId) async {
    userModel.value = await firebaseFirestore
        .collection(userCollection)
        .doc(userId)
        .get()
        //comment 18 : fromSnapshot() put automatically data that get from firebase to our model properties
        // and we dont need to bind them to each property manually knowledge
        .then((doc) => UserModel.fromSnapshot(doc));
  }

  _clearControllers() {
    password.clear();
    name.clear();
    email.clear();
  }
}
