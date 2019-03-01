
import Foundation

class ExpenseItem {
    var amount: Float
    var category: String
    var date: Date

    init(amount: Float, date: Date, category: String) {
        self.amount = amount
        self.category = category
        self.date = date
    }
}
