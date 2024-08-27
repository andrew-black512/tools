#!/usr/bin/python3


import flickrapi

api_key = ""
api_secret = ""
extra_params={}
user_id=''

flickr = flickrapi.FlickrAPI(api_key, api_secret, format='parsed-json',store_token=False)

photos = flickr.photos.search(user_id=user_id,extras='date_taken,description,geo,tags,machine_tags,url_m',**extra_params)
for photo in photos['photos']['photo']:
    print(photo['title'])