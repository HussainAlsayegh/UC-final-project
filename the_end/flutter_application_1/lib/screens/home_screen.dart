import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/food.dart';
import 'package:flutter_application_1/screens/food_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  var foods = [
    Food(
      name: 'Breakfast;Oats,apples,bananas',
      imgURL:
          'https://kitchen.sayidaty.net/uploads/small/0b/0b96f4266cdda44efdce726c926cfb4c_w750_h500.jpg',
    ),
    Food(
      name: 'Lunch;vegetables, brown rice, fish',
      imgURL:
          'https://www.rd.com/wp-content/uploads/2017/09/attention-diabetics-this-is-how-many-meals-you-should-eat-every-day-hint-its-not-3-359270072-Soloviova-Liudmyla-ft.jpg',
    ),
    Food(
      name: 'Dinner;Corn, baked potatoes,',
      imgURL:
          'https://veryveganrecipes.com/wp-content/uploads/2015/01/roasted-potato-and-corn.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Meals'),
      ),
      body: ListView.builder(
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 6,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodScreen(
                      food: foods[index],
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.network(
                    foods[index].imgURL,
                    width: 90,
                    height: 90,
                  ),
                  Container(
                    padding: EdgeInsets.all(30),
                    child: Text(
                      foods[index].name,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
