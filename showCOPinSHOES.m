function showCOPinSHOES(shoesCOP, shoesMKR, contact, file_header, pnt, check)
tt= round((contact(end)-contact(1))/5);
t1 = contact(1):contact(1)+tt;
t2 = t1(end)+1:t1(end)+1+tt;
t3 = t2(end)+1:t2(end)+1+tt;
t4 = t3(end)+1:t3(end)+1+tt;
t5 = t4(end)+1:contact(end);


scale = 5;

figure();
scatter(shoesMKR(pnt, 1:3:end), shoesMKR(pnt, 2:3:end))
hold on
scatter(shoesCOP(t1, 1), shoesCOP(t1, 2), "r")
hold on
scatter(shoesCOP(t2, 1), shoesCOP(t2, 2), "g")
hold on
scatter(shoesCOP(t3, 1), shoesCOP(t3, 2), "b")
hold on
scatter(shoesCOP(t4, 1), shoesCOP(t4, 2), "m")
hold on
scatter(shoesCOP(t5, 1), shoesCOP(t5, 2), "c")

%Origin
quiver(0, 0, 0.01, 0, scale, "r")
hold on
quiver(0, 0, 0, 0.01, scale, "g")
hold on

% axis([-0.15 0.15 -0.05 0.3])
xlim([-0.15 0.15])
ylim([-0.05 0.3])
% axis equal
I = getframe(gcf);
imwrite(I.cdata, file_header+"_shoesCOP.png")

if check == "off"
    close
end

end