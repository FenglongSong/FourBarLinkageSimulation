function [] = draw()
%* * * * * * ȫ�ֱ�����th xB yB xC yC a * * * * * *
global xC yC xB yB th w3 w4 a3 a4 w2
clf;
s1 = subplot(2,2,1);
s2 = subplot(2,2,2);
s3 = subplot(2,2,3);
s4 = subplot(2,2,4);

dt = 2*pi/(length(xC)-1)/w2;    %ʱ����
t = 0:dt:2*pi/w2;

%* * * * * * ��λ������ * * * * * *
axes(s1);
plot(t,th(1,:),t,th(2,:),t,th(3,:))
xlim([0,2*pi/w2]);
grid on                                  %ͼ�μ�����
ylabel('\theta(��)')
xlabel('\itt(s)')
title('��λ��-tͼ')
legend('����2��λ��','����3��λ��','����4��λ��')

%* * * * * * ���ٶ����� * * * * * *
axes(s2);
plot([0,2*pi/w2],[w2,w2],t,w3,t,w4)
xlim([0,2*pi/w2]);
grid on                                  %ͼ�μ�����
legend('����2���ٶ�\omega_2','����3���ٶ�\omega_3','����4���ٶ�\omega_4')
xlabel('\itt(s)')
ylabel('\omega(rad\cdot s^{-1})')
title('���ٶ�-tͼ')

%* * * * * * �Ǽ��ٶ����� * * * * * *
axes(s3);
plot(t,a3,t,a4)
xlim([0,2*pi/w2]);
grid on                                  %ͼ�μ�����
legend('����3�Ǽ��ٶ�\ita_3','����4�Ǽ��ٶ�\ita_4')
xlabel('\itt(s)')
ylabel('\ita(rad\cdot s^{-2})')
title('�Ǽ��ٶ�-tͼ')

%* * * * * * �켣ͼ * * * * * *
axes(s4);
plot(xB,yB,xC,yC);
grid on;
legend('B��켣','C��켣')
xlabel('\itx')
ylabel('\ity')
title('�Ǽ��ٶ�-tͼ')
end

