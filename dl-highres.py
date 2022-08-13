# pip install bing-image-downloader
python3.9 dl-highres.py
from bing_image_downloader import downloader


#query_string = 'dnd lich art'
query_string = input("Image Search:")
dataset_dir = '/foundry-data/Data/player-assets/art/dataset'
downloader.download(query_string, limit=10,  output_dir=dataset_dir, 
adult_filter_off=True, force_replace=False, timeout=60)
