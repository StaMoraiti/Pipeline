function midSliceID=SliceNumID(fileName)

%% This function extracts the slice number ID of the Interest
%

str_loc=strfind(fileName,'ed');
str_mid=convertCharsToStrings(fileName);
midSliceID=str2num(extractBetween(str_mid,str_loc+2,str_loc+6));