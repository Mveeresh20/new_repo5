import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tngtong/customer/HireInfluencerScreen.dart';
import 'package:tngtong/config.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TrendingAds extends StatefulWidget {
  // Change to StatefulWidget
  final List<dynamic> trendingAds;

  TrendingAds({required this.trendingAds});

  @override
  _TrendingAdsState createState() => _TrendingAdsState();
}

class _TrendingAdsState extends State<TrendingAds> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredTrendingAds = [];

  @override
  void initState() {
    super.initState();
    _filteredTrendingAds =
        widget.trendingAds; // Initialize with all trending ads
  }

  void _searchInfluencers(String query) {
    setState(() {
      _filteredTrendingAds = widget.trendingAds
          .where((influencer) =>
      influencer['name'].toLowerCase().contains(query.toLowerCase()) ||
          influencer['price'].toString().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            'Trending Ads',
            style: TextStyle(color: Colors.white),
          )),
      body: Column(
        children: [
          // Search bar
          _buildSearchBar(),
          // List of trending ads
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.555,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 20),
              itemCount: _filteredTrendingAds.length,
              itemBuilder: (context, index) =>
                  _buildCard(context, _filteredTrendingAds[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter:
          ImageFilter.blur(sigmaX: 20, sigmaY: 20), // Adjust blur intensity
          child: Container(
            color: Colors.blue.withOpacity(0.2), // Very subtle white overlay
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                hintText: "Search influencer by name or price",
                border: InputBorder.none,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                _searchInfluencers(value);
              },
              onSubmitted: (value) {
                _searchInfluencers(value);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, dynamic influencer) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HireInfluencerScreen(influencer: influencer),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                        influencer['image'] != null &&
                            influencer['image'].toString().isNotEmpty
                            ? "${Config.apiDomain}/${influencer['image']}"
                            : "https://demo.infoskaters.com/api/uploads/default_profile.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                influencer['name'] ?? "Unknown",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                "Price: ₹.${influencer['price'] ?? 0}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Flexible(child: _buildSocialIcons(influencer)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialIcons(dynamic influencer) {
    List<Widget> allIcons = [];
    bool showAll = false;

    // Add Facebook Icon
    if (influencer['facebook_link'] != null &&
        influencer['facebook_link'].toString().isNotEmpty &&
        influencer['facebook_followers'] != null &&
        influencer['facebook_followers'] != "N/A" &&
        int.tryParse(influencer['facebook_followers'])! > 0) {
      allIcons.add(
        SocialMediaButton.facebook(
          onTap: () => launchUrl(Uri.parse(influencer['facebook_link'])),
          size: 18,
          color: Colors.blue,
        ),
      );
    }

    // Add Instagram Icon
    if (influencer['instagram_link'] != null &&
        influencer['instagram_link'].toString().isNotEmpty &&
        influencer['instagram_followers'] != null &&
        influencer['instagram_followers'] != "N/A" &&
        int.tryParse(influencer['instagram_followers'])! > 0) {
      allIcons.add(
        SocialMediaButton.instagram(
          onTap: () => launchUrl(Uri.parse(influencer['instagram_link'])),
          size: 18,
          color: Colors.purple,
        ),
      );
    }

    // Add LinkedIn Icon
    if (influencer['linkedin_link'] != null &&
        influencer['linkedin_link'].toString().isNotEmpty &&
        influencer['linkedin_followers'] != null &&
        influencer['linkedin_followers'] != "N/A" &&
        int.tryParse(influencer['linkedin_followers'])! > 0) {
      allIcons.add(
        SocialMediaButton.linkedin(
          onTap: () => launchUrl(Uri.parse(influencer['linkedin_link'])),
          size: 18,
          color: Colors.blue,
        ),
      );
    }

    // Add YouTube Icon
    if (influencer['youtube_link'] != null &&
        influencer['youtube_link'].toString().isNotEmpty &&
        influencer['youtube_followers'] != null &&
        influencer['youtube_followers'] != "N/A" &&
        int.tryParse(influencer['youtube_followers'])! > 0) {
      allIcons.add(
        SocialMediaButton.youtube(
          onTap: () => launchUrl(Uri.parse(influencer['youtube_link'])),
          size: 18,
          color: Colors.red,
        ),
      );
    }

    // Add Twitter Icon
    if (influencer['twitter_link'] != null &&
        influencer['twitter_link'].toString().isNotEmpty &&
        influencer['twitter_followers'] != null &&
        influencer['twitter_followers'] != "N/A" &&
        int.tryParse(influencer['twitter_followers'])! > 0) {
      allIcons.add(
        SocialMediaButton.twitter(
          onTap: () => launchUrl(Uri.parse(influencer['twitter_link'])),
          size: 18,
          color: Colors.blue,
        ),
      );
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Row(
              children: [
                Wrap(
                  spacing: -7.8,
                  runSpacing: 1,
                  alignment: WrapAlignment.center, // Center the icons
                  children: showAll ? allIcons : allIcons.take(3).toList(),
                ),
              ],
            ),
            if (allIcons.length > 3)
              TextButton(
                onPressed: () {
                  setState(() {
                    showAll = !showAll;
                  });
                },
                child: Text(showAll ? "View Less" : "See All"),
              ),
          ],
        );
      },
    );
  }
}