

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_notifications/notification_services.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  NotificationServices notificationServices = NotificationServices();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value){



      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
  }
  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Notifications'),
      ),
      body: Center(
        child: TextButton(
          onPressed: ()
           async {
             try {
               http.Response response = await http.post(
                 Uri.parse('https://fcm.googleapis.com/fcm/send'),
                 headers: <String, String>{
                   'Content-Type': 'application/json; charset=UTF-8',
                   'Authorization': 'key=AAAAz63pd9Q:APA91bGhsCGxwE1Edcg6eSS1St8tXo3w7M6iZOKJ3ANXieTvOn4MYzPDFKdzx6J8SC3SQs4ySTZj_b5o6vlcOYdZw7ODNuU-tZHjE3kNZ6Vf7F_g5L1Mvj7C8aIJtq2SRYUh6uHgQ_mr',
                 },
                 body: jsonEncode(
                     <String, dynamic>{
                       'notification': <String, dynamic>{
                         'body': "Mohamed",
                         'title': 'Incoming call',
                       },
                       'priority': 'high',
                       'data': <String, dynamic>{
                         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
                         'id': '1',
                         'status': 'done'
                       },
                       'to': " f253Tjx-RUGliyfxWfCpJX:APA91bFz4wMhNhSfBJhbfBbQHGuizV9nDZqQ1SZY6kEk9-O5PW2dBNfEvMhsoH_Mhf4_9q-BS6nVQD5pED7xN3LSC-0Lw2wEXJgHFWYOuShI6tc-FILTrC-OU0yqcXYaQnddQGUygD2y",

                     }),
               );
               response;
             } catch (e) {
               e;
             }



           } ,

            /*onPressed: (){

          // send notification from one device to another
          notificationServices.getDeviceToken().then((value)async{

            var data = {
              'to' : value.toString(),
              'notification' : {
                'title' : 'Asif' ,
                'body' : 'Subscribe to my channel' ,
                "sound": "jetsons_doorbell.mp3"
            },
              'android': {
                'notification': {
                  'notification_count': 23,
                },
              },
              'data' : {
                'type' : 'msj' ,

                'id' : 'Asif Taj'
              }
            };

            await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data) ,
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'key=AAAAPk38hHw:APA91bHVwPCb9Prlc2SlO_75vF-4T1EqJsfJhT69Bqtk-5YTStr3CN1QGJU-lu_sOWu4vfh0gXKIlmum2FXBSC_c6wksFWPMAVOuB1p0JEhmdLLsle1vcv-84ndzb-u9xxMzE_9-ii6A',
                *//* 'Authorization' : 'key=AAAAp9pXDFM:APA91bGhBeMCUABE2PXjl9UqodAZ2WdV_UI6PoiwdCzYaT8KeZmBKZszc01CD1GgN0OAJ1w3sNw9IVISyKhrrxQLASHizenGJUr2hjzoPjbjFu0HAx1CTk0l8Ut95ZENAQyRKm6hrltV'*//*
              }
            ).then((value){
              if (kDebugMode) {
                print(value.body.toString());
              }
            }).onError((error, stackTrace){
              if (kDebugMode) {
                print(error);
              }
            });
          });
        },*/
            child: Text('Send Notifications')),
      ),
    );
  }
}
