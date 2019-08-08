import UIKit

typealias SongsListCellConfig = TableCellConfigurator<SongsListTableViewCell, SongModel>

class SongsListTableViewCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var imageViewAlbum: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelArtistName: UILabel!
    
    func configure(data: SongModel) {
        imageViewAlbum.layer.cornerRadius = 10
        imageViewAlbum.loadImageFromURL(data.artworkURL)
        labelTitle.text = data.trackName ?? "--"
        let primaryGenreName = data.primaryGenreName ?? ""
        labelArtistName.text = "\(data.artistName)(\(primaryGenreName))"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageViewAlbum.image = nil
    }
   
}
