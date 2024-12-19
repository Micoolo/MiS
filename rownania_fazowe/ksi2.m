clear all;
close all;

%======CZESC 1======
%wartosci nominalne
wn = 5;
ksi = 2;

%======CZESC 2======
%warunki poczatkowe
U0 = 5;          
X0 = U0;         
Xp0 = 0;         

%======CZESC 3 (symulacje)======
czas = 10;    
czas_skok = 1;
dU = 1;          

[t] = sim('rowFaz_schemat', czas);

% Wykres
figure;
plot(t, aX, 'r', 'LineWidth', 2), grid on;
title('Reakcja na skok, \xi = 2');

%======CZESC 2======
%warunki poczatkowe
U0 = 0;       

%======CZESC 3 (symulacje)======
czas = 10;    
czas_skok = 1;
dU = 0;          

% Warunki początkowe
X0 = [1, -3, -5, 5, 2, -2];   % różne położenia początkowe
Xp0 = [5, 6, 4, -5, -7, -6]; % różne prędkości początkowe

figure; hold on; grid on;

% Symulacja dla różnych warunków początkowych
for i = 1:length(X0)
    
    % Uruchomienie modelu Simulinka
    simOut = sim('rowFaz_schemat', czas);
    
    % Wykres portretu fazowego
    plot(aX, aXp, 'LineWidth', 1.5);
end

% Oznaczenia wykresu
title('Portret fazowy, \xi =2');
xlabel('x');
ylabel('x''');