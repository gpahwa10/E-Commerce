import 'package:amazon_clone/consts/consts.dart';

Widget loadingIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(redColor),
    ),
  );
}
