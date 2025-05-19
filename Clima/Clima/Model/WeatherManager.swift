
import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager,weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a8054ed5f46ca18336ebf61194540f5f&units=metric"
    var weatherURL2 = "http://api.weatherapi.com/v1/current.json?key=a974d39e5ea24051adf73854251905"
    
    var delegate: WeatherManagerDelegate?
    
    func featchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    func featchWeather(Latitude: CLLocationDegrees,Longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(Latitude)&lon=\(Longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        
        //1. Create url
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            //4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let id = decodedData.weather[0].id
            let name = decodedData.name
            
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return weatherModel
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
