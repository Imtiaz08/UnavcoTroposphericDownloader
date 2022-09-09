clear all;clc
%-----------------------------------------------------------------------
% File:       UnavcoTropo.m                                            |
% Author(s):  Imtiaz Nabi, Saqib Mehdi                                 |
%             Institute of Space Technology, 
%             Islamabad, Pakistan                                      |
% Contact:    Imtiaznabi8@gmail.com                                    |
%-----------------------------------------------------------------------

% File Description: 

% The UnavcoTropo.m script finds and extracts the tropospheric data from
% the unavco server and downloads it to local drive that can be accessed
% later.
%======================================================================%


% File Extensions
ext = ['a','b', 'c', 'f', 'g'];

inputType = input("Please Select Input Type (hint 'single' 'range'): \n");
fprintf('Input Type has been selected\n')

% Specify the Input type parameter that needs to be either a single date or
% a range with distinct starting and ending date.

% The date should be in day of year (DOY) format in order to make it with
% the permalinks of the Unavco server.

Year = input('Please Input Year of the Data Record: ');
Year = num2str(Year);
delim = "/";

if inputType == 'single'
    DayOfYear = input('Please Select Day of Year (format 00x to xxx): ');
elseif inputType == 'range'
    DayOfYear = input('Select a Range for Days of Year Please (format [00x xxx]): ');
end

DayOfYear = num2str(DayOfYear, '%03.f');

% This section finds the file name from the HTML code of the page (unavco)
allVar = [];
for ii = 1:length(ext)
    url = "https://data.unavco.org/archive/gnss/products/troposphere";
    url = strcat(url,delim,Year,delim,DayOfYear,delim);
    file = urlread (url);  %'cwu21386.20210102.a.met.gz'
    dat = findstr(file,['.',ext(ii),'.met.gz']);
    f = file(dat(2)-17:dat(2)+8); f=string(f);
    allVar = [allVar f];

    % This section finds the appropriate files according to days and year and
    % then downloads it to the local drive in a compressed format (.gz)
    % for ii = 1:length(ext)
    HttpsUrl = "https://data.unavco.org/archive/gnss/products/troposphere";
    httpsUrl = strcat(HttpsUrl,delim,Year,delim,DayOfYear,delim);
    FileUrl = strcat(httpsUrl, allVar(ii));
    MetFile = allVar(ii);
    metFileFullPath = websave(MetFile, FileUrl);    
    fprintf('The file %s has been downloaded successfully!\n',MetFile)
end


