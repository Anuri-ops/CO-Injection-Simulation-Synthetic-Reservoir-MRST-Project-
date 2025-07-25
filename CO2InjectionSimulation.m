mrstModule add ad-core ad-blackoil mrst-gui

G = cartGrid([60, 40], [600, 400]);  % 10x10m cells
G = computeGeometry(G);

rock.poro = 0.2 * ones(G.cells.num, 1);
rock.perm = 100 * milli*darcy * ones(G.cells.num, 1);

fluid = initSimpleADIFluid('phases', 'WOG', ...
    'mu', [1, 5, 0.05]*centi*poise, ...   % water, oil, gas (CO2)
    'rho', [1000, 700, 600], ...         % density [water, oil, CO2]
    'n', [2, 2, 2]);

state0 = initResSol(G, 100*barsa, [0 1 0]);  % [Sw So Sg]

W = [];

% Injector (CO2) at top-left
W = addWell(W, G, rock, [1, 1], ...
    'Type', 'rate', 'Val', 100*meter^3/day, ...
    'Comp_i', [0 0 1], 'Name', 'CO2_Injector');

% Producer at bottom-right
W = addWell(W, G, rock, [60, 40], ...
    'Type', 'bhp', 'Val', 50*barsa, ...
    'Comp_i', [0 1 0], 'Name', 'Producer');

T = 100*day;
n = 10;
dT = repmat(T/n, [1, n]);

schedule = simpleSchedule(dT, 'W', W);

model = ThreePhaseBlackOilModel(G, rock, fluid, 'gas', true);

[~, states] = simulateScheduleAD(state0, model, schedule);

for i = 1:numel(states)
    clf;
    plotCellData(G, states{i}.s(:,3));  % gas saturation
    title(['CO₂ Saturation at Time Step ', num2str(i)]);
    colorbar;
    drawnow;
end
