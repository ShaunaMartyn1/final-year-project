import 'package:flutter/material.dart';
import 'package:flutter_app/data_service/food_service.dart';
import 'package:flutter_app/pages/home/food_by_category.dart';
//21.46

class ViewCategories extends StatefulWidget {
  const ViewCategories({Key? key}) : super(key: key);

  @override
  State<ViewCategories> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategories> {
  FoodService foodService = FoodService();
  bool showFoodCategory = false;
  late List<Category> categories;
  String categoryName = "";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CategoryList>(
        future: foodService.getCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            categories = snapshot.data!.categories;
            return Container(
                child: showFoodCategory
                    ? FoodByCategory(
                        categoryName: categoryName,
                      )
                      : Column(
                        children: categories
                            .map((category) => Padding(
                                  padding: const EdgeInsets.all(17.0),
                                  child: InkWell(
                                    onTap: () {
                                      categoryName = category.name;
                                      showFoodCategory = true;
                                      setState(() {});
                                    },
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(), //check was category with error
                      )
                    );
          }
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}"); //getting null
          }
          return CircularProgressIndicator();
        });
  }
}

