
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatlyApp());
}

const Color primaryColor = Color(0xFF1769FF);
const Color bgColor = Color(0xFFF5F7FC);

class ChatlyApp extends StatelessWidget {
  const ChatlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'شاتلي',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class ChatUser {
  final String name;
  final String message;
  final String time;
  final String avatar;
  final int unread;
  final bool online;

  const ChatUser({
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unread = 0,
    this.online = false,
  });
}

final List<ChatUser> users = [
  ChatUser(
    name: 'أحمد محمد',
    message: 'شلونك حبيبي؟',
    time: 'الآن',
    avatar: 'أ',
    unread: 2,
    online: true,
  ),
  ChatUser(
    name: 'علي حسن',
    message: 'وصلت الرسالة',
    time: '10:25',
    avatar: 'ع',
    online: true,
  ),
  ChatUser(
    name: 'محمد كريم',
    message: 'نشوفك باچر إن شاء الله',
    time: 'أمس',
    avatar: 'م',
    unread: 1,
  ),
  ChatUser(
    name: 'حسين',
    message: 'تمام حبيبي',
    time: 'أمس',
    avatar: 'ح',
  ),
  ChatUser(
    name: 'مصطفى',
    message: 'صورة جميلة',
    time: 'الاثنين',
    avatar: 'م',
  ),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedTab = 0;
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Row(
            children: [
              Icon(Icons.chat_bubble_rounded,
                  color: primaryColor, size: 27),
              SizedBox(width: 9),
              Text(
                'شاتلي',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_rounded),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
        body: IndexedStack(
          index: selectedTab,
          children: [
            _buildChats(),
            _buildContacts(),
            _buildProfile(),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: selectedTab,
          backgroundColor: Colors.white,
          indicatorColor: primaryColor.withOpacity(0.12),
          onDestinationSelected: (index) {
            setState(() => selectedTab = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.chat_bubble_outline),
              selectedIcon: Icon(Icons.chat_bubble),
              label: 'المحادثات',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'الأصدقاء',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChats() {
    final filtered = users.where((u) =>
        u.name.contains(search)).toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: TextField(
              onChanged: (value) {
                setState(() => search = value);
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'ابحث عن محادثة...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              Text(
                'المحادثات',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'الكل',
                style: TextStyle(color: primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final user = filtered[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 7,
                ),
                leading: Stack(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundColor:
                          primaryColor.withOpacity(0.12),
                      child: Text(
                        user.avatar,
                        style: const TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                    ),
                    if (user.online)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                title: Text(
                  user.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    user.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.time,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 6),
                    if (user.unread > 0)
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: primaryColor,
                        child: Text(
                          '${user.unread}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChatPage(user: user),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildContacts() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'الأصدقاء',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...users.map((user) => ListTile(
          leading: CircleAvatar(
            backgroundColor: primaryColor.withOpacity(0.12),
            child: Text(user.avatar),
          ),
          title: Text(user.name),
          subtitle: Text(user.online ? 'متصل الآن' : 'غير متصل'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatPage(user: user),
              ),
            );
          },
        )),
      ],
    );
  }

  Widget _buildProfile() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFFE4ECFF),
            child: Icon(
              Icons.person,
              size: 55,
              color: primaryColor,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'حسابي',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'مرحباً بك في شاتلي',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final ChatUser user;

  const ChatPage({super.key, required this.user});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final List<String> messages = [
    'هلا حبيبي شلونك؟',
    'الحمد لله بخير، إنت شلونك؟',
  ];

  void sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(text);
      controller.clear();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor.withOpacity(0.12),
                child: Text(widget.user.avatar),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    widget.user.online ? 'متصل الآن' : 'غير متصل',
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final mine = index % 2 == 1;

                  return Align(
                    alignment: mine
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(13),
                      constraints: const BoxConstraints(
                        maxWidth: 280,
                      ),
                      decoration: BoxDecoration(
                        color: mine ? primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        messages[index],
                        style: TextStyle(
                          color: mine ? Colors.white : Colors.black87,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image_outlined,
                      color: primaryColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'اكتب رسالتك...',
                        filled: true,
                        fillColor: bgColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    child: IconButton(
                      onPressed: sendMessage,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 19,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
