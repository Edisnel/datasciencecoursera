__author__ = 'stirlitz'

def split_FileA(line):
    line = line.strip()
    key_value  = line.split(",")
    return (key_value[0], key_value[1])

def split_fileB(line):
    line = line.strip()
    key_value = line.split(",")
    count = key_value[1]
    parte1 = key_value[0].split(" ")
    word = parte1[1]
    date = parte1[0]
    return (word, date + " " + count)














