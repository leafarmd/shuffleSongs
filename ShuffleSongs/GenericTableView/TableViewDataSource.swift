import UIKit

class TableViewDataSource: NSObject {
    
    var model: TableViewModel
    
    init(model: TableViewModel = TableViewModel()) {
        self.model = model
    }
}

extension TableViewDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = model.items[indexPath.row]
        if Bundle.main.path(forResource: type(of: item).reuseId, ofType: "nib") != nil {
            tableView.register(type(of: item).nib, forCellReuseIdentifier: type(of: item).reuseId)
        } else {
            tableView.register(type(of: item).cell, forCellReuseIdentifier: type(of: item).reuseId)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        
        item.configure(cell: cell)
        
        return cell
    }
}
