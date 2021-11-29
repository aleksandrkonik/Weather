//
//  detailVC.swift
//  WeatherDesign
//
//  Created by user on 20.09.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class detailVC: UIViewController {

    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var temp_c: UILabel!
    
    @IBOutlet weak var coutryLabel: UILabel!
    
    @IBOutlet weak var imageWeather: UIImageView!
    
    var cityName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let colorTop = UIColor(red: 89/255,green: 156/255,blue: 169/255,alpha: 1.0).cgColor
//        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [colorTop,colorBottom]
//        gradientLayer.locations = [0.0,1.0]
//        self.view.layer.addSublayer(gradientLayer)

        // Do any additional setup after loading the view.

        currentWeather(city: cityName)
        
    }
    func currentWeather(city: String){
        let url = "http://api.weatherapi.com/v1/current.json?key=e042d71286ae4dfebd283226212009&q=\(city)"
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let name = json["location"]["name"].stringValue
                let temp = json["current"]["temp_c"].doubleValue
                let country = json["location"]["country"].stringValue
                let weatherURLString = "http:\(json["current"]["condition"]["icon"].stringValue)"
                self.cityNameLabel.text = name
                
                self.temp_c.text = String(temp) + " ºC"
                self.coutryLabel.text = country
                
                let weatherURL = URL(string: weatherURLString)
                if let data = try? Data(contentsOf: weatherURL!){
                    self.imageWeather.image = UIImage(data: data)
                }

            case .failure(let error):
                print(error)
            }
        }
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
