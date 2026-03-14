import 'package:chat_app/constans.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
    required this.isDarkMode,
    required this.isMy,
  });

  final Message message;
  final bool isMy;
  final bool isDarkMode;
  @override
  Widget build(BuildContext context) {
    Offset onTap = Offset.zero;
    String time = message.createdAT != null
        ? DateFormat('hh:mm a').format(message.createdAT!.toDate())
        : '';
    return GestureDetector(
      onTapDown: (details) => onTap = details.globalPosition,
      onLongPress: () => _showMenu(context, onTap),
      child: Align(
        alignment: isMy ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 232, 234, 237),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: isMy ? Radius.circular(20) : Radius.zero,
              bottomLeft: isMy ? Radius.zero : Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: isMy? CrossAxisAlignment.start:CrossAxisAlignment.end,
            children: [ 
              Text(message.message, style: TextStyle(color: Color(0xff2D3243))),
              SizedBox(height: 4),
              Text(time,
     
              style: TextStyle(
                
                fontSize: 13,
                color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context, Offset tapPosition) {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject()
            as RenderBox; // difind size screen

    showMenu(
      context: context,
      color: isDarkMode ? Color(0xff3D3F50) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      position: RelativeRect.fromRect(
        tapPosition & Size(40, 40),
        Offset.zero & overlay.size,
      ),

      items: [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit')
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text("Delete",style: TextStyle(color: Colors.red),)
        ),
      ],
    ).then((value) {
      if (value == 'delete') {
        FirebaseFirestore.instance
            .collection(KMessagesCollections)
            .doc(message.idDoc)
            .delete();
      }
    });
  }
}

// class ChatBubleForFrind extends StatelessWidget {
//   const ChatBubleForFrind({super.key, required this.message});

//   final Message message;
//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         margin: EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: Color.fromARGB(255, 232, 234, 237),
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(15),
//             topRight: Radius.circular(15),
//             bottomLeft: Radius.circular(15),
//           ),
//         ),
//         child: Text(
//           message.message,
//           style: TextStyle(color: Color(0xff2D3243)),
//         ),
//       ),
//     );
//   }
// }
