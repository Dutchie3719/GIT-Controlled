%% %% Modelling Assignement Two
% Daniel Shor
% 4745094

function f = balancefcn(m,y)
    f = y(1)*(m(1)+y(2)*m(2)+y*m(3) / (m(1)+m(2)+m(3)