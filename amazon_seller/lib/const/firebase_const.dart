import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;
User? currentUser = auth.currentUser;

//collections
const vendorsCollection = "vendors";
const productCollection = "products";
const messageCollection="messsages";
const chatCollection = "chats";
const orderCollection = "Orders";