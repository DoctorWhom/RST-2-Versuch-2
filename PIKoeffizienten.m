function [K, Kp, Ki] = PIKoeffizienten( sys, lambdawunsch )
%PIKoeffizienten: Berechne Reglerparameter K, Kp, Ki des PI-Zustandsreglers

Aquer = [vertcat(sys.A,-sys.C) zeros(size(sys.A,1) + size(sys.C,1), 1)];
Bquer = [sys.B;0];

Kquer = -place(Aquer, Bquer, lambdawunsch);

Kp = -1/(sys.C*((sys.B * Kquer(1:size(sys.A,1)) + sys.A)^-1)*sys.B);

K = Kquer(1:size(sys.A,1)) + Kp * sys.C;

Ki = Kquer(end);

end

