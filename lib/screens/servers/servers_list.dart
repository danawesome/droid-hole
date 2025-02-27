// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:droid_hole/screens/servers/servers_tile_item.dart';

import 'package:droid_hole/providers/servers_provider.dart';

class ServersList extends StatelessWidget {
  final BuildContext context;
  final List<ExpandableController> controllers;
  final Function(int) onChange;
  final ScrollController scrollController;
  final double breakingWidth;

  const ServersList({
    Key? key,
    required this.context,
    required this.controllers,
    required this.onChange,
    required this.scrollController,
    required this.breakingWidth
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final serversProvider = Provider.of<ServersProvider>(context);
    
    if (serversProvider.getServersList.isNotEmpty) {
      return ListView(
        children: [
          Wrap(
            children: serversProvider.getServersList.asMap().entries.map(
              (s) => ServersTileItem(
                breakingWidth: breakingWidth,
                server: serversProvider.getServersList[s.key], 
                index: s.key, 
                onChange: onChange
              )
            ).toList(),
          ),
          const SizedBox(height: 8)
        ],
      );
    }
    else {
      return SizedBox(
        height: double.maxFinite,
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.noSavedConnections,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }
  }
}