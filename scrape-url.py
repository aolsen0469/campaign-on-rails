# pip install bing-image-downloader
from bing_image_downloader import downloader
import sys
import argparse

dataset_dir = '/root/scripts/tmp'
#query_string = 'dnd lich art'
#query_string = input("Image Search:")
#print("% s % s" % ("landscape fantasy art", str(sys.argv)))
#query_string = sys.argv[1]

parser = argparse.ArgumentParser(description='Blah')
parser.add_argument('-k', '--keywords', help='keywords to search for', required=True)
args = parser.parse_args()
#keywords = args.keywords
query_string = args.keywords


downloader.download(query_string, limit=5,  output_dir=dataset_dir,
adult_filter_off=True, force_replace=False, timeout=60)
