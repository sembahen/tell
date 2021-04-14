% Process_Meteorology_Time_Series_Within_BA_Domain.m
% 20210413
% Casey D. Burleyson
% Pacific Northwest National Laboratory

% This script takes .mat files containing the county mapping of
% utilities and balancing authorities (BAs) and computes the population-
% weighted hourly time-series of meteorological variables within a given
% BA. The script takes as input the year to process as well as paths to the
% relevant input and output directories. Currently the meteorological data
% comes from the NLDAS reanalysis, but this could be modified in the
% future. NLDAS data were previously averaged into county-level means using
% the Process_County_Mean_NLDAS_Time_Series.m script. The raw NLDAS data and
% other input files are stored on PIC at: /projects/im3/tell/. The output file format is given below. 
% This script coresponds to needed functionality 1.3 on this Confluence page:
% https://immm-sfa.atlassian.net/wiki/spaces/IP/pages/1732050973/2021-02-22+TELL+Meeting+Notes.
% All times are in UTC. Missing values are reported as -9999 in the .csv output files and as
% NaNs in the .mat output files.
%
%   .mat output file format:
%   C1: MATLAB date number
%   C2: Year
%   C3: Month
%   C4: Day
%   C5: Hour
%   C6: Population-weighted NLDAS temperature in K
%   C7: Population-weighted NLDAS specific humidity in kg/kg
%   C8: Population-weighted NLDAS downwelling shortwave radiative flux in W/m^2
%   C9: Population-weighted NLDAS downwelling longwave radiative flux in W/m^2
%   C10: Population-weighted NLDAS wind speed in m/s
%
%   .csv output file format: 
%   C1: Year
%   C2: Month
%   C3: Day
%   C4: Hour
%   C5: Population-weighted NLDAS temperature in K
%   C6: Population-weighted NLDAS specific humidity in kg/kg
%   C7: Population-weighted NLDAS downwelling shortwave radiative flux in W/m^2
%   C8: Population-weighted NLDAS downwelling longwave radiative flux in W/m^2
%   C9: Population-weighted NLDAS wind speed in m/s

warning off all; clear all; close all; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              BEGIN USER INPUT SECTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set some processing flags:
year_to_process = 2015; % Year of data to process

% Set the data input and output directories:
population_data_input_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Data/TELL_Input_Data/inputs/';
service_territory_data_input_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Data/TELL_Input_Data/inputs/Utility_Mapping/Matlab_Files/';
nldas_data_input_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Data/TELL_Input_Data/inputs/County_Mean_NLDAS_Time_Series/';
mat_data_output_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Data/TELL_Input_Data/inputs/BA_Hourly_Meteorology/Matlab_Files/';
csv_data_output_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Data/TELL_Input_Data/inputs/BA_Hourly_Meteorology/CSV_Files/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              END USER INPUT SECTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%            BEGIN PRE-PROCESSING SECTION             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make a list of all of the monthly files with county-mean NLDAS meteorology:
input_files = dir([nldas_data_input_dir,'County_Mean_NLDAS_Time_Series_*.mat']);
for file = 1:size(input_files,1)
    filename = input_files(file,1).name;
    year = str2num(filename(1,31:34));
    month = str2num(filename(1,35:36));
    Names(file,1).filename = filename;
    Times(file,1) = year;
    Times(file,2) = month;
    clear filename year month
end
% Subset that list to only the selected year:
NLDAS_Names = Names(find(Times(:,1) == year_to_process),:);
NLDAS_Times = Times(find(Times(:,1) == year_to_process),:);
clear input_files file Names Times
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             END PRE-PROCESSING SECTION              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              BEGIN PROCESSING SECTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load in the county population dataset used to population-weight the meteorology variables:
load([population_data_input_dir,'county_populations_2000_to_2019.mat']);
Pop(:,1) = FIPS_Code;
Pop(:,2) = Population(:,find(Year(1,:) == year_to_process));
clear FIPS_Code Population Year

% Load in the BA service territory dataset:
load([service_territory_data_input_dir,'BA_Service_Territory_',num2str(year_to_process),'.mat']);

% Cluge fix to get rid of Washington, D.C. since it's not in the NLDAS county-level mean dataset:
BA_Service_Territory = BA_Service_Territory(find(BA_Service_Territory(:,1) ~= 11000),:);

% Loop over the NLDAS files and concatenate them into long arrays:
for file = 1:size(NLDAS_Names,1)
    % Load the file:
    load([nldas_data_input_dir,NLDAS_Names(file,1).filename]);
    
    % Compute the mean wind speed using the U and V components:
    Mean_WSP = sqrt(Mean_U.^2 + Mean_V.^2);
    
    % Concatenate the time-series:
    if file == 1
       Q = Mean_Q;
       LWdn = Mean_LWdn;
       SWdn = Mean_SWdn;
       T = Mean_T;
       WSP = Mean_WSP;
       Time_All = Time;
    else
       Q = cat(2,Q,Mean_Q);
       LWdn = cat(2,LWdn,Mean_LWdn);
       SWdn = cat(2,SWdn,Mean_SWdn);
       T = cat(2,T,Mean_T);
       WSP = cat(2,WSP,Mean_WSP);
       Time_All = cat(2,Time_All,Time);
    end
    clear Mean_LWdn Mean_P Mean_Q Mean_R Mean_SWdn Mean_T Mean_U Mean_V Time Mean_WSP
end
Time = Time_All;
clear file Time_All NLDAS_Names NLDAS_Times

% Loop over all of the BAs with a valid service territory and compute the population-weighted mean of each meteorological variable:
for i = 1:size(BA_Metadata,1)
    % Display the progress:
    Progress = 100.*(i/size(BA_Metadata,1))
    
    % Retrieve the BA abbreviation to be used in the output file:
    BA_Code = char(BA_Metadata{i,2});
    
    % Subset the territory to only the BA being processed:
    Territory = BA_Service_Territory(find(BA_Service_Territory(:,2) == BA_Metadata{i,1}),:);
       
    if isempty(Territory) == 0
       % Assign the population to each county in the BA territory and compute the fraction of the total population in each county:
       Territory = unique(Territory(:,1),'rows');
       for row = 1:size(Territory,1)
           Territory(row,2) = Pop(find(Pop(:,1) == Territory(row,1)),2);
       end
       Territory(:,3) = Territory(:,2)./sum(Territory(:,2));
       clear row
       
       % Compute the population-weighted value for each county and each meteorological variable:
       for row = 1:size(Territory,1)
           T_Subset(row,:) = Territory(row,3).*T(find(FIPS(:,1) == Territory(row,1)),:);
           Q_Subset(row,:) = Territory(row,3).*Q(find(FIPS(:,1) == Territory(row,1)),:);
           SWdn_Subset(row,:) = Territory(row,3).*SWdn(find(FIPS(:,1) == Territory(row,1)),:);
           LWdn_Subset(row,:) = Territory(row,3).*LWdn(find(FIPS(:,1) == Territory(row,1)),:);
           WSP_Subset(row,:) = Territory(row,3).*WSP(find(FIPS(:,1) == Territory(row,1)),:);
       end
       clear row
       
       % Sum up the fractional values from each county into a new variable:
       Data(:,1) = datenum(Time(1,:),Time(2,:),Time(3,:),Time(4,:),0,0)';
       Data(:,2:5) = Time';
       Data(:,6) = roundn(nansum(T_Subset,1),-2)'; clear T_Subset
       Data(:,7) = roundn(nansum(Q_Subset,1),-5)'; clear Q_Subset
       Data(:,8) = roundn(nansum(SWdn_Subset,1),-2)'; clear SWdn_Subset
       Data(:,9) = roundn(nansum(LWdn_Subset,1),-2)'; clear LWdn_Subset
       Data(:,10) = roundn(nansum(WSP_Subset,1),-2)'; clear WSP_Subset
       
       % Save the data as a .mat file:
       save([mat_data_output_dir,BA_Code,'_',num2str(year_to_process),'_Hourly_Meteorology_Data_',num2str(year_to_process),'.mat'],'Data');
       
       % Convert the data into a table and save it as a .csv file:
       Output_Table = array2table(Data(:,2:10));
       Output_Table.Properties.VariableNames = {'Year','Month','Day','Hour','Temperature','Specific_Humidity','Shortwave_Radiation','Longwave_Radiation','Wind_Speed'};
       writetable(Output_Table,strcat([csv_data_output_dir,BA_Code,'_Hourly_Meteorology_Data_',num2str(year_to_process),'.csv']),'Delimiter',',','WriteVariableNames',1);
       clear Output_Table Data 
    end
    clear BA_Code Territory Progress
end
clear i
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               END PROCESSING SECTION                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                BEGIN CLEANUP SECTION                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear csv_data_output_dir mat_data_output_dir population_data_input_dir service_territory_data_input_dir nldas_data_input_dir Q SWdn T Time Pop LWdn WSP FIPS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 END CLEANUP SECTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%