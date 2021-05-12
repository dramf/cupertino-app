import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';

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
          default:
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
