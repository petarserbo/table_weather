//
//  ViewController.swift
//  table_weather
//
//  Created by Petar Perich on 09.08.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    let emptyCity = Weather()
    var citiesArray = [Weather]()
    var filteredCitiesArray = [Weather]()
    var myCities = ["Лондон", "Москва", "Париж", "Уфа", "Белград", "Барселона", "Тюмень", "Томск", "Амстердам", "Сочи"]
    var searchBarIsEmpty: Bool {
        guard let text = searchBar.text else { return false}
        return text.isEmpty
    }
    
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 70)
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.placeholder = " Search Here....."
        searchBar.sizeToFit()
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        return tableView
    }()
    
    
    func addSearchBar(){
        tableView.tableHeaderView = searchBar
        searchBar.delegate = self
    }
    
    func navigationBarSetup(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.title = "Погода"
        
        
    }
    
    //MARK: - Alert for plus button in Navigation Bar
    func alertPlusCity(name: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "OK", style: .default) { (action) in
            
            let tftext = alertController.textFields?.first
            guard let text = tftext?.text else { return }
            completionHandler(text)
        }
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { (_) in}
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func addButtonTapped (){
        
        alertPlusCity(name: "Город", placeholder: "Введите название города") { (city) in
            self.myCities.append(city)
            self.citiesArray.append(self.emptyCity)
            self.addCities()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        addSearchBar()
        navigationBarSetup()
        
        
        if citiesArray.isEmpty{
            citiesArray = Array(repeating: emptyCity, count: myCities.count)
        }
        addCities()
    }
    
    func addCities(){
        getCityWeather(citiesArray: self.myCities) { (index, weather) in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.myCities[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    
}

// MARK:- Table View Data Source
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchBarIsEmpty{
            return citiesArray.count
        }else{
            return filteredCitiesArray.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        var citiesItem = Weather()
        if searchBarIsEmpty{
            citiesItem = citiesArray [indexPath.row]
        }else{
            citiesItem = filteredCitiesArray [indexPath.row]
        }
        
        cell.nameLabel.text = citiesItem.name
        cell.conditionsLabel.text = citiesItem.conditionString
        cell.temperatureLabel.text = citiesItem.temperatureString
        
        return cell
    }
}
// MARK:- Table View Delegate & Search Bar Delegate
extension ViewController: UITableViewDelegate, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var citiesItem = Weather()
        if searchBarIsEmpty{
            citiesItem = citiesArray [indexPath.row]
        }else{
            citiesItem = filteredCitiesArray [indexPath.row]
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detail = DetailViewController()
        detail.nameDetailInfo = citiesItem.name
        detail.conditionsDetailInfo = citiesItem.conditionString
        detail.temperatureDetailInfo = citiesItem.temperatureString
        detail.windDetailInfo = "Скорость ветра:" + " " + String(format: "%.0f", citiesItem.windSpeed) + " " + "м/с"
        detail.pressureDetailInfo = "Давление:" + " " + String(citiesItem.presureMm) + " " + "мм.рт.ст"
        navigationController?.pushViewController(detail, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            if searchBarIsEmpty{
                
                citiesArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else{
                filteredCitiesArray.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            tableView.endUpdates()
            
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCitiesArray = []
        
        if searchText == "" {
            filteredCitiesArray = citiesArray
        }else{
            
            for city in citiesArray{
                if city.name.lowercased().contains(searchText.lowercased()){
                    filteredCitiesArray.append(city)
                    
                }
            }
        }
        self.tableView.reloadData()
    }
}


