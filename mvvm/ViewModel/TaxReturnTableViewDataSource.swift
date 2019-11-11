import Foundation
import UIKit



// Even though this generic is one object, it becomes an array of objects in the GenericDataSource generics
// because you need a list to supply to a table or collection view
class TaxReturnTableViewDataSource : GenericDataSource<TaxReturn>, UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TaxReturnTableViewCell = tableView.dequeueReusableCell(withIdentifier: "TaxReturnCell", for: indexPath as IndexPath) as? TaxReturnTableViewCell else {
            fatalError("TaxReturnCell cell is not found")
        }
        let taxReturn = self.data.value[indexPath.row]
        cell.taxReturn = taxReturn
        return cell
    }
}
