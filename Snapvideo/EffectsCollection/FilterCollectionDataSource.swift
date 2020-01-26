import UIKit

class FilterCollectionDataSource: NSObject, UICollectionViewDataSource {
    weak var collectionView: UICollectionView?
    let filters: [AnyFilter]
    var filteredImages: [String: UIImage] = [:]
    var image: UIImage? {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    var context: CIContext = CIContext(options: [CIContextOption.workingColorSpace : NSNull()])
    
    init(collectionView: UICollectionView, filters: [AnyFilter]) {
        self.filters = filters
        self.collectionView = collectionView
        super.init()
        collectionView.dataSource = self
        collectionView.register(
            EffectsCollectionViewCell.self,
            forCellWithReuseIdentifier: "effectsCollectionViewCell"
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reusableIdentifier = "effectsCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableIdentifier, for: indexPath) as! EffectsCollectionViewCell
        cell.effectName.text = filters[indexPath.row].name
        
        if let filteredImage = filteredImages[filters[indexPath.row].name] {
            cell.previewImageView.image = filteredImage
        } else {
            if let cgImage = image?.cgImage {
                let ciImage = CIImage(cgImage: cgImage)
                let filteredCIImage = filters[indexPath.row].apply(ciImage)
                if let filteredCGImage = context.createCGImage(filteredCIImage, from: filteredCIImage.extent) {
                    let uiImage = UIImage(cgImage: filteredCGImage)
                    filteredImages[filters[indexPath.row].name] = uiImage
                    cell.previewImageView.image = uiImage
                }
            }
        }
        
        return cell
    }
}
