function varargout = my_gui(varargin)
% MY_GUI MATLAB code for my_gui.fig
%      MY_GUI, by itself, creates a new MY_GUI or raises the existing
%      singleton*.
%
%      H = MY_GUI returns the handle to a new MY_GUI or the handle to
%      the existing singleton*.
%
%      MY_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MY_GUI.M with the given input arguments.
%
%      MY_GUI('Property','Value',...) creates a new MY_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before my_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to my_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help my_gui

% Last Modified by GUIDE v2.5 04-Jan-2019 19:55:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @my_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @my_gui_OutputFcn, ...
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


% --- Executes just before my_gui is made visible.
function my_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to my_gui (see VARARGIN)

% Choose default command line output for my_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes my_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = my_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function N_Callback(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of N as text
%        str2double(get(hObject,'String')) returns contents of N as a double


% --- Executes during object creation, after setting all properties.
function N_CreateFcn(hObject, eventdata, handles)
% hObject    handle to N (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function M_Callback(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of M as text
%        str2double(get(hObject,'String')) returns contents of M as a double


% --- Executes during object creation, after setting all properties.
function M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opt.N = round(str2double(get(handles.N, 'string')));
opt.M = str2double(get(handles.M, 'string'));
i_max = str2double(get(handles.it_max, 'string'));
opt.initial = get(handles.initial_y, 'string');
opt.method = get(get(handles.uibuttongroup2, 'SelectedObject'), 'Tag');
opt.solver = get(get(handles.uibuttongroup1, 'SelectedObject'), 'Tag');
opt.search = get(get(handles.uibuttongroup4, 'SelectedObject'), 'Tag');
opt.loop = 0;
% disp(N);disp(M);disp(it_max);
while(1)
    tic
    [x_sol, iteration, y0] = take_home_func(opt, i_max);
    elapsed_time = toc;
    elapsed_text = [num2str(elapsed_time), ' s'];
    set(handles.text_time, 'string', elapsed_text); 
    x = linspace(0,5,opt.N);

    axes(handles.axes1); % switch to axes
    plot(x, y0);
    title('The Initial Function');
    xlabel('x');ylabel('y');

    axes(handles.axes2); % switch to axes
    plot(x, x_sol);
    title('The Minimum Surface Function');
    xlabel('x');ylabel('y');

    answer = questdlg('Would you like to continue the optimization process?', ...
        'Make Your Choice', ...
        'Yes','No', 'No');

    opt.loop = 1;
    if(strcmp(answer, 'No'))
        break;
    else
        answer_it = inputdlg({'Please enter the new maximum iteration'});
        i_max = round(str2num(answer_it{1}));
        answer_in = questdlg('Would you like to use select a new inital function?', ...
        'Make Your Choice', ...
        'Yes','No, use the last point', 'No, use the last point');
        if(strcmp(answer_in, 'Yes'))
            answer_initial = inputdlg({'Please enter the new inital function'});
            opt.loop = 0;
            opt.initial = sprintf(answer_initial{1});
        else
            opt.initial = x_sol;
        end

    end
end

% --- Executes when selected object is changed in uibuttongroup1.
function uibuttongroup1_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.method = get(eventdata.NewValue, 'String');



function it_max_Callback(hObject, eventdata, handles)
% hObject    handle to it_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of it_max as text
%        str2double(get(hObject,'String')) returns contents of it_max as a double


% --- Executes during object creation, after setting all properties.
function it_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to it_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function initial_y_Callback(hObject, eventdata, handles)
% hObject    handle to initial_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of initial_y as text
%        str2double(get(hObject,'String')) returns contents of initial_y as a double


% --- Executes during object creation, after setting all properties.
function initial_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to initial_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
