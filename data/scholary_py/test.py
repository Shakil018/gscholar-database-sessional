import cv2
import numpy as np
import urllib.request
from scholarly import scholarly
import os
import json
import yaml
from ast import literal_eval
import time


def read_profile_img(author):
    os.makedirs(author_name, exist_ok=True)
    img_url = author.url_picture
    req = urllib.request.urlopen(img_url)
    arr = np.asarray(bytearray(req.read()), dtype=np.uint8)
    img = cv2.imdecode(arr, -1) # 'Load it as it is'
    cv2.imwrite(os.path.join(author.name, 'profile_pic.jpg'), img)
    return img

def read_info(author, is_filled=False):
    os.makedirs(author.name, exist_ok=True)
    filled = "filled" if is_filled else "unfilled"

    with open( os.path.join(author_name, f'info_{filled}.json'), 'w') as file:
        info_str = str(author)
        file.write(json.dumps(literal_eval(info_str), indent=4))

    return info_str

def read_and_fill_publications(author):
    os.makedirs(author.name, exist_ok=True)
    author.fill()
    for pub in author.publications:
        pub.fill()

    with open( os.path.join(author_name, r'info_bib_filled.json'), 'w') as file:
        info_str = str(author)
        file.write(json.dumps(literal_eval(info_str), indent=4))

# href: https://scholar.google.com/citations?user=UjpbO6IAAAAJ&hl=en
author_name = 'Luke Zettlemoyer'
author = next(scholarly.search_author(author_name))
# print(author)

# img = read_profile_img(author)
# info = read_info(author, is_filled=False)
# author.fill()
# info = read_info(author, is_filled=True)
read_and_fill_publications(author)

# cv2.imshow(author_name, img)
# if cv2.waitKey() & 0xff == 27: quit()
'''
author.fill()
for pub in author.publications:
    pub.fill()
    time.sleep()

with open(r'd:\info_bib_filled.json', 'w') as file:
    info_str = str(author)
    file.write(json.dumps(literal_eval(info_str), indent=4))
'''
