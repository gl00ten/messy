#!/usr/bin/python

import zlib

print('---compression---')


originalFile = open('blahblah.txt','r')
compressedFile = open('compressedText.txt','wb')

compressedFile.write(originalFile.readline().encode())


linebreak=b''
for line in originalFile.readlines():
  print(line,zlib.compress(line.encode()))
  compressedFile.write( linebreak + zlib.compress(line.encode()) )
  linebreak=b'\n'
  
originalFile.close()
compressedFile.close()



print('---decompression---')

compressedFile = open('compressedText.txt','rb')
decompressedFile = open('decompressedText.txt','w')

decompressedFile.write(compressedFile.readline().decode())

for line in compressedFile.readlines():
    #print(line,str(zlib.decompress(line)))
    decompressedFile.write(zlib.decompress(line).decode())

compressedFile.close()
decompressedFile.close()
