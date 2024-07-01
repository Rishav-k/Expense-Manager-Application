import Foundation

class BalanceViewModel {
    private var balance: Balance = Balance()
    private var transactions: [Transaction] = []

    var totalBalance: Double {
        return balance.total
    }

    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
        updateBalance(with: transaction)
    }

    func getTransactions() -> [Transaction] {
        return transactions
    }

    private func updateBalance(with transaction: Transaction) {
        switch transaction.type {
        case .credit:
            balance.total += transaction.amount
        case .debit:
            balance.total -= transaction.amount
        }
    }
}
