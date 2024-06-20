import 'package:bandung_sewa_motor/app/modules/pesanan_admin/controllers/pesanan_admin_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../../helper/auth_service.dart';
import '../../home_admin/controllers/home_admin_controller.dart';
import '../../profile_admin/controllers/profile_admin_controller.dart';

class LandingAdminController extends GetxController {
  final authService = Get.put(AuthService());

  var tabIndex = 0.obs;
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  int notificationId = 0;

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

  void initializeLocalNotifications() {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_logo');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
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
    Get.put(HomeAdminController());
    Get.put(ProfileAdminController());
    Get.put(PesananAdminController());

    requestPermission();
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
    Get.delete<HomeAdminController>();

    Get.delete<ProfileAdminController>();

    Get.delete<PesananAdminController>();

    super.onClose();
  }
}
