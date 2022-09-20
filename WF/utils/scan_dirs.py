


import os
for dentry in os.scandir("C:\\Windows"):
    sz = (  dentry.stat().st_size  / 1000000)  
    if sz > 1:
       print("{} ".format(dentry.name))

       