%% UNIVERSITÀ DEGLI STUDI DI TRENTO
% Gruppo 6 - Bando, Faccin, Mounaddime, Rossato 
%
function dZdt = f(t,Z)
    %
    global k g l1 m1 l2 m2
    %
    % dZdt = (dtheta1, domega1, dtheta2, domega2)
    theta1 = Z(1);
    omega1 = Z(2);
    theta2 = Z(3);
    omega2 = Z(4);
    % Z = [theta1, omega1, theta2, omega2];
    %
    dtheta1 = omega1;
    domega1 = (k*l1*cos(theta1)*(l2*sin(theta2)-l1*sin(theta1))-m1*g*l1*sin(theta1))/(m1*(l1)^2);
    dtheta2 = omega2;
    domega2 = (-k*l2*cos(theta2)*(l2*sin(theta2)-l1*sin(theta1))-m2*g*l2*sin(theta2))/(m2*(l2)^2);
    dZdt = [dtheta1, domega1, dtheta2, domega2];
    %
end