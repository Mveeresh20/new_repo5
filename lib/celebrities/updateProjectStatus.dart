/*import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailProject extends StatefulWidget {
  const DetailProject({super.key});

  @override
  State<DetailProject> createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  Map<String, dynamic> projectData = {
    'customerId': 'CUST789',
    'customerName': 'Jane Smith',
    'projectId': 'PROJ789',
    'projectStatus': 'Pending',
    'assignDate': '2023-11-01',
    'deadlineDate': '2023-12-15',
    'requirements':
    'Detailed requirements from JSON this is influncer setter appp',
  };

  String _projectStatus = 'Ongoing';
  String _uploadedFilePath = '';
  String _uploadedFileName = '';
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[500],
      ),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Details",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow('Customer ID', projectData['customerId']),
                    _buildDetailRow(
                        'Customer Name', projectData['customerName']),
                    _buildDetailRow('Project ID', projectData['projectId']),
                    _buildDetailRow('Project Status', projectData['projectStatus']),
                    // ... inside your build method ...

                    _buildDetailRow('Assign Date', projectData['assignDate']),
                    _buildDetailRow(
                        'Deadline Date', projectData['deadlineDate']),
                    SizedBox(height: 10),
                    Text('Requirements',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(projectData['requirements']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload File',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _simulateFileUpload,
                      child: Text('Choose Video File',
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.purple,
                        backgroundColor: Colors.purple,
                      ),
                    ),
                    if (_isUploading)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          LinearProgressIndicator(value: _uploadProgress),
                          SizedBox(height: 5),
                          Text('Uploading: $_uploadedFileName'),
                        ],
                      ),
                    if (_uploadedFilePath.isNotEmpty && !_isUploading)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Uploaded: $_uploadedFileName'),
                      ),
                    SizedBox(height: 20),
                    Text('Change Status',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    _buildStatusDropdown(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Implement submit logic here
                      },
                      child:
                      Text('Submit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _projectStatus,
      onChanged: (String? newValue) {
        setState(() {
          _projectStatus = newValue!;
        });
      },
      items: <String>['Ongoing', 'Pending', 'Review']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _simulateFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 0.0;
          _uploadedFilePath = result.files.first.path!;
          _uploadedFileName = result.files.first.name;
        });

        for (double i = 0; i <= 100; i++) {
          await Future.delayed(Duration(milliseconds: 50));
          setState(() {
            _uploadProgress = i / 100.0;
          });
        }

        setState(() {
          _isUploading = false;
        });
        print('File path: $_uploadedFilePath');
        print('File name: $_uploadedFileName');
      } else {
        print('User canceled file picker');
      }
    } catch (e) {
      print('Error picking file: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }
}*/



/*
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
class DetailProject extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const DetailProject({super.key, required this.projectData});

  @override
  State<DetailProject> createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  String _projectStatus = 'Ongoing';
  String _uploadedFilePath = '';
  String _uploadedFileName = '';
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the project status with the value from projectData
    _projectStatus = widget.projectData['b_status'] ?? 'Ongoing';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[500],
      ),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow('Customer ID', widget.projectData['b_desc']),
                  /* _buildDetailRow('Customer Name', widget.projectData['customerName']),
                    _buildDetailRow('Project ID', widget.projectData['projectId']),
                    _buildDetailRow('Project Status', widget.projectData['projectStatus']),
                    _buildDetailRow('Assign Date', widget.projectData['assignDate']),
                    _buildDetailRow('Deadline Date', widget.projectData['deadlineDate']),
                    SizedBox(height: 10),
                    Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(widget.projectData['requirements']),*/
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload File',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _simulateFileUpload,
                      child: Text('Choose Video File', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.purple,
                        backgroundColor: Colors.purple,
                      ),
                    ),
                    if (_isUploading)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          LinearProgressIndicator(value: _uploadProgress),
                          SizedBox(height: 5),
                          Text('Uploading: $_uploadedFileName'),
                        ],
                      ),
                    if (_uploadedFilePath.isNotEmpty && !_isUploading)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Uploaded: $_uploadedFileName'),
                      ),
                    SizedBox(height: 20),
                    Text('Change Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    _buildStatusDropdown(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _projectStatus,
      onChanged: (String? newValue) {
        setState(() {
          _projectStatus = newValue!;
        });
      },
      items: <String>['Ongoing', 'Pending', 'Review']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _simulateFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 0.0;
          _uploadedFilePath = result.files.first.path!;
          _uploadedFileName = result.files.first.name;
        });

        for (double i = 0; i <= 100; i++) {
          await Future.delayed(Duration(milliseconds: 50));
          setState(() {
            _uploadProgress = i / 100.0;
          });
        }

        setState(() {
          _isUploading = false;
        });
        print('File path: $_uploadedFilePath');
        print('File name: $_uploadedFileName');
      } else {
        print('User canceled file picker');
      }
    } catch (e) {
      print('Error picking file: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _submitForm() async {
    if (_uploadedFilePath.isEmpty) {
      print('No file selected');
      return;
    }

    // Prepare the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://demo.infoskaters.com/api/updateProjectByCelebrity.php'),
    );

    // Add file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'workFile',
      _uploadedFilePath,
      filename: basename(_uploadedFilePath),
    ));

    // Add other fields
    //request.fields['projectId'] = widget.projectData['projectId'];
    request.fields['newStatus'] = _projectStatus;

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Project status and file updated successfully');
    } else {
      print('Failed to update project status and file');
    }
  }
}*/




/*
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:tngtong/toast_utils.dart';
class DetailProject extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const DetailProject({super.key, required this.projectData});

  @override
  State<DetailProject> createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  String _projectStatus = 'Ongoing'; // Default status
  String _uploadedFilePath = '';
  String _uploadedFileName = '';
  double _uploadProgress = 0.0;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    // Initialize the project status with the value from projectData
    // Ensure the value is one of the valid statuses
    final status = widget.projectData['b_status'] ?? 'Ongoing';
    if (['Ongoing', 'Pending', 'Review'].contains(status)) {
      _projectStatus = status;
    } else {
      _projectStatus = 'Ongoing'; // Fallback to default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[500],
      ),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow('Customer ID', widget.projectData['c_id'].toString()),
                    _buildDetailRow('Customer Name', widget.projectData['user_name']),
                    _buildDetailRow('Project ID', widget.projectData['id'].toString()),
                    _buildDetailRow('Project Status', widget.projectData['b_status']),
                    _buildDetailRow('Assign Date', widget.projectData['b_date']),
                    _buildDetailRow('Deadline Date', widget.projectData['deadline_date']),
                    SizedBox(height: 10),
                    Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(widget.projectData['b_desc']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload File',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _simulateFileUpload,
                      child: Text('Choose Video File', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                    ),
                    if (_isUploading)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          LinearProgressIndicator(value: _uploadProgress),
                          SizedBox(height: 5),
                          Text('Uploading: $_uploadedFileName'),
                        ],
                      ),
                    if (_uploadedFilePath.isNotEmpty && !_isUploading)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Uploaded: $_uploadedFileName'),
                      ),
                    SizedBox(height: 20),
                    Text('Change Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    _buildStatusDropdown(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _projectStatus,
      onChanged: (String? newValue) {
        setState(() {
          _projectStatus = newValue!;
        });
      },
      items: <String>['Ongoing', 'Pending', 'Review']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _simulateFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 0.0;
          _uploadedFilePath = result.files.first.path!;
          _uploadedFileName = result.files.first.name;
        });

        for (double i = 0; i <= 100; i++) {
          await Future.delayed(Duration(milliseconds: 50));
          setState(() {
            _uploadProgress = i / 100.0;
          });
        }

        setState(() {
          _isUploading = false;
        });
        print('File path: $_uploadedFilePath');
        print('File name: $_uploadedFileName');
      } else {
        print('User canceled file picker');
      }
    } catch (e) {
      print('Error picking file: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _submitForm() async {

    if (_uploadedFilePath.isEmpty) {
      print('No file selected');
      ToastUtils.showSuccess("No file selected");

      return;
    }

    // Prepare the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://demo.infoskaters.com/api/updateProjectByCelebrity.php'),
    );

    // Add file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'workFile',
      _uploadedFilePath,
      filename: basename(_uploadedFilePath),
    ));

    // Add other fields
    request.fields['newStatus'] = _projectStatus;
    request.fields['projectId'] = widget.projectData['id'].toString();

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Project status and file updated successfully');
      ToastUtils.showSuccess("message");
    } else {
      print('Failed to update project status and file');
      ToastUtils.showSuccess("Errror");

    }
  }
}*/


/*
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:tngtong/toast_utils.dart';
import 'dart:convert';
import 'package:tngtong/config.dart';

class DetailProject extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const DetailProject({super.key, required this.projectData});

  @override
  State<DetailProject> createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  String _projectStatus = 'Ongoing'; // Default status
  String _uploadedFilePath = '';
  String _uploadedFileName = '';
  double _uploadProgress = 0.0;
  bool _isUploading = false;
  String? _submissionVideoUrl;
  VideoPlayerController? _videoPlayerController;
  bool _isLoadingVideo = true;

  @override
  void initState() {
    super.initState();
    // Initialize the project status with the value from projectData
    final status = widget.projectData['b_status'] ?? 'Ongoing';
    if (['Ongoing', 'Pending', 'Review'].contains(status)) {
      _projectStatus = status;
    } else {
      _projectStatus = 'Ongoing'; // Fallback to default
    }

    // Fetch submission video
    _fetchSubmissionVideo();
  }

  // Fetch submission video from the API
  Future<void> _fetchSubmissionVideo() async {
    final projectId = widget.projectData['id'].toString();
    final url = Uri.parse('https://demo.infoskaters.com/api/getProjectVideo.php?projectId=$projectId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['projectUrl'] != null) {
          setState(() {
            _submissionVideoUrl ="${Config.apiDomain}/${data['projectUrl']}";
            _isLoadingVideo = false;
          });
          _initializeVideoPlayer();
        } else {
          setState(() {
            _isLoadingVideo = false;
          });
        }
      } else {
        setState(() {
          _isLoadingVideo = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingVideo = false;
      });
      print('Error fetching video: $e');
    }
  }

  // Initialize video player
  void _initializeVideoPlayer() {
    if (_submissionVideoUrl != null) {
      _videoPlayerController = VideoPlayerController.network(_submissionVideoUrl!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[500],
      ),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Project Details Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow('Customer ID', widget.projectData['c_id'].toString()),
                    _buildDetailRow('Customer Name', widget.projectData['user_name']),
                    _buildDetailRow('Project ID', widget.projectData['id'].toString()),
                    _buildDetailRow('Project Status', widget.projectData['b_status']),
                    _buildDetailRow('Assign Date', widget.projectData['b_date']),
                    _buildDetailRow('Deadline Date', widget.projectData['deadline_date']),
                    SizedBox(height: 10),
                    Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(widget.projectData['b_desc']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Submission Video Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Submission Video',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    if (_isLoadingVideo)
                      Center(child: CircularProgressIndicator())
                    else if (_submissionVideoUrl != null)
                      Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: VideoPlayer(_videoPlayerController!),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.play_arrow),
                                onPressed: () {
                                  setState(() {
                                    _videoPlayerController!.play();
                                  });
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.pause),
                                onPressed: () {
                                  setState(() {
                                    _videoPlayerController!.pause();
                                  });
                                },
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Implement download functionality
                            },
                            child: Text('Download Video'),
                          ),
                        ],
                      )
                    else
                      Text('No Submission'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Upload File and Change Status Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload File',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _simulateFileUpload,
                      child: Text('Choose Video File', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                    ),
                    if (_isUploading)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          LinearProgressIndicator(value: _uploadProgress),
                          SizedBox(height: 5),
                          Text('Uploading: $_uploadedFileName'),
                        ],
                      ),
                    if (_uploadedFilePath.isNotEmpty && !_isUploading)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Uploaded: $_uploadedFileName'),
                      ),
                    SizedBox(height: 20),
                    Text('Change Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    _buildStatusDropdown(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _projectStatus,
      onChanged: (String? newValue) {
        setState(() {
          _projectStatus = newValue!;
        });
      },
      items: <String>['Ongoing', 'Pending', 'Review']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _simulateFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 0.0;
          _uploadedFilePath = result.files.first.path!;
          _uploadedFileName = result.files.first.name;
        });

        for (double i = 0; i <= 100; i++) {
          await Future.delayed(Duration(milliseconds: 50));
          setState(() {
            _uploadProgress = i / 100.0;
          });
        }

        setState(() {
          _isUploading = false;
        });
        print('File path: $_uploadedFilePath');
        print('File name: $_uploadedFileName');
      } else {
        print('User canceled file picker');
      }
    } catch (e) {
      print('Error picking file: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _submitForm() async {
    if (_uploadedFilePath.isEmpty) {
      print('No file selected');
      ToastUtils.showSuccess("No file selected");
      return;
    }

    // Prepare the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://demo.infoskaters.com/api/updateProjectByCelebrity.php'),
    );

    // Add file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'workFile',
      _uploadedFilePath,
      filename: basename(_uploadedFilePath),
    ));

    // Add other fields
    request.fields['newStatus'] = _projectStatus;
    request.fields['projectId'] = widget.projectData['id'].toString();

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Project status and file updated successfully');
      ToastUtils.showSuccess("message");
    } else {
      print('Failed to update project status and file');
      ToastUtils.showSuccess("Errror");
    }
  }
}*/

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:tngtong/toast_utils.dart';
import 'dart:convert';
import 'package:tngtong/config.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class DetailProject extends StatefulWidget {
  final Map<String, dynamic> projectData;

  const DetailProject({super.key, required this.projectData});

  @override
  State<DetailProject> createState() => _DetailProjectState();
}

class _DetailProjectState extends State<DetailProject> {
  String _projectStatus = 'Ongoing'; // Default status
  String _uploadedFilePath = '';
  String _uploadedFileName = '';
  double _uploadProgress = 0.0;
  bool _isUploading = false;
  String? _submissionVideoUrl;
  VideoPlayerController? _videoPlayerController;
  bool _isLoadingVideo = true;
  bool _isMuted = false;

  @override
  void initState() {
    super.initState();
    // Initialize the project status with the value from projectData
    final status = widget.projectData['b_status'] ?? 'Ongoing';
    if (['Ongoing', 'Pending', 'Review'].contains(status)) {
      _projectStatus = status;
    } else {
      _projectStatus = 'Ongoing'; // Fallback to default
    }

    // Fetch submission video
    _fetchSubmissionVideo();
  }

  // Fetch submission video from the API
  Future<void> _fetchSubmissionVideo() async {
    final projectId = widget.projectData['id'].toString();
    final url = Uri.parse('https://demo.infoskaters.com/api/getProjectVideo.php?projectId=$projectId');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true && data['projectUrl'] != null) {
          setState(() {
            _submissionVideoUrl = "${Config.apiDomain}/${data['projectUrl']}";
            _isLoadingVideo = false;
          });
          _initializeVideoPlayer();
        } else {
          setState(() {
            _isLoadingVideo = false;
          });
        }
      } else {
        setState(() {
          _isLoadingVideo = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoadingVideo = false;
      });
      print('Error fetching video: $e');
    }
  }

  // Initialize video player
  void _initializeVideoPlayer() {
    if (_submissionVideoUrl != null) {
      _videoPlayerController = VideoPlayerController.network(_submissionVideoUrl!)
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  // Toggle play/pause
  void _togglePlayPause() {
    setState(() {
      if (_videoPlayerController!.value.isPlaying) {
        _videoPlayerController!.pause();
      } else {
        _videoPlayerController!.play();
      }
    });
  }

  // Toggle sound
  void _toggleSound() {
    setState(() {
      _isMuted = !_isMuted;
      _videoPlayerController!.setVolume(_isMuted ? 0 : 1);
    });
  }

  // Download video
  Future<void> _downloadVideo() async {
    if (_submissionVideoUrl == null) return;

    final dio = Dio();
    final dir = await getApplicationDocumentsDirectory();
    final savePath = '${dir.path}/${basename(_submissionVideoUrl!)}';

    try {
      await dio.download(_submissionVideoUrl!, savePath);
      ToastUtils.showSuccess("Video downloaded to $savePath");
    } catch (e) {
      ToastUtils.showSuccess("Failed to download video: $e");
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Project Details',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[500],
      ),
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Project Details Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project Details",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    _buildDetailRow('Customer ID', widget.projectData['c_id'].toString()),
                    _buildDetailRow('Customer Name', widget.projectData['user_name']),
                    _buildDetailRow('Project ID', widget.projectData['id'].toString()),
                    _buildDetailRow('Project Status', widget.projectData['b_status']),
                    _buildDetailRow('Assign Date', widget.projectData['b_date']),
                    _buildDetailRow('Deadline Date', widget.projectData['deadline_date']),
                    SizedBox(height: 10),
                    Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text(widget.projectData['b_desc']),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Submission Video Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Submission Video',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    if (_isLoadingVideo)
                      Center(child: CircularProgressIndicator())
                    else if (_submissionVideoUrl != null)
                      Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: VideoPlayer(_videoPlayerController!),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _videoPlayerController!.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                                onPressed: _togglePlayPause,
                              ),
                              IconButton(
                                icon: Icon(
                                  _isMuted ? Icons.volume_off : Icons.volume_up,
                                ),
                                onPressed: _toggleSound,
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: _downloadVideo,
                            child: Text('Download Video'),
                          ),
                        ],
                      )
                    else
                      Text('No Submission'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Upload File and Change Status Card
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Upload File',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _simulateFileUpload,
                      child: Text('Choose Video File', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                    ),
                    if (_isUploading)
                      Column(
                        children: [
                          SizedBox(height: 10),
                          LinearProgressIndicator(value: _uploadProgress),
                          SizedBox(height: 5),
                          Text('Uploading: $_uploadedFileName'),
                        ],
                      ),
                    if (_uploadedFilePath.isNotEmpty && !_isUploading)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Uploaded: $_uploadedFileName'),
                      ),
                    SizedBox(height: 20),
                    Text('Change Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 10),
                    _buildStatusDropdown(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildStatusDropdown() {
    return DropdownButton<String>(
      value: _projectStatus,
      onChanged: (String? newValue) {
        setState(() {
          _projectStatus = newValue!;
        });
      },
      items: <String>['Ongoing', 'Pending', 'Review']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void _simulateFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.video,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _isUploading = true;
          _uploadProgress = 0.0;
          _uploadedFilePath = result.files.first.path!;
          _uploadedFileName = result.files.first.name;
        });

        for (double i = 0; i <= 100; i++) {
          await Future.delayed(Duration(milliseconds: 50));
          setState(() {
            _uploadProgress = i / 100.0;
          });
        }

        setState(() {
          _isUploading = false;
        });
        print('File path: $_uploadedFilePath');
        print('File name: $_uploadedFileName');
      } else {
        print('User canceled file picker');
      }
    } catch (e) {
      print('Error picking file: $e');
      setState(() {
        _isUploading = false;
      });
    }
  }

  void _submitForm() async {
    if (_uploadedFilePath.isEmpty) {
      print('No file selected');
      ToastUtils.showSuccess("No file selected");
      return;
    }

    // Prepare the request
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://demo.infoskaters.com/api/updateProjectByCelebrity.php'),
    );

    // Add file to the request
    request.files.add(await http.MultipartFile.fromPath(
      'workFile',
      _uploadedFilePath,
      filename: basename(_uploadedFilePath),
    ));

    // Add other fields
    request.fields['newStatus'] = _projectStatus;
    request.fields['projectId'] = widget.projectData['id'].toString();

    // Send the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Project status and file updated successfully');
      ToastUtils.showSuccess("message");
    } else {
      print('Failed to update project status and file');
      ToastUtils.showSuccess("Errror");
    }
  }
}