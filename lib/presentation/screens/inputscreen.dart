import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  List<TextEditingController> textControllers =
      List.generate(12, (index) => TextEditingController());

  @override
  void dispose() {
    for (int i = 0; i < 12; i++) {
      textControllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 30),
            _buildRow(textControllers[0], textControllers[1], textControllers[2], 'Customer ID','Item ID','Item',true),
            const SizedBox(height: 30),
            _buildRow(textControllers[3], textControllers[4], textControllers[5],'Delivery Date','Sanchi','Number of Boxes',true),
            const SizedBox(height: 30),
            _buildRow(textControllers[6], textControllers[7], textControllers[8],'Weight','Size','Kakoshiji',false),
            const SizedBox(height: 30),
            _buildRow(textControllers[9], textControllers[10], textControllers[11],'Hukurotype','Bango','Seal',false),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(TextEditingController controller1, TextEditingController controller2, TextEditingController controller3, String fieldname1 , String fieldname2 , String fieldname3 , bool showbutton) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildField(controller1, fieldname1),
        _buildField(controller2, fieldname2, showButton: showbutton),
        _buildField(controller3, fieldname3),
      ],
    );
  }

  Widget _buildField(TextEditingController controller, String fieldName, {bool showButton = false}) {
    return SizedBox(
      width: 300,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(fieldName),
                TextFormField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          if (showButton)
            ElevatedButton(
              onPressed: () {
                _showCodeSelectionDialog(context, controller);
              },
              child: const Text('View Price'),
            ),
        ],
      ),
    );
  }

  Future<void> _showCodeSelectionDialog(BuildContext context, TextEditingController controller) async {
    String? selectedCode = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select a code'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(
                10,
                (index) => ListTile(
                  title: Text('Code ${index + 1}'),
                  onTap: () {
                    Navigator.of(context).pop('Code ${index + 1}');
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
    if (selectedCode != null) {
      setState(() {
        controller.text = selectedCode;
      });
    }
  }
}
