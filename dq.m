%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
%% JACOBIANA
%
function J = dq(Z,Zn,tn,dt)
    % Calcolo delle derivate di q usando le differenze finite
    eps = 1e-7;
    J = zeros(4,4);   % Inizializzo la matrice Jacobiana
    for i=1:4
        Z_p    = Z;
        Z_p(i) = Z_p(i) + eps;
        Z_m    = Z;
        Z_m(i) = Z_m(i) - eps; 
        %
        % Calcolo della derivata
        p_p     = q(Z_p, Zn, tn, dt);
        p_m     = q(Z_m, Zn, tn, dt);
        J(:, i) = (q(Z_p,Zn,tn,dt) - q(Z_m,Zn,tn,dt)) / (2*eps);
    end
    % disp('Jacobiana calcolata:');
    % disp(J);
end
% 