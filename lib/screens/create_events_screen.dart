import 'dart:io';

import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/utils/call_api.dart';
import 'package:dating_made_better/widgets/top_app_bar.dart';
import 'package:dating_made_better/widgets/top_app_bar_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});
  static const routeName = '/create-events-screen';

  @override
  _CreateEventScreenState createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _linkController = TextEditingController();
  DateTime _startDateTime = DateTime.now();
  DateTime _endDateTime = DateTime.now().add(Duration(hours: 1));
  String imageUrl = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(
        centerTitle: false,
            showActions: DropDownType.showNothing,
            showLeading: true,
            heading: "Create an event!",
            screen: Screen.eventsScreen,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                style: AppTextStyles.regularText(context),
                decoration: InputDecoration(
                  labelText: 'Event Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
              ),
              SizedBox(height: marginHeight48(context)),
              TextFormField(
                controller: _descriptionController,
                style: AppTextStyles.regularText(context),
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              SizedBox(height: marginHeight48(context)),
              _buildDateTimePicker(
                label: 'Start Date & Time',
                dateTime: _startDateTime,
                onChanged: (dateTime) {
                  setState(() {
                    _startDateTime = dateTime;
                  });
                },
                context: context,
              ),
              SizedBox(height: marginHeight48(context)),
              _buildDateTimePicker(
                label: 'End Date & Time',
                dateTime: _endDateTime,
                onChanged: (dateTime) {
                  setState(() {
                    _endDateTime = dateTime;
                  });
                },
                context: context,
              ),
              SizedBox(height: marginHeight48(context)),
              TextFormField(
                style: AppTextStyles.regularText(context),
                key: Key('locationField'), // Add this line
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.search),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
                onTap: () {
                  // TODO: Implement location search functionality
                  // This should call the backend to search for locations
                },
              ),
               SizedBox(height: marginHeight48(context)),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widgetColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(marginWidth64(context)),
                      side: BorderSide(width: 0.5),
                    ),
                    padding: EdgeInsets.zero,
                    fixedSize: Size(
                      (MediaQuery.of(context).size.width) * 0.85,
                      (MediaQuery.of(context).size.height) * 0.4,
                    ),
                  ),
                  onPressed: () async { 
                    addImageFromGallery().then((value) {
                      setState(() {
                        imageUrl = value;
                      });
                    },);
                   },
                  child: imageUrl.isNotEmpty
                      ? Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        )
                      : const Icon(
                          Icons.camera,
                          color: textColor,
                        ),
                ),
              ),
               SizedBox(height: marginHeight48(context)),
              TextFormField(
                style: AppTextStyles.regularText(context),
                controller: _linkController,
                decoration: InputDecoration(
                  labelText: 'Relevant link [Website, app, etc.]',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid link';
                  }
                  return null;
                },
              ),
              SizedBox(height: marginHeight48(context)),
              ElevatedButton(
                onPressed: () {  _submitForm(context); Navigator.of(context).pop();},
                child: Text('Create!',  
                  style: AppTextStyles.secondaryHeading(context, color: AppColors.secondaryColor)
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
              SizedBox(height: marginHeight32(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateTimePicker({
    required String label,
    required DateTime dateTime,
    required ValueChanged<DateTime> onChanged,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: dateTime,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 365)),
        );
        if (date != null) {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(dateTime),
          );
          if (time != null) {
            onChanged(DateTime(
              date.year,
              date.month,
              date.day,
              time.hour,
              time.minute,
            ));
          }
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        child: Text(
          style: AppTextStyles.regularText(context),
          DateFormat('yyyy-MM-dd, kk:mm').format(dateTime)
        ),
      ),
    );
  }

  Future<String> addImageFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      requestFullMetadata: true,
    );
    if (pickedFile != null) {
      File rotatedImage =
          await FlutterExifRotation.rotateAndSaveImage(path: pickedFile.path);
      uploadPhotosAPI([rotatedImage]).then((filePaths) {
        setState(() {
          imageUrl = filePaths[0];
        });
      }).catchError((error) {
        debugPrint(error.toString());
      });
    }
    return imageUrl;
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> bodyParams = {
        'name': _nameController.text,
        'description': _descriptionController.text,
        'location_id': 1,
        'start_time': _startDateTime.toString(),
        'end_time': _endDateTime.toString(),
        'image_url': imageUrl,
        'link': _linkController.text,
      };
      createEvents(bodyParams);
    }
  }
}
