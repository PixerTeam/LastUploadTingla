import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tingla/schema/notification_schema.dart';
import 'package:tingla/size_config.dart';

import 'custom_divider.dart';
import 'notification_item_widget.dart';

class HasBody extends StatelessWidget {
  const HasBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List _dates = [];
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: getProportionScreenHeight(136.0)),
              if (NotificationSchema.newNotificationList.length != 0)
                Column(
                  children: [
                    CustomDivider(
                      title:
                          "${NotificationSchema.newNotificationList.length} ta yangi xabar",
                    ),
                  ],
                ),
            ],
          ),
        ),
        if (NotificationSchema.newNotificationList.length != 0)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return NotificationItemWidget(
                  newItem: true,
                  title: NotificationSchema.newNotificationList[index]["title"],
                  subtitle: NotificationSchema.newNotificationList[index]
                      ["subtitle"],
                  tag: NotificationSchema.newNotificationList[index]["key"],
                  body: NotificationSchema.newNotificationList[index]["body"],
                );
              },
              childCount: NotificationSchema.newNotificationList.length,
            ),
          ),
        if (NotificationSchema.oldNotificationList.length != 0)
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                Widget? _dateWidget;
                if (!_dates.contains(
                    NotificationSchema.oldNotificationList[index]["date"])) {
                  _dates.add(
                      NotificationSchema.oldNotificationList[index]["date"]);
                  _dateWidget = CustomDivider(
                    title: NotificationSchema.oldNotificationList[index]
                        ["date"],
                  );
                }

                return Column(
                  children: [
                    if (_dateWidget != null) _dateWidget,
                    NotificationItemWidget(
                      newItem: false,
                      title: NotificationSchema.oldNotificationList[index]
                          ["title"],
                      subtitle: NotificationSchema.oldNotificationList[index]
                          ["subtitle"],
                      tag: NotificationSchema.oldNotificationList[index]["key"],
                      body: NotificationSchema.oldNotificationList[index]
                          ["body"],
                    ),
                  ],
                );
              },
              childCount: NotificationSchema.oldNotificationList.length,
            ),
          ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              SizedBox(height: getProportionScreenHeight(24.0)),
            ],
          ),
        ),
      ],
    );
  }
}
