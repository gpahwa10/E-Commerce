import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/screens/message_screen/chat_screen.dart';
import 'package:amazon_seller/services/store_services.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "Messages", size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
          stream: StoreServices.getMessages(uid: currentUser!.uid),
          builder:
              ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      data.length,
                      (index) => ListTile(
                        onTap: () => Get.to(const ChatScreen()),
                        leading: const CircleAvatar(
                          backgroundColor: purpleColor,
                          child: Icon(
                            Icons.person,
                            color: white,
                          ),
                        ),
                        title: boldText(text: "${data[index]['sender_name']}", color: fontGrey),
                        subtitle:
                            normalText(text: "${data[index]['last_msg']}", color: darkGrey),
                        trailing: normalText(text: "Time", color: darkGrey),
                      ),
                    ),
                  ),
                ),
              );
            }
          })),
    );
  }
}
