import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoardCardWidget extends ConsumerStatefulWidget {
  const BoardCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _BoardCardWidgetState();
}

class _BoardCardWidgetState extends ConsumerState<BoardCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: 250,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
