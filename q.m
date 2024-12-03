%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
function res = q(Z,Zn,tn,dt)
    % Sistema di quazioni in forma implicita, da risolvere con Newton
    res = Z - Zn - 0.5*dt*( f(tn,Zn) + f(tn+dt,Z) );
end