/*import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'OrderPaymentScreen.dart';
import 'package:tngtong/config.dart';

class HireInfluencerScreen extends StatelessWidget {
  final Map<String, dynamic> influencer;
  HireInfluencerScreen({Key? key, required this.influencer}) : super(key: key);

  final TextEditingController _requirementController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Hire ${influencer['name'] ?? 'Influencer'}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 40),

                _buildProfileCard(),
                SizedBox(height: 20),
                _buildRequirementSection(),
                SizedBox(height: 20),
                _buildPaymentButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade800, Colors.pink.shade400],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: influencer['image'] != null && influencer['image'].isNotEmpty
                  ? NetworkImage("${Config.apiDomain}/${influencer['image']}")
                  : AssetImage('assets/default_profile.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              influencer['name'] ?? 'Unknown',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              influencer['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook, influencer['facebook'], influencer['followers_fb']),
                SizedBox(width: 20),
                _buildSocialIcon(Icons.camera_alt, influencer['instagram'], influencer['followers_insta']),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter Requirements:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 5),
        TextField(
          controller: _requirementController,
          maxLength: 150,
          maxLines: 3,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            hintText: "Describe your requirements...",
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderPaymentScreen(
                influencer: influencer,
                requirement: _requirementController.text.trim(),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Text(
            "Proceed to Pay ₹${influencer['price'] ?? 'N/A'}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
        ),
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, dynamic url, dynamic followers) {
    if (url == null || url.toString().isEmpty) {
      return SizedBox(); // Hide if no URL
    }
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30, color: Colors.white),
          onPressed: () => launchUrl(Uri.parse(url.toString())),
        ),
        Text(
          "${followers ?? '0'} followers",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}*/
///////////////////////////////


/*
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'OrderPaymentScreen.dart';
import 'package:tngtong/config.dart';

class HireInfluencerScreen extends StatelessWidget {
  final Map<String, dynamic> influencer;
  HireInfluencerScreen({Key? key, required this.influencer}) : super(key: key);

  final TextEditingController _requirementController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Hire ${influencer['name'] ?? 'Influencer'}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 80),

                _buildProfileCard(),
                SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: _buildRequirementSection(),
                ),

                SizedBox(height: 20),
                _buildPaymentButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: influencer['image'] != null && influencer['image'].isNotEmpty
                  ? NetworkImage("${Config.apiDomain}/${influencer['image']}")
                  : AssetImage('assets/default_profile.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              influencer['name'] ?? 'Unknown',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              influencer['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSocialIcon(Icons.facebook, influencer['facebook'], influencer['followers_fb']),
                SizedBox(width: 20),
                _buildSocialIcon(Icons.camera_alt, influencer['instagram'], influencer['followers_insta']),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildRequirementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter Requirements:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 5),
        TextFormField(
          controller: _requirementController,
          maxLength: 150,
          maxLines: 3,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            hintText: "Describe your requirements...",
            hintStyle: TextStyle(color: Colors.white70),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Requirement is required';
            }
            return null;
          },
        ),
      ],
    );
  }
  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade800, Colors.pink.shade400],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
  Widget _buildSocialIcon(IconData icon, dynamic url, dynamic followers) {
    if (url == null || url.toString().isEmpty) {
      return SizedBox(); // Hide if no URL
    }
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 30, color: Colors.black),
          onPressed: () => launchUrl(Uri.parse(url.toString())),
        ),
        Text(
          "${followers ?? '0'} followers",
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
  Widget _buildPaymentButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderPaymentScreen(
                  influencer: influencer,
                  requirement: _requirementController.text.trim(),
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Text(
            "Proceed to Pay ₹${influencer['price'] ?? 'N/A'}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'OrderPaymentScreen.dart';
import 'package:tngtong/config.dart';
import 'package:social_media_buttons/social_media_button.dart';

class HireInfluencerScreen extends StatelessWidget {
  final Map<String, dynamic> influencer;
  HireInfluencerScreen({Key? key, required this.influencer}) : super(key: key);

  final TextEditingController _requirementController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Hire ${influencer['name'] ?? 'Influencer'}",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          _buildGradientBackground(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 80),

                _buildProfileCard(),
                SizedBox(height: 20),

                Form(
                  key: _formKey,
                  child: _buildRequirementSection(),
                ),

                SizedBox(height: 20),
                _buildPaymentButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: influencer['image'] != null && influencer['image'].isNotEmpty
                  ? NetworkImage("${Config.apiDomain}/${influencer['image']}")
                  : AssetImage('assets/default_profile.png') as ImageProvider,
            ),
            SizedBox(height: 10),
            Text(
              influencer['name'] ?? 'Unknown',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 5),
            Text(
              influencer['description'] ?? 'No description available.',
              style: TextStyle(fontSize: 16, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            // Display Social Media Icons with Followers
            _buildSocialMediaSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialMediaSection() {
    return Wrap(
      spacing: 20, // Horizontal spacing between icons
      runSpacing: 10, // Vertical spacing between rows
      alignment: WrapAlignment.center,
      children: [
        if (influencer['facebook_link'] != null && influencer['facebook_link'].toString().isNotEmpty)
          _buildSocialIcon(
            SocialMediaButton.facebook(
              onTap: () => launchUrl(Uri.parse(influencer['facebook_link'])),
              size: 24,
              color: Colors.blue,
            ),
            influencer['facebook_followers'] ?? '0',
          ),
        if (influencer['instagram_link'] != null && influencer['instagram_link'].toString().isNotEmpty)
          _buildSocialIcon(
            SocialMediaButton.instagram(
              onTap: () => launchUrl(Uri.parse(influencer['instagram_link'])),
              size: 24,
              color: Colors.purple,
            ),
            influencer['instagram_followers'] ?? '0',
          ),
        if (influencer['linkedin_link'] != null && influencer['linkedin_link'].toString().isNotEmpty)
          _buildSocialIcon(
            SocialMediaButton.linkedin(
              onTap: () => launchUrl(Uri.parse(influencer['linkedin_link'])),
              size: 24,
              color: Colors.blue,
            ),
            influencer['linkedin_followers'] ?? '0',
          ),
        if (influencer['youtube_link'] != null && influencer['youtube_link'].toString().isNotEmpty)
          _buildSocialIcon(
            SocialMediaButton.youtube(
              onTap: () => launchUrl(Uri.parse(influencer['youtube_link'])),
              size: 24,
              color: Colors.red,
            ),
            influencer['youtube_followers'] ?? '0',
          ),
        if (influencer['twitter_link'] != null && influencer['twitter_link'].toString().isNotEmpty)
          _buildSocialIcon(
            SocialMediaButton.twitter(
              onTap: () => launchUrl(Uri.parse(influencer['twitter_link'])),
              size: 24,
              color: Colors.blue,
            ),
            influencer['twitter_followers'] ?? '0',
          ),
      ],
    );
  }

  Widget _buildSocialIcon(Widget icon, String followers) {
    return Column(
      children: [
        icon, // Use the provided SocialMediaButton widget
        SizedBox(height: 4), // Spacing between icon and followers text
        Text(
          "$followers followers",
          style: TextStyle(color: Colors.black54, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRequirementSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter Requirements:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 5),
        TextFormField(
          controller: _requirementController,
          maxLength: 150,
          maxLines: 3,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            hintText: "Describe your requirements...",
            hintStyle: TextStyle(color: Colors.white70),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Requirement is required';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade800, Colors.pink.shade400],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderPaymentScreen(
                  influencer: influencer,
                  requirement: _requirementController.text.trim(),
                ),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Text(
            "Proceed to Pay ₹${influencer['price'] ?? 'N/A'}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
        ),
      ),
    );
  }
}