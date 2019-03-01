import UIKit
import CoreData

class HomeVC: UIViewController, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var foodGroceriesLabel: UILabel!
    @IBOutlet weak var entertainmentLabel: UILabel!
    @IBOutlet weak var transportationLabel: UILabel!
    @IBOutlet weak var clothesLabel: UILabel!
    @IBOutlet weak var housingLabel: UILabel!
    @IBOutlet weak var utilitiesLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!

    var fetchResultController: NSFetchedResultsController<ExpenseItemMO>!
    var expenseItems = [ExpenseItemMO]()

    override func viewDidLoad() {
        super.viewDidLoad()

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
                    computeTotal(expenseItems: expenseItems)
                }
            } catch {
                print(error)
            }
        }

    }

    // Refresh data each time view appears
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func computeTotal(expenseItems: [ExpenseItemMO]) {
        if (expenseItems.count > 0) {
            var total: Float = 0.00
            var foodGroceriesTotal: Float = 0.00
            var entertainmentTotal: Float = 0.00
            var transportationTotal:Float = 0.00
            var clothesTotal: Float = 0.00
            var housingTotal: Float = 0.00
            var utilitiesTotal: Float = 0.00
            var otherTotal: Float = 0.00

            for i in 0...expenseItems.count - 1 {

                // Find total
                total += expenseItems[i].amount

                // Find category totals
                switch expenseItems[i].category {
                case "Food & Groceries":
                    foodGroceriesTotal += expenseItems[i].amount
                case "Entertainment":
                    entertainmentTotal += expenseItems[i].amount
                case "Transportation":
                    transportationTotal += expenseItems[i].amount
                case "Clothes":
                    clothesTotal += expenseItems[i].amount
                case "Housing":
                    housingTotal += expenseItems[i].amount
                case "Utilities":
                    utilitiesTotal += expenseItems[i].amount
                case "Other":
                    otherTotal += expenseItems[i].amount
                default:
                    total += 0.0 // Do nothing
                }
            }

            // Set labels
            totalLabel.text? = "$" + String(total)
            foodGroceriesLabel.text? = "$" + String(foodGroceriesTotal)
            entertainmentLabel.text? = "$" + String(entertainmentTotal)
            transportationLabel.text? = "$" + String(transportationTotal)
            clothesLabel.text? = "$" + String(clothesTotal)
            housingLabel.text? = "$" + String(housingTotal)
            utilitiesLabel.text? = "$" + String(utilitiesTotal)
            otherLabel.text? = "$" + String(otherTotal)
        }
    }


}
