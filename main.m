clc; clear all; close all;
%set(gcf,'color','White')

I = imread('4.jpg');
%有三个色
%转为灰度图（若已为灰度图则忽略）
%I = rgb2gray(I);
%I = im2double(I);

figure('Name','Raw Image');
imshow(I,[]);
initialkey=[0x76,0x23,0xB3,0x8A,0x99,0x1B,0x04,0x52,0x61,0x42,...
    0x16,0x33,0x53,0x7A,0x99,0xAB,0xC4,0xD2,0x61,0x4F,...
    0x06,0x23,0x63,0x4A,0x89,0x6B,0x34,0x97,0x15,0x9D
    ];
% PPADencryption
F=PPADencryption(I,initialkey,16);

%F= F./(max(max(F)));

imwrite(F,'encryption.tif');

figure('Name','Encrypted Image');
imshow(F,[]);

%F= F./(max(max(F)));
% PPADdecryption
F1=PPADdecryption(F,initialkey,16);
imwrite(F1,'decryption.tif');
figure('Name','decrypted Image');
imshow(F1,[]);


