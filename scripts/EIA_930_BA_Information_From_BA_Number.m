% EIA_930_BA_Information_From_BA_Number.m
% 20210212
% Casey D. Burleyson
% Pacific Northwest National Laboratory

% Lookup table that takes as input the EIA BA number of a BA and returns 
% the abbreviation or short name and the full or long name of the BA.

function [BA_Short_Name,BA_Long_Name] = EIA_930_BA_Information_From_BA_Number(EIA_BA_Number)
    if EIA_BA_Number == 1;      BA_Short_Name = 'NBSO'; BA_Long_Name = 'New Brunswick System Operator'; end
    if EIA_BA_Number == 189;    BA_Short_Name = 'AEC';  BA_Long_Name = 'PowerSouth Energy Cooperative'; end
    if EIA_BA_Number == 317;    BA_Short_Name = 'YAD';  BA_Long_Name = 'Alcoa Power Generating Inc. - Yadkin Division'; end
    if EIA_BA_Number == 599;    BA_Short_Name = 'AMPL'; BA_Long_Name = 'Anchorage Municipal Light and Power'; end
    if EIA_BA_Number == 803;    BA_Short_Name = 'AZPS'; BA_Long_Name = 'Arizona Public Service Company'; end
    if EIA_BA_Number == 924;    BA_Short_Name = 'AECI'; BA_Long_Name = 'Associated Electric Cooperative Inc.'; end
    if EIA_BA_Number == 1738;   BA_Short_Name = 'BPAT'; BA_Long_Name = 'Bonneville Power Administration'; end
    if EIA_BA_Number == 2775;   BA_Short_Name = 'CISO'; BA_Long_Name = 'California Independent System Operator'; end
    if EIA_BA_Number == 3046;   BA_Short_Name = 'CPLE'; BA_Long_Name = 'Duke Energy Progress East'; end
    if EIA_BA_Number == 3413;   BA_Short_Name = 'CHPD'; BA_Long_Name = 'PUD No. 1 of Chelan County'; end
    if EIA_BA_Number == 3522;   BA_Short_Name = 'CEA';  BA_Long_Name = 'Chugach Electric Association Inc.'; end
    if EIA_BA_Number == 5326;   BA_Short_Name = 'DOPD'; BA_Long_Name = 'PUD No. 1 of Douglas County'; end
    if EIA_BA_Number == 5416;   BA_Short_Name = 'DUK';  BA_Long_Name = 'Duke Energy Carolinas'; end
    if EIA_BA_Number == 5701;   BA_Short_Name = 'EPE';  BA_Long_Name = 'El Paso Electric Company'; end
    if EIA_BA_Number == 5723;   BA_Short_Name = 'ERCO'; BA_Long_Name = 'Electric Reliability Council of Texas Inc.'; end
    if EIA_BA_Number == 5748;   BA_Short_Name = 'EEI';  BA_Long_Name = 'Electric Energy Inc.'; end
    if EIA_BA_Number == 6452;   BA_Short_Name = 'FPL';  BA_Long_Name = 'Florida Power & Light Company'; end
    if EIA_BA_Number == 6455;   BA_Short_Name = 'FPC';  BA_Long_Name = 'Duke Energy Florida Inc.'; end
    if EIA_BA_Number == 6909;   BA_Short_Name = 'GVL';  BA_Long_Name = 'Gainesville Regional Utilities'; end
    if EIA_BA_Number == 8795;   BA_Short_Name = 'HST';  BA_Long_Name = 'City of Homestead'; end
    if EIA_BA_Number == 9191;   BA_Short_Name = 'IPCO'; BA_Long_Name = 'Idaho Power Company'; end
    if EIA_BA_Number == 9216;   BA_Short_Name = 'IID';  BA_Long_Name = 'Imperial Irrigation District'; end
    if EIA_BA_Number == 9617;   BA_Short_Name = 'JEA';  BA_Long_Name = 'JEA'; end
    if EIA_BA_Number == 11208;  BA_Short_Name = 'LDWP'; BA_Long_Name = 'Los Angeles Department of Water and Power'; end
    if EIA_BA_Number == 11249;  BA_Short_Name = 'LGEE'; BA_Long_Name = 'Louisville Gas & Electric Company and Kentucky Utilities'; end
    if EIA_BA_Number == 12825;  BA_Short_Name = 'NWMT'; BA_Long_Name = 'NorthWestern Energy'; end
    if EIA_BA_Number == 13407;  BA_Short_Name = 'NEVP'; BA_Long_Name = 'Nevada Power Company'; end
    if EIA_BA_Number == 13434;  BA_Short_Name = 'ISNE'; BA_Long_Name = 'ISO New England Inc.'; end
    if EIA_BA_Number == 13485;  BA_Short_Name = 'NSB';  BA_Long_Name = 'New Smyrna Beach Utilities Commission'; end
    if EIA_BA_Number == 13501;  BA_Short_Name = 'NYIS'; BA_Long_Name = 'New York Independent System Operator'; end
    if EIA_BA_Number == 14015;  BA_Short_Name = 'OVEC'; BA_Long_Name = 'Ohio Valley Electric Corporation'; end
    if EIA_BA_Number == 14378;  BA_Short_Name = 'PACW'; BA_Long_Name = 'PacifiCorp - West'; end
    if EIA_BA_Number == 14379;  BA_Short_Name = 'PACE'; BA_Long_Name = 'PacifiCorp - East'; end
    if EIA_BA_Number == 14412;  BA_Short_Name = 'GRMA'; BA_Long_Name = 'Gila River Power LLC'; end
    if EIA_BA_Number == 14610;  BA_Short_Name = 'FMPP'; BA_Long_Name = 'Florida Municipal Power Pool'; end
    if EIA_BA_Number == 14624;  BA_Short_Name = 'GCPD'; BA_Long_Name = 'PUD No. 2 of Grant County'; end
    if EIA_BA_Number == 14725;  BA_Short_Name = 'PJM';  BA_Long_Name = 'PJM Interconnection LLC'; end
    if EIA_BA_Number == 15399;  BA_Short_Name = 'AVRN'; BA_Long_Name = 'Avangrid Renewables LLC'; end
    if EIA_BA_Number == 15466;  BA_Short_Name = 'PSCO'; BA_Long_Name = 'Public Service Company of Colorado'; end
    if EIA_BA_Number == 15248;  BA_Short_Name = 'PGE';  BA_Long_Name = 'Portland General Electric Company'; end
    if EIA_BA_Number == 15473;  BA_Short_Name = 'PNM';  BA_Long_Name = 'Public Service Company of New Mexico'; end
    if EIA_BA_Number == 15500;  BA_Short_Name = 'PSEI'; BA_Long_Name = 'Puget Sound Energy'; end
    if EIA_BA_Number == 16534;  BA_Short_Name = 'BANC'; BA_Long_Name = 'Balancing Authority of Northern California'; end
    if EIA_BA_Number == 16572;  BA_Short_Name = 'SRP';  BA_Long_Name = 'Salt River Project'; end
    if EIA_BA_Number == 16868;  BA_Short_Name = 'SCL';  BA_Long_Name = 'Seattle City Light'; end
    if EIA_BA_Number == 17539;  BA_Short_Name = 'SCEG'; BA_Long_Name = 'South Carolina Electric & Gas Company'; end
    if EIA_BA_Number == 17543;  BA_Short_Name = 'SC';   BA_Long_Name = 'South Carolina Public Service Authority'; end
    if EIA_BA_Number == 17716;  BA_Short_Name = 'SPA';  BA_Long_Name = 'Southwestern Power Administration'; end
    if EIA_BA_Number == 18195;  BA_Short_Name = 'SOCO'; BA_Long_Name = 'Southern Company Services Inc. - Transmission'; end
    if EIA_BA_Number == 18429;  BA_Short_Name = 'TPWR'; BA_Long_Name = 'City of Tacoma Department of Public Utilities Light Division'; end
    if EIA_BA_Number == 18445;  BA_Short_Name = 'TAL';  BA_Long_Name = 'City of Tallahassee'; end
    if EIA_BA_Number == 18454;  BA_Short_Name = 'TEC';  BA_Long_Name = 'Tampa Electric Company'; end
    if EIA_BA_Number == 18642;  BA_Short_Name = 'TVA';  BA_Long_Name = 'Tennessee Valley Authority'; end
    if EIA_BA_Number == 19281;  BA_Short_Name = 'TIDC'; BA_Long_Name = 'Turlock Irrigation District'; end
    if EIA_BA_Number == 19547;  BA_Short_Name = 'HECO'; BA_Long_Name = 'Hawaiian Electric Company Inc.'; end
    if EIA_BA_Number == 19610;  BA_Short_Name = 'WAUW'; BA_Long_Name = 'Western Area Power Administration - UGP West'; end
    if EIA_BA_Number == 20169;  BA_Short_Name = 'AVA';  BA_Long_Name = 'Avista Corporation'; end
    if EIA_BA_Number == 21554;  BA_Short_Name = 'SEC';  BA_Long_Name = 'Seminole Electric Cooperative'; end
    if EIA_BA_Number == 24211;  BA_Short_Name = 'TEPC'; BA_Long_Name = 'Tucson Electric Power Company'; end
    if EIA_BA_Number == 25471;  BA_Short_Name = 'WALC'; BA_Long_Name = 'Western Area Power Administration - Desert Southwest Region'; end
    if EIA_BA_Number == 28502;  BA_Short_Name = 'WAUE'; BA_Long_Name = 'Western Area Power Administration - UGP East'; end
    if EIA_BA_Number == 28503;  BA_Short_Name = 'WACM'; BA_Long_Name = 'Western Area Power Administration - Rocky Mountain Region'; end
    if EIA_BA_Number == 29304;  BA_Short_Name = 'SEPA'; BA_Long_Name = 'Southeastern Power Administration'; end
    if EIA_BA_Number == 32790;  BA_Short_Name = 'HECO'; BA_Long_Name = 'New Harquahala Generating Company LLC'; end
    if EIA_BA_Number == 56090;  BA_Short_Name = 'GRIF'; BA_Long_Name = 'Griffith Energy LLC'; end
    if EIA_BA_Number == 56365;  BA_Short_Name = 'GWA';  BA_Long_Name = 'NaturEner Power Watch LLC'; end
    if EIA_BA_Number == 56545;  BA_Short_Name = 'GRIS'; BA_Long_Name = 'Gridforce South'; end
    if EIA_BA_Number == 56669;  BA_Short_Name = 'MISO'; BA_Long_Name = 'Midcontinent Independent Transmission System Operator Inc.'; end
    if EIA_BA_Number == 56812;  BA_Short_Name = 'DEAA'; BA_Long_Name = 'Arlington Valley LLC'; end
    if EIA_BA_Number == 58786;  BA_Short_Name = 'CPLW'; BA_Long_Name = 'Duke Energy Progress West'; end
    if EIA_BA_Number == 58790;  BA_Short_Name = 'GRID'; BA_Long_Name = 'Gridforce Energy Management LLC'; end
    if EIA_BA_Number == 58791;  BA_Short_Name = 'WWA';  BA_Long_Name = 'NaturEner Wind Watch LLC'; end
    if EIA_BA_Number == 59504;  BA_Short_Name = 'SWPP'; BA_Long_Name = 'Southwest Power Pool'; end
end