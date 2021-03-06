% RST 2 Versuch 2
load Modellparameter.mat

a = (Ke*Km)/(J * R) + mu / J;
b = (Km * V)/(J * R);

A = [0,1;0,-a];
B = [0;b];
C = [1,0];
%% Aufgabe 1

%c)
sigma = ss(A,B,C,0);
x0 = [2;-10];
t = 0:2e-3:10;
u = zeros (size(t));

[y,t,x] = lsim(sigma, u, t, x0);

plot(t,y,t, 2-10/a * (1-exp(-a*t)));
legend('Simulierte Position', 'Berechnete Position');

%d)
[x1,x2] = meshgrid(-2:0.2:2);
dx1 = x2;
dx2 = -2*x2;

figure;
quiver(x1,x2,dx1,dx2);

%e)
e = eig(A);

%% Aufgabe 2

%c)
%Überprüfung des Regelgesetzes

K = place(A,B,[-4,-5]);
Kberechnet = [20/b, 9/b-a/b];

%e)

f = -1/(C*(A + B*K)^-1 * B);

%g)

Re = [-4.9, -5.1, -5/2, -5/2, -2.9, -3.1, -3/2, -3/2, -0.4, -0.6];
Im = [0,0, sqrt(3)*5/2, -sqrt(3)*5/2,0,0, sqrt(3)*3/2, -sqrt(3)*3/2,0,0];
lambda = complex(Re, Im);

figure;
plot(lambda, 'o');
sgrid;

sys = zpk([],lambda, 1);
[Wn,damping] = damp(sys);

%% Aufgabe 3.3
%b)
test = ss([0,1;-1.5,3],[0;1],[1,1],0);
[~, ~, ~] = PIKoeffizienten(test,[-3.1,-3.0,-2.9]);

%c)
pwunsch = [-2.1,-2,-1.9];
[K,Kp,Ki] = PIKoeffizienten(sigma, pwunsch);

%d)
s = tf('s');
cpi = Kp + Ki/s;
s0 = zero(cpi);

figure;
pkplx = complex(pwunsch);
s0kplx = complex(s0);
plot(real(pkplx),imag(pkplx), 'x',real(s0kplx),imag(s0kplx),'o');

%e)
[K2, Kp2, Ki2] = PIKoeffizienten(sigma, pwunsch, -10);


%% Aufgabe 3.4

M = 25*pi;
Tp = 10;
t = 0:0.2:2*Tp;

ystern = M/2 * (1 - cos(4*pi*t/Tp));
dydx = 4*pi/Tp * sin(4*pi*t/Tp);
d2ydx2 = (4*pi/Tp)^-2 * cos(4*pi*t/Tp);

[x1stern,x2stern,ustern] = trajectorystates(t,ystern,dydx,d2ydx2);

x1ber = ystern;
x2ber = dydx;

uber = 1/b * (a * M / 2 + (16*pi^2 / Tp^2 - a*M/2)*cos(4*pi*t/Tp));


plot(t,x1stern, t, x1ber);
figure;
plot(t,x2stern, t, x2ber);
figure;
plot(t,ustern,t,uber);
legend('u aus der Funktion', 'u analytisch berechnet');