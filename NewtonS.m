%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
function k_guess = NewtonS(Z,t,dt)
    %
    tol  = 1e-11;       % Tolleranza per la convergenza
    iMAX = 10000;       % Iterazioni massime
    %
    % Inizializzazione
    k_guess = [f(t, Z), f(t, Z)];
    %
    for i = 1:iMAX
        res     = s(k_guess,Z,t,dt);        % Calcolare il residuo globale
        J       = ds(k_guess,Z,t,dt);       % Calcolare la Jacobiana globale
        delta_k = -J \ res(:);              % Aggiornamento di Newton
        k_guess = k_guess + delta_k.';
        %
        if norm(res) < tol
            break;
        end
    end
end
