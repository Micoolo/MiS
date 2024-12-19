clear all;
close all;

%======CZESC 1======
%wartosci nominalne
wn = 5;
ksi = 0.2;

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
title('Reakcja na skok, \xi = 0.2');

%======CZESC 2======
%warunki poczatkowe
U0 = 0;   
X0 = [1, -3, -2];   
Xp0 = [5, 6, -5]; 

%======CZESC 3 (symulacje)======
dU = 0;  

figure; hold on; grid on;

for i = 1:length(X0)
    simOut = sim('rowFaz_schemat', czas);
    plot(aX, aXp, 'LineWidth', 1.5);
end

title('Portret fazowy, \xi = 0.2');
xlabel('x');
ylabel('x''');