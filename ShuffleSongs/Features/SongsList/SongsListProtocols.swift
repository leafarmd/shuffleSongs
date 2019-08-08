import UIKit

protocol SongsListView: class {
    func showLoadingFeedback()
    func hideLoadingFeedback()
    func reloadData(with model: [SongModel])
    func showMessage(title: String, message: String)
}

protocol SongsListRoutering {
    func makeViewController() -> UIViewController
}

protocol SongsListServiceInput: class {
    var output: SongsListServiceOutput? { get }
    func fetchSongsList(id: String, limit: Int)
}

protocol SongsListServiceOutput: class {
    func fetchSongsListSucceeded(output: SongsOutput)
    func fetchSongsListFailed(error message: String)
}
