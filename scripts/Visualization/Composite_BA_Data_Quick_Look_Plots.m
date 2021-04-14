% Composite_BA_Data_Quick_Look_Plots.m
% 20210415
% Casey D. Burleyson
% Pacific Northwest National Laboratory

% This TELL visualization script takes as input the composite time-series
% of meteorology, population, and electricity demand within balancing
% authorities (BAs) and generates a quick-look plot for each BA that can be
% used to understand the major modes of variability. The input to this
% script is generated using the Process_Composite_BA_Data.m script in the
% TELL repository. Data needed to run this script are stored on PIC at
% /projects/im3/tell/. This script relies on the function
% EIA_930_BA_Information_From_BA_Short_Name.m that returns the long name 
% and EIA BA # of the BA given the BA abbreviation.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              BEGIN USER INPUT SECTION               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set some processing flags:
save_images = 1; % (1 = Yes)

% Set the data input and image output directories:
composite_data_input_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Data/TELL_Input_Data/inputs/Composite_BA_Hourly_Data/Matlab_Files/';
image_output_dir = '/Users/burl878/OneDrive - PNNL/Documents/IMMM/Images/TELL/Analysis/Composite_BA_Data_Quick_Look_Plots/';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              END USER INPUT SECTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%              BEGIN PLOTTING SECTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input_files = dir([composite_data_input_dir,'*.mat']);
for file = 1:size(input_files,1)
    filename = input_files(file,1).name;
    BA_Short_Name = filename(1,1:(size(filename,2)-39));
    [EIA_BA_Number,BA_Long_Name] = EIA_930_BA_Information_From_BA_Short_Name(BA_Short_Name);
       
    load([composite_data_input_dir,filename]);
       
    DJF = Data(find(Data(:,3) == 1 | Data(:,3) == 2  | Data(:,3) == 12),:);
    MAM = Data(find(Data(:,3) == 3 | Data(:,3) == 4  | Data(:,3) == 5),:);
    JJA = Data(find(Data(:,3) == 6 | Data(:,3) == 7  | Data(:,3) == 8),:);
    SON = Data(find(Data(:,3) == 9 | Data(:,3) == 10 | Data(:,3) == 11),:);
       
    for hour = [0:1:23]
        Mean_Temp(1,hour+1) = nanmean(DJF(find(DJF(:,5) == hour),7)) - 273.15;
        Mean_Temp(2,hour+1) = nanmean(MAM(find(DJF(:,5) == hour),7)) - 273.15;
        Mean_Temp(3,hour+1) = nanmean(JJA(find(DJF(:,5) == hour),7)) - 273.15;
        Mean_Temp(4,hour+1) = nanmean(SON(find(DJF(:,5) == hour),7)) - 273.15;
        Mean_Load(1,hour+1) = nanmean(DJF(find(DJF(:,5) == hour),13));
        Mean_Load(2,hour+1) = nanmean(MAM(find(DJF(:,5) == hour),13));
        Mean_Load(3,hour+1) = nanmean(JJA(find(DJF(:,5) == hour),13));
        Mean_Load(4,hour+1) = nanmean(SON(find(DJF(:,5) == hour),13));
    end
    clear DJF MAM JJA SON hour
       
    a = figure('Color',[1 1 1]); set(a,'Position',get(0,'Screensize'));
    subplot(2,1,1); hold on;
    line(Data(:,1),Data(:,13),'Color','k','LineWidth',1);
    legend('EIA-930 Adjusted Hourly Demand','Location','NorthWest');
    xlim([datenum(2015,1,1,0,0,0) datenum(2021,1,1,0,0,0)]);
    set(gca,'xtick',[735965,736330,736696,737061,737426,737791,738157],'xticklabel',{'2015','2016','2017','2018','2019','2020','2021'});
    ylabel('Hourly Demand [MWh]','FontSize',21); 
    set(gca,'LineWidth',3,'FontSize',21,'Box','on')
    title([BA_Long_Name,' (',BA_Short_Name,') Hourly Electricity Demand'],'FontSize',24)
       
    subplot(2,3,4); hold on;
    line([0.5:1:23.5],Mean_Temp(1,:),'Color','b','LineWidth',3);
    line([0.5:1:23.5],Mean_Temp(2,:),'Color','g','LineWidth',3);
    line([0.5:1:23.5],Mean_Temp(3,:),'Color','r','LineWidth',3);
    line([0.5:1:23.5],Mean_Temp(4,:),'Color',[1.00 0.72 0.04],'LineWidth',3);
    legend('DJF','MAM','JJA','SON','Location','North','Orientation','Horizontal');
    xlim([0 24]); set(gca,'xtick',[0:3:24],'xticklabel',{'00','03','06','09','12','15','18','21','00'});
    xlabel('Time [UTC]','FontSize',21); 
    ylabel(['Mean Temperature [',setstr(176),'C]'],'FontSize',21); 
    set(gca,'LineWidth',3,'FontSize',21,'Box','on')
    title('Temperature Diurnal Cycles','FontSize',24)
       
    subplot(2,3,5); hold on;
    line([0.5:1:23.5],Mean_Load(1,:),'Color','b','LineWidth',3);
    line([0.5:1:23.5],Mean_Load(2,:),'Color','g','LineWidth',3);
    line([0.5:1:23.5],Mean_Load(3,:),'Color','r','LineWidth',3);
    line([0.5:1:23.5],Mean_Load(4,:),'Color',[1.00 0.72 0.04],'LineWidth',3);
    legend('DJF','MAM','JJA','SON','Location','North','Orientation','Horizontal');
    xlim([0 24]); set(gca,'xtick',[0:3:24],'xticklabel',{'00','03','06','09','12','15','18','21','00'});
    xlabel('Time [UTC]','FontSize',21); 
    ylabel(['Mean Demand [MWh]'],'FontSize',21); 
    set(gca,'LineWidth',3,'FontSize',21,'Box','on')
    title('Demand Diurnal Cycles','FontSize',24)
     
    subplot(2,3,6); hold on;
    line(Data(:,1),Data(:,6)./(10^6),'Color','k','LineWidth',3);
    legend('Total Population in BA Territory','Location','NorthWest');
    xlim([datenum(2015,1,1,0,0,0) datenum(2020,1,1,0,0,0)]);
    set(gca,'xtick',[735965,736330,736696,737061,737426,737791,738157],'xticklabel',{'2015','2016','2017','2018','2019','2020','2021'});
    ylabel('Population [100,000s]','FontSize',21); 
    set(gca,'LineWidth',3,'FontSize',21,'Box','on')
    title('Population','FontSize',24)
     
    if save_images == 1
       set(gcf,'Renderer','zbuffer'); set(gcf,'PaperPositionMode','auto');
       print(a,'-dpng','-r150',[image_output_dir,BA_Short_Name,'_Composite_BA_Data.png']);
       close(a);
    end
    clear a ans BA_Long_Name BA_Short_Name Data EIA_BA_Number Mean_Load Mean_Temp filename
end
clear input_files file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               END PLOTTING SECTION                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                BEGIN CLEANUP SECTION                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear composite_data_input_dir image_output_dir save_images
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 END CLEANUP SECTION                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%