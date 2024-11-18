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
Tzew0 = TzewN + 0;
Fp0 = FpN * 1.0;
Pg0 = PgN * 1.0;

%stan rownowagi
%Twew0 = Tzew0 + (Pg0 / ((Kw*Ks)/(Kw + Ks)) + (cpp*rop*Fp0));
Twew0 = (Pg0 + Tzew0*(cpp*rop*Fp0 + ((Ks*Kw)/(Kw + Ks)))) / (cpp*rop*Fp0 + ((Kw * Ks)/(Kw + Ks)));
Ts0 = (Kw*Twew0 + Ks*Tzew0) / (Kw + Ks);


%======CZESC 3======
%symulacje
czas = 50000; %czas symulacji
%zaklocenie
czas_skok = 5000;
dTzew = 1;
dFp = 0;
dPg = 0;

%symulacja
[t] = sim('lab1Sim', czas);

%wykresy
figure, plot(t, aTwew, 'r'), grid on, title('Reakcja Twew na skok Tzew');
figure, plot(t, aTs, 'r'), grid on, title('Reakcja Ts na skok Tzew');

