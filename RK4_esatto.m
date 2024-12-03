%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
clc 
clear
close all
%
%% CALCOLO DELLA SOLUZIONE ESATTA CON IL METODO DI RUNGE-KUTTA DI ORDINE 4
%
t0   = 0;                            % Tempo iniziale
tend = 20;                           % Tempo finale
Z0   = impostaParametri(indice);     % Condizione iniziale
%
dte     = 10^-5;                     % Time step
NMAXe   = tend/dte;
te(1)   = t0;
Ze(1,:) = Z0;
%
for j = 1:NMAXe           
    if (te(j)+dte>tend)
        dte = tend-te(j);
    end
    if (te(j)>=tend)
        break
    end
    % RK4 per la soluzione "esatta"
    k1e = f(te(j),Ze(j,:));
    k2e = f(te(j)+0.5*dte, Ze(j,:)+0.5*dte*k1e);
    k3e = f(te(j)+0.5*dte, Ze(j,:)+0.5*dte*k2e);
    k4e = f(te(j)+1.0*dte, Ze(j,:)+1.0*dte*k3e);
    Ze(j+1,:) = Ze(j,:) + dte/6*(k1e+2*k2e+2*k3e+k4e);
    %
    te(j+1) = te(j) + dte;
end
%