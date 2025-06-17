#!/bin/bash

shp2pgsql -s 4326 data/ne_110m_admin_0_countries/ne_110m_admin_0_countries.shp uci_road_raw.countries > sqitch/deploy/uci-road-raw/countries.sql
