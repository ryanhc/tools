#!/bin/bash

echo "==============="
echo "HDD Information"
echo "==============="
# 14a
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD140EDGZ-11B1PA0_7LGEKDNK
# 14b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD140EDGZ-11B1PA0_7LGGWT2K

# 8a
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SGHG8UC
# 8b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SH0T09C

# 3a
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0077880
# 3b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0092210

echo "==================="
echo "Important HDD Info "
echo "==================="

OPTION="Device\ Model|SMART\ overall-health|temperature|reallocated_sector|current_pending|offline_uncorr|power_on"
# 14a
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD140EDGZ-11B1PA0_7LGEKDNK | egrep -i "$OPTION"
# 14b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD140EDGZ-11B1PA0_7LGGWT2K | egrep -i "$OPTION"

# 8a
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SGHG8UC | egrep -i "$OPTION"
# 8b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD80EMAZ-00WJTA0_7SH0T09C | egrep -i "$OPTION"

# 3a
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0077880 | egrep -i "$OPTION"
# 3b
sudo smartctl -a /dev/disk/by-id/ata-WDC_WD30EFRX-68EUZN0_WD-WCC4N0092210 | egrep -i "$OPTION"
