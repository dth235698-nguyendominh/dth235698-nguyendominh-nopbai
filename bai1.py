print('Hello World')
print('\n')
print('Albert Einstein đã từng nói: Một người không bao giờ mắc sai lầm không bao giờ thử bất kì điều gì mới')
print('\n')
print('Mình về mình có nhớ ta?\nMười lăm năm ấy thiết tha mặn nồng.\nMình về mình có nhớ không?\nNhìn cây nhớ núi, nhìn sông nhớ nguồn.')
print('\n')
print('Nguyen Do Minh')
print('\n')
print('Chao cac ban')
print('\n')
cao=4
rong=9
for i in range(cao):
    print('*'*rong)
print('\n')
def cay_thong():
    rong = 9
    tang = [1, 3, 5, 3, 5, 9, 1, 1]

    for sao in tang:
        trang = (rong - sao) // 2
        print(" " * trang + "*" * sao)

cay_thong()