import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';



class FileUploadWidget extends StatefulWidget {

  final String title;
  final String subtitle;
  final Function(PlatformFile?) onFileSelected;

  const FileUploadWidget({
    Key? key,
    required this.title,
    required this.subtitle, 
    required this.onFileSelected,
  }) : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();

}


class _FileUploadWidgetState extends State<FileUploadWidget> {
  
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles();
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedFile = result.files.first;
        });
        widget.onFileSelected(_selectedFile);
      } else {
        widget.onFileSelected(null);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error selecting file: $e')),
      );
      print(e);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title above the card
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
              color: Colors.grey.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [ 
                    Expanded(
                      child: Text(
                        widget.subtitle,
                        style: GoogleFonts.inter(),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16.0),

Align(
  alignment: Alignment.centerLeft,
  child: Container(
    decoration: BoxDecoration(
      border: Border.all(width: 0.5),
      borderRadius: BorderRadius.circular(15)
    ),
    child: TextButton(
      onPressed: _pickFile,
      child: Text(
        _selectedFile == null ? '+ Upload File' : 'File Uploaded',
        style: GoogleFonts.inter(color: Colors.red),
      ),
    ),
  ),
)

              ],
            ),
          ),
        ),
      ],
    );
  }
}


