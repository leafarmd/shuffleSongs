import Foundation

final class SongsListService: SongsListServiceInput {
    weak var output: SongsListServiceOutput?
    let api: APICore
    
    init(api: APICore = API()) {
        self.api = api
    }
    
    func fetchSongsList(id: String, limit: Int = 5) {
        
        api.requestObject(from: .songs(id: id, limit: limit), type: SongsOutput.self) { [weak self] response in
            switch response {
            case .success(let result):
                self?.output?.fetchSongsListSucceeded(output: result)
            case .failure(let failure):
                self?.output?.fetchSongsListFailed(error: failure.message)
            }
        }
    }
}
