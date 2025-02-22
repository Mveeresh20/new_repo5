import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _selectedGender;
  DateTime? _selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Name", _nameController),
            _buildTextField("Email", _emailController),
            _buildDropdown<String>("Gender", ["Male", "Female"], _selectedGender, (value) {
              setState(() => _selectedGender = value);
            }),
            _buildDatePicker("Birthday", _selectedDate, (date) {
              setState(() => _selectedDate = date);
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>(String label, List<T> items, T? selectedItem, ValueChanged<T?> onChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: selectedItem,
            isExpanded: true,
            onChanged: onChanged,
            items: items.map((T value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(value.toString()),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, ValueChanged<DateTime?> onDateSelected) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            onDateSelected(pickedDate);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
         /* child: Text(
           // selectedDate != null ? DateFormat('yyyy-MM-dd').format(selectedDate) : "Select Date",
           // style: TextStyle(color: Colors.black87),
          ),*/
        ),
      ),
    );
  }

  void _saveProfile() {
    // Save profile logic here
    print("Name: ${_nameController.text}");
    print("Email: ${_emailController.text}");
    print("Gender: $_selectedGender");
    print("Birthday: $_selectedDate");
  }
}
