% EIA_930_BA_Information_From_BA_Short_Name.m
% 20210205
% Casey D. Burleyson
% Pacific Northwest National Laboratory

% Lookup table that takes as input the abbreviation or short name of a
% BA and returns the EIA BA number and the full or long name of the BA.

function [EIA_BA_Number,BA_Long_Name] = EIA_930_BA_Information_From_BA_Short_Name(BA_Short_Name)
    if size(BA_Short_Name,2) == 2    
       if BA_Short_Name == 'SC'; EIA_BA_Number = 17543; BA_Long_Name = 'South Carolina Public Service Authority'; end
    end
    if size(BA_Short_Name,2) == 3
       if BA_Short_Name == 'AEC'; EIA_BA_Number = 189;   BA_Long_Name = 'PowerSouth Energy Cooperative'; end
       if BA_Short_Name == 'YAD'; EIA_BA_Number = 317;   BA_Long_Name = 'Alcoa Power Generating Inc. - Yadkin Division'; end
       if BA_Short_Name == 'CEA'; EIA_BA_Number = 3522;  BA_Long_Name = 'Chugach Electric Association Inc.'; end
       if BA_Short_Name == 'DUK'; EIA_BA_Number = 5416;  BA_Long_Name = 'Duke Energy Carolinas'; end
       if BA_Short_Name == 'EPE'; EIA_BA_Number = 5701;  BA_Long_Name = 'El Paso Electric Company'; end
       if BA_Short_Name == 'EEI'; EIA_BA_Number = 5748;  BA_Long_Name = 'Electric Energy Inc.'; end
       if BA_Short_Name == 'FPL'; EIA_BA_Number = 6452;  BA_Long_Name = 'Florida Power & Light Company'; end
       if BA_Short_Name == 'FPC'; EIA_BA_Number = 6455;  BA_Long_Name = 'Duke Energy Florida Inc.'; end
       if BA_Short_Name == 'GVL'; EIA_BA_Number = 6909;  BA_Long_Name = 'Gainesville Regional Utilities'; end
       if BA_Short_Name == 'HST'; EIA_BA_Number = 8795;  BA_Long_Name = 'City of Homestead'; end
       if BA_Short_Name == 'IID'; EIA_BA_Number = 9216;  BA_Long_Name = 'Imperial Irrigation District'; end
       if BA_Short_Name == 'JEA'; EIA_BA_Number = 9617;  BA_Long_Name = 'JEA'; end
       if BA_Short_Name == 'NSB'; EIA_BA_Number = 13485; BA_Long_Name = 'New Smyrna Beach Utilities Commission'; end
       if BA_Short_Name == 'PJM'; EIA_BA_Number = 14725; BA_Long_Name = 'PJM Interconnection LLC'; end
       if BA_Short_Name == 'PGE'; EIA_BA_Number = 15248; BA_Long_Name = 'Portland General Electric Company'; end
       if BA_Short_Name == 'PNM'; EIA_BA_Number = 15473; BA_Long_Name = 'Public Service Company of New Mexico'; end
       if BA_Short_Name == 'SRP'; EIA_BA_Number = 16572; BA_Long_Name = 'Salt River Project'; end
       if BA_Short_Name == 'SCL'; EIA_BA_Number = 16868; BA_Long_Name = 'Seattle City Light'; end
       if BA_Short_Name == 'SPA'; EIA_BA_Number = 17716; BA_Long_Name = 'Southwestern Power Administration'; end
       if BA_Short_Name == 'TAL'; EIA_BA_Number = 18445; BA_Long_Name = 'City of Tallahassee'; end
       if BA_Short_Name == 'TEC'; EIA_BA_Number = 18454; BA_Long_Name = 'Tampa Electric Company'; end
       if BA_Short_Name == 'TVA'; EIA_BA_Number = 18642; BA_Long_Name = 'Tennessee Valley Authority'; end
       if BA_Short_Name == 'AVA'; EIA_BA_Number = 20169; BA_Long_Name = 'Avista Corporation'; end
       if BA_Short_Name == 'SEC'; EIA_BA_Number = 21554; BA_Long_Name = 'Seminole Electric Cooperative'; end
       if BA_Short_Name == 'GWA'; EIA_BA_Number = 56365; BA_Long_Name = 'NaturEner Power Watch LLC'; end
       if BA_Short_Name == 'WWA'; EIA_BA_Number = 58791; BA_Long_Name = 'NaturEner Wind Watch LLC'; end
    end
    if size(BA_Short_Name,2) == 4
       if BA_Short_Name == 'NBSO'; EIA_BA_Number = 1;     BA_Long_Name = 'New Brunswick System Operator'; end
       if BA_Short_Name == 'AMPL'; EIA_BA_Number = 599;   BA_Long_Name = 'Anchorage Municipal Light and Power'; end
       if BA_Short_Name == 'AZPS'; EIA_BA_Number = 803;   BA_Long_Name = 'Arizona Public Service Company'; end
       if BA_Short_Name == 'AECI'; EIA_BA_Number = 924;   BA_Long_Name = 'Associated Electric Cooperative Inc.'; end
       if BA_Short_Name == 'AVRN'; EIA_BA_Number = 15399; BA_Long_Name = 'Avangrid Renewables LLC'; end
       if BA_Short_Name == 'BPAT'; EIA_BA_Number = 1738;  BA_Long_Name = 'Bonneville Power Administration'; end
       if BA_Short_Name == 'CISO'; EIA_BA_Number = 2775;  BA_Long_Name = 'California Independent System Operator'; end
       if BA_Short_Name == 'CPLE'; EIA_BA_Number = 3046;  BA_Long_Name = 'Duke Energy Progress East'; end
       if BA_Short_Name == 'CPLW'; EIA_BA_Number = 58786; BA_Long_Name = 'Duke Energy Progress West'; end
       if BA_Short_Name == 'CHPD'; EIA_BA_Number = 3413;  BA_Long_Name = 'PUD No. 1 of Chelan County'; end
       if BA_Short_Name == 'DOPD'; EIA_BA_Number = 5326;  BA_Long_Name = 'PUD No. 1 of Douglas County'; end
       if BA_Short_Name == 'ERCO'; EIA_BA_Number = 5723;  BA_Long_Name = 'Electric Reliability Council of Texas Inc.'; end
       if BA_Short_Name == 'IPCO'; EIA_BA_Number = 9191;  BA_Long_Name = 'Idaho Power Company'; end
       if BA_Short_Name == 'LDWP'; EIA_BA_Number = 11208; BA_Long_Name = 'Los Angeles Department of Water and Power'; end
       if BA_Short_Name == 'LGEE'; EIA_BA_Number = 11249; BA_Long_Name = 'Louisville Gas & Electric Company and Kentucky Utilities'; end
       if BA_Short_Name == 'NWMT'; EIA_BA_Number = 12825; BA_Long_Name = 'NorthWestern Energy'; end
       if BA_Short_Name == 'NEVP'; EIA_BA_Number = 13407; BA_Long_Name = 'Nevada Power Company'; end
       if BA_Short_Name == 'ISNE'; EIA_BA_Number = 13434; BA_Long_Name = 'ISO New England Inc.'; end
       if BA_Short_Name == 'NYIS'; EIA_BA_Number = 13501; BA_Long_Name = 'New York Independent System Operator'; end
       if BA_Short_Name == 'OVEC'; EIA_BA_Number = 14015; BA_Long_Name = 'Ohio Valley Electric Corporation'; end
       if BA_Short_Name == 'PACW'; EIA_BA_Number = 14378; BA_Long_Name = 'PacifiCorp - West'; end
       if BA_Short_Name == 'PACE'; EIA_BA_Number = 14379; BA_Long_Name = 'PacifiCorp - East'; end
       if BA_Short_Name == 'GRMA'; EIA_BA_Number = 14412; BA_Long_Name = 'Gila River Power LLC'; end
       if BA_Short_Name == 'FMPP'; EIA_BA_Number = 14610; BA_Long_Name = 'Florida Municipal Power Pool'; end
       if BA_Short_Name == 'GCPD'; EIA_BA_Number = 14624; BA_Long_Name = 'PUD No. 2 of Grant County'; end
       if BA_Short_Name == 'PSCO'; EIA_BA_Number = 15466; BA_Long_Name = 'Public Service Company of Colorado'; end
       if BA_Short_Name == 'PSEI'; EIA_BA_Number = 15500; BA_Long_Name = 'Puget Sound Energy'; end
       if BA_Short_Name == 'BANC'; EIA_BA_Number = 16534; BA_Long_Name = 'Balancing Authority of Northern California'; end
       if BA_Short_Name == 'SCEG'; EIA_BA_Number = 17539; BA_Long_Name = 'South Carolina Electric & Gas Company'; end
       if BA_Short_Name == 'SOCO'; EIA_BA_Number = 18195; BA_Long_Name = 'Southern Company Services Inc. - Transmission'; end
       if BA_Short_Name == 'TPWR'; EIA_BA_Number = 18429; BA_Long_Name = 'City of Tacoma Department of Public Utilities Light Division'; end
       if BA_Short_Name == 'TIDC'; EIA_BA_Number = 19281; BA_Long_Name = 'Turlock Irrigation District'; end
       if BA_Short_Name == 'HECO'; EIA_BA_Number = 19547; BA_Long_Name = 'Hawaiian Electric Company Inc.'; end
       if BA_Short_Name == 'WAUW'; EIA_BA_Number = 19610; BA_Long_Name = 'Western Area Power Administration - UGP West'; end
       if BA_Short_Name == 'TEPC'; EIA_BA_Number = 24211; BA_Long_Name = 'Tucson Electric Power Company'; end
       if BA_Short_Name == 'WALC'; EIA_BA_Number = 25471; BA_Long_Name = 'Western Area Power Administration - Desert Southwest Region'; end
       if BA_Short_Name == 'WAUE'; EIA_BA_Number = 28502; BA_Long_Name = 'Western Area Power Administration - UGP East'; end
       if BA_Short_Name == 'WACM'; EIA_BA_Number = 28503; BA_Long_Name = 'Western Area Power Administration - Rocky Mountain Region'; end
       if BA_Short_Name == 'SEPA'; EIA_BA_Number = 29304; BA_Long_Name = 'Southeastern Power Administration'; end
       if BA_Short_Name == 'HGMA'; EIA_BA_Number = 32790; BA_Long_Name = 'New Harquahala Generating Company LLC'; end
       if BA_Short_Name == 'GRIF'; EIA_BA_Number = 56090; BA_Long_Name = 'Griffith Energy LLC'; end
       if BA_Short_Name == 'GRIS'; EIA_BA_Number = 56545; BA_Long_Name = 'Gridforce South'; end
       if BA_Short_Name == 'MISO'; EIA_BA_Number = 56669; BA_Long_Name = 'Midcontinent Independent Transmission System Operator Inc.'; end
       if BA_Short_Name == 'DEAA'; EIA_BA_Number = 56812; BA_Long_Name = 'Arlington Valley LLC'; end
       if BA_Short_Name == 'GRID'; EIA_BA_Number = 58790; BA_Long_Name = 'Gridforce Energy Management LLC'; end
       if BA_Short_Name == 'SWPP'; EIA_BA_Number = 59504; BA_Long_Name = 'Southwest Power Pool'; end
       
       if BA_Short_Name == 'GLHB'; EIA_BA_Number = -9999; BA_Long_Name = 'GridLiance'; end    
   end
end