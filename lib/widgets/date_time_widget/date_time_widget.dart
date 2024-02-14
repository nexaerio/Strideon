import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:strideon/core/provider/date_time_provider.dart';
import 'package:strideon/utils/constants/colors.dart';
import 'package:strideon/utils/constants/sizes.dart';

class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: SSizes.spaceBtwItems,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                child: Ink(
                  decoration: BoxDecoration(
                      color: SColors.light,
                      borderRadius: BorderRadius.circular(SSizes.borderRadiusMd)),
                  child: InkWell(
                    onTap: () => onTap(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        color: SColors.accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(icon),
                          const SizedBox(
                            width: 7,
                          ),
                          Text(value),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
