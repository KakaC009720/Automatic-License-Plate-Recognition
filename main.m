% f_out = fopen('output999.txt','w');
abc = imread('018.jpg');
figure(1),subplot(3,3,2),imshow(abc);
title('���');
a=0;
abc=rgb2gray(abc);
I=abc(184:300,480:767);
cut = [184 300 480 767];
thresh = graythresh(I);    %�G�Ȥ�
bw0=im2bw(I,thresh); 
bw1=medfilt2(bw0);     %�����o�i

figure(1),subplot(3,3,4),imshow(bw1);
title('�G�Ȥ�');
bw2=double(bw1);

grd=edge(bw1,'prewitt');
figure(1),subplot(3,3,5),imshow(grd);
title('prewitt��t����');


bg1=imclose(grd,strel('rectangle',[5,19]));
figure(1),subplot(3,3,6),imshow(bg1);
title('����');
bg3=imopen(bg1,strel('rectangle',[5,19]));
figure(1),subplot(3,3,7),imshow(bg3);
title('�}��');


% bg2=imopen(bg3,strel('rectangle',[19,1]));
% figure(5),imshow(bg2);
% figure(987),imshow(abc),impixelinfo

[L,num]=bwlabel(bg3,8);
Feastats=regionprops(L,'basic');
Area=[Feastats.Area];
BoundingBox=[Feastats.BoundingBox];

RGB=label2rgb(L,'spring','k','shuffle');
% figure(6),imshow(RGB),impixelinfo;

count = numel(Feastats);

for i=1:count
    if 2000<Feastats(i).Area && Feastats(i).Area<6000
        Feastats(i).BoundingBox;
        RGB2=I(Feastats(i).BoundingBox(2):Feastats(i).BoundingBox(2)+Feastats(i).BoundingBox(4),Feastats(i).BoundingBox(1):Feastats(i).BoundingBox(1)+Feastats(i).BoundingBox(3));
        xx=Feastats(i).BoundingBox(1);
        yy=Feastats(i).BoundingBox(2);
    end
end
     
        RGB778 = histeq(RGB2);
        figure(1),subplot(3,3,8),imshow(RGB778);
        title('���赥��');
        RGB777=RGB778<100;
        figure(1),subplot(3,3,9),imshow(RGB777);
        title('�G�Ȥ�');
        
        [RGB9,total]=bwlabel(RGB777,4); %4�s�q

        for i=1:total
            [fy, fx] = find(RGB9==i);
            ratio = (max(fx) - min(fx)) /(max(fy) - min(fy)) ;
            y_r = (max(fy) - min(fy)) / size(RGB9,1);
            area = (max(fx) - min(fx)) .* (max(fy) - min(fy)) ;
            
            
            if  area>130 & ratio<0.8 
                inddd = i;

                a=a+1;
                m1_x = min(fx) +xx+cut(3)-2;
                m1_y = min(fy) +yy+cut(1)-2;
                m2_x = max(fx) +xx+cut(3);
                m2_y = max(fy) +yy+cut(1);     
                fprintf(f_out,'%d %d %d %d\r\n',fix(m1_x),fix(m1_y),fix(m2_x),fix(m2_y));
                figure(2),subplot(1,8,a),imshow(abc(m1_y:m2_y,m1_x:m2_x));
            end 
        end
        
      