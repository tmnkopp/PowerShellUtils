 
import os
import sys 

def get_directory_size(directory):
    """Returns the `directory` size in bytes."""
    total = 0
    try: 
        for entry in os.scandir(directory):
            if entry.is_file(): 
                total += entry.stat().st_size
            elif entry.is_dir(): 
                total += get_directory_size(entry.path)
    except NotADirectoryError: 
        return os.path.getsize(directory)
    except PermissionError: 
        return 0
    return total

def get_size_format(b, factor=1024, suffix="B"):
    """
    Scale bytes to its proper byte format
    e.g:
        1253656 => '1.20MB'
        1253656678 => '1.17GB'
    """
    for unit in ["", "K", "M", "G", "T", "P", "E", "Z"]:
        if b < factor:
            return f"{b:.2f}{unit}{suffix}"
        b /= factor
    return f"{b:.2f}Y{suffix}"

if __name__ == "__main__":
    import sys
    folder_path =r'C:\Users\Tim\source\repos' 
    directory_sizes = []
    names = [] 
    for directory in os.listdir(folder_path):
        directory = os.path.join(folder_path, directory) 
        directory_size = get_directory_size(directory)
        if directory_size  < (1000000*200):
            continue
        directory_sizes.append(directory_size) 
        names.append(os.path.basename(directory) + ": " + get_size_format(directory_size))
    for n in names:
        print(n)
    print("[+] Total directory size:", get_size_format(sum(directory_sizes)))
  

