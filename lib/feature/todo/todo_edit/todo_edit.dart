import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:strideon/core/error/error_text.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/core/provider/date_time_provider.dart';
import 'package:strideon/core/provider/radio_provider.dart';
import 'package:strideon/core/provider/todo_provider.dart';
import 'package:strideon/feature/todo/todo_list/repository/todo_repository.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/widgets/button_widgets/custom_button.dart';
import 'package:strideon/widgets/button_widgets/custom_outline_button.dart';
import 'package:strideon/widgets/date_time_widget/date_time_widget.dart';
import 'package:strideon/widgets/radio_widget/radio_widget.dart';
import 'package:strideon/widgets/task_textfield/task_textfield.dart';

class TodoUpdate extends ConsumerStatefulWidget {
  const TodoUpdate({super.key, required this.getIndex});

  final int getIndex;

  @override
  ConsumerState createState() => _AddNewTaskState();
}

final TextEditingController _titleController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();

class _AddNewTaskState extends ConsumerState<TodoUpdate> {
  @override
  void initState() {
    super.initState();

    final todoDat = ref.read(fetchStreamProvider);

    todoDat.when(
      data: (tasks) {
        if (widget.getIndex < tasks.length) {
          final task = tasks[widget.getIndex];
          _titleController.text = task.titleTask;
          _descriptionController.text = task.description;
          Future.delayed(const Duration(milliseconds: 0), () {
            ref.read(dateProvider.notifier).update((state) => task.dateTask);
            ref.read(timeProvider.notifier).update((state) => task.timeTask);

            // Map task.category to an integer value (adjust as needed)
            int categoryValue;
            switch (task.category) {
              case 'Learning':
                categoryValue = 1;
                break;
              case 'Working':
                categoryValue = 2;
                break;
              case 'General':
                categoryValue = 3;
                break;
              default:
                categoryValue = 0;
            }

            ref.read(radioProvider.notifier).update((state) => categoryValue);
          });
        }
      },
      error: (err, stack) => ErrorText(error: err.toString()),
      loading: () => const Loader(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);
    final todoData = ref.watch(fetchStreamProvider);
    final getRadioValue = ref.watch(radioProvider);
    return todoData.when(
      data: (todoData) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          height: SDeviceUtils.getScreenHeight(context) * 0.70,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Update Task Todo",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(
                  thickness: 1.5,
                  color: SColors.accent,
                ),
                const SizedBox(
                  height: SSizes.spaceBtwItems,
                ),
                Text(
                  'Title Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: SSizes.spaceBtwItems,
                ),

                Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskTextField(
                      maxLines: 1,
                      text: 'Add you Task',
                      textController: _titleController,
                    ),
                    const SizedBox(
                      height: SSizes.spaceBtwItems,
                    ),
                    Text(
                      'Description',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: SSizes.spaceBtwItems,
                    ),
                    TaskTextField(
                      maxLines: 5,
                      text: 'Add Description',
                      textController: _descriptionController,
                    ),
                  ],
                )),

                const SizedBox(
                  height: SSizes.spaceBtwItems,
                ),
                Text(
                  'Category',
                  style: Theme.of(context).textTheme.titleLarge,
                ),

                Row(
                  children: [
                    Expanded(
                        child: RadioWidget(
                      valueInput: 1,
                      titleRadio: 'LRN',
                      categColor: Colors.green,
                      onChangeValue: () =>
                          ref.read(radioProvider.notifier).update((state) => 1),
                    )),
                    Expanded(
                      child: RadioWidget(
                          valueInput: 2,
                          titleRadio: 'WRK',
                          categColor: Colors.blue.shade700,
                          onChangeValue: () => ref
                              .read(radioProvider.notifier)
                              .update((state) => 2)),
                    ),
                    Expanded(
                      child: RadioWidget(
                          valueInput: 3,
                          titleRadio: 'Gen',
                          categColor: Colors.amberAccent.shade700,
                          onChangeValue: () => ref
                              .read(radioProvider.notifier)
                              .update((state) => 3)),
                    ),
                  ],
                ),

                //Date and Time

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DateTimeWidget(
                      title: 'Date',
                      value: dateProv.toString(),
                      icon: CupertinoIcons.calendar,
                      onTap: () async {
                        final getValue = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2026));

                        if (getValue != null) {
                          final format = DateFormat.yMd();
                          ref
                              .read(dateProvider.notifier)
                              .update((state) => format.format(getValue));
                        }
                      },
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    DateTimeWidget(
                      title: 'Time',
                      value: timeProv.toString(),
                      icon: CupertinoIcons.clock,
                      onTap: () async {
                        final getValue = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());

                        if (getValue != null) {
                          ref
                              .read(timeProvider.notifier)
                              .update((state) => getValue.format(context));
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: SSizes.spaceBtwItems,
                ),

                Row(
                  children: [
                    Expanded(
                        child: Container(
                      height: SDeviceUtils.getBottomNavigationBarHeight() * 0.9,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: CustomOutlineButton(
                          voidCallback: () => Navigator.pop(context),
                          text: 'Cancel'),
                    )),
                    const SizedBox(
                      width: 60,
                    ),
                    Expanded(
                        child: Container(
                      height: SDeviceUtils.getBottomNavigationBarHeight() * 0.9,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: CustomButton(
                        voidCallback: () {
                          ref.read(todoRepository).updateDateTime(
                              todoData[widget.getIndex].docID, ref);

                          ref.read(todoRepository).updateRadioValue(
                              todoData[widget.getIndex].docID,
                              getRadioValue.toString(),
                              ref);

                          ref.read(todoRepository).updateTodo(
                              todoData[widget.getIndex].docID,
                              _titleController,
                              _descriptionController);

                          _titleController.clear();
                          _descriptionController.clear();

                          Navigator.of(context).pop();
                          ref.read(radioProvider.notifier).update((state) => 0);
                        },
                        text: 'Update',
                      ),
                    )),
                  ],
                )
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
