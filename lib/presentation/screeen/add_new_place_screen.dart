import 'dart:io';

import 'package:favorite_place_app/models/place.dart';
import 'package:favorite_place_app/presentation/widgets/image_input.dart';
import 'package:favorite_place_app/presentation/widgets/location_input.dart';
import 'package:favorite_place_app/provider/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _addPlace(String title) {
    if (title.isNotEmpty ||
        _selectedImage != null ||
        _selectedLocation != null) {
      ref.read(
        placeProvider.notifier.select(
          (value) => value.addPlace(title, _selectedImage!, _selectedLocation!),
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text('title'),
                ),
              ),
              const SizedBox(height: 7),
              ImageInput(onPickedImage: (image) {
                _selectedImage = image;
              }),
              const SizedBox(height: 7),
              LocationInput(onPickedLocation: (location) {
                _selectedLocation = location;
              }),
              const SizedBox(height: 7),
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: () {
                    _addPlace(_titleController.text);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.add),
                      Text('Add Place'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
