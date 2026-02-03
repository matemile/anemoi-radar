import xarray as xr
import numpy as np
import os.path
from datetime import datetime, timedelta

def datespan(start_date, end_date, delta):
    current_date = start_date
    while current_date < end_date:
        yield current_date
        current_date += delta 
def nextday(start_date, end_date, delta):
    current_date = start_date
    while current_date <= end_date:
        yield current_date
        current_date += delta

start_date = datetime(2021, 10, 9, 0, 0)
end_date = datetime(2023, 1, 1, 0, 0)
for timestamp in datespan(start_date, end_date, delta=timedelta(hours=24)):
    #print(timestamp.strftime("%Y-%m-%dT%H"))
    #print(timestamp)
    #print(timestamp.strftime("%Y"),timestamp.strftime("%m"),timestamp.strftime("%d"))
    dd=timestamp.strftime("%d")
    mm=timestamp.strftime("%m")
    yy=timestamp.strftime("%Y")
    if (os.path.isfile("/lustre/storeB/project/remotesensing/radar/reflectivity-nordic/"+yy+"/"+mm+"/yrwms-nordic.mos.pcappi-0-dbz.noclass-clfilter-novpr-clcorr-block.nordiclcc-1000."+yy+""+mm+""+dd+".nc")):
            ds = xr.open_dataset("/lustre/storeB/project/remotesensing/radar/reflectivity-nordic/"+yy+"/"+mm+"/yrwms-nordic.mos.pcappi-0-dbz.noclass-clfilter-novpr-clcorr-block.nordiclcc-1000."+yy+""+mm+""+dd+".nc")
            #print(ds.time.values)
            #print(timestamp.strftime("%Y-%m-%dT%H:%M:%S.000000000"))
            #print(ds.time.values[0],type(ds.time.values))
            #print(timestamp.strftime("%Y-%m-%dT%H:%M:%S.000000000"),type(timestamp.strftime("%Y-%m-%dT%H:%M:%S.000000000")))
            #print(np.datetime64(timestamp),type(np.datetime64(timestamp)))
            nextday=timestamp+timedelta(hours=24)
            #print(nextday)
            for hourstamp in datespan(timestamp, nextday, delta=timedelta(hours=6)):
                print(hourstamp)
                if np.datetime64(hourstamp) in ds.time.values:
                    print('Data available:',hourstamp.strftime("%Y-%m-%dT%H:%M:%S"))
                else:
                    print('MISSING TIME:',hourstamp.strftime("%Y-%m-%dT%H:%M:%S"))
    else:
        print('MISSING FILE:',timestamp.strftime("%Y-%m-%dT%H:%M:%S"))

