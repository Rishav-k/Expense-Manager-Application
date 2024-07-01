import UIKit

class BalanceViewController: UIViewController {
    
    private var balanceViewModel = BalanceViewModel()
    private var transactionViewModel = TransactionViewModel()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Balance: Rs. 0.00"
        return label
    }()
    
    private let creditButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Credit", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(creditTapped), for: .touchUpInside)
        return button
    }()
    
    private let debitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Debit", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(debitTapped), for: .touchUpInside)
        return button
    }()
    
    private let transactionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View Transactions", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(viewTransactionsTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        updateBalance()
    }
    
    private func setupViews() {
        view.addSubview(balanceLabel)
        view.addSubview(creditButton)
        view.addSubview(debitButton)
        view.addSubview(transactionsButton)
        
        NSLayoutConstraint.activate([
            balanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            balanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            
            transactionsButton.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 20),
            transactionsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            transactionsButton.widthAnchor.constraint(equalToConstant: 200),
            transactionsButton.heightAnchor.constraint(equalToConstant: 50),
            
            debitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            debitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            debitButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            debitButton.heightAnchor.constraint(equalToConstant: 50),
            
            creditButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            creditButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            creditButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            creditButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func creditTapped() {
        presentTransactionViewController(type: .credit)
    }
    
    @objc private func debitTapped() {
        presentTransactionViewController(type: .debit)
    }
    
    @objc private func viewTransactionsTapped() {
        let transactionListVC = TransactionListViewController()
        transactionListVC.transactionViewModel = transactionViewModel
        navigationController?.pushViewController(transactionListVC, animated: true)
    }
    
    private func presentTransactionViewController(type: TransactionType) {
        let transactionVC = TransactionViewController()
        transactionVC.transactionType = type
        transactionVC.balanceViewModel = balanceViewModel
        transactionVC.transactionViewModel = transactionViewModel
        transactionVC.delegate = self
        navigationController?.pushViewController(transactionVC, animated: true)
    }
    
    private func updateBalance() {
        balanceLabel.text = "Balance: Rs. \(balanceViewModel.totalBalance)"
    }
}

extension BalanceViewController: TransactionViewControllerDelegate {
    func didAddTransaction() {
        updateBalance()
    }
}
