import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/api/api.dart';
import 'package:weather/model/weather.dart';
import 'package:weather/utils.dart';
import 'package:weather/widgets/box_field.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

TextEditingController cityInputController = TextEditingController();

class _HomeState extends State<Home> {
  bool isSearching = false;
  double toolbarHeight = 70;
  double bodyMarginTop = 30;
  double bodyPadding = 25;

  WeatherApi api = WeatherApi();
  WeatherModel? weatherModel;

  void _getInitData() async {
    weatherModel = await api.getWeatherDetails('Kolkata');
    setState(() {});
  }

  FaIcon getWeatherIcon() {
    FaIcon icon =
        const FaIcon(FontAwesomeIcons.cloud, color: Colors.white, size: 80.0);
    if (weatherModel!.decription.contains('rain')) {
      icon = const FaIcon(FontAwesomeIcons.cloudShowersHeavy,
          color: Colors.white, size: 80.0);
    } else if (weatherModel!.decription.contains('clear sky')) {
      icon = const FaIcon(FontAwesomeIcons.solidSun,
          color: Colors.white, size: 80.0);
    } else if (weatherModel!.decription.contains('overcast clouds')) {
      icon = const FaIcon(FontAwesomeIcons.cloudSun,
          color: Colors.white, size: 80.0);
    }
    return icon;
  }

  @override
  void initState() {
    super.initState();
    _getInitData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: toolbarHeight,
        elevation: 0.0,
        centerTitle: true,
        title: isSearching ? SearchView() : const Text(''),
        actions: [
          isSearching
              ? Row(
                  children: [
                    IconButton(
                        onPressed: () async {
                          var city = Utils.format(
                              cityInputController.text.trim().toLowerCase(),
                              onError: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Enter a valid city name')));
                          });
                          try {
                            // Gets the Weather Deatails of the provided city
                            weatherModel = await api.getWeatherDetails(city);
                            setState(() {
                              isSearching = false;
                              bodyMarginTop = 30;
                            });
                          } catch (e) {
                            print(e);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Failed to fetch data ... ')
                                ));
                          }
                        },
                        icon: const Icon(Icons.search)),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isSearching = false;
                            toolbarHeight = 70;
                            bodyMarginTop = 30;
                          });
                        },
                        icon: const Icon(Icons.cancel)),
                  ],
                )
              : IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = true;
                      toolbarHeight = 85;
                      bodyMarginTop = toolbarHeight + 12;
                    });
                  },
                  icon: const Icon(Icons.search)),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFF123456), Colors.deepPurpleAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: weatherModel == null
            ? const Text('')
            : Container(
                padding: EdgeInsets.all(bodyPadding),
                margin: EdgeInsets.only(top: bodyMarginTop),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          // city name with country
                          Text(
                              '${weatherModel?.city.toString()}, ${weatherModel?.country}',
                              style: const TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          const SizedBox(height: 5.0),

                          // date time
                          Text(
                              'Updated at ${DateTime.now().toString().substring(0, 19)}',
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                    // Weather Type Icon
                    Expanded(child: getWeatherIcon()),

                    // Description of weather
                    Text('${weatherModel?.decription}',
                        style: const TextStyle(
                            fontSize: 16.0, color: Colors.white)),
                    const SizedBox(height: 10.0),

                    // Temperature of the city
                    Text('${weatherModel?.temperature}°C',
                        style: const TextStyle(
                            fontFamily: 'RobotoThin',
                            fontWeight: FontWeight.w100,
                            fontSize: 65.0,
                            color: Colors.white)),
                    const SizedBox(height: 10.0),

                    // Min Temp & Max Temp
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Min Temp : ${weatherModel?.minTemp}°C',
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.white)),
                          Text('Max Temp : ${weatherModel?.maxTemp}°C',
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Column(
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Latitude
                              Expanded(
                                child: BoxField(
                                    icon: const FaIcon(FontAwesomeIcons.angular,
                                        color: Colors.white),
                                    data: 'Lat',
                                    value: '${weatherModel?.latitide}°'),
                              ),
                              const SizedBox(width: 5.0),
                              // Humidity
                              Expanded(
                                child: BoxField(
                                    icon: const FaIcon(FontAwesomeIcons.sun,
                                        color: Colors.white),
                                    data: 'Humidity',
                                    value: '${weatherModel?.humidity}%'),
                              ),
                              const SizedBox(width: 5.0),
                              // Pressure
                              Expanded(
                                child: BoxField(
                                    icon: const FaIcon(FontAwesomeIcons.cloud,
                                        color: Colors.white),
                                    data: 'Pressure',
                                    value: '${weatherModel?.pressure} Pa'),
                              ),
                            ]),
                        const SizedBox(height: 5.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Longitude
                              Expanded(
                                child: BoxField(
                                    icon: const FaIcon(FontAwesomeIcons.angular,
                                        color: Colors.white),
                                    data: 'Lon',
                                    value: '${weatherModel?.longitude}°'),
                              ),
                              const SizedBox(width: 5.0),
                              // Feels Like Temperature
                              Expanded(
                                child: BoxField(
                                    icon: const FaIcon(
                                        FontAwesomeIcons.thermometer,
                                        color: Colors.white),
                                    data: 'Feels',
                                    value: '${weatherModel?.feelsLike}°C'),
                              ),
                              const SizedBox(width: 5.0),
                              // Wind Speed
                              Expanded(
                                child: BoxField(
                                    icon: const FaIcon(FontAwesomeIcons.wind,
                                        color: Colors.white),
                                    data: 'Wind',
                                    value: '${weatherModel?.wind} km/hr'),
                              ),
                            ]),
                      ],
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: cityInputController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(30.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(30.0),
        ),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        hintText: 'Enter city name',
        hintStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}
