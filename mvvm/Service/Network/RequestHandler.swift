import Foundation

/*
    ADD ANY API-TO-MODEL CONVERSION CODE HERE IF NEED BE.
    SEE EXAMPLE: https://benoitpasquier.com/ios-swift-mvvm-pattern/
 */
class RequestHandler {
    
    func networkResult<T: Decodable>(completion: @escaping ((Result<[T], ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            
            return { dataResult in 
                
                DispatchQueue.global(qos: .background).async(execute: { 
                    switch dataResult {
                        case .success(let data) :
                            ParserHelper.parse(data: data, completion: completion)
                            break
                        case .failure(let error) :
                            print("Network error \(error)")
                            completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                            break
                        }
                })
                
            }
    }
    
    func networkResult<T: Decodable>(completion: @escaping ((Result<T, ErrorResult>) -> Void)) ->
        ((Result<Data, ErrorResult>) -> Void) {
            return { dataResult in
                DispatchQueue.global(qos: .background).async(execute: {
                    switch dataResult {
                    case .success(let data) :
                        ParserHelper.parse(data: data, completion: completion)
                        break
                    case .failure(let error) :
                        print("Network error \(error)")
                        completion(.failure(.network(string: "Network error " + error.localizedDescription)))
                        break
                    }
                })
                
            }
    }
}
