import 'package:cupertino_app/product_row_item.dart';
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
      builder: (context, model, child) {
        final products = model.getProducts();

        return CustomScrollView(
          semanticChildCount: products.length,
          slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Cupertino Store'),
            ),
            SliverSafeArea(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index < products.length) {
                    return ProductRowItem(
                      product: products[index],
                      lastItem: index == products.length - 1,
                    );
                  }
                }),
              ),
            ),
          ],
        );
      },
    );
  }
}
