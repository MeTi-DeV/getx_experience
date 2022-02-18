import 'package:cadevo/models/device.dart';
import 'package:cadevo/screens/home/widgets/devices_draggable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppController extends GetxController{
  static AppController instance = Get.find();
  Rx<Widget> activeDraggableWidget = Rx<Widget>(DevicesDraggable());
  Rx<DeviceModel> activeDevie = DeviceModel().obs;
  RxBool isLoginWidgetDisplayed = false.obs;

//comment : it's like setState while user choose an button our state changes between Signin and craeet accout screen
  changeDIsplayedAuthWidget(){
    isLoginWidgetDisplayed.value = !isLoginWidgetDisplayed.value;
  }
//comment : it's changer content of device that choose and replace it content to the previous content
  changeActiveDeviceTo(DeviceModel device){
    activeDevie.value = device;
  }
//comment : it's make list of devices clickable and route to widget of device that chosen
  changeActiveDraggableWidgetTo(Widget widget){
    activeDraggableWidget.value = widget;
  }
}