import UIKit

protocol TransactionViewControllerDelegate: AnyObject {
    func didAddTransaction()
}

class TransactionViewController: UIViewController {
    
    var transactionType: TransactionType!
    var balanceViewModel: BalanceViewModel!
    var transactionViewModel: TransactionViewModel!
    weak var delegate: TransactionViewControllerDelegate?
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Title"
        return textField
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Amount"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(titleTextField)
        view.addSubview(amountTextField)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            amountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            amountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 100),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func saveTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let amountText = amountTextField.text, !amountText.isEmpty,
              let amount = Double(amountText) else {
            return
        }

        if transactionType == .debit, balanceViewModel.totalBalance < amount {
            // Show an alert if balance goes negative
            let alert = UIAlertController(title: "Insufficient Balance", message: "You do not have enough balance for this transaction.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        let transaction = Transaction(title: title, amount: amount, type: transactionType)
        balanceViewModel.addTransaction(transaction)
        transactionViewModel.addTransaction(transaction)
        delegate?.didAddTransaction()
        navigationController?.popViewController(animated: true)
    }
}
