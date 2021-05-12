import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'model/product.dart';
import 'styles.dart';

const double _kDateTimePickerHeight = 216;

class ShoppingCartTab extends StatefulWidget {
  @override
  _ShoppingCartTabState createState() => _ShoppingCartTabState();
}

class _ShoppingCartTabState extends State<ShoppingCartTab> {
  String? name;
  String? email;
  String? location;
  String? pin;
  DateTime dateTime = DateTime.now();
  final _currencyFormat = NumberFormat.currency(symbol: '\$');

  Widget _buildDateAndTimePicker(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    CupertinoIcons.clock,
                    color: CupertinoColors.lightBackgroundGray,
                    size: 28,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Delivery time',
                    style: Styles.deliveryTimeLabel,
                  ),
                ],
              ),
              Text(
                DateFormat.yMMMd().add_jm().format(dateTime),
                style: Styles.deliveryTime,
              ),
            ],
          ),
          Container(
            height: _kDateTimePickerHeight,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              initialDateTime: dateTime,
              onDateTimeChanged: (newDate) =>
                  setState(() => dateTime = newDate),
            ),
          ),
        ],
      );

  Widget _buildNameField() => CupertinoTextField(
        prefix: const Icon(
          CupertinoIcons.person_solid,
          color: CupertinoColors.lightBackgroundGray,
          size: 28,
        ),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        clearButtonMode: OverlayVisibilityMode.editing,
        textCapitalization: TextCapitalization.words,
        autocorrect: false,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0,
              color: CupertinoColors.inactiveGray,
            ),
          ),
        ),
        placeholder: 'Name',
        onChanged: (newName) => setState(() => name = newName),
      );

  Widget _buildEmailField() => const CupertinoTextField(
        prefix: const Icon(
          CupertinoIcons.mail_solid,
          color: CupertinoColors.lightBackgroundGray,
          size: 28,
        ),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        clearButtonMode: OverlayVisibilityMode.editing,
        keyboardType: TextInputType.emailAddress,
        autocorrect: false,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0,
              color: CupertinoColors.inactiveGray,
            ),
          ),
        ),
        placeholder: 'Email',
      );

  Widget _buildLocationField() => const CupertinoTextField(
        prefix: const Icon(
          CupertinoIcons.location_solid,
          color: CupertinoColors.lightBackgroundGray,
          size: 28,
        ),
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
        clearButtonMode: OverlayVisibilityMode.editing,
        textCapitalization: TextCapitalization.words,
        decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(width: 0, color: CupertinoColors.inactiveGray)),
        ),
        placeholder: 'Location',
      );

  SliverChildBuilderDelegate _buildSliverChildBuilderDelegate(
          AppStateModel model) =>
      SliverChildBuilderDelegate((context, index) {
        final productIndex = index - 4;
        switch (index) {
          case 0:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildNameField(),
            );
          case 1:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildEmailField(),
            );
          case 2:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _buildLocationField(),
            );
          case 3:
            return Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: _buildDateAndTimePicker(context),
            );
          default:
            if (model.productsInCart.length > productIndex) {
              return ShoppingCartItem(
                product: model.getProductById(
                    model.productsInCart.keys.toList()[productIndex]),
                index: index,
                lastItem: productIndex == model.productsInCart.length - 1,
                quantity: model.productsInCart.values.toList()[productIndex],
                formatter: _currencyFormat,
              );
            } else if (model.productsInCart.keys.length == productIndex &&
                model.productsInCart.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Shipping '
                          '${_currencyFormat.format(model.shippingCost)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tax '
                          '${_currencyFormat.format(model.tax)}',
                          style: Styles.productRowItemPrice,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Total '
                          '${_currencyFormat.format(model.totalCost)}',
                          style: Styles.productRowTotal,
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
        }
        return null;
      });

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) => CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Shopping Cart'),
          ),
          SliverSafeArea(
            top: false,
            minimum: const EdgeInsets.only(top: 4),
            sliver: SliverList(
              delegate: _buildSliverChildBuilderDelegate(model),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingCartItem extends StatelessWidget {
  final Product product;
  final int index;
  final bool lastItem;
  final int quantity;
  final NumberFormat formatter;

  ShoppingCartItem({
    required this.product,
    required this.index,
    required this.lastItem,
    required this.quantity,
    required this.formatter,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                product.assetName,
                package: product.assetPackage,
                fit: BoxFit.cover,
                width: 40,
                height: 40,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product.name,
                          style: Styles.productRowItemName,
                        ),
                        Text(
                          '${formatter.format(quantity * product.price)}',
                          style: Styles.productRowItemName,
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${quantity > 1 ? '$quantity x ' : ''}'
                      '${formatter.format(product.price)}',
                      style: Styles.productRowItemPrice,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
