import UIKit
import CoreData

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {


    @IBOutlet weak var historyTableView: UITableView!
    var fetchResultController: NSFetchedResultsController<ExpenseItemMO>!
    var expenseItems = [ExpenseItemMO]()

    override func viewDidLoad() {
        super.viewDidLoad()

        historyTableView.dataSource = self
        historyTableView.delegate = self

        // Fetch data from data source
        let fetchRequest: NSFetchRequest<ExpenseItemMO> = ExpenseItemMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    expenseItems = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)

         // Configure the cell...
        let amount = String(expenseItems[indexPath.row].amount)
        let category = expenseItems[indexPath.row].category
        cell.textLabel?.text = "$\(amount) - \(category!)"

        return cell
    }

    // Functions for updates using CoreData
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        historyTableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                historyTableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                historyTableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                historyTableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            historyTableView.reloadData()
        }

        if let fetchedObjects = controller.fetchedObjects {
            expenseItems = fetchedObjects as! [ExpenseItemMO]
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        historyTableView.endUpdates()
    }

}
