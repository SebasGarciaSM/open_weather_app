// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:open_weather_app/models/location_model.dart';
import 'package:open_weather_app/repositories/location_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Search Bar Controller
  TextEditingController controller = TextEditingController();

  //Location Repository
  final LocationRepository _locationRepository = LocationRepository();

  //List of results
  List<LocationModel> results = [];

  bool showDeleteIcon = false;
  bool showLoadingIndicator = false;

  Future<void> search() async {
    try {
      if (controller.text.isNotEmpty) {
        setState(() {
          showLoadingIndicator = true;
        });

        results =
            await _locationRepository.getLocationData(controller.text.trim());

        setState(() {
          showLoadingIndicator = false;
        });
      } else {
        FocusManager.instance.primaryFocus?.unfocus();
        results.clear();
        setState(() {});
      }
    } catch (e) {
      setState(() {
        results.clear();
        showLoadingIndicator = false;
      });
      print(e);

      String errorTitle = '';
      String errorDescription = '';

      if (e is SocketException) {
        errorTitle = 'No internet connection';
        errorDescription =
            'Reconnect to your internet connection and then try again.';
      } else {
        errorTitle = 'An error has ocurred';
        errorDescription = e.toString();
      }

      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(errorTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(errorDescription),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () => Modular.to.pop(),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Open Weather"),
        forceMaterialTransparency: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SearchBar(
              onSubmitted: (value) => search(),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  showDeleteIcon = true;
                } else {
                  showDeleteIcon = false;
                }
                setState(() {});
              },
              controller: controller,
              hintText: "Search",
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.text,
              trailing: [
                (showDeleteIcon)
                    ? IconButton(
                        onPressed: () {
                          showDeleteIcon = false;
                          controller.clear();
                          setState(() {});
                        },
                        icon: const Icon(Icons.cancel_outlined),
                      )
                    : Container(),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => search(),
                )
              ],
            ),
          ),
          Expanded(
            child: (showLoadingIndicator)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (results.isEmpty)
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 100.0),
                              child: Image(
                                image: AssetImage("assets/images/search.png"),
                              ),
                            ),
                            Text("Search for a city or country."),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: results.length,
                        separatorBuilder: (context, index) {
                          return const Divider(height: 1.0);
                        },
                        itemBuilder: (context, index) {
                          var item = results[index];
                          return ListTile(
                            title: Text(item.name ?? ""),
                            subtitle: Row(
                              children: [
                                (item.state != null)
                                    ? Text("${item.state ?? ""}, ")
                                    : Container(),
                                Text(item.country ?? ""),
                              ],
                            ),
                            onTap: () => Modular.to
                                .pushNamed("/details_page", arguments: item),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
