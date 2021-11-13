clc;
clear;
close all;
x=imread('e1200.jpg');
y=imread('I1200.jpg');
z=imread('f1200.jpg');
a=ssim(y,x);
b=ssim(z,x);
c=psnr(y,x);
d=psnr(z,x);

disp(a);
disp(b);
disp(c);
disp(d);
