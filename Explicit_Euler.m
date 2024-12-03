%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
clc 
clear
close all
%
%% METODO DI EULERO ESPLICITO
%
% Variabili globali
global k g l1 m1 l2 m2 te NMAXe Ze j;
indice = 1;
%
% Definizione del problema
t0      = 0;                           % Tempo iniziale
tend    = 20;                          % Tempo finale
Z0      = impostaParametri(indice);    % Condizione iniziale
%
% Discretizzazione
dt      = 0.001;                       % Time step, deve essere un divisore di tend
NMAX    = tend/dt;                     % Numero massimo di time steps 
t       = zeros(1,NMAX+1);
Z       = zeros(NMAX+1,4);
t(1)    = t0;                          % Primo tempo 
Z(1,:)  = Z0;                          % Primo elemento del vettore soluzione 
%
%
% Controllo monotonia: una volta sola
Jf        = df(t(1), Z(1,:)');         % Jacobiana alla condizione iniziale
autovalJf = eig(Jf);                   % Calcolo degli autovalori
limite    = max(abs(autovalJf));       % Maggior valore assoluto degli autovalori
%
if dt > 1/limite
    error(['Violazione della monotonia: il passo temporale dt = ', num2str(dt), ...
           ' supera il limite massimo consentito dt = ', num2str(1/limite)]);
end
%
for n = 1:NMAX
    if (t(n)+dt>tend)
        dt = tend-t(n);
    end
    if (t(n)>=tend)
        break
    end
    %
    % Metodo di Eulero esplicito
    Z(n+1,:) = Z(n,:) + dt * f( t(n),Z(n,:) );
    %
    % Conservazione dell'energia totale (L=T+Uk+Ug)
    T(n,1)  = 0.5*(l1^2)*(Z(n,2)^2) + 0.5*(l2^2)*(Z(n,4)^2);
    Ug(n,1) = m1*g*l1*(1-cos(Z(n,1))) + m2*g*l2*(1-cos(Z(n,3)));
    Uk(n,1) = 0.5*k*( l2*sin(Z(n,3)) - l1*sin(Z(n,1)) )^2;
    L(n,1)  = T(n,1) + Uk(n,1) + Ug(n,1);
    %
    % Aggiornamento del tempo
    t(n+1) = t(n) + dt; 
    % 
end
%
%% CALCOLO DELL'ERRORE
%
err      = [0,0,0,0];          % Inizializzazione dell'errore
rapporto = j/n;                % Impongo che sia un numero intero positivo
%
for n = 1:NMAX                 % Faccio scorrere l'indice n
    j = (n-1)*rapporto+1;      % Calcolo j per il quale so che dt=dte
    if j > NMAXe               % Controllo che j sia dentro il dominio
        break
    end
    % Calcolo gli errori
    err = err + (t(n+1) - t(n)) * ((Z(n,:) - Ze(j,:))).^2;
end
%
% Calcolo della radice quadrata dell'errore accumulato
err = sqrt(err);
fprintf('Errori: \n θ1: %e\n ω1: %e\n θ2: %e\n ω2: %e\n', err(1), err(2), err(3), err(4));
%
%% GRAFICI
%
% Grafico della variazione degli angoli dei due pendoli (theta1 e theta2)
figure('Name','Simulazione con metodo di Eulero');
subplot(2,1,1)
plot(t,Z(:,1),'b-', t,Z(:,3),'r-')
hold on 
xlabel('Tempo (s)');
ylabel('Angolo (rad)');
legend('\theta_1', '\theta_2')
title(['Angoli nel tempo - test ', num2str(indice)]);
%
% Grafico della variazione delle velocità angolari dei due pendoli (omega1 
% e omega2)
subplot(2,1,2)
plot(t,Z(:,2),'b-', t,Z(:,4),'r-')
hold on 
xlabel('Tempo (s)');
ylabel('Velocità angolare (rad/s)');
legend('\omega_1', '\omega_2')
title(['Velocità angolari nel tempo - test ', num2str(indice)]);
%
% Grafico della conservazione dell'energia totale (L=T+Ug+Uk)
figure('Name','Conservazione dell''energia');
plot(t(1:end-1),L(:,1),'b-', t(1:end-1),Uk(:,1),'r-', t(1:end-1),Ug(:,1),'g-', t(1:end-1),T(:,1),'k-')
hold on 
xlabel('Tempo (s)');
ylabel('Energia (J)');
legend('L', 'U_k', 'U_g', 'T')
title(['Conservazione dell''energia - test ', num2str(indice)]);
%
fprintf('Energia totale iniziale: %e\n', L(1));
fprintf('Energia totale finale: %e\n', L(end));
%
% Confronto tra la soluzione esatta di RK4 e la soluzione di Eulero
figure('Name','Confronto tra gli angoli');
plot(t,Z(:,1),'b--', t,Z(:,3),'r--', te,Ze(:,1),'b-', te,Ze(:,3),'r-');
hold on 
xlabel('Tempo (s)');
ylabel('Angolo (rad)');
legend('\theta_1 E', '\theta_2 E', '\theta_1 RK4e', '\theta_2 RK4e')
title(['Confronto angoli - test ', num2str(indice)])
%
% Movimento del pendolo accoppiato
% Calcolo delle coordinate dei pendoli nel sistema cartesiano
% https://it.mathworks.com/help/symbolic/animation-and-solution-of-double-pendulum.html
% 
x1 = l1*sin(Z(:, 1));
y1 = -l1*cos(Z(:, 1));
x2 = 2 + l2*sin(Z(:, 3));
y2 = -l2*cos(Z(:, 3));
%
figure('Name','Animazione 2D');
hold on;
%
% Definizione delle caratteristiche del grafico 
% https://it.mathworks.com/help/matlab/ref/axis.html#buk989s-1-limits
axis equal;
% axis off;
axis([-2 4 -2.5 2.5]);    % Limiti per gli assi
xlabel('x');
ylabel('y');
title(['Animazione del pendolo accoppiato - test ', num2str(indice)])
timer = text(1,1.5,'Timer: 0',...
     'HorizontalAlignment','center',...
     'VerticalAlignment','top','FontSize',12);
frame   = 30;              % Frame al secondo
animazione = 1 / frame;    % Tempo per ogni frame
% Posizioni iniziali
massa1 = plot(x1(1), y1(1), 'bo', 'MarkerSize', m1*10, 'MarkerFaceColor', 'b');
asta1  = plot([0 x1(1)], [0 y1(1)], 'b-');
massa2 = plot(x2(1), y2(1), 'ro', 'MarkerSize', m2*10, 'MarkerFaceColor', 'r');
asta2  = plot([2 x2(1)], [0 y2(1)], 'r-');
% Molla
molla     = plot(nan, nan, 'k-', 'LineWidth', 1.5);
n_points  = 50;         % Numero di punti per rappresentare la molla
n_waves   = 10;         % Numero di ondulate della molla
amplitude = 0.1;        % Ampiezza delle ondulate
% Loop per creare l'animazione
for ii = 1:frame:NMAX
    % Aggiornamento delle posizioni dei pendoli
    set(massa1, 'XData', x1(ii),     'YData', y1(ii));
    set(asta1,  'XData', [0 x1(ii)], 'YData', [0 y1(ii)]);
    set(massa2, 'XData', x2(ii),     'YData', y2(ii));
    set(asta2,  'XData', [2 x2(ii)], 'YData', [0 y2(ii)]);
    % Direzione del vettore tra le masse
    dx = x2(ii) - x1(ii);
    dy = y2(ii) - y1(ii);
    L  = sqrt(dx^2 + dy^2);   % Lunghezza tra le masse
    ux = -dy / L;             % Versore perpendicolare x
    uy = dx / L;              % Versore perpendicolare y
    % Coordinate lineari della molla
    molla_x = linspace(x1(ii), x2(ii), n_points);
    molla_y = linspace(y1(ii), y2(ii), n_points);
    % Oscillazione sinusoidale per la molla
    oscillation = amplitude * sin(linspace(0, n_waves * 2 * pi, n_points));
    molla_x = molla_x + ux * oscillation;    
    molla_y = molla_y + uy * oscillation;   
    % Aggiorna il grafico della molla
    set(molla, 'XData', molla_x, 'YData', molla_y);
    % Aggiorno il timer
    set(timer, 'String', ['Timer: ', num2str(t(ii), '%.2f')]);
    % Pausa per mantenere la velocità dell'animazione
    pause(animazione);
end
hold off;
%