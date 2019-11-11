import Foundation

final class FileDataService : TaxReturnServiceProtocol {
    
    static let shared = FileDataService()
    
    func fetch(_ completion: @escaping ((Result<[TaxReturn], ErrorResult>) -> Void)) {
        guard let data = FileManager.readJson(forResource: "tax-returns") else {
            completion(Result.failure(ErrorResult.custom(string: "No file or data")))
            return
        }
        ParserHelper.parse(data: data, completion: completion)
    }
}

extension FileManager {
    static func readJson(forResource fileName: String ) -> Data? {
        let bundle = Bundle(for: FileDataService.self)
        if let path = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                return data
            } catch {
                // handle error
            }
        }
        return nil
    }
}
