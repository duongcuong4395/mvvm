import UIKit

class TaxReturnViewController2: UIViewController {

    private let refreshControl = UIRefreshControl()
    
    let dataSource = TaxReturnCollectionViewDataSource()
    
    lazy var viewModel : TaxReturnViewModel = {
        return TaxReturnViewModel(service: TaxReturnService.shared, dataSource: dataSource)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupView()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        viewModel.fetchTaxReturns()
    }
    
    func configureView() {
        view.backgroundColor = .white
        title = "Collection View"
        view.addSubview(collectionView)
        collectionView.pin(to: view)
        
    }
    
    func setupView() {
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured",
                                               message: "Oops, something went wrong!",
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
    }
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: 700)

        let collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(TaxReturnCollectionViewCell.self, forCellWithReuseIdentifier: "TaxReturnCollectionViewCell")
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    
}
