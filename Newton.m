%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
%% FUNZIONE PER RISOLVERE IL SISTEMA NON LINEARE
% y(Z) = Z - Zn - 0.5*dt*( f(tn,Zn) + f(tn+dt,Z) )
%
function Z = Newton(Zn,tn,dt)
    indice = 1;
    %
    tol   = 1e-11;                       % Tolleranza
    iMAXN = 10000;                       % Numero massimo di iterazioni
    %
    % Inizializzazione
    Z0    = impostaParametri(indice);    % Condizione iniziale
    Z     = Z0;
    %
    for i = 1:iMAXN
        res = q(Z,Zn,tn,dt);         % Resto
        J   = dq(Z,Zn,tn,dt);        % Calcolo della Jaobiana
        dZ  = -J \ res(:);           % Newton step
        Z   = Z + dZ.';              % Aggiornamento della soluzione
        %
        if norm(res)<tol    
            break
        end
    end
    %
    if i == iMAXN
        disp('Metodo di Newton non converge');
    end
end