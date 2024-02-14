import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/router.dart';
import 'package:strideon/utils/constants/colors.dart';

class StrideBoardMenu extends StatefulWidget {
  const StrideBoardMenu({super.key});

  @override
  State<StrideBoardMenu> createState() => _StrideBoardMenuState();
}

class _StrideBoardMenuState extends State<StrideBoardMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Workspace Menu'),
          leading: IconButton(
            onPressed: () {
              GoRouter.of(context).pop();
            },
            icon: const Icon(Icons.close),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Workspace 1",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text.rich(TextSpan(children: [
                        TextSpan(text: "@workspace1"),
                        TextSpan(text: ' (Free) '),
                        WidgetSpan(
                            child: Icon(Icons.lock,
                                color: SColors.error, size: 15)),
                        TextSpan(
                            text: "Public",
                            style: TextStyle(color: SColors.error))
                      ])),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text("Description of the workspace"),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.green[400],
                    child: const Text(
                      "W",
                      style: TextStyle(color: SColors.white),
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                  tileColor: SColors.white,
                  leading: const Icon(Icons.person_outline),
                  title: const Padding(
                    padding: EdgeInsets.only(top: 10.0, bottom: 15),
                    child: Text("Members"),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 18.0),
                        child: InkWell(
                          onTap: () {},
                          child: const Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: SColors.spaletteAccent,
                                child: Text("J"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SizedBox(
                          height: 37,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: SColors.spaletteAccent,
                                padding: const EdgeInsets.symmetric(horizontal: 18)
                              ),
                              onPressed: () {
                                GoRouter.of(context).pushNamed(
                                    RouteConstant.memberWorkSpace.name);
                              },
                              child: const Text(
                                "Invite",
                                style:
                                    TextStyle(color: SColors.white),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
