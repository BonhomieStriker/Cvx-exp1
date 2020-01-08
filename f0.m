function f0 = f0(img,type)

f0 = 0;
h = size(img,1);
w = size(img,2);

% c = 0.614; %optimal
% d = 1 - c;

a = 1;
% b = 1;
b = 2.325; % optimal
c = 1;
d = 1;
% rho = 0.0;
e = 1;
f = 1;
g = 1;
h = 1;

diffa = img(1:h - 1, 1:w - 1) - img(1:h - 1, 2:w); %leftup - right
diffaa = img(1:h - 2, 1:w - 2) - 2 * img(1:h - 2, 2:w - 1) + img(1:h - 2, 3:w);

diffb = img(1:h - 1, 1:w - 1) - img(2:h, 1:w - 1); %leftup - down
diffbb = img(1:h - 2, 1:w - 2) - 2 * img(2:h - 1, 1:w - 2) + img(3:h, 1:w - 2);

diffc = img(2:h, 2:w) - img(1:h - 1, 2:w); %rightdown - up
diffcc = img(3:h, 3:w) - 2 * img(2:h - 1, 3:w) + img(1:h - 2, 3:w);

diffd = img(2:h, 2:w) - img(2:h, 1:w - 1); %rightdown - left
diffdd = img(3:h, 3:w) - 2 * img(3:h, 2:w - 1) + img(3:h, 1:w - 2);

if type == 0
%     f0 = a * norm(diffa, inf) + b * norm(diffb, inf) + c * norm(diffc, inf) + d * norm(diffd, inf) + rho * norm(img, inf); 
%     f0 = a * norm(diffa, inf) + b * norm(diffb, inf) + c * norm(diffc, inf) + d * norm(diffd, inf);
    f0 = a * norm(diffa, inf) + b * norm(diffb, inf) + c * norm(diffc, inf) + d * norm(diffd, inf) + e * norm(diffaa, inf) + f * norm(diffbb, inf) + g * norm(diffcc, inf) + h * norm(diffdd, inf); 
%     f0 = c * norm(diffc, inf) + d * norm(diffd, inf); 
elseif type == 1  
%     f0 = a * norm(diffa, 1) + b * norm(diffb, 1) + c * norm(diffc, 1) + d * norm(diffd, 1) + rho * norm(img, 1); 
%     f0 = a * norm(diffa, 1) + b * norm(diffb, 1) + c * norm(diffc, 1) + d * norm(diffd, 1);
    f0 = a * norm(diffa, 1) + b * norm(diffb, 1) + c * norm(diffc, 1) + d * norm(diffd, 1) + e * norm(diffaa, 1) + f * norm(diffbb, 1) + g * norm(diffcc, 1) + h * norm(diffdd, 1); 
%     f0 = c * norm(diffc, 1) + d * norm(diffd, 1);   
elseif type == 3
%     f0 = a * norm(diffa, 'fro') + b * norm(diffb, 'fro') + c * norm(diffc, 'fro') + d * norm(diffd, 'fro') + rho * norm(img, 'fro');
%     f0 = a * norm(diffa, 'fro') + b * norm(diffb, 'fro') + c * norm(diffc, 'fro') + d * norm(diffd, 'fro');
    f0 = a * norm(diffa, 'fro') + b * norm(diffb, 'fro') + c * norm(diffc, 'fro') + d * norm(diffd, 'fro') + e * norm(diffaa, 'fro') + f * norm(diffbb, 'fro') + g * norm(diffcc, 'fro') + h * norm(diffdd, 'fro'); 
%     f0 = c * norm(diffc, 'fro') + d * norm(diffd, 'fro'); 
end

        
