import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/chat_controller.dart';
import 'package:amazon_clone/screens/chat_screen/components/message_bubble.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "User".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(
              () => controller.isLoading.value
                  ? loadingIndicator()
                  : Expanded(
                      child: StreamBuilder(
                        stream: FirestoreServices.getChatMessages(
                            controller.chatDocID.toString()),
                        builder: ((BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else if (snapshot.data!.docs.isEmpty) {
                            return Center(
                                child: "Send a message"
                                    .text
                                    .color(darkFontGrey)
                                    .make());
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {

                                    var data = snapshot.data!.docs[index];

                                return Align(alignment: data['uid'] == currentUser!.uid? Alignment.centerRight:Alignment.centerLeft,child: messageBubble(data));
                              }).toList(),
                            );
                          }
                        }),
                      ),
                    ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                  ),
                )),
                IconButton(
                  onPressed: () {
                    controller.sendMessage(controller.msgController.text);
                    controller.msgController.clear();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ),
                )
              ],
            )
                .box
                .height(70)
                .margin(const EdgeInsets.only(bottom: 8))
                .padding(const EdgeInsets.all(12))
                .make()
          ],
        ),
      ),
    );
  }
}
