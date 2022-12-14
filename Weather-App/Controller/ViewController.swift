//
//  ViewController.swift
//  Weather-App
//
//  Created by Nosirov Xushkiyor Shavkatbek o'g'li on 14/12/22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let networkManager = WeatherNetworkManager()
    
    let currentLocation: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "... Location"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 38.0, weight: .heavy)
        return label
    }()
    
    let currentDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "9 december 2022"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .heavy)
        return label
    }()
    
    let currentTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-4 C"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 50.0, weight: .heavy)
        return label
    }()
    
    let tempSymbol: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "cloudImage")
        image.leftAnchor
        return image
    }()
    
    let tempDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "moderation rain"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15.0, weight: .light)
        return label
    }()
    
    let maxTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let minTemp: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "  °C"
        label.textAlignment = .left
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var stackView: UIStackView!
    var latitude : CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemBackground
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                            style: .done, target: self,
                            action: #selector(handlerAddPlaceButton)),
            UIBarButtonItem(image: UIImage(systemName: "thermometer"),
                            style: .done, target: self,
                            action: #selector(handleShowForecast)),
            UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"),
                            style: .done, target: self,
                            action: #selector(handleRefresh))]
                 
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        transparentNavigationBar()
        
        setupAddView()
        setupConstraint()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        manager.delegate = nil
        
        let location = locations[0].coordinate
        latitude = location.latitude
        longitude = location.longitude
        print("Long", longitude.description)
        print("Lat", latitude.description)
        
        loadDataUsingCoordinates(lat: latitude.description, lon: longitude.description)
    }
    
    func setupAddView(){
        self.view.addSubview(currentLocation)
        self.view.addSubview(currentDate)
        self.view.addSubview(currentTemp)
        self.view.addSubview(tempSymbol)
        self.view.addSubview(tempDescription)
        self.view.addSubview(minTemp)
        self.view.addSubview(maxTemp)
    }

    func setupConstraint() {
        
        currentLocation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        currentLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        currentLocation.heightAnchor.constraint(equalToConstant: 70).isActive = true
        currentLocation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
        
        currentDate.topAnchor.constraint(equalTo: currentLocation.bottomAnchor, constant: 4).isActive = true
        currentDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        currentDate.heightAnchor.constraint(equalToConstant: 25).isActive = true
        currentDate.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -18).isActive = true
        
        currentTemp.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        currentTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        currentTemp.heightAnchor.constraint(equalToConstant: 70).isActive = true
        currentTemp.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        tempSymbol.topAnchor.constraint(equalTo: currentTemp.bottomAnchor).isActive = true
        tempSymbol.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        tempSymbol.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tempSymbol.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        tempDescription.topAnchor.constraint(equalTo: currentTemp.bottomAnchor, constant: 12.5).isActive = true
        tempDescription.leadingAnchor.constraint(equalTo: tempSymbol.trailingAnchor, constant: 8).isActive = true
        tempDescription.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tempDescription.widthAnchor.constraint(equalToConstant: 250).isActive = true
        
        minTemp.topAnchor.constraint(equalTo: tempSymbol.bottomAnchor, constant: 80).isActive = true
        minTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        minTemp.heightAnchor.constraint(equalToConstant: 20).isActive = true
        minTemp.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        maxTemp.topAnchor.constraint(equalTo: minTemp.bottomAnchor).isActive = true
        maxTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
        maxTemp.heightAnchor.constraint(equalToConstant: 20).isActive = true
        maxTemp.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func loadData(city: String) {
        
        networkManager.fetchCurrentWeather(city: city) { weather in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
            
            DispatchQueue.main.async {
                self.currentTemp.text = (String(weather.main.temp.kelvinToCelciusConvertor()) + "°C")
                self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
                self.tempDescription.text = weather.weather[0].description
                self.currentDate.text = stringDate
                self.maxTemp.text = ("Max: " + String(weather.main.temp_max.kelvinToCelciusConvertor()) + "°C")
                self.minTemp.text = ("Min: " + String(weather.main.temp_min.kelvinToCelciusConvertor()) + "°C")
                self.tempSymbol.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")
                UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")

            }
        }
    }
    
    func loadDataUsingCoordinates(lat: String, lon: String) {
           networkManager.fetchCurrentLocationWeather(lat: lat, lon: lon) { (weather) in
                print("Current Temperature", weather.main.temp.kelvinToCelciusConvertor())
                let formatter = DateFormatter()
                formatter.dateFormat = "dd MMM yyyy" //yyyy
                let stringDate = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(weather.dt)))
                
                DispatchQueue.main.async {
                    self.currentTemp.text = (String(weather.main.temp.kelvinToCelciusConvertor()) + "°C")
                    self.currentLocation.text = "\(weather.name ?? "") , \(weather.sys.country ?? "")"
                    self.tempDescription.text = weather.weather[0].description
                    self.currentDate.text = stringDate
                    self.minTemp.text = ("Min: " + String(weather.main.temp_min.kelvinToCelciusConvertor()) + "°C" )
                    self.maxTemp.text = ("Max: " + String(weather.main.temp_max.kelvinToCelciusConvertor()) + "°C" )
                    self.tempSymbol.loadImageFromURL(url: "http://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png")
                   UserDefaults.standard.set("\(weather.name ?? "")", forKey: "SelectedCity")
                }
           }
       }
    
    @objc func handlerAddPlaceButton() {
            let alertController = UIAlertController(title: "Add City", message: "", preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.placeholder = "City Name"
            }
            
            let saveAction = UIAlertAction(title: "Add", style: .default, handler: { alert -> Void in
                let firstTextField = alertController.textFields![0] as UITextField
                print("City Name: \(firstTextField.text)")
                
                guard let cityName = firstTextField.text else { return }
                self.loadData(city: cityName)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            
            alertController.addAction(saveAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
        }
    
    @objc func handleShowForecast() {
           self.navigationController?.pushViewController(ForecastViewController(), animated: true)
    }
    
    @objc func handleRefresh() {
        let city = UserDefaults.standard.string(forKey: "SelectedCity") ?? ""
        loadData(city: city)
    }
    
    func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }


}

