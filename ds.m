%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
function J = ds(k, Z, t, dt)
    eps = 1e-11;          % Perturbazione
    J   = zeros(8,8);
    %
    for j = 1:8
        k_pos    = k;
        k_pos(j) = k_pos(j) + eps;
        k_neg    = k;
        k_neg(j) = k_neg(j) - eps;
        %
        % Differenza centrale
        res_pos = s(k_pos, Z, t, dt);
        res_neg = s(k_neg, Z, t, dt);
        J(:, j) = (res_pos(:) - res_neg(:))/(2*eps);
    end
end