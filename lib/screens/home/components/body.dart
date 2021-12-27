import 'package:flutter/material.dart';
import 'package:tingla/model/apis/api_response.dart';
import 'package:tingla/screens/category/category_screen.dart';
import 'package:tingla/size_config.dart';
import 'package:tingla/variables/variables.dart';
import 'package:tingla/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../../widgets/category_widget.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ApiResponse apiResponse = Provider.of<HomeViewModel>(context).response;
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      padding: EdgeInsets.only(
        bottom: getProportionScreenHeight(100.0),
      ),
      itemCount: apiResponse.data.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(height: 70.0);
        }

        if (apiResponse.data[index - 1].booksCount != 0) {
          return CollectionWidget(
            id: apiResponse.data[index - 1].id,
            title: apiResponse.data[index - 1].name!,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OpenCollectionScreen(
                    title: apiResponse.data[index - 1].name,
                    id: apiResponse.data[index - 1].id,
                  ),
                ),
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
