system ('clear')
class Person
	attr_reader :name
	attr_accessor :cash
	def initialize(name, cash)
		@name = name
		@cash = cash
		puts "Hi #{@name}, you have $#{@cash}."
	end
end

class Bank
	attr_accessor :account
	attr_reader :bank
	def initialize(bank)
		@bank = bank
		@account = {}
		puts "#{@bank} bank was just created."
	end
	def open_account(person)
		if person.class == Person
			@account[person] = 0
			puts "#{person.name}, thanks for opening an account at #{@bank}"
		else
			puts "Error: no person exist"
		end
	end
	def deposit(person, amount)
		if person.class == Person
			if amount > 0 && amount <= person.cash
				@account[person] += amount
				person.cash -= amount
				puts "#{person.name} deposited $#{amount} to #{@bank}. #{person.name} has $#{person.cash}. #{person.name}'s account has $#{@account[person]}."
			elsif amount < 0
				puts "Can't deposit a negative amount."
			elsif amount > person.cash
				puts "#{person.name} doesn't have enough cash to make this deposit."
			else
				puts "Error"
			end
		else
			puts "Error: no person exist"
		end
	end
	def withdraw (person, amount)
		if person.class == Person
			if amount > 0 && amount <= @account[person]
				@account[person] -= amount
				person.cash += amount
				puts "#{person.name} withdrew $#{amount} from #{@bank}. #{person.name} has $#{person.cash}. #{person.name}'s account has $#{@account[person]}."
			elsif amount < 0
				puts "Can't withdraw a negative amount."
			elsif amount > @account[person]
				puts "#{person.name}'s account doesn't have enough money to make this withdrawl."
			else
				puts "Error"
			end
		else
			puts "Error: no person exist"
		end
	end
	def transfer (person, bank, amount)
		if person.class == Person && bank.class == Bank
			if amount <= @account[person]
				@account[person] -= amount
				bank.account[person] += amount
				puts "#{person.name} transferred #{amount} from the #{@bank} account to the #{bank.bank} account. The #{@bank} account has $#{@account[person]} and the #{bank.bank} account has $#{bank.account[person]}."
			else
				puts "Not enough money in acount to make transfer."
			end
		elsif bank.class != Bank
			puts "Error: not a valid bank"
		else
			puts "Error: no person exist"
		end
	end
	def total_cash_in_bank
		sum = (@account.values).inject(:+)
		puts "#{@bank} has $#{sum} in the bank."

	end

end


chase = Bank.new("JP Morgan Chase")
wells_fargo = Bank.new("Wells Fargo")
me = Person.new("Shehzan", 500)
friend1 = Person.new("John", 1000)
chase.open_account(me)
chase.open_account(friend1)
wells_fargo.open_account(me)
wells_fargo.open_account(friend1)
chase.deposit(me, 200)
chase.deposit(friend1, 300)
chase.withdraw(me, 50)
chase.transfer(me, wells_fargo, 100)

chase.deposit(me, 5000)
chase.withdraw(me, 5000)

chase.total_cash_in_bank
wells_fargo.total_cash_in_bank

