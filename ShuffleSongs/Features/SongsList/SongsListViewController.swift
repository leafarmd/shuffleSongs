import UIKit

final class SongsListViewController: TableViewController {
    
    private let presenter: SongsListPresenter
    
    init(presenter: SongsListPresenter, dataSource: TableViewDataSource) {
        self.presenter = presenter
        
        super.init(dataSoruce: dataSource, nibName: "SongsListViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Shuffle Songs"
        tableView.delegate = self
        presenter.attachView(self)
        
        let shuffleButton = UIBarButtonItem(image: UIImage(named: "shuffle"), style: .done, target: self, action: #selector(shuffle))
        navigationItem.rightBarButtonItem = shuffleButton
    }
    
    @objc func shuffle() {
        presenter.shuffle()
    }
}

extension SongsListViewController: SongsListView {
    
    func showLoadingFeedback() {
        Loading.start()
    }
    
    func hideLoadingFeedback() {
        Loading.stop()
    }
    
    func reloadData(with model: [SongModel]) {
        dataSoruce.model.items.removeAll()
        model.forEach { dataSoruce.model.items.append(SongsListCellConfig(item: $0)) }
        tableView.reloadData()
    }
    
    func showMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }
}

extension SongsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
