import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/route_utils.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';

class MemberWorkspace extends StatefulWidget {
  const MemberWorkspace({super.key});

  @override
  State<MemberWorkspace> createState() => _MemberWorkspaceState();
}

class _MemberWorkspaceState extends State<MemberWorkspace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Members"),
        centerTitle: false,
        actions: [
          TextButton(
              onPressed: () {
                GoRouter.of(context)
                    .pushNamed(RouteConstant.inviteWorkSpaceMember.name);
              },
              child: Text("Invite",
                  style: Theme.of(context).textTheme.labelMedium))
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Members (1)"),
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: SColors.spaletteAccent,
                    child: Text("J"),
                  ),
                  title: const Text("Jane Doe"),
                  subtitle: const Text("@janedoe"),
                  trailing: const Text(
                    "Admin",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SSizes.fontSizeSm),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: SColors.spaletteAccent,
                                        child: Text("J"),
                                      ),
                                      title: Text("Jane Doe"),
                                      subtitle: Text("@janedoe"),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Admin",
                                      ),
                                    ),
                                    const Text(
                                        "Can view, create and edit Workspace boards, and change settings for the workspace"),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.8,
                                        height: 50,
                                        child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18),
                                                backgroundColor: SColors.error),
                                            child:
                                                const Text("Leave workspace")),
                                      ),
                                    )
                                  ]),
                            ),
                          );
                        });
                  },
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
