#!/usr/bin/env python3

import sys
import datetime
import xml.etree.ElementTree as ET
from dateutil import parser
import pytz

cutoff_date = datetime.datetime.now(pytz.utc) - datetime.timedelta(days=30)
date_now = datetime.datetime.now(pytz.utc)

root = ET.fromstring(sys.stdin.read())

new_root = ET.Element('rss', attrib={'version': '2.0'})
new_channel = ET.SubElement(new_root, 'channel')
new_channel.extend(root.find('channel/*'))

for item in root.iter('item'):
    pubdate_str = item.find('pubDate').text
    pubdate = parser.parse(pubdate_str)

    if pubdate >= cutoff_date and pubdate <= date_now:
        new_channel.append(item)

print(ET.tostring(new_root, encoding='unicode'))
