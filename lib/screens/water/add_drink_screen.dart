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
    // Was missing before: without this the controller leaks every time
    // this screen is opened and closed.
    amountController.dispose();
    super.dispose();
  }

  void _saveEntry() {
    final amount = int.tryParse(amountController.text.trim());

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid amount"),
        ),
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Drink Saved Successfully"),
      ),
    );

    // Return the entered data to whoever pushed this screen instead of
    // just popping with nothing.
    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Tap anywhere outside the text field to dismiss the keyboard.
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
                          fontSize: 28,
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

                const SizedBox(height: 45),

                const Text(
                  "Amount (ml)",
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            // Prevents non-numeric input instead of only
                            // relying on the number keyboard.
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 52,
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
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                //================ FAVORITE CONTAINERS =================
                const Text(
                  "FAVORITE CONTAINERS",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(width: 16),
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

                const SizedBox(height: 40),

                //================ DRINK TYPE =================
                const Text(
                  "DRINK TYPE",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 2,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 20),

                Wrap(
                  spacing: 16,
                  runSpacing: 16,
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

                const SizedBox(height: 40),

                //================ TEMPERATURE =================
                const Text(
                  "Temperature",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TemperatureChip(
                      icon: Icons.ac_unit,
                      title: "Cold",
                      selected: selectedTemperature == 0,
                      onTap: () => setState(() => selectedTemperature = 0),
                    ),
                    TemperatureChip(
                      icon: Icons.water,
                      title: "Normal",
                      selected: selectedTemperature == 1,
                      onTap: () => setState(() => selectedTemperature = 1),
                    ),
                    TemperatureChip(
                      icon: Icons.local_fire_department,
                      title: "Hot",
                      selected: selectedTemperature == 2,
                      onTap: () => setState(() => selectedTemperature = 2),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                //================ TIME =================
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffF4F4F4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 34,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 18),
                      const Expanded(
                        child: Text(
                          "Time",
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Now",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff5A845F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.edit,
                              size: 18,
                              color: Color(0xff5A845F),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 45),

                //================ SAVE BUTTON =================
                SizedBox(
                  width: double.infinity,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: _saveEntry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff5A845F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    child: const Text(
                      "Save Entry",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                Center(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}