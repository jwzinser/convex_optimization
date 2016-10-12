%Final Exam 2
% Designing an optimal image system
% Run this code to generate D, G, & E.
% You need not understand how these matrices are constructed.

L = 20; % number of wavelengths
M = 10; % number of diodes
N = 6; % number of LEDs

% This defines 20 discrete wavelengths
wavelength = 380:20:760; %(nm)

% Define the vectors of cone responsiveness
% Cone sensitivies for wavelengths in the visible range.  This data is 
%  based on a graph on page 93 in Wandell's "Foundations of Vision" 
L_cone_log = [-.9 -1.1 -1 -.8 -.7 -.6 -.5 -.4 -.3 -.25 -.3  -.4 -.8 -1.2 -1.6 -1.9 -2.4 -2.8 -3.6 -4];

M_cone_log = [-.8 -.85 -.85 -.6 -.5 -.4 -.3 -.2 -.1 -.15 -.3  -.7 -1.2 -1.7 -2.2 -2.9 -3.5 -4.2 -4.8 -5.5];

S_cone_log = [-.4 -.3 -.2 -.1 -.3 -.6 -1.2 -1.8 -2.5 -3.2  -4.1 -5 -6  -7 -8 -9 -10 -10.5 -11 -11.5];

% Raise everything to the 10 power to get the actual responsitivies.  
% These vectors contain the coefficients l_i, m_i, and s_i described in the 
% problem statement from shortest to longest wavelength. 
L_coefficients = 10.^(L_cone_log);
M_coefficients = 10.^(M_cone_log);
S_coefficients = 10.^(S_cone_log);

% Plot the cone responsiveness. 
if 0
    figure(1);
    plot(wavelength,L_cone_log,'-*')
    hold;
    plot(wavelength,M_cone_log,'--x');
    plot(wavelength,S_cone_log,'-o')
    xlabel('Light Wavelength (nm)');
    ylabel('Log Relative Sensitivity');
    legend('L cones', 'M cones', 'S cones');
    title('Approximate Human Cone Sensitivities');
    grid;
end

% put cone responsiveness into matrix E
E = [L_coefficients;M_coefficients;S_coefficients]';

% This defines the responsiveness of the camera diodes
% Response decays exponentially for wavelengths lower than the bandgap
exp_decay = exp(-linspace(0,1,L))';
D = zeros(L,M);
skip = 2;
for i=1:M
    D(:,i) = [zeros(skip*i-1,1); exp_decay(1:L-skip*i+1)];
end
D = flipud(D);
    
% This defines the responsiveness of the projector LEDs
% data taken from http://softsolder.com/2010/03/21/spectral-characteristics-the-graph/
% Blue LED,Green LED,Orange LED,Red LED,Violet LED,Yellow LED;
G = [0.11,0.0,0.0,0.0,0.0,0.0;
0.9,0.0,0.0,0.0,0.0,0.0;
0.33,0.02,0.0,0.0,0.0,0.0;
0.05,0.92,0.0,0.0,0.0,0.0;
0.0,0.77,0.0,0.0,0.0,0.0;
0.0,0.11,0.0,0.0,0.0,0.0;
0.0,0.0,0.0,0.0,0.0,0.0;
0.0,0.0,0.0,0.0,0.0,0.0;
0.0,0.0,0.08,0.0,0.0,0.0;
0.0,0.0,0.95,0.13,0.0,0.0;
0.0,0.0,0.37,0.96,0.08,0.0;
0.0,0.0,0.11,0.6,0.8,0.13;
0.0,0.0,0.0,0.2,0.8,0.6;
0.0,0.0,0.0,0.0,0.3,0.9;
0.0,0.0,0.0,0.0,0.1,0.43;
0.0,0.0,0.0,0.0,0.0,0.2;
0.0,0.0,0.0,0.0,0.0,0.0;
0.0,0.0,0.0,0.0,0.0,0.0;
0.0,0.0,0.0,0.0,0.0,0.0;
0.0,0.0,0.0,0.0,0.0,0.0];

cvx_begin
variable P(N,M)
minimize (norm(E'-E'*G*P*D'))
subject to 
P>=0
cvx_end

%%
%With small number of LEDs and photodiodes
cvx_begin
variable Ps(N,M)
minimize norm(Ps'*ones(N,1),1)+norm(Ps*ones(M,1),1)
subject to
norm(E'-E'*G*Ps*D')<=1
Ps>=0
cvx_end

spy(abs(Ps)>.01)

