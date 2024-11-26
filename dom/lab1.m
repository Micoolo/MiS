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
Cvw = cpp * rop * Vw;
Cvs = cps * ros * Vs;

%======CZESC 2======
%warunki poczatkowe
Tzew0 = TzewN;
Fp0 = FpN * 1.0;
Pg0 = PgN * 1.0;

%stan rownowagi
Twew0 = (Pg0 + Tzew0*(cpp*rop*Fp0 + ((Ks*Kw)/(Kw + Ks)))) / (cpp*rop*Fp0 + ((Kw * Ks)/(Kw + Ks)));
Ts0 = (Kw*Twew0 + Ks*Tzew0) / (Kw + Ks);


%======CZESC 3 (symulacje)======
czas = 250000; %czas symulacji
%zaklocenia
czas_skok = 10000;
dTzew = 1;
dFp = 0;
dPg = 0;

%symulacja
%out = sim('lab1Sim', czas);

%punkty pracy
Tzew0 = TzewN; Pg0 = PgN; Fp0 = FpN;
%stan rownowagi
Twew0 = (Pg0 + Tzew0*(cpp*rop*Fp0 + ((Ks*Kw)/(Kw + Ks)))) / (cpp*rop*Fp0 + ((Kw * Ks)/(Kw + Ks)));
Ts0 = (Kw*Twew0 + Ks*Tzew0) / (Kw + Ks);
out1 = sim('lab1Sim', czas);

Tzew0 = TzewN + 5; Pg0 = PgN * 0.7; Fp0 = FpN;
%stan rownowagi
Twew0 = (Pg0 + Tzew0*(cpp*rop*Fp0 + ((Ks*Kw)/(Kw + Ks)))) / (cpp*rop*Fp0 + ((Kw * Ks)/(Kw + Ks)));
Ts0 = (Kw*Twew0 + Ks*Tzew0) / (Kw + Ks);
out2 = sim('lab1Sim', czas);


Tzew0 = TzewN ; Pg0 = PgN * 1.3 ; Fp0 = FpN * 1.3;
%stan rownowagi
Twew0 = (Pg0 + Tzew0*(cpp*rop*Fp0 + ((Ks*Kw)/(Kw + Ks)))) / (cpp*rop*Fp0 + ((Kw * Ks)/(Kw + Ks)));
Ts0 = (Kw*Twew0 + Ks*Tzew0) / (Kw + Ks);
out3 = sim('lab1Sim', czas);

%figure, plot(out.tout, out.Twew, "linewidth", 2), ylim([18 22]), grid on, title('Twew');
%figure, plot(out.tout, out.Ts), ylim([14 17]), grid on, title('Ts');


figure;
hold on;
plot(out1.tout, out1.Twew, 'b', 'LineWidth', 2); % Wyniki dla punktu 1
plot(out2.tout, out2.Twew, 'r', 'LineWidth', 2); % Wyniki dla punktu 2
plot(out3.tout, out3.Twew, 'g', 'LineWidth', 2); % Wyniki dla punktu 3
ylim([13 24]);
grid on;
title('Twew dla różnych punktów pracy');
legend('Punkt 1: PgN, TzewN, FpN', 'Punkt 2: 70%PgN, TzewN+5, FpN', 'Punkt 3: 70%PgN, TzewN+5, 50%FpN');