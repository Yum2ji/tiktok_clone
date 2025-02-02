import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/inbox/chat_detail_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  final List<int> _items = [];
  final Duration _duration = const Duration(milliseconds: 300);

  void _addItem() {
    // 해당 key 값은 animationlist 부분 build 안에서 key로 매핑
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        duration: _duration,
      );
      _items.add(_items.length);
    }
  }

  void _deleteItem(index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,

        //removeiteme 할때는 아래내용이 build
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: Container(
            color: Colors.red,
            child: _makeTile(index),
          ),
        ),

        duration: _duration,
      );
      _items.removeAt(index);
    }
  }

  void _onChatTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChatDetailScreen(),
      ),
    );
  }

  Widget _makeTile(int index) {
    return ListTile(
      onLongPress: () => _deleteItem(index),
      onTap: _onChatTap,
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage(
          "https://i.ytimg.com/vi/LYKTtPFB9b4/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBHxhTHbXz0HzU6pp4GLK-98XPQnw",
        ),
        child: Text("유미"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Yumi($index)",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size18,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              fontSize: Sizes.size14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
      subtitle: const Text(
        "Hi HI Hi dont'forget",
        style: TextStyle(
          fontSize: Sizes.size16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        shadowColor: Colors.white,
        title: const Text(
          "Direct Messages",
        ),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(FontAwesomeIcons.plus),
          )
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        initialItemCount: 0,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            key: UniqueKey(),
            //key가 여러곳에 쓰여서 헷갈리지않게라고 하는데.. 이 개념이 약간 헷갈림.
            //AnimatedList -ListTile로만 구성될 때는 ListTIle안에 설정
            // FadeTransition이 생기면서 FadeTransition으로 설정함
            opacity: animation,
            child: ScaleTransition(
              scale: animation,
              child: SizeTransition(
                  sizeFactor: animation, child: _makeTile(index)),
            ),
          );
        },
      ),
    );
  }
}
