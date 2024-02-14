import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/widgets/cardboard_widget/board_visibility.dart';

class BoardMenu extends StatefulWidget {
  const BoardMenu({super.key});

  @override
  State<BoardMenu> createState() => _BoardMenuState();
}

class _BoardMenuState extends State<BoardMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("Board menu"),
        centerTitle: false,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: SColors.accent,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.star_border,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: SColors.accent,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const BoardVisibility();
                          });
                    },
                    icon: const Icon(
                      Icons.people,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: SColors.accent,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(RouteConstant.copyBoard.name);
                    },
                    icon: const Icon(
                      Icons.copy,
                      size: 30,
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: SColors.accent,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: IconButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(RouteConstant.boardSettings.name);
                    },
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListTile(
              tileColor: SColors.white,
              leading: const Icon(Icons.person_outline),
              title: const Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Text("Members"),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 18.0),
                    child: CircleAvatar(
                      backgroundColor: SColors.accent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: SizedBox(
                      height: 37,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            foregroundColor: Colors.white,
                            backgroundColor: SColors.spaletteAccent),
                        onPressed: () {
                          GoRouter.of(context).pushNamed(
                              RouteConstant.inviteWorkSpaceMember.name);
                        },
                        child: const Text("Invite"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Container(
              color: SColors.white,
              child: ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text("About this board"),
                onTap: () {},
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                color: SColors.white,
                child: ListTile(
                  leading: const Icon(Icons.rocket),
                  title: const Text("Power-Ups"),
                  onTap: () {
                    GoRouter.of(context).pushNamed(RouteConstant.powerUp.name);
                  },
                ),
              )),
          Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                color: SColors.white,
                child: ListTile(
                  leading: const Icon(Icons.push_pin_outlined),
                  title: const Text("Pin to home screen"),
                  onTap: () {},
                ),
              )),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "Activity",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      )),
    );
  }
}
