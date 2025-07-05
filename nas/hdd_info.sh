#!/bin/bash

echo "==============="
echo "HDD Information"
echo "==============="
# 8t
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SGHG8UC
# 8t-b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SH0T09C
# 3t
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0077880
# 3t-b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0092210

echo "==================="
echo "Important HDD Info "
echo "==================="
# 8t
sudo smartctl -A /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SGHG8UC | egrep -i "temperature|reallocated_sector|current_pending|offline_uncorr|power_on"
# 8t-b
sudo smartctl -A /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SH0T09C | egrep -i "temperature|reallocated_sector|current_pending|offline_uncorr|power_on"
# 3t
sudo smartctl -A /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0077880 | egrep -i "temperature|reallocated_sector|current_pending|offline_uncorr|power_on"
# 3t-b
sudo smartctl -A /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0092210 | egrep -i "temperature|reallocated_sector|current_pending|offline_uncorr|power_on"
