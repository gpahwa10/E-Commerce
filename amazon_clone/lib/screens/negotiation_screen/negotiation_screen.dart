import 'package:amazon_clone/consts/consts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class NegotiationScreen extends StatefulWidget {
  const NegotiationScreen({Key? key}) : super(key: key);

  @override
  State<NegotiationScreen> createState() => _NegotiationScreenState();
}

class _NegotiationScreenState extends State<NegotiationScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  final String productName = Get.arguments[0];
  final double productPrice = double.parse(Get.arguments[1].toString());
  final String productImage = Get.arguments[2];

  // Gemini model and chat session
  late GenerativeModel _model;
  late ChatSession _chatSession;
  bool _isLoading = false;

  // API key - Replace with your actual API key
  static const String _apiKey = "AIzaSyBGer25QfrwAwgJlJxNZzySd_Dnt7b1ioU";

  @override
  void initState() {
    super.initState();
    _initGeminiChat();
  }

  void _initGeminiChat() {
    try {
      // Initialize the Gemini model
      _model = GenerativeModel(
        model: 'gemini-1.5-pro', // Updated model name, use 'gemini-1.5-pro' or 'gemini-1.5-flash'
        apiKey: _apiKey,
      );

      // Create a chat session with initial system prompt
      _chatSession = _model.startChat(
        history: [
          Content.multi([
            TextPart('''You are an AI negotiation assistant for an e-commerce platform. 
Your role is to negotiate product prices with customers.

Product: $productName
Base Price: ₹${productPrice.toStringAsFixed(2)}

Guidelines:
1. You can offer up to 30% discount from the base price, but try to maximize profit.
2. Start with a friendly greeting and ask what price they'd like to offer.
3. Be polite but firm in negotiations.
4. If they offer a reasonable price (less than 20% discount), accept quickly.
5. If they offer a moderate discount (20-30%), negotiate a bit before accepting.
6. If they offer too low (more than 30% discount), counter-offer with the maximum 30% discount.
7. Keep responses concise and focused on the negotiation.
8. Use Indian Rupee (₹) symbol for all prices.
9. After agreeing on a price, ask if they want to add the item to their cart.

Remember, your goal is to close the sale while maintaining a good customer relationship.'''),
          ]),
          Content.multi([
            TextPart('''Hello! I'm your negotiation assistant for $productName. The current price is ₹${productPrice.toStringAsFixed(2)}. What price would you like to offer?'''),
          ]),
        ],
      );

      // Add initial AI message to the chat
      _addMessage(
        "Hello! I'm your negotiation assistant for $productName. The current price is ₹${productPrice.toStringAsFixed(2)}. What price would you like to offer?",
        false,
      );
    } catch (e) {
      print('Error initializing Gemini: $e');
      _addMessage(
        "Hello! I'm your negotiation assistant. What price would you like to offer for $productName?",
        false,
      );
    }
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = _messageController.text;
    _addMessage(userMessage, true);
    _messageController.clear();

    // Call Gemini API for response
    _getGeminiResponse(userMessage);
  }

  Future<void> _getGeminiResponse(String userMessage) async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Send user message to Gemini
      final response = await _chatSession.sendMessage(
        Content.text(userMessage), // Use Content.text for user input
      );

      // Get AI response text
      final responseText = response.text;

      if (responseText != null) {
        _addMessage(responseText, false);
      } else {
        _addMessage("I'm sorry, I couldn't process your request. Please try again.", false);
      }
    } catch (e) {
      print('Error getting Gemini response: $e');
      _addMessage("I'm sorry, there was an error processing your request. Please try again later.", false);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _addMessage(String message, bool isUser) {
    setState(() {
      _messages.add(ChatMessage(
        text: message,
        isUser: isUser,
        time: DateTime.now(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Negotiate Price".text.fontFamily(semibold).make(),
            5.heightBox,
            productName.text.size(14).make(),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CircleAvatar(
              backgroundColor: Colors.green.withOpacity(0.1),
              child: const Icon(Icons.handshake_outlined, color: Colors.green),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Product info card
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: lightGrey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Image.network(
                  productImage,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ).box.roundedSM.clip(Clip.antiAlias).make(),
                10.widthBox,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    productName.text.fontFamily(semibold).make(),
                    5.heightBox,
                    "Current Price: ₹${productPrice.toStringAsFixed(2)}"
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .make(),
                  ],
                ),
              ],
            ),
          ),

          // Chat messages
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  reverse: false,
                  itemCount: _messages.length,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemBuilder: (context, index) {
                    return MessageBubble(
                      message: _messages[index],
                    );
                  },
                ),

                // Loading indicator
                if (_isLoading)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(
                            color: Colors.green,
                            strokeWidth: 2,
                          ),
                          10.widthBox,
                          "AI is thinking...".text.color(darkFontGrey).make(),
                        ],
                      ).box.color(Colors.white.withOpacity(0.8)).rounded.padding(const EdgeInsets.all(8)).make(),
                    ),
                  ),
              ],
            ),
          ),

          // Message input
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Enter your offer...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: textfieldGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: Colors.green),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onSubmitted: (_) => _handleSendMessage(),
                    enabled: !_isLoading,
                  ),
                ),
                IconButton(
                  onPressed: _isLoading ? null : _handleSendMessage,
                  icon: Icon(
                    Icons.send,
                    color: _isLoading ? Colors.grey : Colors.green,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime time;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.time,
  });
}

class MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const MessageBubble({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.green : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                color: message.isUser ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('hh:mm a').format(message.time),
              style: TextStyle(
                color: message.isUser ? Colors.white.withOpacity(0.7) : Colors.black54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}