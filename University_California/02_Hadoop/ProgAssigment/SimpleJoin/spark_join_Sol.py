#!/usr/bin/env python

from os.path import expanduser, join

from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession
from pyspark.sql import Row

conf = SparkConf().setAppName("Join on spark and other examples").setMaster("spark://PC:7077")
sc = SparkContext(conf=conf)

#froom local filesystem
#text_RDD = sc.textFile("file:///usr/local/spark/README.md")

fileA = sc.textFile("file:////media/Datos/DataScience/Documentacion/Cursos/ProgramaUniversidadCalifornia/02_Hadoop/Week5/ProgAssigment1/SimpleJoin/join1_FileA.txt")
fileB = sc.textFile("file:////media/Datos/DataScience/Documentacion/Cursos/ProgramaUniversidadCalifornia/02_Hadoop/Week5/ProgAssigment1/SimpleJoin/join1_FileB.txt")

def split_fileA(line):
    line = line.strip()
    key_value  = line.split(",")
    return (str(key_value[0]), int(key_value[1]))
    
def split_fileB(line):
    line = line.strip()
    key_value = line.split(",")
    count = key_value[1]
    parte1 = key_value[0].split(" ")
    word = parte1[1]
    date = parte1[0]
    return (word, date + " " + count)
    
fileA_data = fileA.map(split_fileA)
fileB_data = fileB.map(split_fileB)
    
fileB_joined_fileA = fileB_data.join(fileA_data)





 
    
    
    


	
 

		



