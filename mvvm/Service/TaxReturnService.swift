import Foundation

protocol TaxReturnServiceProtocol : class {
    func fetch(_ completion: @escaping ((Result<[TaxReturn], ErrorResult>) -> Void))
}

final class TaxReturnService : RequestHandler, TaxReturnServiceProtocol {
    
    static let shared = TaxReturnService()
    
    let endpoint = "http://127.0.0.1:3002/api/tax-return/5e9bd466-54a9-443e-bcca-a955424b0772/customers"
    var task : URLSessionTask?
    
    func fetch(_ completion: @escaping ((Result<[TaxReturn], ErrorResult>) -> Void)) {
        
        // cancel previous request if already in progress
        self.cancelFetchCurrencies()
        
        task = RequestService().loadData(urlString: endpoint,
                                         completion: self.networkResult(completion: completion))
    }
    
    func cancelFetchCurrencies() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
