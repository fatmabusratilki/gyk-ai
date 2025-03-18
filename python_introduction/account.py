class Account:
    def __init__(self, startBalance):
        self.__balance = startBalance
    def deposit(self, amount):
        self.__balance += amount
        print(f"{amount} kadar para yatırılıyor..")
    def withdraw(self, amount):
        if(self.__balance < amount):
            print("Bu kadar miktar çekemezsiniz..")
            return
        self.__balance -= amount
        print(f"{amount} kadar para çekiliyor..")
    def print_status(self):
        print(f"Hesap bakiyesi: {self.__balance}")
#