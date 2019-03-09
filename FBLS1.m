function varargout = FBLS1(varargin)
% FBLS1 MATLAB code for FBLS1.fig
%      FBLS1, by itself, creates a new FBLS1 or raises the existing
%      singleton*.
%
%      H = FBLS1 returns the handle to a new FBLS1 or the handle to
%      the existing singleton*.
%
%      FBLS1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FBLS1.M with the given input arguments.
%
%      FBLS1('Property','Value',...) creates a new FBLS1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FBLS1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FBLS1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help FBLS1

% Last Modified by GUIDE v2.5 08-Dec-2018 19:11:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FBLS1_OpeningFcn, ...
                   'gui_OutputFcn',  @FBLS1_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FBLS1 is made visible.
function FBLS1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FBLS1 (see VARARGIN)

% Choose default command line output for FBLS1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FBLS1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = FBLS1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% ‘计算’按钮
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% 判断输入的对象是否是数字字符
% L1 = str2double(get(handles.edit_input_1, 'String'));
% L2 = str2double(get(handles.edit_input_2, 'String'));
% L3 = str2double(get(handles.edit_input_3, 'String'));
% L4 = str2double(get(handles.edit_input_4, 'String'));
global L1 L2 L3 L4 w2;
global flag_animate;
L1 = get(handles.edit_input_1, 'String');
L2 = get(handles.edit_input_2, 'String');
L3 = get(handles.edit_input_3, 'String');
L4 = get(handles.edit_input_4, 'String');
w2 = get(handles.edit_input_omega, 'String');

%flag = isempty(str2num(L1)) + isempty(str2num(L2)) + isempty(str2num(L3)) + isempty(str2num(L4));
L = [isempty(str2num(L1)); isempty(str2num(L2)); isempty(str2num(L3)); isempty(str2num(L4))];
if L==zeros(4,1)
    set(handles.edit15,'String','输入正确！');
else
    L_error = find(L);
    L_str = [];
    for i=1:size(L_error)
        L_str = [L_str, num2str(L_error(i))];
    end
    set(handles.edit15,'String',['输入的L',L_str,'错误！包含非数值字符。']);
end
% 开始计算
L1 = str2double(get(handles.edit_input_1, 'String'));
L2 = str2double(get(handles.edit_input_2, 'String'));
L3 = str2double(get(handles.edit_input_3, 'String'));
L4 = str2double(get(handles.edit_input_4, 'String'));
w2 = str2double(get(handles.edit_input_omega, 'String'));

[str_judge, flag_animate] = Calculate();
set(handles.edit15,'String', str_judge);



function edit_input_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_1 as a double



% --- Executes during object creation, after setting all properties.
function edit_input_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_input_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_input_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% 绘图按钮
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axes(handles.axes1);
global flag_animate;
if flag_animate
    set(handles.edit15,'String','画出运动轨迹');
    animate();
else
    set(handles.edit15,'String','无法绘制该机构的速度曲线');
end



% 绘制速度曲线按钮
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global flag_animate;
% persistent flag_draw;
% if isempty(flag_draw)
%     flag_draw = true;
% end
if flag_animate
    set(handles.edit15,'String','绘制速度曲线');
    open('draw_curve.fig');
    draw();
else
    set(handles.edit15,'String','无法绘制该机构的速度曲线');
end



% * * * * * ** * * ** * * * 输出信息 * ** * * ** * * * * * * *
function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double
set(handles.edit15,'String',result_text);


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_omega_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_omega (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_omega as text
%        str2double(get(hObject,'String')) returns contents of edit_input_omega as a double


% --- Executes during object creation, after setting all properties.
function edit_input_omega_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_omega (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
