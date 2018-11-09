//
//  ViewController.swift
//  WeatherApp
//
//  Created by Akamate Chayapiwat on 26/10/2018.
//  Copyright (c) 2018 Akamate. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController,CLLocationManagerDelegate {
    

    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "f04535cd0a189288cb5474081fef8800"
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    func getWeatherData(url : String,paras : [String:String]){
        Alamofire.request(url , method : .get, parameters : paras).responseJSON {
            response in
            if(response.result.isSuccess){
                print("success")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json : weatherJSON)
            }
            else {
                print("error : \(String(describing: response.result.error))")
                self.cityLabel.text = "connection issue"
            }
        }
    }

     //JSON parsing
    func updateWeatherData(json : JSON){
        if let temp = json["main"]["temp"].double{
            self.weatherDataModel.temperature = Int(temp-273.15)
            self.weatherDataModel.city = json["name"].stringValue
            self.weatherDataModel.condition = json["weather"][0]["id"].intValue
            self.weatherDataModel.weatherIconName = self.weatherDataModel.updateWeatherIcon(condition: self.weatherDataModel.condition)
            updateUIwithWeatherData()
        }
        else {
            self.cityLabel.text = "weather unavailable"
        }
    }

    
    func updateUIwithWeatherData(){
        self.cityLabel.text = self.weatherDataModel.city
        self.temperatureLabel.text = "\(self.weatherDataModel.temperature)"
        self.weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        if(location.horizontalAccuracy > 0){
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            print("longitude : \(longitude), latitude = \(latitude)")
            let params : [String : String] = ["lat": String(latitude), "lon" : String(longitude) ,"appid" : self.APP_ID]
            getWeatherData(url : WEATHER_URL,paras : params);
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
        self.cityLabel.text = "connection issue"
    }
    
    
    func userEnteredANewCityName(city: String) {
        print(city)
        let params : [String : String] = ["q" : city , "appid" : APP_ID]
        getWeatherData(url : WEATHER_URL, paras : params)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityViewController
            userEnteredANewCityName(city: destinationVC.changeCityTextField.text!)
        }
    }
    
    
}


