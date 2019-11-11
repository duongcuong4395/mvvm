import UIKit

class TaxReturnViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    let dataSource = TaxReturnTableViewDataSource()
    
    lazy var viewModel : TaxReturnViewModel = {
        return TaxReturnViewModel(dataSource: dataSource)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupView()
        addRefreshControl()
        
        viewModel.fetchTaxReturns()
    }
    
    func configureView() {
        view.backgroundColor = .white
        title = "Table View"
        view.addSubview(tableView)
        tableView.pin(to: view)
    }
    
    func setupView() {
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] _ in
            self?.tableView.reloadData()
        }
        
        self.viewModel.onErrorHandling = { [weak self] error in
            let controller = UIAlertController(title: "An error occured",
                                               message: "Oops, something went wrong!",
                                               preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "Close", style: .cancel, handler: nil))
            self?.present(controller, animated: true, completion: nil)
        }
    }
    
    func addRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Your Tax Returns ...")
        refreshControl.addTarget(self, action: #selector(refreshTaxReturns(_:)), for: .valueChanged)
    }
    
    @objc func refreshTaxReturns(_ sender: Any) {
        viewModel.fetchTaxReturns()
        self.refreshControl.endRefreshing()
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 50
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.register(TaxReturnTableViewCell.self, forCellReuseIdentifier: "TaxReturnCell")
        return tableView
    }()
}


