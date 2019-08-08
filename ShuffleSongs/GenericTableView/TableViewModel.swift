import Foundation

import UIKit

final class TableViewModel {
    
    var items: [CellConfigurator]
    
    init(items: [CellConfigurator] = []) {
        self.items = items
    }
}
