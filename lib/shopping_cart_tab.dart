import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() => _ShoppingCartTabState();
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) => const CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Shopping Cart'),
          ),
        ],
      ),
    );
  }
}
