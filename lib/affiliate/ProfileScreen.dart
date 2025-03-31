/*
import 'dart:convert';
import 'dart:io';
import 'package:tngtong/config.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';
class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  SharedPreferences? prefs; // SharedPreferences instance
  String? loginEmail; // To store the retrieved email
  String? userId;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // Basic Details
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Profile Details
  /* final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController();*/
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _zipController = TextEditingController();

  // Professional Details
  /* final TextEditingController _videoPriceController = TextEditingController();
  final TextEditingController _firstRevisionPriceController = TextEditingController();
  final TextEditingController _secondRevisionPriceController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();
  final TextEditingController _workDetailsController = TextEditingController();*/

  // Payment/Bank Details
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();

  // Social Media
  /*final TextEditingController _instagramFollowersController = TextEditingController();
  final TextEditingController _instagramLinkController = TextEditingController();
  final TextEditingController _facebookFollowersController = TextEditingController();
  final TextEditingController _facebookLinkController = TextEditingController();
  final TextEditingController _linkedinFollowersController = TextEditingController();
  final TextEditingController _linkedinLinkController = TextEditingController();
  final TextEditingController _youtubeFollowersController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();
  final TextEditingController _twitterFollowersController = TextEditingController();
  final TextEditingController _twitterLinkController = TextEditingController();*/
  String? _selectedGender;
  /*String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;*/
  DateTime? _selectedDate;
  /* List<String> _selectedTags = [];
  List<String> _selectedCategories = [];*/
  // String? _selectedProfession;

  /* final List<String> _tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5", "Tag6"];
  final List<String> _categories = ["Category1", "Category2", "Category3"];
  final List<String> _professions = ["Singer", "Director", "Influencer", "Actor"];*/
// Image picker
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final String? _profileImagePath = null; // Path to the profile image, can be updated by the user.
  final String _apiUrl = "https://demo.infoskaters.com/api/affiliater_update_profile.php";
  File? _selectedImage;
  String _serverUrl = "https://demo.infoskaters.com/api/upload.php";
  @override
  void initState() {
    super.initState();

    _initializePreferences();
    //fetchProfileData("2");

    /*setState(() {
      _aboutController.text = "hi" ?? '';});*/
    //fetchUserId();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    print('Login Email: $loginEmail');
    fetchUserId();

  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() {
      userId = id;
      //userId = "2";

    });
    fetchProfileData(userId!);

    print('Login Id: $userId');

  }



  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    try {

      var response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json', // Use application/json if you're sending JSON
        },
        body: jsonEncode({

          //////////////////
          'u_id':userId ,
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'password': _passwordController.text,
          'confirm_password': _confirmPasswordController.text,

          // Profile Details

          'address': _addressController.text,
          'country': _countryController.text,
          'state': _stateController.text,
          'city': _cityController.text,
          'zip_code': _zipController.text,



          // Payment/Bank Details
          'bank_name': _bankNameController.text,
          'ifsc_code': _ifscCodeController.text,
          'account_number': _accountNumberController.text,
          'account_holder_name': _accountHolderController.text,
          'pan_number': _panController.text,
          'upi_number': _upiNumberController.text,

          // Social Media
          'profile_photo_url':"",


          // Gender and Date of Birth
          'gender': _selectedGender,
          //'birthday': _selectedDate?.toIso8601String(),


          "birthday": "1990-01-01",

        }),


      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Success: ${responseData['message']}')),
          );
        } else {    print('Response body: ${responseData['message']}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${responseData['message']}')),
        );

        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print('error:$e');

    }
    //_uploadImage();
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No image selected."),
        ),
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_serverUrl));
      request.files.add(
          await http.MultipartFile.fromPath('image', _selectedImage!.path));
      request.fields['c_id'] = userId!;

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var json = jsonDecode(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(json['message'] ?? 'Image uploaded successfully!'),
          ),
        );
      } else {
        var responseData = await response.stream.bytesToString();
        debugPrint('Response status: ${response.statusCode}');
        debugPrint('Response body: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to upload image. Please try again."),
          ),
        );
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }


  Future<void> fetchProfileData(String u_id) async {
    final String apiUrl = "https://demo.infoskaters.com/api/get_affiliater.php?u_id=$u_id";
    final String getasicDetailsApi = "https://demo.infoskaters.com/api/get_affiliater_basic.php?u_id=$u_id";
////
    try {
      //final url = Uri.parse('${Config.apiDomain}${Config.celebrity_reg}');

      final response = await http.get(Uri.parse(getasicDetailsApi));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        if (data.containsKey("error")) {
          print("Error: ${data['error']}");
          return;
        }

        setState(() {
          _nameController.text = data['a_name'] ?? '';
          _emailController.text = data['a_email'] ?? '';
          _phoneController.text = data['a_mob'] ?? '';

        });

      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
////
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        if (data.containsKey("error")) {
          print("Error: ${data['error']}");
          return;
        }

        setState(() {

          _addressController.text = data['address'] ?? '';
          _cityController.text = data['city'] ?? '';
          _stateController.text = data['state'] ?? '';
          _countryController.text = data['country'] ?? '';
          _zipController.text = data['zip_code'] ?? '';

          _bankNameController.text = data['bank_name'] ?? '';
          _ifscCodeController.text = data['ifsc_code'] ?? '';
          _accountNumberController.text = data['account_number'] ?? '';
          _accountHolderController.text = data['account_holder_name'] ?? '';
          _panController.text = data['pan_number'] ?? '';
          _upiNumberController.text = data['upi_number'] ?? '';

          _selectedGender=data['gender'] ?? '';

        });


        print("Data loaded successfully");
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF04AB),
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // Basic Details Section
              _buildSection(
                title: "Basic Details",
                child: Column(
                  children: [
                    _buildProfileImage(),
                    _buildTextField(_nameController, "Name", Icons.person),
                    _buildTextField(_emailController, "Email", Icons.email),
                    _buildTextField(_phoneController, "Phone", Icons.phone),
                    _buildPasswordTextField(_passwordController, "Password"),
                    _buildPasswordTextField(_confirmPasswordController, "Confirm Password"),
                  ],
                ),
              ),

              // Profile Details Section
              _buildSection(
                title: "Profile Details",
                child: Column(
                  children: [
                    _buildDropdown<String>("Gender", ["Male", "Female"], _selectedGender, (value) {
                      setState(() => _selectedGender = value);
                    }),
                    _buildDatePicker("Birthday", _selectedDate, (date) {
                      setState(() => _selectedDate = date);
                    }),
                    _buildTextField(_addressController, "Address", Icons.location_on),
                    _buildTextField(_cityController, "City", Icons.location_on),
                    _buildTextField(_stateController, "State", Icons.location_on),
                    _buildTextField(_countryController, "Country", Icons.location_on),
                    _buildTextField(_zipController, "ZIP/PIN Code", Icons.pin_drop),
                    /*   _buildDropdown<String>("Country", ["India", "USA"], _selectedCountry, (value) {
                      setState(() => _selectedCountry = value);
                    }),
                    _buildDropdown<String>("State", ["State1", "State2"], _selectedState, (value) {
                      setState(() => _selectedState = value);
                    }),
                    _buildDropdown<String>("City", ["City1", "City2"], _selectedCity, (value) {
                      setState(() => _selectedCity = value);
                    }),*/

                    // _buildMultiSelect(_categories, _selectedCategories),

                  ],
                ),
              ),


              // Payment/Bank Details Section
              _buildSection(
                title: "Payment/Bank Details",
                child: Column(
                  children: [
                    _buildTextField(_accountHolderController, "Account Holder Name", Icons.account_circle),
                    _buildTextField(_accountNumberController, "Account Number", Icons.account_balance),
                    _buildTextField(_bankNameController, "Bank", Icons.account_balance),
                    _buildTextField(_ifscCodeController, "IFSC Code", Icons.code),
                    _buildTextField(_panController, "PAN Number", Icons.credit_card),
                    _buildTextField(_upiNumberController, "UPI Number", Icons.payment),
                  ],
                ),
              ),
              // Social Media Section

              // Save Button
              GestureDetector(
                onTap: () {
                  // Save logic here
                  _submitForm();
                  // _uploadImage();
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xffFF04AB), Color(0xffAE26CD)],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Save Changes',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Image Update (Circular Shape with Pencil Icon)
  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        _pickImage(); // Trigger image selection when the circle is tapped
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _profileImagePath != null
                ? NetworkImage(_profileImagePath!) // Display selected image
                : NetworkImage('https://demo.infoskaters.com/api/uploads/default_profile.png') // Fetch default image from API
            as ImageProvider,
            backgroundColor: Colors.grey[300], // Fallback background color
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black, // Black background for pencil icon
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /* Widget _buildProfileImage() {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _profileImagePath != null
              ? NetworkImage(_profileImagePath!) // Update this with your image source
              : const AssetImage('images/default_profile.png') as ImageProvider,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              _pickImage();
              // Add logic to change profile picture here (e.g., picking an image from gallery or camera)
            },
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }*/

  // Helper Widgets
  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: label == "Password" ? !_passwordVisible : !_confirmPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              label == "Password"
                  ? (_passwordVisible ? Icons.visibility : Icons.visibility_off)
                  : (_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            ),
            onPressed: () {
              setState(() {
                if (label == "Password") {
                  _passwordVisible = !_passwordVisible;
                } else {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                }
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>(String label, List<T> items, T? selectedItem, ValueChanged<T?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, ValueChanged<DateTime?> onDateChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null && pickedDate != selectedDate) {
            onDateChanged(pickedDate);
          }
        },
      ),
    );
  }

  Widget _buildTagSelector(List<String> availableTags, List<String> selectedTags, int maxSelection) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: availableTags.map((tag) {
          return ChoiceChip(
            label: Text(tag),
            selected: selectedTags.contains(tag),
            onSelected: (selected) {
              setState(() {
                if (selected) {
                  if (selectedTags.length < maxSelection) {
                    selectedTags.add(tag);
                  }
                } else {
                  selectedTags.remove(tag);
                }
              });
            },
          );
        }).toList(),
      ),
    );
  }

  /*Widget _buildMultiSelect(List<String> items, List<String> selectedItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MultiSelectDialogField<String>(
        title: const Text("Select Categories"),
        items: items.map((item) {
          return MultiSelectItem<String>(item, item);
        }).toList(),
        initialValue: selectedItems,
        onConfirm: (selected) {
          setState(() {
            selectedItems = selected;
          });
        },
      ),
    );
  }*/

  Widget _buildMultiSelect(List<String> items, List<String> selectedItems) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: MultiSelectDialogField<String>(
        title: const Text("Select Categories"),
        items: items.map((item) => MultiSelectItem<String>(item, item)).toList(),
        initialValue: selectedItems,
        buttonText: const Text("Select Categories"),
        onConfirm: (List<String> selected) {
          setState(() {
            selectedItems.clear();
            selectedItems.addAll(selected); // Update selected items list
          });

          // Returning the updated list
          print("Selected Items: $selectedItems");
        },
      ),
    );
  }

  Widget _buildSocialField(String platform, TextEditingController followersController,
      TextEditingController linkController, IconData icon) {
    return Column(
      children: [
        _buildTextField(followersController, "$platform Followers", icon),
        _buildTextField(linkController, "$platform Profile Link", icon),
      ],
    );
  }
}
*/

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tngtong/api_service.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  SharedPreferences? prefs;
  String? loginEmail;
  String? userId;

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedDate;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final String? _profileImagePath = null;
  final String _apiUrl = "https://demo.infoskaters.com/api/affiliater_update_profile.php";
  File? _selectedImage;
  String _serverUrl = "https://demo.infoskaters.com/api/upload.php";

  @override
  void initState() {
    super.initState();
    _initializePreferences();
  }

  Future<void> _initializePreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      loginEmail = prefs?.getString('loginEmail');
    });
    fetchUserId();
  }

  Future<void> fetchUserId() async {
    String? id = await ApiService.getAffilaterId(loginEmail);
    setState(() {
      userId = id;
    });
    fetchProfileData(userId!);
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    try {
      var response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'u_id': userId,
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'password': _passwordController.text,
          'confirm_password': _confirmPasswordController.text,
          'address': _addressController.text,
          'country': _countryController.text,
          'state': _stateController.text,
          'city': _cityController.text,
          'zip_code': _zipController.text,
          'bank_name': _bankNameController.text,
          'ifsc_code': _ifscCodeController.text,
          'account_number': _accountNumberController.text,
          'account_holder_name': _accountHolderController.text,
          'pan_number': _panController.text,
          'upi_number': _upiNumberController.text,
          'profile_photo_url': "",
          'gender': _selectedGender,
          "birthday": "1990-01-01",
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Success: ${responseData['message']}')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No image selected."),
        ),
      );
      return;
    }

    try {
      var request = http.MultipartRequest('POST', Uri.parse(_serverUrl));
      request.files.add(
          await http.MultipartFile.fromPath('image', _selectedImage!.path));
      request.fields['c_id'] = userId!;

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var json = jsonDecode(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(json['message'] ?? 'Image uploaded successfully!'),
          ),
        );
      } else {
        var responseData = await response.stream.bytesToString();
        debugPrint('Response status: ${response.statusCode}');
        debugPrint('Response body: $responseData');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to upload image. Please try again."),
          ),
        );
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    }
  }

  Future<void> fetchProfileData(String u_id) async {
    final String apiUrl = "https://demo.infoskaters.com/api/get_affiliater.php?u_id=$u_id";
    final String getasicDetailsApi = "https://demo.infoskaters.com/api/get_affiliater_basic.php?u_id=$u_id";

    try {
      final response = await http.get(Uri.parse(getasicDetailsApi));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        if (data.containsKey("error")) {
          print("Error: ${data['error']}");
          return;
        }

        setState(() {
          _nameController.text = data['a_name'] ?? '';
          _emailController.text = data['a_email'] ?? '';
          _phoneController.text = data['a_mob'] ?? '';
        });
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print(data);
        if (data.containsKey("error")) {
          print("Error: ${data['error']}");
          return;
        }

        setState(() {
          _addressController.text = data['address'] ?? '';
          _cityController.text = data['city'] ?? '';
          _stateController.text = data['state'] ?? '';
          _countryController.text = data['country'] ?? '';
          _zipController.text = data['zip_code'] ?? '';
          _bankNameController.text = data['bank_name'] ?? '';
          _ifscCodeController.text = data['ifsc_code'] ?? '';
          _accountNumberController.text = data['account_number'] ?? '';
          _accountHolderController.text = data['account_holder_name'] ?? '';
          _panController.text = data['pan_number'] ?? '';
          _upiNumberController.text = data['upi_number'] ?? '';
          _selectedGender = data['gender'] ?? '';
        });

        print("Data loaded successfully");
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (error) {
      print("Error fetching data: $error");
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Account"),
          content: const Text("Are you sure you want to delete your account? Your account will be automatically deleted within 2 days."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _deleteAccount(); // Call the delete account function
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount() async {
    final String deleteAccountUrl = "https://demo.infoskaters.com/api/delete_profile.php"; // Replace with your actual API endpoint

    try {
      final response = await http.post(
        Uri.parse(deleteAccountUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'u_id': userId, // Send the user ID to delete the account
          'u_type':'affiliater',
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Success: ${responseData['message']}')),
          );
          // Optionally, navigate the user to the login screen or another appropriate screen
         // Navigator.of(context).pushReplacementNamed('/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${responseData['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete account!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('MY Account',style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              _buildSection(
                title: "Basic Details",
                child: Column(
                  children: [
                  //  _buildProfileImage(),
                    _buildTextField(_nameController, "Name", Icons.person),
                    _buildTextField(_emailController, "Email", Icons.email),
                    _buildTextField(_phoneController, "Phone", Icons.phone),
                    _buildPasswordTextField(_passwordController, "Password"),
                    _buildPasswordTextField(_confirmPasswordController, "Confirm Password"),
                  ],
                ),
              ),
              _buildSection(
                title: "Profile Details",
                child: Column(
                  children: [
                    _buildDropdown<String>("Gender", ["Male", "Female"], _selectedGender, (value) {
                      setState(() => _selectedGender = value);
                    }),
                    _buildDatePicker("Birthday", _selectedDate, (date) {
                      setState(() => _selectedDate = date);
                    }),
                    _buildTextField(_addressController, "Address", Icons.location_on),
                    _buildTextField(_cityController, "City", Icons.location_on),
                    _buildTextField(_stateController, "State", Icons.location_on),
                    _buildTextField(_countryController, "Country", Icons.location_on),
                    _buildTextField(_zipController, "ZIP/PIN Code", Icons.pin_drop),
                  ],
                ),
              ),
              _buildSection(
                title: "Payment/Bank Details",
                child: Column(
                  children: [
                    _buildTextField(_accountHolderController, "Account Holder Name", Icons.account_circle),
                    _buildTextField(_accountNumberController, "Account Number", Icons.account_balance),
                    _buildTextField(_bankNameController, "Bank", Icons.account_balance),
                    _buildTextField(_ifscCodeController, "IFSC Code", Icons.code),
                    _buildTextField(_panController, "PAN Number", Icons.credit_card),
                    _buildTextField(_upiNumberController, "UPI Number", Icons.payment),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _submitForm();
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 207, 9, 204),
                  Color(0xffAE26CD)
                ],
            ),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
                  child: const Center(
                    child: Text(
                      'Save Changes',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              IconButton(
                onPressed: () {
                  _showDeleteConfirmationDialog();
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
                iconSize: 30,
                padding: EdgeInsets.zero, // Remove default padding if you want it more compact
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        _pickImage();
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: _profileImagePath != null
                ? NetworkImage(_profileImagePath!) // Display selected image
                : NetworkImage('https://demo.infoskaters.com/api/uploads/default_profile.png') // Fetch default image from API
            as ImageProvider,
            backgroundColor: Colors.grey[300], // Fallback background color
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black, // Black background for pencil icon
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: label == "Password" ? !_passwordVisible : !_confirmPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(
              label == "Password"
                  ? (_passwordVisible ? Icons.visibility : Icons.visibility_off)
                  : (_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            ),
            onPressed: () {
              setState(() {
                if (label == "Password") {
                  _passwordVisible = !_passwordVisible;
                } else {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                }
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>(String label, List<T> items, T? selectedItem, ValueChanged<T?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DropdownButtonFormField<T>(
        value: selectedItem,
        items: items.map((T item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Text(item.toString()),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, ValueChanged<DateTime?> onDateChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.calendar_today),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null && pickedDate != selectedDate) {
            onDateChanged(pickedDate);
          }
        },
      ),
    );
  }
}


