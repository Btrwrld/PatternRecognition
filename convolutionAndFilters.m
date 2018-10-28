# Trabajo Pr�ctico 2

#2. Filtros lineales

#2.1 Funci�n de convoluci�n

pkg load image

function r = f_conv(U, F, padding)
  r = zeros(size(U));
  K = size(F)(1);

  if padding
    p = ceil(K/3);
    U = padarray(U,[p p],0,'both');
  end

  [width, height] = size(U);

  for i=1:(width-K+1)
      for j=1:(height-K+1)
          window = double(U(i: K + i - 1, j: K + j - 1));
          r(i,j) = sum(dot(window,F));
      end
  end

  r = uint8(r);

endfunction

U = [1 2 3 4 5 ; 6 7 8 9 10 ; 11 12 13 14 15 ; 16 17 18 19 20 ; 21 22 23 24 25];

F = ones(3);

#F = ones(5)

#F = ones(7)

f_conv(U, F, true)

conv2(U,F,'same')

# 2.2 Filtros lineales

img = imread('input/Lena.PNG');

img = rgb2gray(img);

var = 0.0005;
img_w_noise = imnoise(img,'gaussian',var);

imwrite(img, 'output/Lena.PNG');
imwrite(img_w_noise, 'output/Lena_noise.PNG');

# a) Gaussiano

# Filtro Gaussiano 3x3
sigma = (3-1)/4;
F = fspecial('gaussian',3,sigma);
img_FGauss = f_conv(img, F, true);
img_w_noise_FGauss = f_conv(img_w_noise, F, true);
imwrite(img_FGauss, 'output/Lena_gaussFilter_3x3.PNG');
imwrite(img_w_noise_FGauss, 'output/Lena_noise_gaussFilter_3x3.PNG');

# Filtro Gaussiano 5x5
sigma = (5-1)/4;
F = fspecial('gaussian',5,sigma);
img_FGauss = f_conv(img, F, true);
img_w_noise_FGauss = f_conv(img_w_noise, F, true);
imwrite(img_FGauss, 'output/Lena_gaussFilter_5x5.PNG');
imwrite(img_w_noise_FGauss, 'output/Lena_noise_gaussFilter_5x5.PNG');

# Filtro Gaussiano 7x7

F = fspecial('gaussian',7,sigma);
img_FGauss = f_conv(img, F, true);
img_w_noise_FGauss = f_conv(img_w_noise, F, true);
imwrite(img_FGauss, 'output/Lena_gaussFilter_7x7.PNG');
imwrite(img_w_noise_FGauss, 'output/Lena_noise_gaussFilter_7x7.PNG');


# b) Sobel

F = fspecial('sobel');
img_FSobel = f_conv(img, F, true);
img_w_noise_FSobel = f_conv(img_w_noise, F, true);
imwrite(img_FSobel, 'output/Lena_sobel.PNG');
imwrite(img_w_noise_FSobel, 'output/Lena_noise_sobel.PNG');

F = 1/8 * fspecial('sobel');
img_FSobel = f_conv(img, F, true);
img_w_noise_FSobel = f_conv(img_w_noise, F, true);
imwrite(img_FSobel, 'output/Lena_sobel_alpha.PNG');
imwrite(img_w_noise_FSobel, 'output/Lena_noise_sobel_alpha.PNG');

# c) Prewitt

F = fspecial('prewitt');
img_FPrewitt = f_conv(img, F, true);
img_w_noise_FPrewitt = f_conv(img_w_noise, F, true);
imwrite(img_FPrewitt, 'output/Lena_Prewitt.PNG');
imwrite(img_w_noise_FPrewitt, 'output/Lena_noise_Prewitt.PNG');

F = 1/6 * fspecial('prewitt');
img_FPrewitt = f_conv(img, F, true);
img_w_noise_FPrewitt = f_conv(img_w_noise, F, true);
imwrite(img_FPrewitt, 'output/Lena_Prewitt_alpha.PNG');
imwrite(img_w_noise_FPrewitt, 'output/Lena_noise_Prewitt_alpha.PNG');

# d) Laplaciano y LoG

F = fspecial('laplacian',0);
#F = [-1 -1 -1 ; -1 8 -1 ; -1 -1 -1];
img_FLaplacian = f_conv(img, F, true);
img_w_noise_FLaplacian = f_conv(img_w_noise, F, true);
imwrite(img_FLaplacian, 'output/Lena_Laplacian.PNG');
imwrite(img_w_noise_FLaplacian, 'output/Lena_noise_Laplacian.PNG');

sigma = (3-1)/4;
F = fspecial('log',3,sigma);
img_FLoG = f_conv(img, F, true);
img_w_noise_FLoG = f_conv(img_w_noise, F, true);
imwrite(img_FLoG, 'output/Lena_LoG.PNG');
imwrite(img_w_noise_FLoG, 'output/Lena_noise_LoG.PNG');

# e) Unsharp Mask con lambda = 1
sigma = 0.9;
lambda = 1;
F = fspecial('gaussian',25,sigma);
img_Gauss = f_conv(img, F, true);
img_Noisy_Gauss = f_conv(img_w_noise, F, true);
img_UnsMsk = img + lambda*(img - img_Gauss);
img_Noisy_UnsMsk = img_w_noise + lambda*(img_w_noise - img_Gauss);
imwrite(img_UnsMsk, 'output/Lena_UnsMsk_L1.PNG');
imwrite(img_Noisy_UnsMsk, 'output/Lena_noise_UnsMsk_L1.PNG');

# Unsharp Mask con lambda = 0.75
lambda = 0.75;
img_UnsMsk = img + lambda*(img - img_Gauss);
img_Noisy_UnsMsk = img_w_noise + lambda*(img_w_noise - img_Gauss);
imwrite(img_UnsMsk, 'output/Lena_UnsMsk_L3/4.PNG');
imwrite(img_Noisy_UnsMsk, 'output/Lena_noise_UnsMsk_L3/4.PNG');

# Unsharp Mask con lambda = 1.5
lambda = 1.5;
img_UnsMsk = img + lambda*(img - img_Gauss);
img_Noisy_UnsMsk = img_w_noise + lambda*(img_w_noise - img_Gauss);
imwrite(img_UnsMsk, 'output/Lena_UnsMsk_L3/2.PNG');
imwrite(img_Noisy_UnsMsk, 'output/Lena_noise_UnsMsk_L3/2.PNG');



# 2. Detecci�n de Bordes

# 1.a)

function r = laplacian_local_var(img, P)
  r = zeros(size(img));
  dim_U = size(img);
  p = ceil(P/3);
  img = padarray(img,[p p],0,'both');

  for i = 1:dim_U(1)
    for j = 1:dim_U(2)
      celda = img(i:i+P-1,j:j+P-1);
      mu = 1/(P.^2) * (sum(celda(:)));
      sigma = 1/(P.^2 - 1) * (sum(((celda-mu).^2)(:)));
      if sigma == 0
        r(i,j) = 0;
      else
        F = fspecial('log',P,sigma);
        r(i,j)= sum(dot(celda,F));
      end
    end
  end

  meanImg = mean(r(:));

  r(r < meanImg)=255;
  r(r >= meanImg) = 0;

end

# 1.b)

img_laplace_localvar = laplacian_local_var(img, 3);
img_noise_laplace_localvar = laplacian_local_var(img_w_noise, 3);
imwrite(img_laplace_localvar, 'output/Lena_Laplace_LocalVar.PNG');
imwrite(img_noise_laplace_localvar, 'output/Lena_noise_Laplace_LocalVar.PNG');
