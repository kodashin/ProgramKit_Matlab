%bottom point:red
%top point:blue

function [peak_bot,peak_top] = getWavePeak2(data,fig_on,yokoziku)
FR1000 = 1/1000;
%•ªÍ”ÍˆÍ‚Ì’Šo
base_id = 1:length(data);
peak_bot = base_id(data <= data([1 1:end-1]) & data < data([2:end end]));%‹É¬
peak_top = base_id(data >= data([1 1:end-1]) & data > data([2:end end]));%‹É¬
if fig_on == "on" 
    if yokoziku == "time"
        figure();
    plot(0:FR1000:(length(data)-1)*FR1000,data)
    hold on
    plot(peak_bot*FR1000, data(peak_bot), 'or')%bottom
    hold on
    plot(peak_top*FR1000, data(peak_top), 'ob')%top
    elseif yokoziku == "frame"
        
        figure();
    plot(data)
    hold on
    plot(peak_bot, data(peak_bot), 'or')%bottom
    hold on
    plot(peak_top, data(peak_top), 'ob')%top
        
    end
end
