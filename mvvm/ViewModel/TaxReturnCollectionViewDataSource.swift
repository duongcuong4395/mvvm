import Foundation
import UIKit

// Even though this generic is one object, it becomes an array of objects in the GenericDataSource generics
// because you need a list to supply to a table or collection view
class TaxReturnCollectionViewDataSource : GenericDataSource<TaxReturn>, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: TaxReturnCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaxReturnCollectionViewCell", for: indexPath as IndexPath) as? TaxReturnCollectionViewCell else {
            fatalError("TaxReturnCollectionViewCell cell is not found")
        }
        let taxReturn = self.data.value[indexPath.row]
        cell.taxReturn = taxReturn
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    }
}
