//
//  SettingsViewController.swift
//  8Ball
//
//  Created by QwertY on 24.01.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var answerTextField: UITextField!
    @IBOutlet private weak var answersTableView: UITableView!
    @IBOutlet private weak var deleteAnswersButton: UIButton!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        saveAnswer()
    }
    
    @IBAction func deleteAnswersButtonTapped(_ sender: Any) {
        changeTableViewEditingMode()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsTableView()
        setupAnswerTextField()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupSettingsTableView() {
        answersTableView.delegate = self
        answersTableView.dataSource = self
        answersTableView.tableFooterView = UIView()
    }
    
    private func setupAnswerTextField() {
        answerTextField.delegate = self
    }
    
    private func saveAnswer() {
        if let answer = answerTextField.text {
            if !answer.isEmpty {
                UserAnswers.answers.append(answer)
                answerTextField.text = ""
                answersTableView.reloadData()
            }
        }
    }
    
    private func changeTableViewEditingMode() {
        if (answersTableView.isEditing == true) {
            answersTableView.isEditing = false
            deleteAnswersButton.setTitle("Delete answers", for: .normal)
        } else {
            answersTableView.isEditing = true
            deleteAnswersButton.setTitle("Done", for: .normal)
        }
    }
    
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        UserAnswers.answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "settingsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = UserAnswers.answers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            UserAnswers.answers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        answerTextField.resignFirstResponder()
        saveAnswer()
        return true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}
