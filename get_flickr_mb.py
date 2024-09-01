#!/usr/bin/python3


import flickrapi
import config
import pprint

extra_params={}
user_id= 'andrewblack' # 'lesleyablack'
 #
tags = "tourdesouthwark"
flickr = flickrapi.FlickrAPI(config.API_KEY, config.API_SECRET, format='parsed-json')
date_prev = ''
min_taken_date = "2014-08-29"
#https://www.flickr.com/services/api/flickr.photos.search.html
photos = flickr.photos.search(user_id=user_id, \
                              #tags=tags, \
                              min_taken_date =min_taken_date, \
                              extras='date_taken,description,geo,\
                              tags,machine_tags,url_m',**extra_params)
for photo in photos['photos']['photo']:
    date = photo['datetaken'][0:10]

    if date != date_prev:
        print("------------------")
        print(date)
        date_prev = date 


    print(f'  {photo["title"]}' )
    print ("    " + photo['url_m'])
    print ("    " + photo['tags'])
    
    print ()