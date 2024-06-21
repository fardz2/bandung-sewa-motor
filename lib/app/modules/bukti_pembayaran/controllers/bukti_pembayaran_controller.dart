import 'dart:convert';
import 'dart:io';

import 'package:bandung_sewa_motor/app/models/pembayaran_model.dart';
import 'package:bandung_sewa_motor/app/modules/detail_pembayaran/controllers/detail_pembayaran_controller.dart';
import 'package:bandung_sewa_motor/app/modules/metode_bayar/controllers/metode_bayar_controller.dart';
import 'package:bandung_sewa_motor/app/modules/sewamotor/controllers/sewamotor_controller.dart';
import 'package:bandung_sewa_motor/app/routes/app_pages.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bandung_sewa_motor/app/helper/auth_service.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:image_picker/image_picker.dart';

import '../../../helper/firestore_service.dart';

class BuktiPembayaranController extends GetxController {
  var pesananID = "".obs;
  var motorID = "".obs;

  var totalHarga = 0.obs;
  var ongkir = 0.obs;
  var totalPembayaran = 0.obs;
  var jumlah = 0.obs;
  final isLoading = false.obs;
  final clipboardController = TextEditingController();

  final authService = Get.put(AuthService());
  final firestoreService = Get.put(FirestoreService());

  getDetailPesanan() async {
    firestoreService.getPesananByIdStream(pesananID.value).listen((event) {
      totalHarga.value =
          event.rincianHarga['totalHarga'] - event.rincianHarga['ongkir'];
      ongkir.value = event.rincianHarga['ongkir'];
      motorID.value = event.motorID;
      totalPembayaran.value = event.rincianHarga['totalHarga'];
    });
  }

  getDetailMotor() async {
    firestoreService.getDetailMotor(motorID.value).listen((even) {
      jumlah.value = even.jumlah;
    });
  }

  final buktiPembayaran = XFile("").obs;
  // untuk mengambil gambar
  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;
    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }
    if (pickedFile != null) {
      buktiPembayaran.value = pickedFile;
    }
  }

  // untuk mengupload gambar ke firebase storage
  Future<String> uploadFile(File image) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('BuktiPembayaran/${image.path}');
    await storageReference.putFile(image);
    String returnURL = "";
    await storageReference.getDownloadURL().then(
      (fileURL) {
        returnURL = fileURL;
      },
    );
    return returnURL;
  }

  void submit() async {
    isLoading.value = true;
    if (buktiPembayaran.value.path == "") {
      Get.snackbar(
        "Peringatan",
        "Gambar pembayaran belum dipilih",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } else {
      await getDetailMotor();
      String url = await uploadFile(File(buktiPembayaran.value.path));

      String pembayaranID = await firestoreService.addPembayaran(
          PembayaranModel(
              pembayaranID: "",
              rentalID: pesananID.value,
              userID: authService.user.value!.uid,
              totalHarga: totalPembayaran.value,
              buktiPembayaran: url,
              metode: "transfer",
              status: "pending"));
      await firestoreService.updatePesananPembayaran(
        pesananID.value,
        pembayaranID,
      );

      await firestoreService.updateMotorJumlah(motorID.value, jumlah.value - 1,
          jumlah.value - 1 == 0 ? "Tidak Tersedia" : "Tersedia");
      Get.snackbar(
        "Sukses",
        "Pesanan telah dibuat",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      buktiPembayaran.value = XFile("");

      sendPushNotification("Pesanan Baru Masuk",
          "Nomor pesanan $pesananID, pembayaran Transfer");

      Get.offNamedUntil(
        Routes.LANDING,
        ModalRoute.withName(Routes.LANDING),
      );
    }
    isLoading.value = false;
  }

  void sendPushNotification(String title, String body) async {
    try {
      var jsonKey = ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "private_key_id": "7fb2d0319ec3fd4cc2c9076b6bddef7cb6be43af",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDUj9U4O2WWVGWu\nz+POHPzlJNyM36+ve2AEtGEZ08yT0fmZJAfk8qfws6j+poHsNjOpYM0BzVNfGpaa\nZEyodVOeWPN06788YuGHCei7Yw5wnLZjdWeT2HfOSv9G3aEo4biOz3wbPjz8GNnE\niB7L1kYeZ5qIeGNxQ6luGdUVVa0VEGpqLibrTzmoXUp2mDDnj7Y0+atsy3jV9YXe\n+7gftprRpK3BVC9xSYinCwCFQLasRB/wJo7hsUOhSsIjzNiFlB5Y3RXhg5ESWHdx\nMCp7USvxszzR1iBqiWvjZk1YKwxmZ2c6lsPJHW4e5Ouh5O9aOWcfdReLSImHomAk\neLWRErzZAgMBAAECggEAHqbRFedGymtIMHGtBXtbooVywmO9N15gpb0HJYzLuuM0\nDXfLJaIyQnz92R7UrGXShFG/rktYAuZYIlJlVYN5t+NW1Bzsuj3+DJWKuH7bxbRr\nfqMe+QxlllttPWBXTYhjL0DPQjRy4d2JhZQlcLpo6RiCibxmhp49r/FMr2Nn7pno\nn0aKrWoG5nXR63Qr+RIC6jqFOn3fhVewhqU1NhRnSldyw9aUQMk63Dz5ba8mpMHD\nWRs2PBqWbkjHxN/Vja0vwwxYL7mWGXlgL7Z8NgjZsjAs44dzVC8KFzR0NUu4mtdv\nBuVot72igJnnDV4r459asa5OUT4L28Y9Zw7goB23CQKBgQDqmhGtEt3EVnp3gGTE\nBHIPnZu2DWUBbSS9vm+gfablrTX4gCPS8870OjSwAdNGH4mg3oumIPWKZN3tjsY7\nCuvE6PCBgMIK6xHMjj6ONXdCfhvSuUOHSHQ9Za14awUvIdKsQkfV89RSIxMW+hlY\nOSTrsIWzhCxR2NFwQVme5HiQ3QKBgQDn8yHas5/WvnpYz+wd52/Wcz8JwaXFnyY/\n49JueJXyv523nfweXcWtwPcL5NXsudjRsTj5l+b0tlu8cSvgmqtz4f2xdKGsNg2y\nLzhsACabVzu3vVs/JDZ3SOzfApOrmXLAWgSwm+qF7xqq5CR19wS8M3ZYg4uFf959\ndQ2gA17+LQKBgD42GwfdX+en0xQLfS0pzKFtdxRA2w8UxVB3xpw1leOEGjLKsDVJ\nqBDFuqEN6tvGkzWQrlGgndxUQTG00cZob/sollaRMWO50F+BPP9zGCwOywwHSuv9\n/60kYGr1XkuQWZCKhwgqf5xEZtSJ/9yQUsUZa2seWq5do7Rz7/MdvQcVAoGAJsoy\nTzDa+j7AlzmucxHRUjvTvv3ziykibGzdNDxWV1JUPfDdyPZFqNksd4C9helOqULK\nFHOi3CnjDZCfleBH7AlPM+4dW39uqu3asbUUv8XG5uNz7wtPUIORmXoE2B3BYwmq\n3x40ClICU7Hzpwa4dADnOcZF/v1zZ+e7b5cgu8ECgYBQwbOpRyHpr+wPAiRvsYFG\nJb6RTSbp8CF2XnnAtM5WQMtMVeQh8bwx//Wa3MOkli+74LdWnLFrHsBrkj2UHHfR\nXPe5YeR9n69NpCz4mMZQGBfZHlto2aUdkEWWq0pNAHlIxyS37aJTG5yiu6ugK7jD\nFylvmqupa5aSEE9h04TAQg==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-2yqlf@bandung-sewa-motor.iam.gserviceaccount.com",
        "client_id": "100277015050098278978",
      });
      var scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      var client = await clientViaServiceAccount(jsonKey, scopes);

      var response = await client.post(
        Uri.parse(
            'https://fcm.googleapis.com/v1/projects/bandung-sewa-motor/messages:send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, dynamic>{
            'message': <String, dynamic>{
              'topic': "Jzhb1Nf67CNiwKsGB02TnT1ju3Z2",
              'notification': <String, dynamic>{
                'title': title,
                'body': body,
              },
              'data': <String, dynamic>{
                'user_id': "Jzhb1Nf67CNiwKsGB02TnT1ju3Z2",
              },
              'android': <String, dynamic>{
                'priority': 'high',
                'notification': <String, dynamic>{
                  'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                  'channel_id': 'channel_id_5',
                },
              },
            },
          },
        ),
      );
      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print(
            'Failed to send notification. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  @override
  void onInit() {
    pesananID.value = Get.arguments;

    getDetailPesanan();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    Get.delete<SewamotorController>();
    Get.delete<MetodeBayarController>();
    Get.delete<DetailPembayaranController>();
    super.onClose();
  }
}
