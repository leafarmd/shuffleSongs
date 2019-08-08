import UIKit

final class SongsListRouter: SongsListRoutering {
    private let navigator: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigator = navigator
    }
    
    func makeViewController() -> UIViewController {
        let service = SongsListService()
        let presenter = SongsListPresenter(service: service, router: self)
        service.output = presenter
        let dataSource = TableViewDataSource()
        let viewController = SongsListViewController(presenter: presenter, dataSource: dataSource)
        return viewController
    }
}
