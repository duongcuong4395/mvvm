import Foundation

final class ParserHelper {
        
    static func parse<T: Decodable>(data: Data, completion : (Result<T, ErrorResult>) -> Void) {
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(T.self, from: data)
            completion(.success(decoded))
        } catch {
            // can't parse json
            completion(.failure(.parser(string: "Error while parsing json data")))
        }
    }
    

}
