# KUBO

Food Planner

Run "flutter packages pub run build_runner build --delete-conflicting-outputs" if new database
Run "flutter packages pub run build_runner watch --delete-conflicting-outputs" dependency injection


Bloc Naming Convention

State 
    Subject + Action + State of Action
    Eg. WeatherFetchSuccess

Cubit Function or Method
    Action + Subject
    Eg. fetchWeather