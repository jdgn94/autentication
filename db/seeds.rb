# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

TransactionType.create(name_transaction: "deposit")
TransactionType.create(name_transaction: "withdraw")
TransactionType.create(name_transaction: "transfer")
Currency.create(name_currency: "Dollar", acronym: "USD", symbol: "$", conversion: 1)
Currency.create(name_currency: "euro", acronym: "EUR", symbol: "€", conversion: 0.85999)
Currency.create(name_currency: "Bolivar", acronym: "VES", symbol: "BSS", conversion: 61.7751)
Currency.create(name_currency: "Yen", acronym: "JPY", symbol: "¥", conversion: 112.03)
AccountType.create(name_account_type: "savings account")
AccountType.create(name_account_type: "current account")
BankType.create(name_bank: "Banesco")
BankType.create(name_bank: "Bank of Venezuela")
BankType.create(name_bank: "BBVA")
BankType.create(name_bank: "BNC")
BankType.create(name_bank: "BOD")
BankType.create(name_bank: "Mercantil")
TransactionModeType.create(name_transaction_type: "cash")
TransactionModeType.create(name_transaction_type: "check")
TransactionModeType.create(name_transaction_type: "electronic transfer")
