clc;
clear all;

N = 50; % numarul de coeficienti
D = 13; % durata
P = 40; % perioada
F=1/P; % frecventa 
w0=2*pi/P; % pulsatia
t=0:0.02:P-0.02; % timpul pe care calculam integrala (o perioada); 
                 % rezolutia temporala trebuie sa fie de 2 ori mai mica decat perioada semnalului conform teoremei esantionarii;
                 
% semnalul dreptungiular
x = zeros(1,size(t,2)); 
x(t<=D) =1; % de la 0 la D x are valoarea 1 si in rest are valoarea 0
t_4 = 0:0.02:4*P-0.02; % vectorul de timp 
x_4 = repmat(x,1,4); % vectorul x care reprezinta semnalul pe 4 perioade 

   
% integrala numerica prin functia trapz
for k = -N:N
    x_temp = x;
    x_temp = x_temp.*exp(-j*k*w0*t); % vectorul inmultit cu termenul corespunzator
    X(k+51) = trapz(t,x_temp); % trapz calculeaza integrala prin metoda trapezului 
end

x_refacut(1:length(t)) = 0; % initializarea semnalului reconstruit cu 0

%reconstructia lui x(t)
for index = 1:length(t);
    for k = -N:N
        x_refacut(index) = x_refacut(index) + (1/P)*X(k+N+1)*exp(j*k*w0*t(index));
    end
end

figure(1);
plot(t_4,x_4); % afisarea lui x(t)
title('semnalul original si cel reconstruit');
hold on
x_refacut = repmat(x_refacut,1,4); % generarea lui x reconstruit pentru 4 perioade
plot(t_4,x_refacut,'--'); % afisarea lui x reconstruit pentru 4 perioade
xlabel('Timp [s]');
ylabel('Amplitudine');
legend('original','refacut')

f = -N*F:F:N*F; % generarea vectorului de frecvente
figure(2);
stem(f,abs(X)); % afisarea lui X
title('Spectrul lui x(t)');
xlabel('Frecventa [Hz]');
ylabel('abs(X)');

%
% Prin Seriile Fourier putem arata ca orice semnal periodic poate fi aproximat
% printr-o suma infinita de sin si cos.
% Coeficienti lui sin si cos reprezinta spectrul de amplitudini al
% semnalului.
% Semnalul refoacut se observa ca se aproprie ca forma de semnalul original
% dar are o anume eroare. Cu cat marim
% numarul de coeficienti cu atat aceasta  eroare va fi  mai mica. 