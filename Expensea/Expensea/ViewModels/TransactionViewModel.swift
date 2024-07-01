import Foundation

class TransactionViewModel {
    private var transactions: [Transaction] = []

    var transactionCount: Int {
        return transactions.count
    }

    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }

    func transaction(at index: Int) -> Transaction {
        return transactions[index]
    }
}
