import Foundation

final class ShuffleFactory {
    
    static func ShuffeSongs(songs: [SongModel]) -> [SongModel] { //Could be a better shuffle 😅
        var models = songs
        var dict: [String: Int] = [:]
        models.forEach { dict[$0.artistName] = 1 + (dict[$0.artistName] ?? 0) }
        if let maxFrequency = (dict.compactMap { $0.value }).max() {
            if maxFrequency > (models.count + 1) / 2 {
                models.shuffle()
                return models
            }
        }
        
        models.shuffle()
        var keepSwapping = true
        while keepSwapping {
            keepSwapping = false
            var indexesToSwap: [Int] = []
            var index = 1
            while index < models.count - 1 {
                let after = models.index(after: index)
                let before = models.index(before: index)
                if models[index].artistName == models[before].artistName || models[index].artistName == models[after].artistName {
                    indexesToSwap.append(index)
                    keepSwapping = true
                }
                index += 2
            }
            
            while indexesToSwap.count != 0 {
                let value = indexesToSwap.removeFirst()
                for index in 1..<models.count - 1 {
                    let after = models.index(after: index)
                    let before = models.index(before: index)
                    if models[value].artistName != models[before].artistName && models[value].artistName != models[after].artistName {
                        models.swapAt(value, index)
                    }
                }
            }
        }
    
        return models
    }
}
