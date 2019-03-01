import UIKit
import CoreData


extension String {

    // Checks validity of double for amountField
    func isValidDouble(maxDecimalPlaces: Int) -> Bool {
        let formatter = NumberFormatter()
        formatter.allowsFloats = true
        let decimalSeparator = formatter.decimalSeparator ?? "."
        if formatter.number(from: self) != nil {
            let split = self.components(separatedBy: decimalSeparator)
            let digits = split.count == 2 ? split.last ?? "" : ""
            return digits.count <= maxDecimalPlaces
        }
        return false
    }
}

class AddExpenseVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    // Category array for UIPickerView
    var categories = ["--", "Food & Groceries", "Entertainment", "Transportation", "Clothes","Housing", "Utilities", "Other"]

    // Variable for ExpenseItem object
    var date: Date?
    var category: String?
    var amount: Float?

    // MARK: UI components
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var amountField: UITextField! {
        didSet { amountField?.addDoneCancelToolbar(onDone: (target: self, action: #selector(doneButtonTapped)), onCancel: (target: self, action: #selector(cancelButtonTapped))) }
    }
    @objc func cancelButtonTapped() {
        amountField.text = ""
        amountField.resignFirstResponder()
    }
    @objc func doneButtonTapped() {
        //amountField.text = "$" + amountField.text!
        amountField.resignFirstResponder()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty { return true }
        let currentText = textField.text ?? ""
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return replacementText.isValidDouble(maxDecimalPlaces: 2)
    }
    @IBOutlet weak var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered AddExpenseVC.")
        self.categoryPicker.dataSource = self
        self.categoryPicker.delegate = self
        self.amountField.delegate = self
        categoryPicker.selectRow(0, inComponent: 0, animated: true) // prevents nil selesction
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category = categories[row]
    }

    @IBAction func cancel(_ sender: Any) {
        print("Expense canceled.")
        dismiss(animated: true, completion: nil)
    }

    @IBAction func addExpense(_ sender: Any) {
        if !amountField.text!.isEmpty && datePicker != nil && category != nil && category! != "--" {
            // Formatting date to MMM dd, yyyy
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyy"
            date = datePicker.date

            // Get amount
            amount = Float((amountField.text!)) // Drop leading $ sign

            // Create ExpenseItem object
            var expenseItem: ExpenseItemMO!
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                expenseItem = ExpenseItemMO(context: appDelegate.persistentContainer.viewContext)
                expenseItem.amount = amount!
                expenseItem.category = category
                expenseItem.date = date
                print("Saving data to context...")
                appDelegate.saveContext()
            }

            print("\nAmount: $" + String(amount!))
            print("Date: " + dateFormatter.string(from: date!))
            print("Category: " + category!)
            print("Expense added.\n")
            dismiss(animated: true, completion: nil)
        }
        else {
            // Send error alert
            print("Failed to add expense.")
            let alert = UIAlertController(title: "Missing Input", message: "Please make sure to enter an amount and pick a category.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }


    }

}
