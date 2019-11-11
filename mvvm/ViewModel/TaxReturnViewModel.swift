import Foundation

struct TaxReturnViewModel {
    
    weak var dataSource : GenericDataSource<TaxReturn>?
    weak var service: TaxReturnServiceProtocol?
    
    var onErrorHandling : ((ErrorResult?) -> Void)?
    
    init(service: TaxReturnServiceProtocol = FileDataService.shared,
                dataSource : GenericDataSource<TaxReturn>?) {
        self.service = service
        self.dataSource = dataSource
    }
    
    func fetchTaxReturns() {
        
        guard let service = service else {
            onErrorHandling?(ErrorResult.custom(string: "Missing service"))
            return
        }
        
        service.fetch { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let taxReturns):
                    // TODO: One can add any view model conversion here
                    // TODO: Feed this to the GenericDatasource
                    print(taxReturns)
                    self.dataSource?.data.value = taxReturns
                case .failure(let error) :
                    self.onErrorHandling?(error)
                }
            }
        }
    }
}
