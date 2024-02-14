import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:strideon/core/provider/todo_provider.dart';
import 'package:strideon/feature/card_board/views/screen/stride_create_board_page.dart';
import 'package:strideon/feature/chat_stride/tab_bar/tab_bar.dart';
import 'package:strideon/feature/home/home_screen.dart';
import 'package:strideon/feature/views/home/nav_bar/nav_bar.dart';
import 'package:strideon/gobal/drawer/community_list_drawer.dart';
import 'package:strideon/utils/constants/colors.dart';

final bottomNavIndexProvider = StateProvider((ref) => 0);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late String formattedDate;
    User? user = FirebaseAuth.instance.currentUser;
    final todoData = ref.watch(fetchStreamProvider);
    DateTime myDate = DateTime.now();

    // Format the date using intl package
    formattedDate = DateFormat('EEE, d MMM').format(myDate);

    return Scaffold(
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 100,
      backgroundColor: SColors.light,
      body: Consumer(builder: (context, ref, child) {
        final currentIndex = ref.watch(bottomNavIndexProvider);

        return IndexedStack(
          index: currentIndex,
          children: [
            HomeScreen(
                formattedDate: formattedDate, user: user, todoData: todoData),
            const TabBarExample(),
            const StrideBoardScreen(),
            // const DiagramView()
          ],
        );
      }),
      bottomNavigationBar: navBar(),
      drawer: const CommunityListDrawer(),
    );
  }
}
