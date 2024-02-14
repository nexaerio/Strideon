import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget(
      {super.key,
      required this.titleRadio,
      required this.categColor,
      required this.valueInput,
      required this.onChangeValue});

  final String titleRadio;
  final Color categColor;
  final int valueInput;
  final VoidCallback onChangeValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final radio = ref.watch(radioProvider);
    return Material(
      color: Colors.transparent,
      child: Theme(
        data: ThemeData(unselectedWidgetColor: Colors.green),
        child: RadioListTile(
            activeColor: categColor,
            contentPadding: EdgeInsets.zero,
            title: Transform.translate(
                offset: const Offset(-22, 0),
                child: Text(
                  titleRadio,
                  style: Theme.of(context).textTheme.labelMedium?.apply(
                        color: categColor,
                      ),
                )),
            value: valueInput,
            groupValue: radio,
            onChanged: (value) => onChangeValue()),
      ),
    );
  }
}
