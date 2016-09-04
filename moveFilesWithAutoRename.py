import os

os.chdir('/sourcedir/jpeg')


targetDir = '/targetdir/'

def moveFileWithAutoRename(pathToFile,dstDir):
    basename = os.path.basename(pathToFile)
    dstFile = os.path.join(dstDir, basename)
    if os.path.exists(dstFile):
       basename = os.path.splitext(basename)[0] + '-' + os.path.splitext(basename)[1]   
    count = 1
    while os.path.exists(dstFile):
            newbasename = os.path.splitext(basename)[0] + str(count) + os.path.splitext(basename)[1]
            count += 1
            dstFile = os.path.join(dstDir,newbasename)
    print('moving ' + pathToFile + dstFile)
    os.rename(pathToFile,dstFile)    

fileList = os.listdir()

for file in fileList:
    if file.endswith(('.jpg','.jpeg')):
        moveFileWithAutoRename('./'+file, targetDir)
