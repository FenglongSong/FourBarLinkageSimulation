function [str, flag] = Calculate()
%* * * * * * ȫ�ֱ�����th xB yB xC yC a * * * * * *
global xC yC xB yB th w2 w3 w4 a3 a4 L1 L2 L3 L4
flag = 0;       
%flag = 0�޷����ɻ�����1�������� 2���ڻ�ת���˫ҡ��,3�����ڻ�ת���˫ҡ�˻��� 4��Ҫ����24λ��
num = 120;       %��pi�ֳɶ��ٷ�
disp(' * * * * * * ƽ���ĸ˻������˶����� * * * * * *')
%* * * * * * ����Ƿ������������� * * * * * *
L = [L1,L2,L3,L4];
Lsum = sum(L);
Lmin = min(L);
Lmax = max(L);
isCrank = 2*(Lmax+Lmin) - Lsum; %<=0���������
isLinkage = 2*Lmax - Lsum;       %<0�������˻�����>=0���޷����ɻ���
if(isLinkage>=0) %���ǻ���
    str = sprintf('��������޷����������˻�����');
    flag = 0;
    return
elseif(isCrank > 0)%�ǻ�������������Ϊ˫ҡ��
    str = sprintf('���������˳ɹ���Ϊ�����ڻ�ת���˫ҡ�˻���');
    flag = 3;
else
    switch Lmin
        case L1             %˫��������
            str = sprintf('���������˳ɹ���Ϊ˫��������');
            flag = 1;
        case L2             %L2Ϊ����������-ҡ�˻���
            str = sprintf('���������˳ɹ���Ϊ����-ҡ�˻���');
            flag = 1;
        case L3             %˫ҡ�˻���
            str = sprintf('���������˳ɹ���L3Ϊ��ת���˫ҡ�˻���');
            flag = 2;
        case L4             %L3Ϊ����������-ҡ�˻���
            str = sprintf('L4Ϊ����������-ҡ�˻������뽫L4��L2����');
            flag = 4;
        otherwise
    end
end

%* * * * * * * * * λ����� * * * * * * * * * * *
%���ݸ˼�����ѡ��th2��Χ
if(flag == 1)           %����������th2ΪԲ�ܾ��ȷֲ�
    th2=(0:1/num:2)*pi;                      %��������ǶȦ�_2������Ϊ5��
elseif(flag == 2)          %���ڻ�ת��L3��˫ҡ�˻��������th2����ֵ
    th2max = acos((L1^2+L2^2-(L3+L4)^2)/(2*L1*L2));
    th2min = acos((L1^2+L2^2-(L3-L4)^2)/(2*L1*L2));
    th2 = zeros(1,2*num);
    th2(1:num) = linspace(th2min,th2max,num);
    th2(num+1:2*num) = linspace(th2max,th2min,num);
elseif(flag == 3)          %�����ڻ�ת�˵�˫ҡ�˻��������th2����ֵ
    switch Lmax
        case {L1,L2}
            th2max = acos((L1^2+L2^2-(L3+L4)^2)/(2*L1*L2));
            th2min = -th2max;
            th2 = zeros(1,2*num);
            th2(1:num) = linspace(th2min,th2max,num);
            th2(num+1:2*num) = linspace(th2max,th2min,num);
        case {L3,L4}
            th2min = acos((L1^2+L2^2-(L3-L4)^2)/(2*L1*L2));
            th2max = 2*pi-th2min;
            th2 = zeros(1,2*num);
            th2(1:num) = linspace(th2min,th2max,num);
            th2(num+1:2*num) = linspace(th2max,th2min,num);
    end
end

%�ⷽ��
fourbar = @(th,th2) [L2*cos(th2)+L3*cos(th(1))-L4*cos(th(2))-L1;...
                    L2*sin(th2)+L3*sin(th(1))-L4*sin(th(2))];
th34=zeros(2,length(th2));
options=optimset('display','off');
% for i=1:length(th2)
%     th34(:,i)=fsolve(fourbar,[1,1],options,th2(i));               
% end
th34(:,1)=fsolve(fourbar,[1 0.5],options,th2(1));
for i=2:length(th2)
    th34(:,i)=fsolve(fourbar,th34(:,i-1),options,th2(i));               
end

th = [th2;th34];
% yC = L2*sin(th2)+L3*sin(th34(1,:));         %����3��C�˵�Y����ֵ
% xC = L2*cos(th2)+L3*cos(th34(1,:));         %����3��C�˵�X����ֵ
yC = L4*sin(th34(2,:));         %����3��C�˵�Y����ֵ
xC = L1+L4*cos(th34(2,:));         %����3��C�˵�X����ֵ
xB = L2*cos(th2);                           %����3��B�˵�X����ֵ                                                                  
yB = L2*sin(th2);                           %����3��B�˵�Y����ֵ
%* * * * * * * * * ���ٶ���� * * * * * * * * * * *
w3 = -w2*L2*sin(th2 - th34(2,:))./(L3*sin(th34(1,:)-th34(2,:)));
w4 = w2*L2*sin(th2 - th34(1,:))./(L4*sin(th34(2,:)-th34(1,:)));
%* * * * * * * * * �Ǽ��ٶ���� * * * * * * * * * * *
a3 = (-L2*w2.^2.*cos(th2-th34(2,:))-L3*w3.^2.*cos(th34(1,:)-th34(2,:))+L4*w4.^2)...
    ./(L4*sin(th34(1,:)-th34(2,:)));
a4 = (L2*w2.^2.*cos(th2-th34(1,:))-L4*w4.^2.*cos(th34(1,:)-th34(2,:))+L3*w3.^2)...
    ./(L4*sin(th34(2,:)-th34(1,:)));
end

