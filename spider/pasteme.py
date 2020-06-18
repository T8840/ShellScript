#!/usr/bin/env python
# -*- coding: utf-8 -*- 
# 
#  FileName     : pasteme.py
#  Date         : 2020年06月17日
#  Description  : 
# 
import warnings
import requests
import json
import sys
import io
from sys import argv
reload(sys)
sys.setdefaultencoding('utf-8')
with open(argv[1],'r') as f:
    contents='' 
    for line  in f.readlines():
        contents +=line
with warnings.catch_warnings():
    warnings.simplefilter("ignore")
    data={
        "lang":"bash",
        "content":contents
        }
    json_data = json.dumps(data)
    res = requests.post(url="http://api.pasteme.cn",headers={"Content-Type":"application/json"},data=json_data)
    print(res.content)
