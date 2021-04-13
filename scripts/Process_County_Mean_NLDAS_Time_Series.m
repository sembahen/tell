% Process_County_Mean_NLDAS_Time_Series.m
% 20201202
% Casey D. Burleyson
% Pacific Northwest National Laboratory

% This script takes as input hourly output files from the NLDAS reanlaysis
% and calculates the county-mean value of the various meteorological
% variables. County-means are based on data inside shapefiles that are read
% in from the input directory.

warning off all; clear all; close all; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              BEGIN USER INPUT SECTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
start_date = datenum(2020,12,01,0,0,0); 
end_date = datenum(2020,12,31,23,59,59); 

geolocation_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Data/TELL/Proof_of_Concept_Figure/';
nldas_data_input_dir = '/Users/burl878/Desktop/NLDAS/County_Mean_NLDAS_Time_Series/';
nldas_data_output_dir = '/Users/burl878/Desktop/NLDAS/County_Mean_NLDAS_Time_Series/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              END USER INPUT SECTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            BEGIN PRE-PROCESSING SECTION             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input_files = dir([nldas_data_input_dir,'NLDAS_FORA0125_H.A*.SUB.nc4']);
for file = 1:size(input_files,1)
    filename = input_files(file,1).name;
    year = str2num(filename(1,19:22));
    month = str2num(filename(1,23:24));
    day = str2num(filename(1,25:26));
    hour = str2num(filename(1,28:29));
    Names(file,1).filename = filename;
    Times(file,1) = datenum(year,month,day,hour,0,0);
    Times(file,2) = year; Times(file,3) = month; Times(file,4) = day; Times(file,5) = hour;
    clear filename year month day hour
end
clear input_files file
Names = Names(find(Times(:,1) >= datenum(start_date) & Times(:,1) <= datenum(end_date)),:);
Times = Times(find(Times(:,1) >= datenum(start_date) & Times(:,1) <= datenum(end_date)),:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             END PRE-PROCESSING SECTION              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              BEGIN PROCESSING SECTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load([geolocation_dir,'shapefile_counties.mat']);
for i = 1:size(shapefile_counties,1)
    FIPS(i,1) = shapefile_counties(i,1).county_FIPS;
end
clear i

for file = 1:size(Times,1)
    Time(1:4,file) = Times(file,2:5)';
    
    ncid = netcdf.open([nldas_data_input_dir,Names(file,1).filename],'NOWRITE');
    
    [Lat_Grid,Lon_Grid] = meshgrid(double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lat'))),double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'lon'))));
    T = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'TMP')));      T(find(T == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'TMP'),'_FillValue'))) = NaN.*0;
    P = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'PRES')));     P(find(P == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'PRES'),'_FillValue'))) = NaN.*0;
    U = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'UGRD')));     U(find(U == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'UGRD'),'_FillValue'))) = NaN.*0;
    V = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'VGRD')));     V(find(V == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'VGRD'),'_FillValue'))) = NaN.*0;
    Q = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'SPFH')));     Q(find(Q == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'SPFH'),'_FillValue'))) = NaN.*0;
    R = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'APCP')));     R(find(R == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'APCP'),'_FillValue'))) = NaN.*0;
    SWdn = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'DSWRF'))); SWdn(find(SWdn == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'DSWRF'),'_FillValue'))) = NaN.*0;
    LWdn = double(netcdf.getVar(ncid,netcdf.inqVarID(ncid,'DLWRF'))); LWdn(find(LWdn == netcdf.getAtt(ncid,netcdf.inqVarID(ncid,'DLWRF'),'_FillValue'))) = NaN.*0;

    if file == 1
       for i = 1:size(shapefile_counties,1)
           Indices(i,1).ind = inpolygon(Lat_Grid,Lon_Grid,shapefile_counties(i,1).lat_vector,shapefile_counties(i,1).lon_vector);
       end
       clear i
    end
    
    for i = 1:size(shapefile_counties,1)
        Mean_T(i,file) = nanmean(T(Indices(i,1).ind));
        Mean_P(i,file) = nanmean(P(Indices(i,1).ind));
        Mean_U(i,file) = nanmean(U(Indices(i,1).ind));
        Mean_V(i,file) = nanmean(V(Indices(i,1).ind));
        Mean_Q(i,file) = nanmean(Q(Indices(i,1).ind));
        Mean_R(i,file) = nanmean(R(Indices(i,1).ind));
        Mean_SWdn(i,file) = nanmean(SWdn(Indices(i,1).ind));
        Mean_LWdn(i,file) = nanmean(LWdn(Indices(i,1).ind));
    end
    clear i
   
    netcdf.close(ncid);
    Percent_Complete = (file/size(Names,1))*100
    clear ncid Lat_Grid Lon_Grid T P U V Q R SWdn LWdn Percent_Complete
end
clear file

save([nldas_data_output_dir,'County_Mean_NLDAS_Time_Series_',datestr(start_date,'yyyymm'),'.mat'],'FIPS','Mean_LWdn','Mean_P','Mean_Q','Mean_R','Mean_SWdn','Mean_T','Mean_U','Mean_V','Time');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               END PROCESSING SECTION                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                BEGIN CLEANUP SECTION                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear nldas_data_input_dir nldas_data_output_dir geolocation_dir start_date end_date shapefile_counties Names Times Indices
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 END CLEANUP SECTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%