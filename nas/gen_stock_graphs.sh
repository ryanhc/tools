#!/bin/bash

pushd /home/ryanc/tools/stock

source /home/ryanc/.local/python/bin/activate
python fear_and_greed_index.py
python draw_stock_graphs.py
cp *.png /home/ryanc/docker/nginx/html/charts
#cp *.png /home/ryanc/docker/httpd/public_html/charts
deactivate
popd


pushd /home/ryanc/bin
#./mattermost_image.sh /home/ryanc/tools/stock/fear_and_greed_index.png "Fear and Greed Index"
./mattermost.sh "Daily Stock Price Report\n[![Daily Stock Price Report](https://stock.rhchoi.com/charts/fear_and_greed_index.png)](https://stock.rhchoi.com)"
popd

exit 0

