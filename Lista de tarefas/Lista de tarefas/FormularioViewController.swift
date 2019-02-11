//
//  FormularioViewController.swift
//  Lista de tarefas
//
//  Created by aluno on 05/02/19.
//  Copyright © 2019 teste. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FormularioViewController: UIViewController {

    @IBOutlet weak var novoItem: UITextField!
    @IBOutlet weak var myMap: MKMapView!
    
    @IBOutlet weak var imagemPin: UIImageView!
    
    let locationManager = CLLocationManager()
    var dataBase = Database.instance()
    
    private var tarefa: Tarefa?
    private var atualuzar = false
    
    
    func setTarefa(tarefa: Tarefa){
        self.tarefa = tarefa
        
        atualuzar = true
    }

    
    @IBAction func btAdicionar(_ sender: UIButton) {
        if let value = self.novoItem.text {
            if(value != ""){
                
                if(self.tarefa != nil){
                    let tarefa = Tarefa(descricao: value, latitude: myMap.centerCoordinate.latitude, longitude: myMap.centerCoordinate.longitude)
                    
                    dataBase.insert(add: tarefa)
                }
                else{
                    let tarefa = Tarefa(descricao: value, latitude: myMap.centerCoordinate.latitude, longitude: myMap.centerCoordinate.longitude)
                    
                    dataBase.edit(index: <#T##Int#>, value: tarefa)
                }
                
                UserDefaults.standard.set(value, forKey: value)
                
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        novoItem.text = tarefa?.descricao
        
        //imagemPin.
        //imagemPin.image = UIImage(named: "pin")
        
        locationManager.delegate = self
        //myMap.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // requesting user permission
        locationManager.requestWhenInUseAuthorization()
        
        // creating a center zoom where the map will update
        if let coordinates = locationManager.location?.coordinate {
            update(coordinates: coordinates)
        }
        
        //let cordenadas = myMap.centerCoordinate
        
        // adding a annotation
        let point = MKPointAnnotation()
        point.title = "Local da tarefa"
        point.coordinate = CLLocationCoordinate2D(latitude: -8.0179, longitude: -34.8889)
        //myMap.addAnnotation(point)
        
        // start location updates
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
    }
    
    private func update(coordinates: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        myMap.setRegion(region, animated: true)
        
        //myMap.centerCoordinate
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension FormularioViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // update the location here
        if let coordinate = locations.last {
            let region = MKCoordinateRegion(center: coordinate.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            myMap.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // update the authorization here
    }
}

extension FormularioViewController: MKMapViewDelegate {}
