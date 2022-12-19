% Function to calculate threshold automatically
% Original code written by: Sara Oliverio
% Modifications by: CHEONG Vee San
% Changelog 25 July 2018 - Replaced histogram with histcounts
% Changelog 10 Aug 2018 - Detect bg peak if no. of peaks>3
%   Picks the peak is within 5% of next peak, else pick abs highest peak
%   However, this may pick an artefact...
% Changelog 25 OCt 2018 - Added script to detect range of values for
%   partial volume effect
function [threshold1, dblPVE] = segm_th2(Grey_Rec)

nBin=21;

[y2,BinEdges] = histcounts(Grey_Rec,nBin);    % split into 20 bins

% middle points of the intervals
x2 = zeros(1, length(BinEdges)-1);
for ii = 1:(length(BinEdges)-1)
    x2(ii) = (BinEdges(ii) + BinEdges(ii+1))/2;
end

% find peaks in the histogram
[maxtab, ~] = peakdet(y2, 1000, x2);

if (length(maxtab)<=3)

    % threshold1 = mean of the bone and background peaks
    threshold1 = ( maxtab(end, 1) + maxtab(end-1, 1) )/2.0;

else
    ascending_maxtab=sortrows(maxtab,2);
    
    for ii = length(maxtab):-1:1
        if ((ascending_maxtab(ii,2)-ascending_maxtab(ii-1,2))/ascending_maxtab(ii-1,2)<0.05)
            bg_peak=ascending_maxtab(ii,1);
            break;
        end
    end
    
    if (isnan(bg_peak)==1)
        bg_peak= ascending_maxtab(length(maxtab),1);
    end
    threshold1= ( maxtab(end, 1) + bg_peak )/2.0;
end

% Finds the region to account for partial volume effect
    for ii=1:nBin
        if (BinEdges(ii)>threshold1)
            if (y2(ii-1)>y2(ii))
                thresholdBin=ii-1;
            else
                thresholdBin=ii;
            end
            break;
        end
    end
    
    % Left bound
    for ii=thresholdBin:-1:1
        if (y2(ii)>y2(thresholdBin)*2)
            thresholdLeft=BinEdges(ii+1);
            break;
        end
    end
    
    % Right bound
    for ii=thresholdBin:nBin
        if (y2(ii)>y2(thresholdBin)*2)
            thresholdRight=BinEdges(ii);
            break;
        end
    end

    if ~(exist('thresholdRight','var'))
        thresholdRight=2*threshold1-thresholdLeft;

    end
        dblPVE=[thresholdLeft, thresholdRight];
end