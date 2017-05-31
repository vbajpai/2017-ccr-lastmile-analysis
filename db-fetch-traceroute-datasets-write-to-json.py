# *This script gets the UDM ID from `ra_traceroute` table, fetches the
# measurement data from RIPE and saves the json as separate files
# `asn-msmid.json`.*

import sqlite3
import pandas as pd
import requests
import ipaddress
import time

def get_json_resource_from_absolute_uri(url, query_params):
    try: res = requests.get(url, params = query_params)
    except Exception as e: print(e, file=sys.stderr)
    else:
        try: res_json = res.json()
        except Exception as e: print(e, file=sys.stderr)
        else:
            return res_json

def get_udm_data(udm):
    if udm is None: return None
    base_uri = 'https://atlas.ripe.net';
    url = '%s/api/v2/measurements/%s/results'%(base_uri, str(udm))
    try: res_json = get_json_resource_from_absolute_uri(url, 'format=json')
    except Exception as e: print(e, file=sys.stderr)
    else: return res_json

DB_LOCATION = 'lastmile.db'
RA_TRACEROUTE = 'ra_traceroute'

con = sqlite3.connect(DB_LOCATION)

query = '''SELECT    o.msm_id as 'udmid'
                   , o.asn_v4 as 'source_asn'
           FROM    %s as o
        '''%(RA_TRACEROUTE)

df = pd.read_sql(query, con)

import json
for index, row in df.iterrows():
    udmid, source_asn = row
    with open('%s-%s.json'%(source_asn, udmid), 'w') as fsock:
      try:
          udm_json_data = get_udm_data(udmid)
          json.dump(udm_json_data, fsock)
      except Exception as e: print(e, type(e), udmid)
      else: print('.', end="")

con.close()
