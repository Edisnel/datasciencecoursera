#!/usr/bin/env python

from os.path import expanduser, join

from pyspark import SparkContext, SparkConf
from pyspark.sql import SparkSession
from pyspark.sql import Row

conf = SparkConf().setAppName("Join on spark and other examples").setMaster("spark://PC:7077")
sc = SparkContext(conf=conf)

#froom local filesystem
#text_RDD = sc.textFile("file:///usr/local/spark/README.md")

fileAgenc = sc.textFile("file:///home/ecarrazana/Escritorio/AdvancedJoin/join2_genchanA.txt")
fileBgenc = sc.textFile("file:///home/ecarrazana/Escritorio/AdvancedJoin/join2_genchanB.txt")
fileCgenc = sc.textFile("file:///home/ecarrazana/Escritorio/AdvancedJoin/join2_genchanC.txt")

fileA_B_C_genn = sc.textFile("/input/join2_gennum?.txt")
fileA_B_C_genc = sc.textFile("/input/join2_genchan?.txt")



def split_show_views(line):
    line = line.strip()
    key_value  = line.split(",")
    return (str(key_value[0]), int(key_value[1]))
    
def split_show_channel(line):
    line = line.strip()
    key_value  = line.split(",")
    return (str(key_value[0]), str(key_value[1]))
    
def extract_channel_views(line):    
    parte2 = line[1]    
    channel = parte2[0]
    views = parte2[1]
    return (channel, views)
    
def suma(a,b)
	return a+b 
    
show_views_file = sc.textFile("/input/join2_gennum?.txt")
show_channel_file = sc.textFile("/input/join2_genchan?.txt")

show_views = show_views_file.map(split_show_views)
show_channel = show_channel_file.map(split_show_channel)

joined_dataset = show_channel.join(show_views)

channel_views = joined_dataset.map(extract_channel_views).reduceByKey(lambda a,b:a+b)







#total_genn = fileA_B_C_genn.map(split_show_views).reduceByKey(lambda a,b:a+b)
#total_genn.collect()

#total_genc = fileA_B_C_genc.map(split_filestr).groupByKey().mapValues(list)
#total_genc.collect()

#total_joined = total_genc.join(total_genn)
    
#fileA_data = fileA.map(split_fileA)
#fileB_data = fileB.map(split_fileB)    
#fileB_joined_fileA = fileB_data.join(fileA_data)
#fileB_joined_fileA.saveAsTextFile('file:///home/ecarrazana/Escritorio/AdvancedJoin/mycsv.csv')






 
    
    
    


	
 

		



