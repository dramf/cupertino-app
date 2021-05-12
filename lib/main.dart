import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'model/app_state_model.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (_) => AppStateModel()..loadProducts(),
      child: CupertinoStoreApp(),
    ));
