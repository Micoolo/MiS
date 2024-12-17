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
czas = 200000;    
czas_skok = 20000;
dU = 1;          

[t] = sim('rowFaz_schemat', czas);

% Wykres
figure;
plot(t, aX, 'r', 'LineWidth', 2), grid on;
title('Odpowiedź układu w stanie ustalonym');
xlabel('Czas [s]');
ylabel('x(t)');

%jak jest kanciaste to zmienic max step size
