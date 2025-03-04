-- Deploy uci-road-races-map:uci-road-raw/iso-ioc-mappings to pg
-- requires: uci-road-raw/schema

BEGIN;

CREATE TABLE uci_road_raw.country_mappings (
    iso_code varchar(3) NOT NULL,
    ioc_code varchar(3) NOT NULL
);

INSERT INTO uci_road_raw.country_mappings (iso_code, ioc_code)
VALUES
('DZA', 'ALG'),
('ASM', 'ASA'),
('AGO', 'ANG'),
('ATG', 'ANT'),
('ABW', 'ARU'),
('BHS', 'BAH'),
('BHR', 'BRN'),
('BGD', 'BAN'),
('BRB', 'BAR'),
('BLZ', 'BIZ'),
('BMU', 'BER'),
('BTN', 'BHU'),
('BWA', 'BOT'),
('VGB', 'IVB'),
('BRN', 'BRU'),
('BGR', 'BUL'),
('BFA', 'BUR'),
('KHM', 'CAM'),
('CYM', 'CAY'),
('TCD', 'CHA'),
('CHL', 'CHI'),
('COG', 'CGO'),
('CRI', 'CRC'),
('HRV', 'CRO'),
('DNK', 'DEN'),
('SLV', 'ESA'),
('GNQ', 'GEQ'),
('FJI', 'FIJ'),
('GMB', 'GAM'),
('DEU', 'GER'),
('GRC', 'GRE'),
('GRD', 'GRN'),
('GTM', 'GUA'),
('GIN', 'GUI'),
('GNB', 'GBS'),
('HTI', 'HAI'),
('HND', 'HON'),
('IDN', 'INA'),
('IRN', 'IRI'),
('KWT', 'KUW'),
('LVA', 'LAT'),
('LBN', 'LIB'),
('LSO', 'LES'),
('LBY', 'LBA'),
('MDG', 'MAD'),
('MWI', 'MAW'),
('MYS', 'MAS'),
('MRT', 'MTN'),
('MUS', 'MRI'),
('MCO', 'MON'),
('MNG', 'MGL'),
('MMR', 'MYA'),
('NPL', 'NEP'),
('NLD', 'NED'),
('NIC', 'NCA'),
('NER', 'NIG'),
('NGA', 'NGR'),
('OMN', 'OMA'),
('PSE', 'PLE'),
('PRY', 'PAR'),
('PHL', 'PHI'),
('PRT', 'POR'),
('PRI', 'PUR'),
('KNA', 'SKN'),
('VCT', 'VIN'),
('WSM', 'SAM'),
('SAU', 'KSA'),
('SYC', 'SEY'),
('SGP', 'SIN'),
('SVN', 'SLO'),
('SLB', 'SOL'),
('ZAF', 'RSA'),
('LKA', 'SRI'),
('SDN', 'SUD'),
('CHE', 'SUI'),
('TWN', 'TPE'),
('TZA', 'TAN'),
('TGO', 'TOG'),
('TON', 'TGA'),
('TTO', 'TRI'),
('ARE', 'UAE'),
('VIR', 'ISV'),
('URY', 'URU'),
('VUT', 'VAN'),
('VNM', 'VIE'),
('ZMB', 'ZAM'),
('ZWE', 'ZIM');

COMMIT;
