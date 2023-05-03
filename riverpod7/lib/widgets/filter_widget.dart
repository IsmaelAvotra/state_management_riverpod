import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod7/models/data_model.dart';
import 'package:riverpod7/providers/provider.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return DropdownButton(
        value: ref.watch(favoriteStatusProvider),
        items: FavoriteStatus.values
            .map(
              (fs) => DropdownMenuItem(
                value: fs,
                child: Text(
                  fs.toString().split('.').last,
                ),
              ),
            )
            .toList(),
        onChanged: (FavoriteStatus? fs) {
          ref.read(favoriteStatusProvider.notifier).state = fs!;
        },
      );
    });
  }
}
