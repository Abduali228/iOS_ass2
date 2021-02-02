import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
   
    var historyTable = ["Test", "Test"]
    var data: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpHistory()
    }
    
    private func setUpHistory(){
        historyTable.append(data)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = historyTable[indexPath.row]
        return cell
    }
    
    @IBAction func Back(_ sender: UIButton) {
        let viewcontroller = storyboard?.instantiateViewController(identifier: "home") as! ViewController
        
        viewcontroller.modalPresentationStyle = .fullScreen
        present(viewcontroller, animated: true)
    }
    
    
}

