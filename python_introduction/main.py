print("Hello World")

# Değişkenler
x = 5
print(x)
print(type(x)) # integer => tam sayı

text = "Turkcell" # string + tanımlama
print(text)

text = "Kodlamaio" # Değer atama
print(text)

# immutabla (value) - Değer Tip
a = 5
b = a
b = 3
print(b)
print(a)

# Mutable - (reference type)
x = [1,2,3]
y = x
y.append(4)
print(x)
print(y)

# type-safe değil
number = 5
number = "Halit"
print(number)

# index
names = ["Halit", "Esra", "Lütfiye", 5, True]
print(names[0]) # ilk değer
print(names[-1]) # son değer
print(names[0:2])
print(names[:2])
print(names[0:0:2])
print(names[::2])
print(names[1:])

numbers = [0,5,10,24,12,56,5,5]
print(len(numbers))
print("******")
numbers.sort(reverse=False) # default => false küçükten büyüğe. True => büyükten küçüğe
print(numbers)
print(sorted(numbers)) # sıralama için farklı yöntem
print(numbers.count(5)) # belirli bir değerin tekrar sayısına ulaşmak
numbers.reverse()
print(numbers)

# döngüler 
# x satır kodun y adet çalışmasını sağlamak temel amaç

# indentation mantığı 
my_variable2 = "For disindaki değişken"
for i in range(5):
    my_variable = "For içindeki değişken"
    print(my_variable2)
    print(i)
print(my_variable)
# shift + tab -> 1 indent sola 
# tab -> 1 indent sağa
for i in range (5,10):
    print(i)
print("*****")
for i in range(5,10,2):
    print(i)

# range(baslangıç, (0), bitiş, adım sayısı(1))

students = ["Merve", "Şeyda", "Şüheda", "Ece"]

for student in students:
    print(student)


# Koşul ve şart blokları
# Bir if bloğu her zaman yalnızca bir blok çalıştırır. !!
# Aynı koşulu sağlayan bloklar var ise önce olan kullanılır. 
note = 50
if note > 50:
    print("Geçtiniz")

elif note ==50:
    print("Sınırdan geçtiniz")

else: 
    print("Kaldınız")

for student in students:
    if student == "Şüheda":
        break # bu loopu burda bitir
    print(student)
else:
    print("1. For loopu bitti.")
print("******")

for student in students:
    if student == "Şüheda":
        continue # bu iterasyonu burda bitir.
    print(student)
else: # break ile kırılmadıysa loop bitiminde çalışır.
    print("2. For loopu bitti.")


# while döngüsü
i=0
while i<5: # koşul sağlandığı sürece buradaki döngüyü çalıştır.
    print(i)
    i += 1

student_name = "Halit"

#while student_name == "Halit":
#    print("**")

# match-case 3.10 -> switch -case  yapısı gibi

print("************************* DERS 2 **************************")
# string
age = 25 # dışarıdan int olarak geliyor
name = "Halit"
# text = "Merhaba, adim" + name+ "yasim" + age # formatlama # hatalı

# build-in
text = f"Merhaba adim {name} yasim {age}" # f-string
# text = "Merhaba, adim {} yasim {}".format(name, age)
# text = "Merhaba adim {name} yasim {age}".format(name=name, age=age)
print(text)

text2 = "tURKcell kodlamaio"
print(text2.capitalize())
print(text2.lower())
print(text2.upper())
print(text2.endswith("io")) # case-sensetive
print(text2.startswith("turk")) # case-sensitive
print(text2.lower().startswith("turk"))


age2 = "25"
print(age2.isalnum())
print(age2.isnumeric())
print(age2.isascii())
print(age2.isspace())
print(age2.isalpha())

text3 = 'Merhaba Turkcell'
print(text3)

long_text = """ Line 1 
Line 2
Line 3 """ # tek tırnak veya çift tırnak olması önemli değil

print(long_text)

escape_characters = "Bugünkü konumuz \"Python ile programlama\"" # escape character \
print(escape_characters)

escape_characters2 = "Bugünkü konumuz \n \\ Python ile Programlama"
print(escape_characters2)

folder_path = r"C:\Program Files\Turkcell\n" # raw -> kaçış karakterlerini iptal et.
print(folder_path)

print("\n************* FUNCTİONS ******************\n")
# FUNCTİONS

def say_hello():
    print("Merhaba Turkcell")

say_hello()

# parametre, argüman* args
def calculate_age(year):
    age = 2025 - year
    print(f"Hesaplanan Yas {age}")

calculate_age(1998)
calculate_age(1985)
calculate_age(2000)
calculate_age(2002)
calculate_age(1978)

def say_hi(fname, lname):
    print(f"Merhaba {fname} {lname}")

say_hi("Fatma Büşra", "Tilki")

def calculate_return_age(year):
    age = 2025 - year
    return age

age5 = calculate_return_age(2000)
if(age5 < 18):
    print("Reşit Değil")
else:
    print("Reşit")

# *args
def print_lessons(*lessons):
    for lesson in lessons:
        print(lesson)
print_lessons("Java","Python")
print_lessons("C#")
print_lessons("İstatistik","Matematik","Biyoloji")
#

# **kwargs -> keyword args
def introduce_instructor(**instructor):
    print(f"Ad: {instructor['fname']}  Soyad: {instructor['lname']} Yaş: {instructor['age']}")

introduce_instructor(fname="Halit Enes",lname="Kalaycı",age=25)
introduce_instructor(fname="Engin",lname="Demiroğ",age=25)


def default_parameter(name, country = "Turkey"):
    print(f"{name} {country}")

default_parameter("A","Greece")
default_parameter("B","Bulgaria")
default_parameter("C")

print(bool(0))