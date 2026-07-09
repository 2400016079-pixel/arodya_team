import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/container_card.dart';
import '../../widgets/drink_type_card.dart';
import '../../widgets/temperature_chip.dart';

class AddDrinkScreen extends StatefulWidget {
  const AddDrinkScreen({super.key});

  @override
  State<AddDrinkScreen> createState() => _AddDrinkScreenState();
}

class _AddDrinkScreenState extends State<AddDrinkScreen> {
  int selectedContainer = -1;
  int selectedDrink = 0;
  int selectedTemperature = 1;

  final amountController = TextEditingController(text: "250");

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    final amount = int.tryParse(amountController.text.trim());

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    const drinkTypes = ["Water", "Coffee", "Tea", "Juice", "Milk", "Isotonic"];
    const temperatures = ["Cold", "Normal", "Hot"];

    final result = {
      "amount": amount,
      "drinkType": drinkTypes[selectedDrink],
      "temperature": temperatures[selectedTemperature],
    };

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Drink Saved Successfully")));

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //================ HEADER =================
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Expanded(
                      child: Text(
                        "Add Drink",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                const Text(
                  "Amount (ml)",
                  style: TextStyle(fontSize: 18, color: Colors.black54),
                ),

                const SizedBox(height: 14),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff6C7487),
                          ),
                          decoration: const InputDecoration(
                            hintText: "250",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "ml",
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                //================ FAVORITE CONTAINERS =================
                const Text(
                  "FAVORITE CONTAINERS",
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 1.2,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: ContainerCard(
                        icon: Icons.local_drink,
                        title: "My Tumbler",
                        amount: "650 ml",
                        selected: selectedContainer == 0,
                        onTap: () {
                          setState(() {
                            selectedContainer = 0;
                            amountController.text = "650";
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: ContainerCard(
                        icon: Icons.local_cafe,
                        title: "Small Cup",
                        amount: "150 ml",
                        selected: selectedContainer == 1,
                        onTap: () {
                          setState(() {
                            selectedContainer = 1;
                            amountController.text = "150";
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                //================ DRINK TYPE =================
                const Text(
                  "DRINK TYPE",
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 1.2,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 14),

                // Replaced Wrap with a 3-column GridView so all 6
                // drink types line up evenly in 2 clean rows instead
                // of wrapping 2-per-row with "Isotonic" left dangling
                // alone on its own line.
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.95,
                  children: [
                    DrinkTypeCard(
                      icon: Icons.water_drop,
                      title: "Water",
                      selected: selectedDrink == 0,
                      onTap: () => setState(() => selectedDrink = 0),
                    ),
                    DrinkTypeCard(
                      icon: Icons.local_cafe,
                      title: "Coffee",
                      selected: selectedDrink == 1,
                      onTap: () => setState(() => selectedDrink = 1),
                    ),
                    DrinkTypeCard(
                      icon: Icons.emoji_food_beverage,
                      title: "Tea",
                      selected: selectedDrink == 2,
                      onTap: () => setState(() => selectedDrink = 2),
                    ),
                    DrinkTypeCard(
                      icon: Icons.blender,
                      title: "Juice",
                      selected: selectedDrink == 3,
                      onTap: () => setState(() => selectedDrink = 3),
                    ),
                    DrinkTypeCard(
                      icon: Icons.local_drink,
                      title: "Milk",
                      selected: selectedDrink == 4,
                      onTap: () => setState(() => selectedDrink = 4),
                    ),
                    DrinkTypeCard(
                      icon: Icons.science,
                      title: "Isotonic",
                      selected: selectedDrink == 5,
                      onTap: () => setState(() => selectedDrink = 5),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                //================ TEMPERATURE =================
                const Text(
                  "Temperature",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 14),

                Row(
                  children: [
                    Expanded(
                      child: TemperatureChip(
                        icon: Icons.ac_unit,
                        title: "Cold",
                        selected: selectedTemperature == 0,
                        onTap: () => setState(() => selectedTemperature = 0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TemperatureChip(
                        icon: Icons.water,
                        title: "Normal",
                        selected: selectedTemperature == 1,
                        onTap: () => setState(() => selectedTemperature = 1),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TemperatureChip(
                        icon: Icons.local_fire_department,
                        title: "Hot",
                        selected: selectedTemperature == 2,
                        onTap: () => setState(() => selectedTemperature = 2),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                //================ TIME =================
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 26,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Text("Time", style: TextStyle(fontSize: 17)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 9,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Now",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xff5A845F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.edit,
                              size: 15,
                              color: Color(0xff5A845F),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 36),

                //================ SAVE BUTTON =================
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _saveEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5A845F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    child: const Text(
                      "Save Entry",
                      style: TextStyle(fontSize: 19, color: Colors.white),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}