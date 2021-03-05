clear
% close all
clf

fileNames = {'Recording 173645-022221.mp3',    'Recording 173709-022221.mp3',...
    'Recording 173730-022221.mp3','Recording 173750-022221.mp3'};

for ind1 = 1:4
    
    [f{ind1},P{ind1}] = plotFrequencies(fileNames{ind1},0);
    subplot(4,1,ind1)
    plot(f{ind1},P{ind1})
    grid on
    xlim([20,1000])
    ylim([0,6e-4])
    title(sprintf('File %i',ind1))
end

xlabel('Frequency (Hz)')