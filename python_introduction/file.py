# # 06.02.2025
# # kalıcı hafıza - disk (hdd, sdd)

# with open("dosya.txt", "r", encoding="utf-8") as file:
#     print(f"Kalıcı hafızadan okunan veri: {file.read()}")

# value = input("Dosyaya yazmak istediğiniz değeri belirtiniz: ")

# # "w" komutu dosyayı sıfırdan yazar.
# # with open("dosya.txt", "w", encoding="utf-8") as file:
# #     file.write(value)

# # "a" komutu üzerine yazar.
# with open("dosya.txt", "a", encoding="utf-8") as file:
#     file.write(value)

f = open("dosya.txt", "r", encoding="utf-8")
content = f.read()
print(content)

f2 = open("dosya.txt", "a", encoding="utf-8")
f2.write("Yeni içerik")
f2.close()