load('dcm_spont')
spont = DCM;
clear DCM

load('dcm_seiz')
seiz = DCM;
clear DCM

%%

G = zeros(2);
T = zeros(2);

G(1,1)  = spont.Ep.G(1);
G(1,2)  = spont.Ep.G(2);
G(2,1)  = seiz.Ep.G(1);
G(2,2)  = seiz.Ep.G(2);
% G = exp(G);

T(1,1)  = spont.Ep.T(1);
T(1,2)  = spont.Ep.T(2);
T(2,1)  = seiz.Ep.T(1);
T(2,2)  = seiz.Ep.T(2);
% T = exp(T);

T(:,1)  = T(:,1)/T(1,1);
T(:,2)  = T(:,2)/T(1,2);
G(:,1)  = G(:,1)/G(1,1);
G(:,2)  = G(:,2)/G(1,2);

subplot(1,2,1)
plot(G(:,1),'k', 'LineWidth', 1.5); hold on
plot(G(:,2),'r', 'LineWidth', 1.5)
axis square
axis([1 2 0 2.5]);
set(gca, 'XTickLabel', '')

subplot(1,2,2)
plot(T(:,1),'k', 'LineWidth', 1.5); hold on
plot(T(:,2),'r', 'LineWidth', 1.5)
axis square
axis([1 2 0 2.5]);
set(gca, 'XTickLabel', '')
set(gcf, 'color', 'w');