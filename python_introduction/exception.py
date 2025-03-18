# 04.02.2025
# Hata Yönetimi

print("Hata yönetimi")

# Kullanıcıdan 2 sayı al, bunların bölümünü print et.
# try-catch-finally blokları -> try-except-else-finally

try:
    sayi1 = input("Lütfen ilk sayıyı giriniz: ") # casting "1", "abc", "12345", "True", 1->"1"
    sayi1 = int(sayi1)

    sayi2 = input("Lütfen ikinci sayıyı giriniz: ")
    sayi2 = int(sayi2)

    if(sayi2==0):
        raise RuntimeError("İkinci sayı 0 olamaz.")
    print(f"Sonuç: {sayi1/sayi2}")

    print("Hata yönteimi bitti.")
except ZeroDivisionError as e:
    print(e)
    print("İkinci sayı olarak 0 girilemez..")
except RuntimeError as e:
    print(e)
except Exception as e:
    print(f"Bilinmeyen hata...: {e}")
else: # Hiç bir hata fırlamadığında kullanılacak. / finally kod bloğu else bloğu kullanıldığında adından da anlaşılabileceği gibi en sona yazılmalı.
    print("Hata yok..")
finally:
    print("Her halükarda en son çalışacak kod.")

print(".....")


