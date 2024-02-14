import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:strideon/core/notification/local_notification.dart';
import 'package:strideon/core/provider/date_time_provider.dart';
import 'package:strideon/core/provider/radio_provider.dart';
import 'package:strideon/feature/todo/todo_list/repository/todo_repository.dart';
import 'package:strideon/models/todo_model.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/widgets/button_widgets/custom_button.dart';
import 'package:strideon/widgets/button_widgets/custom_outline_button.dart';
import 'package:strideon/widgets/date_time_widget/date_time_widget.dart';
import 'package:strideon/widgets/radio_widget/radio_widget.dart';
import 'package:strideon/widgets/task_textfield/task_textfield.dart';

final TextEditingController titleController = TextEditingController();
final TextEditingController descriptionController = TextEditingController();

class AddNewTask extends ConsumerStatefulWidget {
  const AddNewTask({super.key});

  @override
  ConsumerState createState() => _AddNewTaskState();
}

DateTime scheduleTime = DateTime.now();

final _formKey = GlobalKey<FormState>();

class _AddNewTaskState extends ConsumerState<AddNewTask> {
  @override
  Widget build(BuildContext context) {
    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);
    var firebaseAuth = FirebaseAuth.instance;

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
                "New Task Todo",
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
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskTextField(
                        maxLines: 1,
                        text: 'Add you Task',
                        textController: titleController),
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
                      textController: descriptionController,
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
                      categColor: Colors.blue,
                      onChangeValue: () => ref
                          .read(radioProvider.notifier)
                          .update((state) => 2)),
                ),
                Expanded(
                  child: RadioWidget(
                      valueInput: 3,
                      titleRadio: 'Gen',
                      categColor: Colors.amber,
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
                    final scheduleTime = await showDatePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2025));

                    if (scheduleTime != null) {
                      final format = DateFormat.yMd();
                      ref
                          .read(dateProvider.notifier)
                          .update((state) => format.format(scheduleTime));
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
                    final scheduleTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());

                    if (scheduleTime != null) {
                      ref
                          .read(timeProvider.notifier)
                          .update((state) => scheduleTime.format(context));
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
                      if (_formKey.currentState!.validate()) {
                        final getRadioValue = ref.read(radioProvider);
                        String category = '';

                        switch (getRadioValue) {
                          case 1:
                            category = 'Learning';
                            break;
                          case 2:
                            category = 'Working';
                            break;
                          case 3:
                            category = 'General';
                            break;
                        }

                        NotificationService().scheduleNotification(
                          id: 2,
                          title: "Title",
                          body: "Hello",
                          scheduledNotificationDateTime: scheduleTime,
                        );

                        ref.read(todoRepository).addNewTask(TodoModel(
                            docID: firebaseAuth.currentUser!.uid,
                            titleTask: titleController.text,
                            description: descriptionController.text,
                            category: category,
                            timeTask: ref.read(timeProvider),
                            isDone: false,
                            dateTask: ref.read(dateProvider)));

                        titleController.clear();
                        descriptionController.clear();

                        ref.read(radioProvider.notifier).update((state) => 0);
                        Navigator.pop(context);
                      }
                    },
                    text: 'Create',
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
