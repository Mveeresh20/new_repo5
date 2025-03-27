/*import 'package:flutter/material.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController();
  final TextEditingController _videoPriceController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();

  // Add file picker or image picker here for profile photo/video, etc.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB81736),
        title: const Text('Update Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              // Basic Details Section
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 3, blurRadius: 5)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Basic Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Add image picker code to pick profile photo
                      },
                      child: Container(
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[200],
                          image: const DecorationImage(image: AssetImage('assets/default_profile.png'), fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        label: Text('Name'),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        label: Text('Email'),
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                    TextField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        label: Text('Phone Number'),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      decoration: InputDecoration(
                        label: const Text('Confirm Password'),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible = !_confirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Profile Details Section
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 3, blurRadius: 5)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Profile Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Add image/video picker code for work photos/videos
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Icon(Icons.camera_alt, color: Colors.grey)),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _aboutController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        label: Text('About You (min 50 words)'),
                        prefixIcon: Icon(Icons.edit),
                      ),
                    ),
                    TextField(
                      controller: _workNameController,
                      decoration: const InputDecoration(
                        label: Text('Previous Work (Shows/Movies)'),
                        prefixIcon: Icon(Icons.work),
                      ),
                    ),
                    TextField(
                      controller: _videoPriceController,
                      decoration: const InputDecoration(
                        label: Text('Video Making Price'),
                        prefixIcon: Icon(Icons.monetization_on),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // KYC Details Section
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 3, blurRadius: 5)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('KYC Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _bankNameController,
                      decoration: const InputDecoration(
                        label: Text('Bank Name'),
                        prefixIcon: Icon(Icons.account_balance),
                      ),
                    ),
                    TextField(
                      controller: _ifscCodeController,
                      decoration: const InputDecoration(
                        label: Text('IFSC Code'),
                        prefixIcon: Icon(Icons.code),
                      ),
                    ),
                    TextField(
                      controller: _accountNumberController,
                      decoration: const InputDecoration(
                        label: Text('Account Number'),
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                    TextField(
                      controller: _accountHolderController,
                      decoration: const InputDecoration(
                        label: Text('Account Holder Name'),
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                    ),
                    TextField(
                      controller: _upiNumberController,
                      decoration: const InputDecoration(
                        label: Text('UPI Number'),
                        prefixIcon: Icon(Icons.payment),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Save Button
              GestureDetector(
                onTap: () {
                  // Add logic for saving the updated profile
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xffB81736),
                        Color(0xff281537),
                      ],
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
}*/
/*import 'package:flutter/material.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController();
  final TextEditingController _videoPriceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();
  final TextEditingController _instagramFollowersController = TextEditingController();
  final TextEditingController _instagramLinkController = TextEditingController();
  final TextEditingController _facebookFollowersController = TextEditingController();
  final TextEditingController _facebookLinkController = TextEditingController();
  final TextEditingController _linkedinFollowersController = TextEditingController();
  final TextEditingController _linkedinLinkController = TextEditingController();
  final TextEditingController _youtubeFollowersController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();
  final TextEditingController _twitterFollowersController = TextEditingController();
  final TextEditingController _twitterLinkController = TextEditingController();

  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;
  DateTime? _selectedDate;
  List<String> _selectedTags = [];
  List<String> _selectedCategories = [];
  String? _selectedProfession;

  final List<String> _tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5", "Tag6"];
  final List<String> _categories = ["Category1", "Category2", "Category3"];
  final List<String> _professions = ["Singer", "Director", "Influencer", "Actor"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB81736),
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
                    _buildDropdown<String>("Country", ["India", "USA"], _selectedCountry, (value) {
                      setState(() => _selectedCountry = value);
                    }),
                    _buildDropdown<String>("State", ["State1", "State2"], _selectedState, (value) {
                      setState(() => _selectedState = value);
                    }),
                    _buildDropdown<String>("City", ["City1", "City2"], _selectedCity, (value) {
                      setState(() => _selectedCity = value);
                    }),
                    _buildTextField(_zipController, "ZIP/PIN Code", Icons.pin_drop),
                    _buildTagSelector(_tags, _selectedTags, 5),
                    _buildMultiSelect(_categories, _selectedCategories),
                    _buildDropdown<String>("Profession", _professions, _selectedProfession, (value) {
                      setState(() => _selectedProfession = value);
                    }),
                  ],
                ),
              ),

              // Social Media Section
              _buildSection(
                title: "Social Media",
                child: Column(
                  children: [
                    _buildSocialField("Instagram", _instagramFollowersController, _instagramLinkController, Icons.camera_alt),
                    _buildSocialField("Facebook", _facebookFollowersController, _facebookLinkController, Icons.facebook),
                    _buildSocialField("LinkedIn", _linkedinFollowersController, _linkedinLinkController, Icons.facebook),
                    _buildSocialField("YouTube", _youtubeFollowersController, _youtubeLinkController, Icons.video_library),
                    _buildSocialField("Twitter", _twitterFollowersController, _twitterLinkController, Icons.chat),
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

              // Save Button
              GestureDetector(
                onTap: () {
                  // Save logic here
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xffB81736), Color(0xff281537)],
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
          label: Text(label),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: !_passwordVisible,
        decoration: InputDecoration(
          label: Text(label),
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() => _passwordVisible = !_passwordVisible);
            },
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
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, DateTime? selectedDate, ValueChanged<DateTime?> onDateSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
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
        child: AbsorbPointer(
          child: TextField(
            decoration: InputDecoration(
              labelText: label,
              hintText: selectedDate != null
                  ? "${selectedDate.toLocal()}".split(' ')[0]
                  : "Select Date",
              prefixIcon: const Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTagSelector(List<String> tags, List<String> selectedTags, int maxSelection) {
    return Wrap(
      spacing: 5,
      children: tags.map((tag) {
        bool isSelected = selectedTags.contains(tag);
        return FilterChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (bool selected) {
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
    );
  }

  Widget _buildMultiSelect(List<String> items, List<String> selectedItems) {
    return Wrap(
      spacing: 5,
      children: items.map((item) {
        bool isSelected = selectedItems.contains(item);
        return ChoiceChip(
          label: Text(item),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedItems.add(item);
              } else {
                selectedItems.remove(item);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSocialField(String platform, TextEditingController followerController, TextEditingController linkController, IconData icon) {
    return Column(
      children: [
        _buildTextField(followerController, "$platform Followers", icon),
        _buildTextField(linkController, "$platform Link", Icons.link),
      ],
    );
  }
}*/

//third implimantation in code
/*import 'package:flutter/material.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // Basic Details
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Profile Details
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;
  DateTime? _selectedDate;
  List<String> _selectedTags = [];
  List<String> _selectedCategories = [];
  String? _selectedProfession;

  final List<String> _tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5", "Tag6"];
  final List<String> _categories = ["Category1", "Category2", "Category3"];
  final List<String> _professions = ["Singer", "Director", "Influencer", "Actor"];

  // Payment/Bank Details
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();

  // Social Media
  final TextEditingController _instagramFollowersController = TextEditingController();
  final TextEditingController _instagramLinkController = TextEditingController();
  final TextEditingController _facebookFollowersController = TextEditingController();
  final TextEditingController _facebookLinkController = TextEditingController();
  final TextEditingController _linkedinFollowersController = TextEditingController();
  final TextEditingController _linkedinLinkController = TextEditingController();
  final TextEditingController _youtubeFollowersController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();
  final TextEditingController _twitterFollowersController = TextEditingController();
  final TextEditingController _twitterLinkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB81736),
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
                    _buildDropdown<String>("Country", ["India", "USA"], _selectedCountry, (value) {
                      setState(() => _selectedCountry = value);
                    }),
                    _buildDropdown<String>("State", ["State1", "State2"], _selectedState, (value) {
                      setState(() => _selectedState = value);
                    }),
                    _buildDropdown<String>("City", ["City1", "City2"], _selectedCity, (value) {
                      setState(() => _selectedCity = value);
                    }),
                    _buildTextField(_zipController, "ZIP/PIN Code", Icons.pin_drop),
                    _buildTagSelector(_tags, _selectedTags, 5),
                    _buildMultiSelect(_categories, _selectedCategories),
                    _buildDropdown<String>("Profession", _professions, _selectedProfession, (value) {
                      setState(() => _selectedProfession = value);
                    }),
                  ],
                ),
              ),

              // Social Media Section
              _buildSection(
                title: "Social Media",
                child: Column(
                  children: [
                    _buildSocialField("Instagram", _instagramFollowersController, _instagramLinkController, Icons.camera_alt),
                    _buildSocialField("Facebook", _facebookFollowersController, _facebookLinkController, Icons.facebook),
                    _buildSocialField("LinkedIn", _linkedinFollowersController, _linkedinLinkController, Icons.facebook),
                    _buildSocialField("YouTube", _youtubeFollowersController, _youtubeLinkController, Icons.video_library),
                    _buildSocialField("Twitter", _twitterFollowersController, _twitterLinkController, Icons.chat),
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

              // Save Button
              GestureDetector(
                onTap: () {
                  // Save logic here
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xffB81736), Color(0xff281537)],
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
          if (pickedDate != null) {
            onDateChanged(pickedDate);
          }
        },
      ),
    );
  }

  Widget _buildTagSelector(List<String> tags, List<String> selectedTags, int maxTags) {
    return Wrap(
      spacing: 5,
      children: tags.map((tag) {
        final isSelected = selectedTags.contains(tag);
        return FilterChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                if (selectedTags.length < maxTags) {
                  selectedTags.add(tag);
                }
              } else {
                selectedTags.remove(tag);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildMultiSelect(List<String> items, List<String> selectedItems) {
    return Wrap(
      spacing: 5,
      children: items.map((item) {
        return FilterChip(
          label: Text(item),
          selected: selectedItems.contains(item),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedItems.add(item);
              } else {
                selectedItems.remove(item);
              }
            });
          },
        );
      }).toList(),
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
  }}*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////
/*import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  _ProfileUpdateScreenState createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  // Basic Details
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Profile Details
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _zipController = TextEditingController();

  // Professional Details
  final TextEditingController _videoPriceController = TextEditingController();
  final TextEditingController _firstRevisionPriceController = TextEditingController();
  final TextEditingController _secondRevisionPriceController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();
  final TextEditingController _workDetailsController = TextEditingController();

  // Payment/Bank Details
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();

  // Social Media
  final TextEditingController _instagramFollowersController = TextEditingController();
  final TextEditingController _instagramLinkController = TextEditingController();
  final TextEditingController _facebookFollowersController = TextEditingController();
  final TextEditingController _facebookLinkController = TextEditingController();
  final TextEditingController _linkedinFollowersController = TextEditingController();
  final TextEditingController _linkedinLinkController = TextEditingController();
  final TextEditingController _youtubeFollowersController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();
  final TextEditingController _twitterFollowersController = TextEditingController();
  final TextEditingController _twitterLinkController = TextEditingController();
  String? _selectedGender;
  /*String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;*/
  DateTime? _selectedDate;
  List<String> _selectedTags = [];
  List<String> _selectedCategories = [];
  String? _selectedProfession;

  final List<String> _tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5", "Tag6"];
  final List<String> _categories = ["Category1", "Category2", "Category3"];
  final List<String> _professions = ["Singer", "Director", "Influencer", "Actor"];

  final String? _profileImagePath = null; // Path to the profile image, can be updated by the user.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffB81736),
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

              // Professional Details Section
              _buildSection(
                title: "Professional Details",
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        // Add image/video picker code for work photos/videos
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Icon(Icons.camera_alt, color: Colors.grey)),
                      ),
                    ),
                    _buildDropdown<String>("Profession", _professions, _selectedProfession, (value) {
                      setState(() => _selectedProfession = value);
                    }),
                    _buildTextField(_aboutController, "About You (50-60 words)", Icons.description),
                    _buildMultiSelect(_categories, _selectedCategories),
                    _buildTagSelector(_tags, _selectedTags, 5),

                    _buildTextField(_videoPriceController, "Video Price", Icons.attach_money),
                    _buildTextField(_firstRevisionPriceController, "1 Revision Price", Icons.attach_money),
                    _buildTextField(_secondRevisionPriceController, "2 Revision Price", Icons.attach_money),
                    _buildTextField(_profilePhotoController, "Profile Photo (URL)", Icons.image),
                    _buildTextField(_workDetailsController, "Work Details (Shows/Movies)", Icons.work),
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
              _buildSection(
                title: "Social Media",
                child: Column(
                  children: [
                    _buildSocialField("Instagram", _instagramFollowersController, _instagramLinkController, Icons.camera_alt),
                    _buildSocialField("Facebook", _facebookFollowersController, _facebookLinkController, Icons.facebook),
                    _buildSocialField("LinkedIn", _linkedinFollowersController, _linkedinLinkController, Icons.facebook),
                    _buildSocialField("YouTube", _youtubeFollowersController, _youtubeLinkController, Icons.video_library),
                    _buildSocialField("Twitter", _twitterFollowersController, _twitterLinkController, Icons.chat),
                  ],
                ),
              ),
              // Save Button
              GestureDetector(
                onTap: () {
                  // Save logic here
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xffB81736), Color(0xff281537)],
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
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: _profileImagePath != null
              ? NetworkImage(_profileImagePath!) // Update this with your image source
              : const AssetImage('assets/images/default_profile.png') as ImageProvider,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
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
  }

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

  Widget _buildMultiSelect(List<String> items, List<String> selectedItems) {
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
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _workNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  final TextEditingController _zipController = TextEditingController();

  // Professional Details
  final TextEditingController _videoPriceController = TextEditingController();
  final TextEditingController _firstRevisionPriceController = TextEditingController();
  final TextEditingController _secondRevisionPriceController = TextEditingController();
  final TextEditingController _profilePhotoController = TextEditingController();
  final TextEditingController _workDetailsController = TextEditingController();

  // Payment/Bank Details
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _ifscCodeController = TextEditingController();
  final TextEditingController _accountNumberController = TextEditingController();
  final TextEditingController _accountHolderController = TextEditingController();
  final TextEditingController _panController = TextEditingController();
  final TextEditingController _upiNumberController = TextEditingController();

  // Social Media
  final TextEditingController _instagramFollowersController = TextEditingController();
  final TextEditingController _instagramLinkController = TextEditingController();
  final TextEditingController _facebookFollowersController = TextEditingController();
  final TextEditingController _facebookLinkController = TextEditingController();
  final TextEditingController _linkedinFollowersController = TextEditingController();
  final TextEditingController _linkedinLinkController = TextEditingController();
  final TextEditingController _youtubeFollowersController = TextEditingController();
  final TextEditingController _youtubeLinkController = TextEditingController();
  final TextEditingController _twitterFollowersController = TextEditingController();
  final TextEditingController _twitterLinkController = TextEditingController();
  String? _selectedGender;
  /*String? _selectedCountry;
  String? _selectedState;
  String? _selectedCity;*/
  DateTime? _selectedDate;
  List<String> _selectedTags = [];
  List<String> _selectedCategories = [];
  String? _selectedProfession;

  final List<String> _tags = ["Tag1", "Tag2", "Tag3", "Tag4", "Tag5", "Tag6"];
  final List<String> _categories = ["Category1", "Category2", "Category3"];
  final List<String> _professions = ["Singer", "Director", "Influencer", "Actor"];
// Image picker
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  final String? _profileImagePath = null; // Path to the profile image, can be updated by the user.
  String? imgurl="";
  final String _apiUrl = "https://demo.infoskaters.com/api/celebrity_update_profile.php";
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
    String? id = await ApiService.getCelId(loginEmail);
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
      print("Selected category submit ${_selectedCategories}");

      var response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json', // Use application/json if you're sending JSON
        },
        body: jsonEncode({

          //////////////////
          'c_id':userId ,
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'password': _passwordController.text,
          'confirm_password': _confirmPasswordController.text,

          // Profile Details
          'about_you': _aboutController.text,
          'work_name': _workNameController.text,
          'address': _addressController.text,
          'country': _countryController.text,
          'state': _stateController.text,
          'city': _cityController.text,
          'zip_code': _zipController.text,

          // Professional Details
          'video_price': _videoPriceController.text,
          'first_revision_price': _firstRevisionPriceController.text,
          'second_revision_price': _secondRevisionPriceController.text,
          //'profile_photo_url': _profilePhotoController.text,
          'work_details': _workDetailsController.text,

          // Payment/Bank Details
          'bank_name': _bankNameController.text,
          'ifsc_code': _ifscCodeController.text,
          'account_number': _accountNumberController.text,
          'account_holder_name': _accountHolderController.text,
          'pan_number': _panController.text,
          'upi_number': _upiNumberController.text,

          // Social Media
          'profile_photo_url':"",
          'instagram_followers': _instagramFollowersController.text,
          'instagram_link': _instagramLinkController.text,
          'facebook_followers': _facebookFollowersController.text,
          'facebook_link': _facebookLinkController.text,
          'linkedin_followers': _linkedinFollowersController.text,
          'linkedin_link': _linkedinLinkController.text,
          'youtube_followers': _youtubeFollowersController.text,
          'youtube_link': _youtubeLinkController.text,
          'twitter_followers': _twitterFollowersController.text,
          'twitter_link': _twitterLinkController.text,

          // Gender and Date of Birth
          'gender': _selectedGender,
          //'birthday': _selectedDate?.toIso8601String(),

          // Tags and Categories
          'tags_str': jsonEncode(_selectedTags),
          'categories_str': jsonEncode(_selectedCategories),
          // 'profession': _selectedProfession,
          //
          /* "c_id": 2,
          "about_you": "I am a professional artist with 5 years of experience.",
          "work_name": "Freelance Illustrator",
          "address": "123 Creative Lane",
          "city": "Mumbai",
          "state": "Maharashtra",
          "country": "India",
          "zip_code": "400001",
          "video_price": "5000",
          "first_revision_price": "2000",
          "second_revision_price": "1000",
          "work_details": "Specialized in digital illustrations, logo design, and branding.",
          "bank_name": "HDFC Bank",
          "ifsc_code": "HDFC0001234",
          "account_number": "123456789101",
          "account_holder_name": "John Doe",
          "pan_number": "ABCDE1234F",
          "upi_number": "john.doe@upi",
          "gender": "Male",*/
          "birthday": "1990-01-01",
          /* "categories_str": "[\"Illustration\", \"Graphic Design\"]",
         /"tags_str": "[\"Freelance\", \"Digital Art\"]",
         /*"profile_photo_url":"",
          "instagram_followers":"",
          "instagram_link":"",
          "facebook_followers":"",
          "facebook_link":"",
          "linkedin_followers":"",
          "linkedin_link":"",
          "youtube_followers":"",
          "youtube_link":"",
          "twitter_followers":"",
          "twitter_link":"",*/
////////////////////////////////////////////////////////////////
          // Add other fields here...*/
          /*"about_you": "This is a test about me section.",
          "work_name": "Actor",
          "address": "123 Test Lane",
          "city": "Test City",
          "state": "Test State",
          "country": "Test Country",
          "zip_code": "123456",*/
          /* "video_price": "5000",
          "first_revision_price": "1000",
          "second_revision_price": "1500",
          "profile_photo_url": "https://example.com/profile.jpg",
          "work_details": "Experienced actor with over 10 years in the industry.",
          "bank_name": "Test Bank",
          "ifsc_code": "TEST0001234",
          "account_number": "1234567890",
          "account_holder_name": "John Doe",
          "pan_number": "ABCDE1234F",
          "upi_number": "1234567890@upi",
          "instagram_followers": "10000",
          "instagram_link": "https://instagram.com/test",
          "facebook_followers": "5000",
          "facebook_link": "https://facebook.com/test",
          "linkedin_followers": "2000",
          "linkedin_link": "https://linkedin.com/test",
          "youtube_followers": "15000",
          "youtube_link": "https://youtube.com/test",
          "twitter_followers": "3000",
          "twitter_link": "https://twitter.com/test",*/
          /* "gender": "Male",
          "birthday": "1990-01-01",
          "categories_str": "Actor, Influencer",
          "tags_str": "Movies, Acting, Influencer",
          "c_id": "2"*/
        }),
        /* body: jsonEncode({
            "c_id": 2,
            "about_you": "I am a professional artist with 5 years of experience.",
            "work_name": "Freelance Illustrator",
            "address": "123 Creative Lane",
            "city": "Mumbai",
            "state": "Maharashtra",
            "country": "India",
            "zip_code": "400001",
            "video_price": "5000",
            "first_revision_price": "2000",
            "second_revision_price": "1000",
            "work_details": "Specialized in digital illustrations, logo design, and branding.",
            "bank_name": "HDFC Bank",
            "ifsc_code": "HDFC0001234",
            "account_number": "123456789101",
            "account_holder_name": "John Doe",
            "pan_number": "ABCDE1234F",
            "upi_number": "john.doe@upi",
            "gender": "Male",
            "birthday": "1990-01-01",
            "categories_str": "[\"Illustration\", \"Graphic Design\"]",
            "tags_str": "[\"Freelance\", \"Digital Art\"]",
            "profile_photo_url":"",
            "instagram_followers":"",
            "instagram_link":"",
            "facebook_followers":"",
            "facebook_link":"",
            "linkedin_followers":"",
            "linkedin_link":"",
            "youtube_followers":"",
            "youtube_link":"",
            "twitter_followers":"",
            "twitter_link":""

          }),*/

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
    _uploadImage();
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


  Future<void> fetchProfileData(String c_id) async {
    final String apiUrl = "https://demo.infoskaters.com/api/get_celebrity.php?c_id=$c_id";
    final String getasicDetailsApi = "https://demo.infoskaters.com/api/get_celebrity_basic.php?c_id=$c_id";
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
          _nameController.text = data['c_name'] ?? '';
          _emailController.text = data['c_email'] ?? '';
          _phoneController.text = data['c_mob'] ?? '';

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
          _aboutController.text = data['about_you'] ?? '';
          _workNameController.text = data['work_name'] ?? '';
          _addressController.text = data['address'] ?? '';
          _cityController.text = data['city'] ?? '';
          _stateController.text = data['state'] ?? '';
          _countryController.text = data['country'] ?? '';
          _zipController.text = data['zip_code'] ?? '';
          _videoPriceController.text = data['video_price'] ?? '';
          _firstRevisionPriceController.text = data['first_revision_price'] ?? '';
          _secondRevisionPriceController.text = data['second_revision_price'] ?? '';
          _workDetailsController.text = data['work_details'] ?? '';
          _bankNameController.text = data['bank_name'] ?? '';
          _ifscCodeController.text = data['ifsc_code'] ?? '';
          _accountNumberController.text = data['account_number'] ?? '';
          _accountHolderController.text = data['account_holder_name'] ?? '';
          _panController.text = data['pan_number'] ?? '';
          _upiNumberController.text = data['upi_number'] ?? '';
          _instagramFollowersController.text = data['instagram_followers'].toString();
          _instagramLinkController.text = data['instagram_link'] ?? '';
          _facebookFollowersController.text = data['facebook_followers'].toString();
          _facebookLinkController.text = data['facebook_link'] ?? '';
          _linkedinFollowersController.text = data['linkedin_followers'].toString();
          _linkedinLinkController.text = data['linkedin_link'] ?? '';
          _youtubeFollowersController.text = data['youtube_followers'].toString();
          _youtubeLinkController.text = data['youtube_link'] ?? '';
          _twitterFollowersController.text = data['twitter_followers'].toString();
          _twitterLinkController.text = data['twitter_link'] ?? '';
           imgurl='https://demo.infoskaters.com/api/${data['profile_photo_url'] ?? 'uploads/default_profile.png'}';
         // _selectedTags=["Tag1", "Tag2", "Tag3", "Tag4", "Tag5", "Tag6"];
          _selectedGender=data['gender'] ?? '';
          //  _selectedDate=data['birthday'] ?? '';
          /*  if (data['birthday'] != null && data['birthday'].isNotEmpty) {
            try {
              //_selectedDate = DateTime.parse(data['birthday']);
            } catch (e) {
              print("Error parsing date: $e");
            }
          }*/
          _selectedCategories =List<String>.from(jsonDecode(data['categories_str']));
          //_selectedCategories=["Category1","Category2"];
          _selectedTags = List<String>.from(jsonDecode(data['tags_str']));
          // _selectedProfession=data['gender'] ?? '';
        });
        print("Selected tags are ${_selectedTags}");
        print("Selected category are ${_selectedCategories}");

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
          'u_type': 'celebrity', // Send the user type
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Success: ${responseData['message']}')),
          );
          // Optionally, navigate the user to the login screen or another appropriate screen
          //Navigator.of(context).pushReplacementNamed('/login');
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

              // Professional Details Section
              _buildSection(
                title: "Professional Details",
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    /* GestureDetector(
                      onTap: () {
                        // Add image/video picker code for work photos/videos
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(child: Icon(Icons.camera_alt, color: Colors.grey)),
                      ),
                    ),*/
                    _buildDropdown<String>("Profession", _professions, _selectedProfession, (value) {
                      setState(() => _selectedProfession = value);
                    }),
                    _buildTextField(_aboutController, "About You (50-60 words)", Icons.description),
                    _buildMultiSelect(_categories, _selectedCategories),
                    _buildTagSelector(_tags, _selectedTags, 5),

                    _buildTextField(_videoPriceController, "Video Price", Icons.attach_money),
                    _buildTextField(_firstRevisionPriceController, "1 Revision Price", Icons.attach_money),
                    _buildTextField(_secondRevisionPriceController, "2 Revision Price", Icons.attach_money),
                    // _buildTextField(_profilePhotoController, "Profile Photo (URL)", Icons.image),
                    _buildTextField(_workDetailsController, "Work Details (Shows/Movies)", Icons.work),
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
              _buildSection(
                title: "Social Media",
                child: Column(
                  children: [
                    _buildSocialField("Instagram", _instagramFollowersController, _instagramLinkController, Icons.camera_alt),
                    _buildSocialField("Facebook", _facebookFollowersController, _facebookLinkController, Icons.facebook),
                    _buildSocialField("LinkedIn", _linkedinFollowersController, _linkedinLinkController, Icons.facebook),
                    _buildSocialField("YouTube", _youtubeFollowersController, _youtubeLinkController, Icons.video_library),
                    _buildSocialField("Twitter", _twitterFollowersController, _twitterLinkController, Icons.chat),
                  ],
                ),
              ),
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
              // Inside the Column widget, below the "Save Changes" button
              const SizedBox(height: 10),

             /* GestureDetector(
                onTap: () {
                  _showDeleteConfirmationDialog(); // Show confirmation dialog
                },

                child: Container(
                  height: 55,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.red, // Red color for delete button
                  ),
                  child: const Center(
                    child: Text(
                      'Delete Profile',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),*/
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

  // Profile Image Update (Circular Shape with Pencil Icon)
  Widget _buildProfileImage() {
    return GestureDetector(
      onTap: () {
        _pickImage(); // Trigger image selection when the circle is tapped
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
         /* CircleAvatar(
            radius: 60,
            backgroundImage: _profileImagePath != null
                ? NetworkImage(_profileImagePath!) // Display selected image
                : NetworkImage('https://demo.infoskaters.com/api/uploads/default_profile.png') // Fetch default image from API
            as ImageProvider,
            backgroundColor: Colors.grey[300], // Fallback background color
          ),*/
          CircleAvatar(
            radius: 60,
            backgroundImage: _profileImagePath != null
                ? NetworkImage(_profileImagePath!) // Selected image from device
                : NetworkImage(imgurl!) as ImageProvider, // Default image
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



