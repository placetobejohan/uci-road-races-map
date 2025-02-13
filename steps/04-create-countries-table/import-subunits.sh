#!/bin/bash

shp2pgsql -s 4326 data/ne_10m_admin_0_map_subunits/ne_10m_admin_0_map_subunits.shp uci_road_raw.subunits > sqitch/deploy/uci-road-raw/subunits.sql
