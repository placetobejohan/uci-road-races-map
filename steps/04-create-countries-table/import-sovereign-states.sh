#!/bin/bash

shp2pgsql -s 4326 data/ne_10m_admin_0_sovereignty/ne_10m_admin_0_sovereignty.shp uci_road_raw.sovereign_states > sqitch/deploy/uci-road-raw/sovereign-states.sql
