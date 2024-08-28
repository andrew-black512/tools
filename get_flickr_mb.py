#!/usr/bin/python3


import flickrapi
import config

extra_params={}
user_id='lesleyablack' #'andrewblack' #65535'

#flickr = flickrapi.FlickrAPI(api_key, api_secret, format='parsed-json',store_token=False)
flickr = flickrapi.FlickrAPI(config.API_KEY, config.API_SECRET, format='parsed-json')

photos = flickr.photos.search(user_id=user_id,extras='date_taken,description,geo,tags,machine_tags,url_m',**extra_params)
for photo in photos['photos']['photo']:
    print(photo['title'])
    print ("    " + photo['url_m'])
    print ("    " + photo['tags'])
    print ("    " + photo['date_taken'])
    
    print ()
    exit