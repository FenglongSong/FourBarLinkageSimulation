function [] = animate( )%标准化后的L4 = L4/Lsum
%* * * * * * 全局变量有th xB yB xC yC a * * * * * *
global xC yC xB yB w2 L1 L2 L3 L4
cla;
%计算坐标系范围
x1 = -2*L2;
x2 = 1.2*(L1+L4);
y1 = -1.2*max(L2,L4);
y2 = 1.5*max(L2,L4);
axis equal
axis([x1,x2,y1,y2]);
grid on;

h = animatedline('Marker', 'o', 'color', 'r', 'LineStyle', '-','LineWidth',2);
h1 = animatedline('Marker', '.', 'color', 'b', 'LineStyle', 'none');%,'LineWidth',2);
h2 = animatedline('Marker', '.', 'color', 'g', 'LineStyle', 'none');%,'LineWidth',2);
shg
pauseTime = 0.0055*2*3.14/w2;
for K =1:1
for n = 1:length(xB)
    clearpoints(h)
    addpoints(h,0,0);
    addpoints(h, xB(n),yB(n) );
    addpoints(h1, xB(n),yB(n) );
    
    addpoints(h, xC(n),yC(n) );
    addpoints(h2, xC(n),yC(n) );
    addpoints(h,L1,0);
    pause(pauseTime);
    axis([x1,x2,y1,y2]);
    drawnow update
end
end

