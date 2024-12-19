clear all;
close all;

%======CZESC 1======
%wartosci nominalne
TzewN = -20;            %C
TwewN = 20;             %C
TsN = 15;               %temperatura scian
PgN = 8000;             %W
Vw = 2.5*50;            %objetosc pokoju
Vs = 0.1*30*2.5;        %objetosc scian
cpp = 1000; rop = 1.2;  %powietrze (cieplo wlasciwe, gestosc)
cps = 880; ros = 1400;  %sciana

%identyfikacja parametrow statycznych
a = 2;
FpN = Vw/(3600/a);
Px = PgN - (cpp*rop*FpN*(TwewN - TzewN));
Kw = Px/(TwewN - TsN);
Ks = Px/(TsN - TzewN);

%parametry dynamiczne
Cvw = (cpp * rop * Vw);
Cvs = (cps * ros * Vs);

%======CZESC 2======
%warunki poczatkowe
Tzew0 = TzewN;
Fp0 = FpN * 1.0;
Pg0 = PgN * 1.0;

%======CZESC 3 (symulacje)======
czas = 100000; %czas symulacji
%zaklocenia
czas_skok = 20000;
dTzew = 1;
dFp = 0;
dPg = 0.1 * Pg0; 

Twew0 = (Pg0 + Tzew0*(cpp*rop*Fp0 + ((Ks*Kw)/(Kw + Ks)))) / (cpp*rop*Fp0 + ((Kw * Ks)/(Kw + Ks)));
Ts0 = (Kw*Twew0 + Ks*Tzew0) / (Kw + Ks);

%regulator
CV0 = Pg0;
dSP = 0;
SP0 = Twew0;
SP = SP0 + dSP;


k = 4 / dPg;
T = 6.65 * 10000 - czas_skok ;
T0 = 0.1 * T;

Kp = 0.9 * T / (k*T0);
Ti = 3.33 * T0;

[t] = sim('lab2Sim', czas);

%wykresy
figure, plot(t, Twew, 'r'), grid on, hold on, title('PV (Twew), dTzew = 1'), ylim([19.99 20.05]);
figure, plot(t, Pg, 'r'), grid on, hold on, title('CV (Pg), dTzew = 1'), ylim([7750 8050]);

