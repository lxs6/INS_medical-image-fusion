%         Xiaosong Li,Fuqiang Zhou, Haishu Tan,et al. Multimodal Medical Image Fusion Based on Joint Bilateral
%         Filter and Local Gradient Energy [J].Information Sciences, Accept
%         Beihang university,

close all; clear all; clc;
addpath source_images;
addpath functions;

A=imread('01 MR-T1.tif');  B=imread('01 MR-T2.tif');     % source images
A = im2double(A);    B = im2double(B);   

if size(A,3)==3
    A=rgb2gray(A);   
end
if size(B,3)==3
    B=rgb2gray(B); 
end

figure,imshow(A);    figure,imshow(B);

%% parameters          
s=3;    r=0.05;   N=4;    T=21; 
tic
%% image decomposition
E1 = RollingGuidanceFilter(A,s,r,1);    
E2 = RollingGuidanceFilter(B,s,r,1);
S1= A-E1;  S2= B-E2;           
LGE1=STO(S1).*local_energy(S1,N);         
LGE2=STO(S2).*local_energy(S2,N);
map=(LGE1>LGE2);
map=majority_consist_new(map,T);        
FS=map.*S1+~map.*S2;                   % fused structure layer                
map2=abs(E1>E2);
FE= E1.*map2+~map2.*E2;                % fused energy layer               
F=FE+FS;                               % fused result                              
toc
figure,imshow(F);
