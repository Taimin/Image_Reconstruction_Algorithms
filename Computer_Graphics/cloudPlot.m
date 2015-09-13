function [ varargout ] = cloudPlot( X, Y, binSize )
%CLOUDPLOT Does a cloud plot of the data in X and Y.
% CLOUDPLOT(X,Y) draws a cloudplot of Y versus X. A cloudplot is in essence
% a 2 dimensional histogram showing the density distribution of the data
% described by X and Y. As the plot displays density information, the
% dimensionality of X and Y are ignored. The only requirement is that X and
% Y have the same number of elements. Cloudplot is written to visualize
% large quantities of data and is most appropriate for datasets of 10000
% elements or more.
%
% CLOUDPLOT(X,Y,binSize) will use the binSize to set the size of the bins
% over which the density of the data is measured. If binSize is a scalar,
% it is used for both X and Y. If it is a 2-element vector, the first
% element will be the bin size in X and the second element will be the bin
% size i Y.
%
% h = CLOUTPLOT(...) returns the handle to the cloud image in h.
%
% Example:
%   cloudPlot( randn(100,1), randn(100,1) );
%    Will plot a Gaussian scattered distribution using a default bin-size.
%
%   cloudPlot( randn(100), randn(100), [0.1 0.1] );
%    Will plot a Gaussian scattered distribution using bins that are
%    0.1x0.1 units large.

% Remove NaNs and Infs as they have no meaning in this sort of plot.
selectNanAndInf = or(or(or(isnan(X),isnan(Y)),isinf(X)),isinf(Y));

X = real(X(~selectNanAndInf));
Y = real(Y(~selectNanAndInf));

if ( nargin < 3 )
    %Do an automatic estimate to get 5 points per bin on average.
    binSize = ...
        5/sqrt((numel(X)/((max(X(:))-min(X(:)))*(max(Y(:))-min(Y(:))))));
    binSize = [binSize binSize];
end

% Check the data size
assert ( numel(X) == numel(Y), ...
    'The number of elements in X and Y must be the same.' );

% Fix if only one binSize is given.
if ( numel(binSize) == 1 )
    binSize = [binSize binSize];
end

assert ( numel(binSize)==2, 'binSize must be a 2-element vector.' );

% Plot to get appropriate limits
h = plot ( X(:), Y(:), '.' );
g = get( h, 'Parent' );
xLim = get(g, 'Xlim' );
yLim = get(g, 'Ylim' );
xTick = get(g, 'XTick' );
xTickLabel = get(g, 'XTickLabel' );
yTick = get(g, 'YTick' );
yTickLabel = get(g, 'YTickLabel' );

% Allocate an area to draw on
bins = ceil([diff(xLim)/binSize(1) diff(yLim)/binSize(2)]);
canvas = zeros(bins);

% Draw in the canvas
xBinIndex = floor((X - xLim(1))/binSize(1))+1;
yBinIndex = floor((Y - yLim(1))/binSize(2))+1;
for i = 1:numel(xBinIndex);
    canvas(xBinIndex(i),yBinIndex(i)) = ...
        canvas(xBinIndex(i),yBinIndex(i)) + 1;
end

% Show the canvas and adjust the grids.
h = imagesc ( log(canvas)' );
axis ( 'xy' );
g = get( h, 'Parent' );
xTickAdjust = (xTick - min(xTick))*bins(1)/(max(xTick)-min(xTick))+0.5;
yTickAdjust = (yTick - min(yTick))*bins(2)/(max(yTick)-min(yTick))+0.5;
set ( g, 'XTick', xTickAdjust );
set ( g, 'XTickLabel', xTickLabel );
set ( g, 'YTick', yTickAdjust );
set ( g, 'YTickLabel', yTickLabel );

% Optionally return a handle
if ( nargout > 0 )
    varargout{1} = h;
end




