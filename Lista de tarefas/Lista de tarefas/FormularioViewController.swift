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
    private var atualizar = false
    private var indice: Int = -1
    
    
    func setTarefa(indice: Int, tarefa: Tarefa){
        self.tarefa = tarefa
        self.indice = indice
        self.atualizar = true
    }

    
    @IBAction func btAdicionar(_ sender: UIButton) {
        if let value = self.novoItem.text {
            if(value != ""){
                let tarefa = Tarefa(descricao: value, latitude: myMap.centerCoordinate.latitude, longitude: myMap.centerCoordinate.longitude)
                if ( atualizar ) {
                    dataBase.edit(index: self.indice, value: tarefa)
                } else {
                    dataBase.insert(add: tarefa)
                }
                
                UserDefaults.standard.set(value, forKey: value)
                
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        novoItem.text = tarefa?.descricao
        var longitude = tarefa?.longitude ?? -8.0179
        var latitude = tarefa?.latitude ?? -34.8889

        
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
        point.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        myMap.addAnnotation(point)
        

        
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
