import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:strideon/models/project.dart';
import 'package:strideon/models/task.dart';
import 'package:strideon/utils/constants/image_strings.dart';

class CompletedTasks extends StatefulWidget {
  final Project project;

  const CompletedTasks({Key? key, required this.project}) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {
  List<Task> completedTask = [];

  @override
  void initState() {
    for (int i = 0; i < widget.project.projectBoards.length; i++) {
      for (int j = 0;
          j < widget.project.projectBoards[i].boardTasks.length;
          j++) {
        if (widget.project.projectBoards[i].boardTasks[j].completed) {
          completedTask.add(widget.project.projectBoards[i].boardTasks[j]);
        }
      }
    }
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Completed Tasks'),
              background: Image.network(
                SImages.bannerDefault,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                DateTime endDate = completedTask[index].taskEndDate.toDate();
                var outputFormat = DateFormat('yyyy-MM-dd   HH:mm:ss');
                var outputDate = outputFormat.format(endDate);

                return buildCompletedTaskCard(completedTask[index], outputDate);
              },
              childCount: completedTask.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCompletedTaskCard(Task task, String outputDate) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 0,
        color: Colors.white,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(36),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.taskName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.taskDescription,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.alarm, color: Theme.of(context).primaryColor),
                      Expanded(
                        child: StreamBuilder(
                          stream: Stream.periodic(const Duration(seconds: 1))
                              .asBroadcastStream(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            Duration elapsed =
                                Duration(seconds: int.parse(task.spentTime)) +
                                    task.timer.elapsed;
                            String elapsedString =
                                ' ${elapsed.inHours.toString().padLeft(2, '0')}:${(elapsed.inMinutes % 60).toString().padLeft(2, '0')}:${(elapsed.inSeconds % 60).toString().padLeft(2, '0')}';
                            return Text(
                              elapsedString,
                              style: const TextStyle(fontSize: 16),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Completed Date: $outputDate",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
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
