import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/router/router.dart';
import 'package:strideon/utils/constants/board_constants.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/widgets/cardboard_widget/square_color.dart';

class BoardSettings extends StatefulWidget {
  const BoardSettings({super.key});

  @override
  State<BoardSettings> createState() => _BoardSettingsState();
}

class _BoardSettingsState extends State<BoardSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Board settings")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BlueRectangle(),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: Text(
                    "Name",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  trailing: const Text("Board 1"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: const ListTile(
                  leading: Text("Workspace"),
                  trailing: Text("Workspace 1"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                // child: ListTile(
                //   leading: const Text("Background"),
                //   trailing: ColorSquare(
                //     background: backgrounds[0],
                //   ),
                //   onTap: () {},
                // ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Text("Enable card cover images"),
                  trailing: Switch(value: true, onChanged: ((value) {})),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                    leading: const Text("Watch"),
                    trailing: Switch(value: false, onChanged: ((value) {}))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                    leading: const Text("Available offline"),
                    trailing: Switch(value: false, onChanged: ((value) {}))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Text("Edit labels"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const EditLabels();
                        });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Text("Email-to-board settings"),
                  onTap: () {},
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Text("Archived cards"),
                  onTap: () {
                    GoRouter.of(context)
                        .pushNamed(RouteConstant.copyBoard.name);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Text("Archived lists"),
                  onTap: () {
                    GoRouter.of(context).pushNamed(RouteConstant.boardMenu.name);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                color: Colors.white,
                child: const ListTile(
                  leading: Text("Visibility"),
                  trailing: Text("Public"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: const ListTile(
                  leading: Text("Commenting"),
                  trailing: Text("Members"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Container(
                color: Colors.white,
                child: const ListTile(
                  leading: Text("Adding members"),
                  trailing: Text("Members"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Container(
                color: Colors.white,
                child: ListTile(
                    leading: const Text("Self join"),
                    trailing: Switch(
                      value: true,
                      onChanged: ((value) {}),
                    )),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 10.0),
                child:
                    Text("Any Workspace member can edit and join the board")),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 50),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: const Text("Close board"),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const CloseBoard();
                        });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CloseBoard extends StatefulWidget {
  const CloseBoard({super.key});

  @override
  State<CloseBoard> createState() => _CloseBoardState();
}

class _CloseBoardState extends State<CloseBoard> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Board 1 is now closed"),
      content: SizedBox(
        height: 100,
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Re-open")),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: OutlinedButton(
                  onPressed: () {},
                  child: const Text(
                    "Delete",
                    style: TextStyle(color: SColors.error),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class EditLabels extends StatefulWidget {
  const EditLabels({super.key});

  @override
  State<EditLabels> createState() => _EditLabelsState();
}

class _EditLabelsState extends State<EditLabels> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Edit labels"),
      content: SizedBox(
        height: 190,
        child: Column(children: buildWidget()),
      ),
    );
  }

  List<Widget> buildWidget() {
    List<Widget> labelContainers = [];
    for (int i = 0; i < labels.length; i++) {
      labelContainers.add(Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Container(
          height: 35,
          decoration: BoxDecoration(
              color: labels[i], borderRadius: BorderRadius.circular(5)),
        ),
      ));
    }
    return labelContainers;
  }
}
