#!/usr/bin/env python
# coding: utf-8

# In[1]:

# In[ ]:

import pandas as pd
from pandas import DataFrame
from os import listdir
from os.path import isfile, join
import os
import datetime
import pymongo
from pymongo import MongoClient
import sys
import json
import csv
import io

# In[ ]:


#dirpath = str(sys.argv[2])
#print(dirpath)

# In[ ]:

def get_files(dirpath, ftype):
    dirpath = dirpath+ ftype + "/"
    files = [dirpath+f for f in listdir(dirpath) if (isfile(join(dirpath, f)) and ".DS_Store" not in f)]
    return files


def csv_to_json(dirpath, filepath):
  values = list()
  with io.open(filepath, "r", encoding='latin-1') as file_obs:
      for line in file_obs.readlines():
          values.append(line.strip("\n").split(","))
      column_label = values[0]
      del values[0]
      df = pd.DataFrame(values, columns=column_label)
      #df.drop(df.columns[-1], axis=1, inplace=True)
      #df = df.rename(columns={'ubicacion.posx': 'latitude',
      #                        'ubicacion.posy': 'longitude'})
      df = df.applymap(lambda x: str(x).replace('´', '').replace('ñ', 'n'))

      #df.reset_index(drop = False, inplace = True)
      #df.set_index('code',inplace=True) 
      
      #df["dateF"] = pd.to_datetime(df["date"], infer_datetime_format=True)
      #df["dateF"] = df["dateF"].astype(str)
      #df.set_index('date',inplace=True)
      print("Exporting data into JSON document -------------------")
      head, tail = os.path.split(filepath)
      jsonfile = dirpath + "json/" + tail.split(".")[0] + ".json"
      print("Exporting " + filepath + " -------- " + jsonfile + " JSON document")
      df.to_json(jsonfile, orient="records")
      return jsonfile

def csv_to_jsons(dirpath):
    for f in get_files(dirpath, "csv"):
        jsonfile = csv_to_json(dirpath,f)

def import_in_mongoDB(col_name, dirpath):
    print("Importing JSON data in MongoDB  -------------------")
    conn = pymongo.MongoClient("localhost", 27017)
    if col_name in conn['Meteo-COL'].list_collection_names():
        conn['Meteo-COL'][col_name].drop()
    for filepath in get_files(dirpath, "json"):
        with open(filepath, "r") as json_doc:
            dct = json.load(json_doc)
        conn['Meteo-COL'][col_name].insert_many(dct)

csv_to_jsons(str(sys.argv[2]))

  #print(get_csv_files(str(sys.argv[1])))
import_in_mongoDB(str(sys.argv[1]), str(sys.argv[2]))