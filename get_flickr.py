#!/usr/bin/python3

import flickrapi
import config 

# Replace with your Flickr API key and secret
api_key = 'YOUR_API_KEY'
api_secret = 'YOUR_API_SECRET'

flickr = flickrapi.FlickrAPI(config.API_KEY, config.API_SECRET, format='parsed-json')
# authenditation as andrewblack 
# https://live.staticflickr.com/65535/52512117757_96141d9f1f_k.jpg
def get_flickr_data(tag):
  photos = flickr.photos.search(tags=tag,    extras='url_sq,original_format,title')
  print (photos)
  print (type(photos))
  for photo in photos.find('photos').find('photo'):
    url_sq = photo.get('url_sq')
    original_format = photo.get('originalformat')
    title = photo.get('title')
    
    # Construct the original image URL based on the square thumbnail URL and original format
    original_url = url_sq.replace('_sq', f'.{original_format}')
    
    # You can now process the data as needed, e.g., store it in a list, database, etc.
    print(f"URL: {original_url}, Title: {title}, Tag: {tag}")

# Example usage:
tag_to_search = 'cats'
get_flickr_data(tag_to_search)
