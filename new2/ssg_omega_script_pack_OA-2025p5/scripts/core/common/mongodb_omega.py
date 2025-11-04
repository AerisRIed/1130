################################################################################
# Copyright (c) 2025 by Cadence Design Systems Inc. ALL RIGHTS RESERVED.       #
# These coded instructions, statements, and computer programs are the          #
# copyrighted works and confidential proprietary information of Cadence Design #
# Systems Inc. They may not be modified, copied, reproduced, distributed, or   #
# disclosed to third parties in any manner, medium, or form, in whole or in    #
# part, without the prior written consent of Cadence Design Systems Inc.       #
################################################################################

from pymongo import MongoClient
import sys
import pandas as pd

def read_from_mysql():
  # SQL QUERY GOES HERE
  return df

#def upload_df_to_mongo(df, collection):
#  key_fields = ['metric', 'flow_phase', 'count']
#  for row in df.to_dict(orient='records'):
#    find_dict = {}
#    for key_field in key_fields:
#      find_dict[key_field] = row[key_field]
#    value_dict = row
#    collection.update_one(find_dict, {'$set': value_dict}, upsert=True)

def upload_csv_to_mongo(csv_file, collection):
  key_fields = ['metric', 'flow_phase', 'count']
  df = pd.read_csv(csv_file,sep=';')

  data = {}
  for _, row in df.iterrows():
    metric = row['metric']
    value = row['value']
    parts = metric.split('.')
    flow_phase = parts[0]

    if flow_phase not in data:
      data[flow_phase] = {'flow_phase': flow_phase, 'metrics': []}

    if len(parts) == 2:
      data[flow_phase][parts[1]] = value
    elif len(parts) == 3 and parts[1] == 'metric' :
      metric_name = parts[2]
      data[flow_phase]['metrics'].append({'name': metric_name, 'value': value})


  for doc in data.values():
    collection.update_one({"flow_phase": doc["flow_phase"]},{"$set": doc}, upsert=True)
    result = collection.find_one({"flow_phase": doc["flow_phase"]})
    print("\n", doc["flow_phase"], " metrics added to MongoDB:\n", result, "\n")

#def read_from_mongo(collection):
#    cursor = collection.find({})
#    df = pd.DataFrame(list(cursor))
#    print('--cursor--')
#    print(cursor)
#    print('--df--')
#    print(df)

client     = MongoClient('mongodb://ssg-plotly:27017/')
db         = client['ssg_db']
collection = db['omega']
upload_csv_to_mongo(sys.argv[1], collection)
#read_from_mongo(collection)
