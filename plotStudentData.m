function plotStudentData(filename)
% PLOTSTUDENTDATA  Plots GPA against CGPA using different plot types
% Usage: plotStudentData('C:\Users\Personal\Desktop\STUDENT DATA.xlsx')

    if nargin < 1
        filename = 'C:\Users\Personal\Desktop\STUDENT DATA.xlsx';
    end

    % ---- Import data ----
    data = readtable(filename);
    data = data(:, {'CGPA','GPA'});
    data = rmmissing(data);                  % remove empty cells
    data = sortrows(data, 'CGPA');           % sort by x
    x = data.CGPA;
    y = data.GPA;

    types  = {'bar','line','scatter','barh','stem','stairs','errorbar','area','hist','pareto'};
    titles = {'Bar plot','Line plot','Scatter plot','Horizontal bar graph', ...
              'Stem plot','Step plot','Error bar plot','Area plot','Histogram','Pareto chart'};

    for k = 1:numel(types)
        figure('Name', titles{k});
        try
            makePlot(types{k}, x, y);
            title([titles{k} ' showing GPA against CGPA']);
            grid on;
        catch err
            close(gcf);
            fprintf('Skipped %s: %s\n', types{k}, err.message);
        end
    end
end

function makePlot(type, x, y)
% MAKEPLOT  Draws one plot, then labels it (labels must come AFTER plotting)

    switch type
        case 'bar'
            bar(x, y);
            xlabel('CGPA'); ylabel('GPA');
        case 'line'
            plot(x, y, '-o');
            xlabel('CGPA'); ylabel('GPA');
        case 'scatter'
            scatter(x, y, 'filled');
            xlabel('CGPA'); ylabel('GPA');
        case 'barh'
            barh(x, y);
            xlabel('GPA'); ylabel('CGPA');
        case 'stem'
            stem(x, y);
            xlabel('CGPA'); ylabel('GPA');
        case 'stairs'
            stairs(x, y);
            xlabel('CGPA'); ylabel('GPA');
        case 'errorbar'
            err = std(y) * ones(size(y));
            errorbar(x, y, err);
            xlabel('CGPA'); ylabel('GPA');
        case 'area'
            area(x, y);
            xlabel('CGPA'); ylabel('GPA');
        case 'hist'
            histogram(y);
            xlabel('GPA'); ylabel('Frequency');
        case 'pareto'
            pareto(y);
            xlabel('Student index'); ylabel('GPA');
        otherwise
            error('Unknown plot type: %s', type);
    end
end
