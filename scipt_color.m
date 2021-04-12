%         Xiaosong Li,Fuqiang Zhou, Haishu Tan,et al. Multimodal Medical Image Fusion Based on Joint Bilateral
%         Filter and Local Gradient Energy [J].Information Sciences,Accept.
%         Beihang university,

close all; clear all; clc;
addpath source_images;
addpath functions;

A=imread('02 MR.bmp');  B=imread('02 SPECT.bmp');     % input source images
A = im2double(A);       B = im2double(B);   
figure,imshow(A);       figure,imshow(B);
if size(A,3)>1
    A=rgb2gray(A);    
end
[hei, wid] = size(A);
%% parameters          
s=3;    r=0.05;   N=4;    T=21; 
tic
%% RGB to YUV
B_YUV=ConvertRGBtoYUV(B);   
BB=B_YUV(:,:,1);            
E1 = RollingGuidanceFilter(A,s,r,1);    
E2 = RollingGuidanceFilter(BB,s,r,1);
S1= A-E1;                  S2= BB-E2;
LGE1=STO(S1).*local_energy(S1,N);         
LGE2=STO(S2).*local_energy(S2,N);
map=(LGE1>LGE2);
map=majority_consist_new(map,T);        
FS=map.*S1+~map.*S2;                    % fused structure layer                
map2=abs(E1>E2);
FE= E1.*map2+~map2.*E2;                 % fused energy layer               
F=FE+FS;                                % temp fused result           
%% YUV to RGB
F_YUV=zeros(hei,wid,3);
F_YUV(:,:,1)=F;
F_YUV(:,:,2)=B_YUV(:,:,2);
F_YUV(:,:,3)=B_YUV(:,:,3);
final_F=ConvertYUVtoRGB(F_YUV);          % final fused result    
toc
figure,imshow(final_F);
