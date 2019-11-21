//
//  HomeViewController.swift
//  Weather
//
//  Created by Toto on 30/07/2019.
//  Copyright © 2019 Toto. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    typealias WebServiceResponse = (Error?) -> Void

    //MARK: Outlets
    @IBOutlet weak private var collectionView: UICollectionView!
    @IBOutlet weak var refresh_button: UIBarButtonItem!
    
    //MARK: Properties
    var estimateWidth = CGFloat(300.0)
    var margin = CGFloat(15.0)
    var viewModel = WeatherViewModel()
    var weathers: [WeatherProtocol] = []
    private var locationManager = CLLocationManager()
    
    private var currentLocation: CLLocation?
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Delegates
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        // Set Register Cell
        self.collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        
        self.setupGrid()
        self.weathers = self.viewModel.weathers
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        self.title = "Méteo"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.collectionView.reloadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.setupGrid()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Setup Grid View
    func setupGrid() {
        let flow = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        flow.minimumInteritemSpacing = CGFloat(1)
        flow.minimumLineSpacing = CGFloat(10)
    }
    
    /* Calculate the number of cells to display based on device orientation and return the items width. */
    func calculateWidth() -> CGFloat {
        let cellCount = floor(CGFloat(self.view.frame.size.width) / estimateWidth)
        let width = (self.view.frame.size.width - (cellCount - 1) - (margin * 2) ) / cellCount
        
        return width
    }
    
    //MARK: Weather
    /* Method to launch the query with the corresponding parameters*/
    func getWeather() {
        if !Connectivity().isConnectedToNetwork {
            self.collectionView.reloadData()
        } else {
            self.viewModel.fetchWeather(currentLocation: self.currentLocation) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.weathers = self.viewModel.weathers
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    
    @IBAction func refreshWeather(_ sender: Any) {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true){ _ in
            self.refresh_button.isEnabled = true
        }
        if CLLocationManager.locationServicesEnabled() {
            self.refresh_button.isEnabled = false
        } else {
            
            self.getWeather()
            return;
        }
    }
}

//MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weathers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.configurewith(weathers[indexPath.row], at: indexPath.row)
        
        cell.layer.cornerRadius = 10.0
        cell.layer.masksToBounds = true
        
        return cell
    }
}


//MARK: UICollectionViewDelegate
//MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeDetailsViewController: HomeDetailsViewController = storyboard.instantiateViewController(withIdentifier: "HomeDetailsViewController") as! HomeDetailsViewController
        homeDetailsViewController.backgroundColor = WeatherUtils.weatherColor(index: indexPath.row)
        homeDetailsViewController.weather = self.weathers[indexPath.row]
        self.navigationController?.pushViewController(homeDetailsViewController, animated: true)
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateWidth()
        return CGSize(width: width , height: width)
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.first
        self.locationManager.stopUpdatingLocation()
        
        self.getWeather()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .notDetermined, .restricted:
            self.currentLocation = nil
            self.getWeather()
        default: break
        }
    }
}
