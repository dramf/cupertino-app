import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';

class ProductListTab extends StatefulWidget {
  @override
  _ProductListTabState createState() => _ProductListTabState();
}

class _ProductListTabState extends State<ProductListTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
        builder: (context, model, child) => const CustomScrollView(
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: Text('Cupertino Store'),
                ),
              ],
            ));
  }
}
