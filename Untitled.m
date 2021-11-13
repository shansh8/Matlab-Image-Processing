clc;
clear;
close all;
a=imread('B1.jpg');
a=round(rgb2hsv(a));
b=imread('B2.jpg');
b=round(rgb2hsv(b));
c=bitxor(a,b);
imshow(c);