import os
myhome = os.environ['HOME']
currentfilelocation = os.path.dirname(os.path.realpath(__file__))

DB_LOCATION = 'lastmile.db'%currentfilelocation
TABLENAME = 'ra_probe'

import requests
import sqlite3
import sys
import time

conn=sqlite3.connect(DB_LOCATION)
conn.execute('pragma foreign_keys=ON')
cur=conn.cursor()

# returns hw_version, hw, webpage given a probeID
def calibrate_using_probeid(probeid):
    if probeid >= 1 and probeid <= 1521:
        hw_version='v1'
        hw='Lantronix XPort Pro'
        webpage='probev1.ripe.net'
    elif probeid > 2000 and probeid < 5000:
        hw_version='v2'
        hw='Lantronix XPort Pro'
        webpage='probev2.ripe.net'
    elif probeid > 6000 and probeid < 6018:
        hw_version='anchorv1'
        hw='Dell PowerEdge'
        webpage='-'
    elif probeid >= 6018 and probeid < 7000:
        hw_version='anchorv2'
        hw='Soekris Net6501-70'
        webpage='anchorv2.ripe.net'
    elif probeid > 10000:
        hw_version='v3'
        hw='TP-Link TL-MR3020'
        webpage='probev3.ripe.net'
    else:
        hw_version=hw=webpage=None
    ts=int(time.time())
    return (probeid, hw_version, hw, webpage, ts)

base='https://atlas.ripe.net/api/v1/probe-archive'
url='%s/?fields=meta'%base
r=requests.get(url)
registered_probe_count=r.json()['meta']['total_count']
#print(registered_probe_count)
url='%s/?limit=%s'%(base,registered_probe_count)
#print(url)
r = requests.get(url)

for objects in r.json()['objects']:
    try: probeid=objects['id']
    except Exception as e: print('%s does not have an id field'%objects)
    else:
        try: probe_details= calibrate_using_probeid(probeid)
        except Exception as e: print('Exception: %s (Insertion Failed)'%e)
        else:
            try: cur.execute('''INSERT INTO %s (  probeid
                                                , hardware_version
                                                , hardware
                                                , webpage
                                                , timestamp
                                                ) VALUES(?, ?, ?, ?, ?)'''%TABLENAME,probe_details)
            except Exception as e: print(e)


conn.commit()
conn.close()
