import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  @override
  void onInit() {
    getChatID();
    super.onInit();
  }

  var chats = firestore.collection(chatCollection);

  var friendName = Get.arguments[0];
  var friendID = Get.arguments[1];

  var senderName = Get.find<HomeController>().username;
  var currentID = currentUser!.uid;

  var msgController = TextEditingController();

  var isLoading = false.obs;

  dynamic chatDocID;

  getChatID() async {
    isLoading(true);
    await chats
        .where('users', isEqualTo: {friendID: null, currentID: null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) {
          if (snapshot.docs.isNotEmpty) {
            chatDocID = snapshot.docs.single.id;
          } else {
            chats.add({
              'created_on': null,
              'last_msg': '',
              'users': {friendID: null, currentID: null},
              'toID': '',
              'fromID': '',
              'friend_name': friendName,
              'sender_name': senderName
            }).then((value) {
              chatDocID = value.id;
            });
          }
        });
    isLoading(false);
  }

  sendMessage(String msg) async {
    if (msg.trim().isNotEmpty) {
      chats.doc(chatDocID).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toID': friendID,
        'fromID': currentID
      });

      chats.doc(chatDocID).collection(messageCollection).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': currentID
      });
    }
  }
}
