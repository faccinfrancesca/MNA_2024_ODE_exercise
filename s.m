%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
function res = s(k,Z,t,dt)
    global gamma;
    %
    % Estrarre k1 e k2 dal vettore k
    k1 = k(1:4);
    k2 = k(5:8);
    %
    % Residui per k1 e k2
    res1 = k1 - f(t+gamma*dt, Z+gamma*dt*k1);
    res2 = k2 - f(t+(1-gamma)*dt, Z+dt*((1-2*gamma) * k1+gamma*k2));
    % Residuo globale
    res = [res1, res2];
end
