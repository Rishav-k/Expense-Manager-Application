import Foundation

enum TransactionType {
    case credit
    case debit
}

struct Transaction {
    let title: String
    let amount: Double
    let type: TransactionType
}
