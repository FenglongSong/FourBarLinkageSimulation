function [] = draw()
%* * * * * * 全局变量有th xB yB xC yC a * * * * * *
global xC yC xB yB th w3 w4 a3 a4 w2
clf;
s1 = subplot(2,2,1);
s2 = subplot(2,2,2);
s3 = subplot(2,2,3);
s4 = subplot(2,2,4);

dt = 2*pi/(length(xC)-1)/w2;    %时间间隔
t = 0:dt:2*pi/w2;

%* * * * * * 角位移曲线 * * * * * *
axes(s1);
plot(t,th(1,:),t,th(2,:),t,th(3,:))
xlim([0,2*pi/w2]);
grid on                                  %图形加网格
ylabel('\theta(度)')
xlabel('\itt(s)')
title('角位移-t图')
legend('曲柄2角位移','连杆3角位移','连杆4角位移')

%* * * * * * 角速度曲线 * * * * * *
axes(s2);
plot([0,2*pi/w2],[w2,w2],t,w3,t,w4)
xlim([0,2*pi/w2]);
grid on                                  %图形加网格
legend('曲柄2角速度\omega_2','连杆3角速度\omega_3','连杆4角速度\omega_4')
xlabel('\itt(s)')
ylabel('\omega(rad\cdot s^{-1})')
title('角速度-t图')

%* * * * * * 角加速度曲线 * * * * * *
axes(s3);
plot(t,a3,t,a4)
xlim([0,2*pi/w2]);
grid on                                  %图形加网格
legend('连杆3角加速度\ita_3','连杆4角加速度\ita_4')
xlabel('\itt(s)')
ylabel('\ita(rad\cdot s^{-2})')
title('角加速度-t图')

%* * * * * * 轨迹图 * * * * * *
axes(s4);
plot(xB,yB,xC,yC);
grid on;
legend('B点轨迹','C点轨迹')
xlabel('\itx')
ylabel('\ity')
title('角加速度-t图')
end

