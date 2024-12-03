%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
%% PARAMETRI INIZIALI
% Imposta le condizioni iniziali per i vari casi di studio
%
function Z = impostaParametri(indice)
%
    global k g l1 m1 l2 m2 te NMAXe Ze j gamma;
    g = 9.81;
    gamma = (3-sqrt(3))/6;
    load('NMAXe.mat', 'NMAXe');
    load('j.mat', 'j');             % Numero di passi
    % 
    switch indice
        case 1
            k  = 1;
            l1 = 1;
            l2 = 1;
            m1 = 1;
            m2 = 1;
            Z  = [15*pi/180, 0, 10*pi/180, 0];  
            % Importo le variabili della soluzione esatta
            load('Ze1.mat', 'Ze');
            load('te1.mat', 'te');     % Soluzione esatta calcolata con RK4
            %
        case 2
            k = 1;
            l1 = 1.2;
            l2 = 1.4;
            m1 = 1.2;
            m2 = 0.8;
            Z = [30*pi/180, 0, 20*pi/180, 0.2];
            %
            load('Ze2.mat', 'Ze');
            load('te2.mat', 'te');
            %
        case 3
            k = 10;
            l1 = 0.9;
            l2 = 1.5;
            m1 = 1.5;
            m2 = 1.2;
            Z = [45*pi/180, 0.1, 35*pi/180, 0.1];
            %
            load('Ze3.mat', 'Ze');
            load('te3.mat', 'te');
            %
        case 4
            k = 10;
            l1 = 1.5;
            l2 = 1.2;
            m1 = 2.0;
            m2 = 1.5;
            Z = [90*pi/180, 0.2, 45*pi/180, 0.2]; 
            %
            load('Ze4.mat', 'Ze');
            load('te4.mat', 'te');
            %
        case 5
            k = 50;
            l1 = 1.1;
            l2 = 0.9;
            m1 = 1.0;
            m2 = 1.0;
            Z = [60*pi/180, 0, 60*pi/180, 0.3];  
            %
            load('ze5.mat', 'Ze');
            load('te5.mat', 'te');
            %
        case 6
            k = 50;
            l1 = 1.3;
            l2 = 1.6;
            m1 = 1.5;
            m2 = 1.2;
            Z = [75*pi/180, 0.1, 50*pi/180, 0.4];
            %
            load('Ze6.mat', 'Ze');
            load('te6.mat', 'te');
            %
        case 7          % Nuove condizioni iniziali
            k = 50;
            l1 = 1.0;
            l2 = 1.1;
            m1 = 1.1;
            m2 = 1.1;
            Z = [25*pi/180, 0, 30*pi/180, 0.5];
            %
            load('Ze7.mat', 'Ze');
            load('te7.mat', 'te');
            %
        case 8          % Nuove condizioni iniziali 
            k = 50;
            l1 = 1.0;
            l2 = 1.0;
            m1 = 1.0;
            m2 = 1.0;
            Z = [30*pi/180, 0, -10*pi/180, 0.5];
            %
            load('Ze8.mat', 'Ze');
            load('te8.mat', 'te');
            %
        case 9          % T7 del file "2024 Parameters ODE Project.xlsx"
            k = 50;
            l1 = 1.0;
            l2 = 1.0;
            m1 = 1.0;
            m2 = 1.0;
            Z = [25*pi/180, 0, 30*pi/180, 0.5];
            %
            load('Ze9.mat', 'Ze');
            load('te9.mat', 'te');
    end
end