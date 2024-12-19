import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';



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
    return GestureDetector(
      onTap: _pickFile,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              size: 48.0,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              widget.subtitle,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: _pickFile,
              child: const Text(
                '+ Upload file',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
