import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:strideon/core/error/error_text.dart';
import 'package:strideon/core/loader/loader.dart';
import 'package:strideon/feature/workspace/controller/workspace_controller.dart';

import '../../core/router/route_utils.dart';

class SearchWorkSpace extends SearchDelegate {
  final WidgetRef ref;

  SearchWorkSpace(this.ref);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ref.watch(searchWorkSpaceProvider(query)).when(
          data: (workspace) => ListView.builder(
            itemCount: workspace.length,
            itemBuilder: (BuildContext context, int index) {
              final workSpace = workspace[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(workSpace.avatar),
                ),
                title: Text(workSpace.name),
                onTap: () {
                  GoRouter.of(context).pushNamed(
                      RouteConstant.workSpaceScreen.name,
                      pathParameters: {'name': workSpace.name});
                },
              );
            },
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
