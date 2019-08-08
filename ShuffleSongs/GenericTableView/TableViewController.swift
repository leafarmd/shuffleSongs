import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let dataSoruce: TableViewDataSource
    
    init(dataSoruce: TableViewDataSource, nibName: String = "TableViewController") {
        self.dataSoruce = dataSoruce
        
        super.init(nibName: "TableViewController", bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    private func setupTableView() {
        
        tableView.dataSource = dataSoruce
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 50
        self.tableView.tableFooterView = UIView()
    }
}
