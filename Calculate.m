function [str, flag] = Calculate()
%* * * * * * 全局变量有th xB yB xC yC a * * * * * *
global xC yC xB yB th w2 w3 w4 a3 a4 L1 L2 L3 L4
flag = 0;       
%flag = 0无法生成机构，1曲柄机构 2存在回转体的双摇杆,3不存在回转体的双摇杆机构 4需要调换24位置
num = 120;       %将pi分成多少份
disp(' * * * * * * 平面四杆机构的运动分析 * * * * * *')
%* * * * * * 检查是否可以组成四连杆 * * * * * *
L = [L1,L2,L3,L4];
Lsum = sum(L);
Lmin = min(L);
Lmax = max(L);
isCrank = 2*(Lmax+Lmin) - Lsum; %<=0则存在曲柄
isLinkage = 2*Lmax - Lsum;       %<0则是连杆机构，>=0则无法构成机构
if(isLinkage>=0) %不是机构
    str = sprintf('输入参数无法构成四连杆机构！');
    flag = 0;
    return
elseif(isCrank > 0)%是机构但无曲柄，为双摇杆
    str = sprintf('生成四连杆成功！为不存在回转体的双摇杆机构');
    flag = 3;
else
    switch Lmin
        case L1             %双曲柄机构
            str = sprintf('生成四连杆成功！为双曲柄机构');
            flag = 1;
        case L2             %L2为曲柄的曲柄-摇杆机构
            str = sprintf('生成四连杆成功！为曲柄-摇杆机构');
            flag = 1;
        case L3             %双摇杆机构
            str = sprintf('生成四连杆成功！L3为回转体的双摇杆机构');
            flag = 2;
        case L4             %L3为曲柄的曲柄-摇杆机构
            str = sprintf('L4为曲柄的曲柄-摇杆机构，请将L4，L2调换');
            flag = 4;
        otherwise
    end
end

%* * * * * * * * * 位移求解 * * * * * * * * * * *
%根据杆件类型选择th2范围
if(flag == 1)           %曲柄机构，th2为圆周均匀分布
    th2=(0:1/num:2)*pi;                      %曲柄输入角度θ_2，步长为5度
elseif(flag == 2)          %存在回转杆L3的双摇杆机构，求解th2极限值
    th2max = acos((L1^2+L2^2-(L3+L4)^2)/(2*L1*L2));
    th2min = acos((L1^2+L2^2-(L3-L4)^2)/(2*L1*L2));
    th2 = zeros(1,2*num);
    th2(1:num) = linspace(th2min,th2max,num);
    th2(num+1:2*num) = linspace(th2max,th2min,num);
elseif(flag == 3)          %不存在回转杆的双摇杆机构，求解th2极限值
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

%解方程
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
% yC = L2*sin(th2)+L3*sin(th34(1,:));         %连杆3的C端点Y坐标值
% xC = L2*cos(th2)+L3*cos(th34(1,:));         %连杆3的C端点X坐标值
yC = L4*sin(th34(2,:));         %连杆3的C端点Y坐标值
xC = L1+L4*cos(th34(2,:));         %连杆3的C端点X坐标值
xB = L2*cos(th2);                           %连杆3的B端点X坐标值                                                                  
yB = L2*sin(th2);                           %连杆3的B端点Y坐标值
%* * * * * * * * * 角速度求解 * * * * * * * * * * *
w3 = -w2*L2*sin(th2 - th34(2,:))./(L3*sin(th34(1,:)-th34(2,:)));
w4 = w2*L2*sin(th2 - th34(1,:))./(L4*sin(th34(2,:)-th34(1,:)));
%* * * * * * * * * 角加速度求解 * * * * * * * * * * *
a3 = (-L2*w2.^2.*cos(th2-th34(2,:))-L3*w3.^2.*cos(th34(1,:)-th34(2,:))+L4*w4.^2)...
    ./(L4*sin(th34(1,:)-th34(2,:)));
a4 = (L2*w2.^2.*cos(th2-th34(1,:))-L4*w4.^2.*cos(th34(1,:)-th34(2,:))+L3*w3.^2)...
    ./(L4*sin(th34(2,:)-th34(1,:)));
end

