import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/provider/todo_provider.dart';
import 'package:strideon/feature/todo/todo_edit/todo_edit.dart';
import 'package:strideon/feature/todo/todo_list/repository/todo_repository.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/snackbar/show_snackbar.dart';

class CardTodoWidget extends ConsumerStatefulWidget {
  const CardTodoWidget({
    Key? key,
    required this.getIndex,
  }) : super(key: key);

  final int getIndex;

  @override
  ConsumerState createState() => _CardTodoWidgetState();
}

class _CardTodoWidgetState extends ConsumerState<CardTodoWidget> {
  @override
  Widget build(BuildContext context) {
    final todoData = ref.watch(fetchStreamProvider);

    return todoData.when(
      data: (todoData) {
        Color categoryColor = Colors.white;
        final getCategory = todoData[widget.getIndex].category;
        switch (getCategory) {
          case 'Learning':
            categoryColor = Colors.green;
            break;

          case 'Working':
            categoryColor = Colors.blue.shade700;
            break;

          case 'General':
            categoryColor = Colors.amber.shade700;
            break;
        }

        return Dismissible(
          direction: DismissDirection.startToEnd,
          key: Key('${todoData[widget.getIndex].docID}'),
          onDismissed: (direction) {
            direction == DismissDirection.startToEnd;

            ref
                .read(todoRepository)
                .deleteTask(todoData[widget.getIndex].docID!);

            showSnackBar(context,
                '${todoData[widget.getIndex].titleTask} has been deleted');
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? SColors.darkContainer
                  : SColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: categoryColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                  ),
                  width: 15,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            todoData[widget.getIndex].titleTask,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .apply(
                                  decoration: todoData[widget.getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                          ),
                          subtitle: Text(
                            todoData[widget.getIndex].description,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .apply(
                                  decoration: todoData[widget.getIndex].isDone
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                          ),
                          trailing: Transform.scale(
                            scale: 1.2,
                            child: Checkbox(
                              activeColor: SColors.primary,
                              // fillColor: MaterialStatePropertyAll(
                              //     Theme.of(context).brightness ==
                              //             Brightness.dark
                              //         ? SColors.primary
                              //         : SColors.light),
                              shape: const CircleBorder(),
                              value: todoData[widget.getIndex].isDone,
                              onChanged: (value) =>
                                  ref.read(todoRepository).updateTask(
                                        todoData[widget.getIndex].docID,
                                        value,
                                      ),
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              useSafeArea: true,
                              isScrollControlled: true,
                              builder: (context) => TodoUpdate(
                                getIndex: widget.getIndex,
                              ),
                            );
                          },
                        ),
                        Transform.translate(
                          offset: const Offset(0, -7),
                          child: Container(
                            child: Column(
                              children: [
                                const Divider(
                                  thickness: 1.5,
                                  color: SColors.accent,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      todoData[widget.getIndex].timeTask,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      error: (err, stack) => Center(
        child: Text(err.toString()),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
