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

%======CZESC 3 (symulacje)======
czas = 250000; %czas symulacji
%zaklocenia
czas_skok = 10000;
dTzew = 1;
dFp = 0;
dPg = 0; 


tab_Tzew = [TzewN, TzewN + 10, TzewN + 10];
tab_Ts = [PgN, PgN, PgN * 0.8];
fig1 = figure(); hold on, grid on;
fig2 = figure(); hold on, grid on;
fig3 = figure(); hold on, grid on;
fig4 = figure(); hold on, grid on;
kolor = ['r', 'g', 'b', 'c', 'm'];

for i = 1:length(tab_Tzew)
    Tzew0 = tab_Tzew(i);
    Pg0 = tab_Ts(i);

    Twew0 = (Pg0 + Tzew0*(cpp*rop*Fp0 + ((Ks*Kw)/(Kw + Ks)))) / (cpp*rop*Fp0 + ((Kw * Ks)/(Kw + Ks)));
    Ts0 = (Kw*Twew0 + Ks*Tzew0) / (Kw + Ks);

    out = sim('lab1Sim', czas);
    Twew_przesuniete = out.Twew - out.Twew(i);
    Ts_przesuniete = out.Ts - out.Ts(i);

    figure(fig1), hold on, grid on, plot(out.tout, out.Twew, kolor(i), "linewidth", 2), title('Reakcja Twew na skok dTzew = 1'), legend('TzewN, PgN', 'TzewN + 10, PgN', 'TzewN + 10, 80%PgN');
    figure(fig2), hold on, grid on, plot(out.tout, out.Ts, kolor(i), "linewidth", 2), title('Reakcja Ts na skok dTzew = 1'), legend('TzewN, PgN', 'TzewN + 10, PgN', 'TzewN + 10, 80%PgN');
    figure(fig3), hold on, grid on, plot(out.tout, Twew_przesuniete, kolor(i), "linewidth", 8-2*i), title('Porownanie reakcji Twew dla wszystkich punktow pracy'), legend('TzewN, PgN', 'TzewN + 10, PgN', 'TzewN + 10, 80%PgN');
    figure(fig4), hold on, grid on, plot(out.tout, Ts_przesuniete, kolor(i), "linewidth", 8-2*i), title('Porownanie reakcji Ts dla wszystkich punktow pracy'), legend('TzewN, PgN', 'TzewN + 10, PgN', 'TzewN + 10, 80%PgN');
    

end


%zrobic jeszcze 4 takie wykresy jak tutaj tylko wylaczamy skok temperatury
%i uastawiamy skok mocy np o 10%
