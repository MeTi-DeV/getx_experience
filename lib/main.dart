import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //comment 1 : it's first of GetX if you want use flutter without context you can use GetMaterialApp
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        // backgroundColor: Colors.blueGrey,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: () {
                  Get.snackbar(
                    'Message',
                    'it\'s SnackBar',
                    isDismissible: true,
                    dismissDirection: DismissDirection.endToStart,
                    snackPosition: SnackPosition.BOTTOM,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                },
                child: Text('Show Snack Bar'),
              ),
              RaisedButton(
                onPressed: () {
                  Get.defaultDialog(
                    
                    onConfirm: (){},
                    radius: 10,
                      cancel: Text('Cancel',style: TextStyle(color: Colors.red),),
                      confirm: Text('Confirm',style: TextStyle(color: Colors.blue),),
                      title: 'Awsome GetX',
                      content: Text('It\'s my Awsome GetX'));
                },
                child: Text('Show Dialog'),
              ),
              RaisedButton(
                onPressed: () {
                  Get.bottomSheet(
                    
                    Wrap(
                      children: [
                        ListTile( leading: Icon(Icons.wb_sunny,color: Colors.grey),trailing: Text('Light mode',style: TextStyle(color: Colors.grey),),onTap: ()=>{Get.changeTheme(ThemeData.light())},),
                        ListTile(leading: Icon(Icons.wb_sunny_outlined,color: Colors.grey),trailing: Text('Dark mode',style: TextStyle(color: Colors.grey)),onTap: ()=>{Get.changeTheme(ThemeData.dark())},),
                      ],
                    ),
                    barrierColor: Colors.transparent,
                    
                  );
                },
                child: Text('Bottom Sheet'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
