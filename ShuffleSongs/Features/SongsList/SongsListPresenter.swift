import Foundation

final class SongsListPresenter {
    
    var models: [SongModel] = []
    weak var view: SongsListView?
    private let service: SongsListServiceInput
    private let router: SongsListRoutering
    
    init(service: SongsListServiceInput, router: SongsListRoutering) {
        self.service = service
        self.router = router
    }
    
    func attachView(_ view: SongsListView) {
        self.view = view
        
        view.showLoadingFeedback()
        service.fetchSongsList(id: "909253,1171421960,358714030,1419227,264111789", limit: 5)
    }
    
    func shuffle() {
    models = ShuffleFactory.ShuffeSongs(songs: models)
        view?.reloadData(with: models)
    }
}

extension SongsListPresenter: SongsListServiceOutput {
    
    func fetchSongsListSucceeded(output: SongsOutput) {
        view?.hideLoadingFeedback()
        
        output.results.forEach {
            models.append(SongModel(output: $0)) }
        view?.reloadData(with: models)
    }
    
    func fetchSongsListFailed(error message: String) {
        view?.hideLoadingFeedback()
        view?.showMessage(title: "Error", message: message)
    }
}
