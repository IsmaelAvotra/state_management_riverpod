import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/data_model.dart';

final peopleProvider = ChangeNotifierProvider<DataModel>(
  (_) => DataModel(),
);
