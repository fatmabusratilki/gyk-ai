# Modüller
# import edilebilen modüller -> built-in (pythonda kurulu),
# kendi modüllerim (projedeki diğer .py dosyaları)
# 3. taraf kütüphaneler


#built-in -> math
# import math # dışarıdan built in modül import etmek
# import math -> tüm matematik kütüphanesini import eder.
from math import sqrt, factorial 
# from oop import Account
import account
import requests
# ctrl+space -> intellisense
num1 = int(input())

result = sqrt(num1)
print(result)

result2 = factorial(num1)
print(result2)

acc1 = account.Account(500)
acc1.deposit(500)
acc1.withdraw(100)
acc1.print_status()


url = "https://jsonplaceholder.typicode.com/posts/1"
response = requests.get(url)

if response.status_code == 200:
    print(response.json())  # JSON yanıtı al
else:
    print("Hata:", response.status_code)