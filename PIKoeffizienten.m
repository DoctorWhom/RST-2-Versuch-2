function [K, Kp, Ki] = PIKoeffizienten( sys, lambdawunsch, s0)
%PIKoeffizienten: Berechne Reglerparameter K, Kp, Ki des PI-Zustandsreglers

Aquer = [vertcat(sys.A,-sys.C) zeros(size(sys.A,1) + size(sys.C,1), 1)];
Bquer = [sys.B;0];

Kquer = -place(Aquer, Bquer, lambdawunsch);

Kp = -1/(sys.C*((sys.B * Kquer(1:size(sys.A,1)) + sys.A)^-1)*sys.B);

Ki = Kquer(end);

if nargin == 3
    Kp = -Ki/s0;
end

K = Kquer(1:size(sys.A,1)) + Kp * sys.C;


end

