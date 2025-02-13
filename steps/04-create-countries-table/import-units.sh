#!/bin/bash

shp2pgsql -s 4326 data/ne_10m_admin_0_map_units/ne_10m_admin_0_map_units.shp uci_road_raw.units > sqitch/deploy/uci-road-raw/units.sql
