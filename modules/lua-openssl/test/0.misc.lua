local openssl = require('openssl')

length = 64
print('α���������', string.rep('-',40))
print(openssl.random_bytes(length))

print('ǿ���������', string.rep('-',40))
print(openssl.random_bytes(length, true))

