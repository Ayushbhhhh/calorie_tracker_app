import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'calorie_provider.dart';
import 'food_item.dart';

class MainScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Food Name'),
            ),
            TextField(
              controller: _caloriesController,
              decoration: InputDecoration(labelText: 'Calories'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _proteinController,
              decoration: InputDecoration(labelText: 'Protein (g)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _carbsController,
              decoration: InputDecoration(labelText: 'Carbs (g)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _fatController,
              decoration: InputDecoration(labelText: 'Fat (g)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final String name = _nameController.text;
                final int calories = int.parse(_caloriesController.text);
                final int protein = int.parse(_proteinController.text);
                final int carbs = int.parse(_carbsController.text);
                final int fat = int.parse(_fatController.text);

                final FoodItem foodItem = FoodItem(
                  name: name,
                  calories: calories,
                  protein: protein,
                  carbs: carbs,
                  fat: fat,
                );

                Provider.of<CalorieProvider>(context, listen: false)
                    .addFoodItem(foodItem);

                _nameController.clear();
                _caloriesController.clear();
                _proteinController.clear();
                _carbsController.clear();
                _fatController.clear();
              },
              child: Text('Add Food'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Consumer<CalorieProvider>(
                builder: (context, provider, child) {
                  return ListView.builder(
                    itemCount: provider.foodItems.length,
                    itemBuilder: (context, index) {
                      final foodItem = provider.foodItems[index];
                      return ListTile(
                        title: Text(foodItem.name),
                        subtitle: Text(
                            'Calories: ${foodItem.calories}, Protein: ${foodItem.protein}g, Carbs: ${foodItem.carbs}g, Fat: ${foodItem.fat}g'),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Total Calories: ${Provider.of<CalorieProvider>(context).totalCalories}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Protein: ${Provider.of<CalorieProvider>(context).totalProtein}g',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Carbs: ${Provider.of<CalorieProvider>(context).totalCarbs}g',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total Fat: ${Provider.of<CalorieProvider>(context).totalFat}g',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
