function a = arraySeries(arr,direc)
if  direc == "bot"
    arr = flip(arr);
    for i = 2:length(arr)
        if arr(i) - arr(i-1)<-1
            break

        end
    end
    a = arr(i-1):arr(1);
elseif direc == "top"
    for i = 2:length(arr)
        if arr(i) - arr(i-1)>1
            break

        end
    end

    a = arr(1):arr(i-1);
end




