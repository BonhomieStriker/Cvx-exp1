clear
close
clc

%% Image Preprocessing
I = imread('lena64color.tiff'); 
D = imread('lena32color.tiff');
U = uint8(zeros(size(I)));

for i = 2:2:size(U, 1)
    for j = 2:2:size(U, 2)
           U(i - 1, j - 1, :) = D(i / 2, j / 2, :);
    end        
end    
I2 = 255 * im2double(I);
D2 = 255 * im2double(D);

%% l1 - norm cvx-opt-model
U1 = zeros(64, 64, 3);
U11 = U1(:, :, 1);
U12 = U1(:, :, 2);
U13 = U1(:, :, 3);
% Channel R
cvx_begin
variables U11(64, 64);
minimize f0(U11, 1);
subject to
    U11 <= 255;
    U11 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           U11(i - 1, j - 1) == D2(i / 2, j / 2, 1);
        end
    end
cvx_end
% Channel G
cvx_begin
variables U12(64,64);
minimize f0(U12, 1);
subject to
    U12 <= 255;
    U12 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           U12(i - 1, j - 1) == D2(i / 2, j / 2, 2);
        end
    end
cvx_end
% Channel B
cvx_begin
variables U13(64,64);
minimize f0(U13, 1);
subject to
    U13 <= 255;
    U13 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           U13(i - 1, j - 1) == D2(i / 2, j / 2, 3);
        end
    end
cvx_end

%% l2 - norm cvx-opt-model
% U2 = zeros(64, 64, 3);
% U21 = U2(:, :, 1);
% U22 = U2(:, :, 2);
% U23 = U2(:, :, 3);
% % Channel R
% cvx_begin
% variables U21(64, 64);
% minimize f0(U21, 2);
% subject to
%     U21 <= 255;
%     U21 >= 0;
%     for i = 2:2:64
%         for j = 2:2:64
%            U21(i - 1, j - 1) == D2(i / 2, j / 2, 1);
%         end
%     end
% cvx_end
% % Channel G
% cvx_begin
% variables U22(64,64);
% minimize f0(U22, 2);
% subject to
%     U22 <= 255;
%     U22 >= 0;
%     for i = 2:2:64
%         for j = 2:2:64
%            U22(i - 1, j - 1) == D2(i / 2, j / 2, 2);
%         end
%     end
% cvx_end
% % Channel B
% cvx_begin
% variables U23(64,64);
% minimize f0(U23, 2);
% subject to
%     U23 <= 255;
%     U23 >= 0;
%     for i = 2:2:64
%         for j = 2:2:64
%            U23(i - 1, j - 1) == D2(i / 2, j / 2, 3);
%         end
%     end
% cvx_end
%% linf - norm cvx-opt-model
Uinf = zeros(64, 64, 3);
Uinf1 = Uinf(:, :, 1);
Uinf2 = Uinf(:, :, 2);
Uinf3 = Uinf(:, :, 3);
% Channel R
cvx_begin
variables Uinf1(64, 64);
minimize f0(Uinf1, 0);
subject to
    Uinf1 <= 255;
    Uinf1 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           Uinf1(i - 1, j - 1) == D2(i / 2, j / 2, 1);
        end
    end
cvx_end
% Channel G
cvx_begin
variables Uinf2(64,64);
minimize f0(Uinf2, 0);
subject to
    Uinf2 <= 255;
    Uinf2 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           Uinf2(i - 1, j - 1) == D2(i / 2, j / 2, 2);
        end
    end
cvx_end
% Channel B
cvx_begin
variables Uinf3(64,64);
minimize f0(Uinf3, 0);
subject to
    Uinf3 <= 255;
    Uinf3 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           Uinf3(i - 1, j - 1) == D2(i / 2, j / 2, 3);
        end
    end
cvx_end

%% Frobenius - norm cvx-opt-model
Uf = zeros(64, 64, 3);
Uf1 = Uf(:, :, 1);
Uf2 = Uf(:, :, 2);
Uf3 = Uf(:, :, 3);
% Channel R
cvx_begin
variables Uf1(64, 64);
minimize f0(Uf1, 3);
subject to
    Uf1 <= 255;
    Uf1 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           Uf1(i - 1, j - 1) == D2(i / 2, j / 2, 1);
        end
    end
cvx_end
% Channel G
cvx_begin
variables Uf2(64,64);
minimize f00(Uf2, 3);
subject to
    Uf2 <= 255;
    Uf2 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           Uf2(i - 1, j - 1) == D2(i / 2, j / 2, 2);
        end
    end
cvx_end
% Channel B
cvx_begin
variables Uf3(64,64);
minimize f000(Uf3, 3);
subject to
    Uf3 <= 255;
    Uf3 >= 0;
    for i = 2:2:64
        for j = 2:2:64
           Uf3(i - 1, j - 1) == D2(i / 2, j / 2, 3);
        end
    end
cvx_end

%% RGB composition & Plotting & Evaluation
% L1 - norm
U1(:, :, 1) = U11;
U1(:, :, 2) = U12;
U1(:, :, 3) = U13;
U1 = uint8(U1);

% % L2 - norm
% U2(:, :, 1) = U21;
% U2(:, :, 2) = U22;
% U2(:, :, 3) = U23;
% U2 = uint8(U2);

% Linf - norm
Uinf(:, :, 1) = Uinf1;
Uinf(:, :, 2) = Uinf2;
Uinf(:, :, 3) = Uinf3;
Uinf = uint8(Uinf);

% Frobenius - norm
Uf(:, :, 1) = Uf1;
Uf(:, :, 2) = Uf2;
Uf(:, :, 3) = Uf3;
Uf = uint8(Uf);

% Plot
figure(1)
subplot(2, 4, 1)
imshow(I)
title('Original Image I', 'fontsize', 20)
xlabel('Shape: 64*64*3', 'fontsize', 20)

subplot(2, 4, 2)
imshow(D)
title('Downsampled Image D', 'fontsize', 20)
xlabel('Shape: 32*32*3', 'fontsize', 20)

subplot(2, 4, 3)
imshow(U)
title('Pre - extended Image U', 'fontsize', 20)
xlabel({'Shape: 64*64*3', ['PSNR: ' num2str(psnr(U,I))]}, 'fontsize', 20)

subplot(2, 4, 4)
imshow(imresize(D,2))
title('Imresize(U,2) Image U', 'fontsize', 20)
xlabel({'Shape: 64*64*3', ['PSNR: ' num2str(psnr(imresize(D, 2, 'bilinear'),I))]}, 'fontsize', 20)

subplot(2, 4, 5)
imshow(U1)
title({'L_1 - norm', 'Upsampled Image U_1'}, 'fontsize', 20)
xlabel({'Shape: 64*64*3', ['PSNR: ' num2str(psnr(U1,I))]}, 'fontsize', 20)

% subplot(2, 4, 6)
% imshow(U2)
% title('L_2 - norm Upsampled Image U_2')
% xlabel({'Shape: 64*64*3', ['PSNR: ' num2str(psnr(U2,I))]})

subplot(2, 4, 6)
imshow(Uinf)
title({'L_{inf} - norm', 'Upsampled Image U_{inf}'}, 'fontsize', 20)
xlabel({'Shape: 64*64*3', ['PSNR: ' num2str(psnr(Uinf,I))]}, 'fontsize', 20)

subplot(2, 4, 7)
imshow(Uf)
title({'Frobenius - norm', 'Upsampled Image U_F'}, 'fontsize', 20)
xlabel({'Shape: 64*64*3', ['PSNR: ' num2str(psnr(Uf,I))]}, 'fontsize', 20)
subplot(2, 4, 8)
src = Uf;
SE = strel('rectangle',[2 1]);
src1 = imerode(src, SE);
src2 = imdilate(src1, SE);
for i = 2:2:64
    for j = 2:2:64
           src2(i - 1, j - 1, :) = D(i / 2, j / 2, :);
    end        
end 
imshow(src2)
title({'Frobenius - norm Upsampled', 'Image U_F after Open Operation'}, 'fontsize', 20)
xlabel({'Shape: 64*64*3', ['PSNR: ' num2str(psnr(src2,I))]}, 'fontsize', 20)