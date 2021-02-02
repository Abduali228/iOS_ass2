import UIKit

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var gameModels = [Question]()
    var currentQuestion: Question?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var table: UITableView!
    @IBOutlet weak var countQuiz: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        setUpQuestions()
        configureUI(question: gameModels.first!)
    }
    
    private func configureUI(question: Question){
        label.text = question.text
        currentQuestion = question
        table.reloadData()
    }
    
    private func checkAnswer(answer: Answer, question: Question) -> Bool{
        return question.answers.contains(where: {$0.text == answer.text}) && answer.correct
    }
    
    private func setUpQuestions() {
        gameModels.append(Question(text: "What is the 2+2?", answers: [
            Answer(text: "2", correct: false),
            Answer(text: "4", correct: true),
            Answer(text: "1", correct: false),
            Answer(text: "3", correct: false)
        ]))
        
        gameModels.append(Question(text: "What is the 3+2?", answers: [
            Answer(text: "2", correct: false),
            Answer(text: "4", correct: false),
            Answer(text: "5", correct: true),
            Answer(text: "3", correct: false)
        ]))
        
        gameModels.append(Question(text: "What is the 1+2?", answers: [
            Answer(text: "2", correct: false),
            Answer(text: "1", correct: false),
            Answer(text: "4", correct: false),
            Answer(text: "3", correct: true)
        ]))
        
        gameModels.append(Question(text: "What is the 1+1?", answers: [
            Answer(text: "2", correct: true),
            Answer(text: "1", correct: false),
            Answer(text: "4", correct: false),
            Answer(text: "3", correct: false)
        ]))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentQuestion?.answers.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath )
        cell.textLabel?.text = currentQuestion?.answers[indexPath.row].text
        return cell
    }
    
    
    var gameResult: Double = 1
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let question = currentQuestion else {
            return
        }
        
        let answer = question.answers[indexPath.row]

       
        var  temp: Int = 0
        
        if checkAnswer(answer: answer, question: question) {
            if let index = gameModels.firstIndex(where: {$0.text == question.text}){
                if index < (gameModels.count - 1){
                    let nextQuestion = gameModels[index+1]
                    countQuiz.text = String(index+1)
                    currentQuestion = nil
                    configureUI(question: nextQuestion)
                    gameResult += 1
                    temp = index
                }else{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    if let vc3 = storyboard.instantiateViewController(identifier: "VC3") as? ResultViewController {
                        vc3.result = gameResult
                        
                        vc3.modalPresentationStyle = .fullScreen
                        present(vc3, animated: true)
                    }
                   
                    
                }
            }
        }else if checkAnswer(answer: answer, question: question) == false {
           if let index = gameModels.firstIndex(where: {$0.text == question.text}){
            if index < (gameModels.count - 1){
                let nextQuestion = gameModels[index+temp+1]
                countQuiz.text = String(index+1)
                currentQuestion = nil
                configureUI(question: nextQuestion)
                
            }else{
            
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let vc3 = storyboard.instantiateViewController(identifier: "VC3") as? ResultViewController {
                    vc3.result = gameResult
                    
                    vc3.modalPresentationStyle = .fullScreen
                    present(vc3, animated: true)
                }
                            }
           }
        }
    }
}

struct Question {
    let text: String
    let answers: [Answer]
    
}

struct Answer {
    let text: String
    let correct: Bool
}
