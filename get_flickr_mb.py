#!/usr/bin/python3


import flickrapi
import config
import pprint

extra_params={}
user_id='lesleyablack' #'andrewblack' #65535'

#flickr = flickrapi.FlickrAPI(api_key, api_secret, format='parsed-json',store_token=False)
flickr = flickrapi.FlickrAPI(config.API_KEY, config.API_SECRET, format='parsed-json')
date_prev = ''
photos = flickr.photos.search(user_id=user_id,extras='date_taken,description,geo,tags,machine_tags,url_m',**extra_params)
for photo in photos['photos']['photo']:
    date = photo['datetaken'][0:10]

    if date != date_prev:
        print("------------------")
        print(date)
        date_prev = date 


    print(f'  {photo["title"]}' )
    print ("    " + photo['url_m'])
    print ("    " + photo['tags'])
    ##print (f'    {date}')
    
    print ()