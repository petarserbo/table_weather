//
//  getCitiesWeather.swift
//  table_weather
//
//  Created by Petar Perich on 10.08.2021.
//

import Foundation
import CoreLocation

let networkService = NetworkService()

func getCityWeather(citiesArray: [String], completion: @escaping (Int, Weather) -> Void){
    
    for(index, item) in citiesArray.enumerated(){
        getCoordinates(city: item) { (coordinate, error) in
            guard let coordinate = coordinate, error == nil else{ return }
            
            networkService.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { (weather) in
                completion(index, weather)
            }
        }
    }
}

func getCoordinates(city:String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?,_ error: Error?) -> () ) {
    CLGeocoder().geocodeAddressString(city) { (placemark, error) in
        completion(placemark?.first?.location?.coordinate, error)
    }
}
