import UIKit

class ResourcesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var videos = ["Raising your credit score": "https://youtu.be/EGnIbI94Idw",
                  "Savings: peer to peer lending": "https://youtu.be/PMezjFfZUoQ",
                  "Planning retirement in your 20s & 30s": "https://finance.yahoo.com/news/one-thing-can-20s-30s-thatll-make-richer-retirement-142743335.html",
                  "Do's & dont's of a W-4": "https://finance.yahoo.com/news/dos-donts-filling-w-4-171411994.html",
                  "Homebuying myths": "https://finance.yahoo.com/news/dont-fall-6-homebuying-myths-145216607.html",
                  "Roth IRA 101": "https://finance.yahoo.com/news/money-basics-roth-ira-211008525.html",
                  "Credit cards & loans": "https://www.khanacademy.org/economics-finance-domain/core-finance/interest-tutorial/credit-card-interest/v/annual-percentage-rate-apr-and-effective-apr",
                  "Renting vs. buying": "https://www.khanacademy.org/economics-finance-domain/core-finance/housing/renting-v-buying/v/renting-versus-buying-a-home",
                  "Mortgages": "https://www.khanacademy.org/economics-finance-domain/core-finance/housing/mortgages-tutorial/v/introduction-to-mortgage-loans",
                  "Personal taxes": "https://www.khanacademy.org/economics-finance-domain/core-finance/taxes-topic/taxes/v/basics-of-us-income-tax-rate-schedule",
                  "Introduction to stocks": "https://www.khanacademy.org/economics-finance-domain/core-finance/stock-and-bonds/stocks-intro-tutorial/v/what-it-means-to-buy-a-company-s-stock",
                  "Inflation basics": "https://www.khanacademy.org/economics-finance-domain/core-finance/inflation-tutorial#inflation-basics-tutorial",
                  "Banking & money": "https://www.khanacademy.org/economics-finance-domain/core-finance/money-and-banking#banking-and-money",
                  "Bitcoin": "https://www.khanacademy.org/economics-finance-domain/core-finance/money-and-banking#bitcoin",
                  "Foreign exchange & trade": "https://www.khanacademy.org/economics-finance-domain/core-finance/money-and-banking#currency-tutorial",
                  "Hedge funds": "https://www.khanacademy.org/economics-finance-domain/core-finance/investment-vehicles-tutorial#hedge-funds",
                  "Retirement accounts: IRAs & 401ks": "https://www.khanacademy.org/economics-finance-domain/core-finance/investment-vehicles-tutorial#ira-401ks",
                  "Buying a car": "https://money.cnn.com/pf/money-essentials-car-budget/index.html",
                  "Kids & money": "https://money.cnn.com/pf/money-essentials-kids-financial-responsibility/index.html",
                  "Health insurance": "https://money.cnn.com/pf/money-essentials-health-insurance-plans/index.html"]

    @IBOutlet weak var videoTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()

        videoTableView.dataSource = self
        videoTableView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier", for: indexPath)

//        let text = videos[indexPath.row]
//        cell.textLabel?.text = text

        let key = Array(videos)[indexPath.row].key
        cell.textLabel?.text = key


        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let key = Array(videos)[indexPath.row].key
        let link = videos[key]

        tableView.deselectRow(at: indexPath, animated: true)

        let optionMenu = UIAlertController(title: nil, message: "Open " + link! + "?", preferredStyle: .actionSheet)

        let goToAction = UIAlertAction(title: "Go to link", style: .default, handler: {
            (action: UIAlertAction!) -> Void in
            UIApplication.shared.open(NSURL(string: link!)! as URL)
            print("Opened link.")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(goToAction)
        optionMenu.addAction(cancelAction)

        present(optionMenu, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
