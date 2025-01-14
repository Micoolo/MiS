clear all;
close all;

% ====== CZĘŚĆ 1 ======
% Parametry modelu logistycznego
r = 0.1;      % współczynnik wzrostu (r)
K = 15;      % pojemność środowiska (K)

% ====== CZĘŚĆ 2 ======
% Warunki początkowe
N0 = [10];  % różne wartości początkowe populacji (N(0))
czas = 5;           % czas symulacji

% ====== CZĘŚĆ 3 (symulacje dla różnych wartości początkowych) ======
figure; hold on; grid on;

for i = 1:length(N0)
    simOut = sim('logistyczny_schemat', czas);
    plot(czas, aN, 'LineWidth', 1.5);
end

title('Portret fazowy modelu logistycznego');
xlabel('');
ylabel('');
legend(cellstr(num2str(N0', 'N0 = %.0f')));
