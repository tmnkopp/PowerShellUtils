import os
for dentry in os.scandir("c:\\Windows"):
    sz = (  dentry.stat().st_size  / 1000000) 
    print( sz )
    if sz > 25:
       print("{} ".format(dentry.name))