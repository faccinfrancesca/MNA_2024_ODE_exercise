%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
function Jf = df(t,Z)
    epsilon = 1e-6;  
    Jf = zeros(4, 4); % Inizializza la matrice Jacobiana
    %
    for i = 1:4
        Z_plus     = Z;
        Z_plus(i)  = Z_plus(i) + epsilon;
        Z_minus    = Z;
        Z_minus(i) = Z_minus(i) - epsilon;
        %
        % Calcola la derivata numerica per differenze finite
        Jf(:, i) = (f(t,Z_plus) - f(t,Z_minus)) / (2 * epsilon);
    end
    %disp('Jacobiana calcolata:');
    %disp(Jf);
end