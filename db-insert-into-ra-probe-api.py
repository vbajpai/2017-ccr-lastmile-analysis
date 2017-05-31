import requests
import os

DB_LOCATION = 'lastmile.db'
TABLENAME = 'ra_probe_api'

base_uri = 'https://atlas.ripe.net/api/v1/probe-archive/'
try: res = requests.get('%s'%(base_uri))
except Exception as e: print(e)

try: total_count = int(res.json()['meta']['total_count'])
except Exception as e: print(e)
try: res = requests.get('%s/?limit=%d'%(base_uri, total_count))
except Exception as e: print(e)

import pandas as pd
import numpy as np

df = pd.DataFrame(res.json()['objects'])
df.rename(columns={'id': 'probeid'}, inplace=True)

import time
timestamp = int(time.time())
df['timestamp'] = timestamp
df = df.set_index('probeid')

def convert_list_to_string(l):
  if l is None: return None
  else: return ', '.join(l)
df['tags'] = df['tags'].apply(convert_list_to_string)

import sqlite3
con = sqlite3.connect(DB_LOCATION)
cur = con.execute('pragma foreign_keys=ON')

df.to_sql(  '%s'%TABLENAME
          , con
          , flavor='sqlite'
          , if_exists = 'append'
          , index_label = 'probeid'
         )

con.commit()
con.close()
