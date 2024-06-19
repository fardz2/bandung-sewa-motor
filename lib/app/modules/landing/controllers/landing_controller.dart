import 'package:bandung_sewa_motor/app/helper/firestore_service.dart';
import 'package:bandung_sewa_motor/app/modules/profile_pelanggan/controllers/profile_pelanggan_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../../../helper/auth_service.dart';
import '../../home/controllers/home_controller.dart';
import '../../pesanan/controllers/pesanan_controller.dart';

class LandingController extends GetxController {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final firestoreService = Get.put(FirestoreService());
  final authService = Get.put(AuthService());

  String? pesananId = "";
  String? userId = "";
  int notificationId = 0;

  var tabIndex = 0.obs;
  String? mToken = "";

  getPesananDetail() {
    return firestoreService.getPesananById(pesananId!).then((value) {
      userId = value.userID;
    });
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mToken = token;
      saveToken(token!);
    });
  }

  void saveToken(String token) async {
    await firestoreService.updateUserToken(authService.user.value!.uid, token);
  }

  void initializeLocalNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
        'channel_id_5', 'bandung_sewa_motor',
        importance: Importance.max, priority: Priority.high, playSound: true);

    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      notificationId++,
      title,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(HomeController());
    Get.put(ProfilePelangganController());
    Get.put(PesananController());

    requestPermission();
    getToken();
    initializeLocalNotifications();
  }

  @override
  void onReady() {
    changeTabIndex(0);
    super.onReady();
    FirebaseMessaging.instance.subscribeToTopic(authService.user.value!.uid);
    String? currentUserId = authService.user.value?.uid;
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data['user_id'] == currentUserId) {
        showNotification(
            message.notification!.title!, message.notification!.body!);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data['user_id'] == currentUserId) {
        showNotification(
            message.notification!.title!, message.notification!.body!);
      }
    });
  }

  @override
  void onClose() {
    Get.delete<HomeController>();
    Get.delete<ProfilePelangganController>();
    Get.delete<PesananController>();
    super.onClose();
  }
}
