import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/feature/todo/add_task/controller/add_task.dart';
import 'package:strideon/feature/todo/todo_list/repository/todo_repository.dart';
import 'package:strideon/feature/todo/todo_list/todo_stream/todo_view.dart';
import 'package:strideon/models/todo_model.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';
import 'package:strideon/utils/device/device_utility.dart';
import 'package:strideon/widgets/appbar/custom_appbar.dart';

enum TodoLists { All, Done, Learning, Working, General }

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.formattedDate,
    required this.user,
    required this.todoData,
  });

  final String formattedDate;
  final User? user;
  final AsyncValue<List<TodoModel>> todoData;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    /*    String selectedTodo = '0';
    Set<TodoLists> filters = <TodoLists>{};
    int todoCount = 0, completedCount = 0;
    bool showCount = false;
    final todoRepo = ref.watch(todoRepository);
    String searchQuery = "";*/

    return Scaffold(
        appBar: const CustomAppBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's Tasks",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        widget.formattedDate,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: SDeviceUtils.getScreenWidth(context) * 0.35,
                  ),
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                      ),
                      child: const Text(
                        ' + Tasks ',
                      ),
                      onPressed: () => showModalBottomSheet(
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => const AddNewTask(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),

              // const SearchField(),

              // TodoFilter(filters: filters),
              const SizedBox(
                height: SSizes.spaceBtwItems,
              ),

              /*ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 20,
                  child: LinearProgressIndicator(
                    value: todoCount == 0
                        ? 1
                        : completedCount == 0
                        ? 0
                        : (completedCount * 100) /
                        ((todoCount + completedCount) * 100),
                    valueColor:  AlwaysStoppedAnimation<Color>(
                        SColors.primary.withOpacity(0.6)),
                    backgroundColor:
                    SColors.primary.withOpacity(0.2),
                  ),
                ),
              ),
              const SizedBox(height: 20),*/

              TodoView(user: widget.user, todoData: widget.todoData),
            ],
          ),
        ))));
  }
}

class TodoFilter extends ConsumerStatefulWidget {
  const TodoFilter({
    super.key,
    required this.filters,
  });

  final Set<TodoLists> filters;

  @override
  ConsumerState<TodoFilter> createState() => _TodoFilterState();
}

class _TodoFilterState extends ConsumerState<TodoFilter> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: TodoLists.values.map((TodoLists todolist) {
                return FilterChip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    padding: const EdgeInsets.all(2),
                    selectedColor: SColors.accent,
                    side: const BorderSide(color: Colors.transparent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    backgroundColor: SColors.primaryBackground,
                    elevation: 0,
                    label: Text(todolist.name),
                    selected: widget.filters.contains(todolist),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          widget.filters.add(todolist);
                        } else {
                          widget.filters.remove(todolist);
                        }
                      });
                    });
              }).toList()),
        ],
      ),
    );
  }
}

class SearchField extends ConsumerStatefulWidget {
  const SearchField({super.key});

  @override
  ConsumerState createState() => _SearchFieldState();
}

TextEditingController _searchController = TextEditingController();

class _SearchFieldState extends ConsumerState<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: _searchController,
        style: const TextStyle(
          color: Colors.grey,
        ),
        decoration: InputDecoration(
          suffixIcon: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SimpleDialog(
                    backgroundColor: SColors.light,
                    title: const Text('Filter'),
                    children: <Widget>[
                      SimpleDialogOption(
                        onPressed: () {
                          // Handle Option 1
                        },
                        child: const Text('Learning'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          // Handle Option 2
                        },
                        child: const Text('Working'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          // Handle Option 2
                        },
                        child: const Text('General'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          ref.read(todoRepository).isDoneFilter();
                        },
                        child: const Text('Done'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          // Handle Option 2
                        },
                        child: const Text('Pending'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(CupertinoIcons.line_horizontal_3_decrease),
          ),
          fillColor: Colors.transparent,
          filled: true,
          hintText: 'Search',
          alignLabelWithHint: true,
          contentPadding: const EdgeInsets.all(17),
        ),
      ),
    );
  }
}
