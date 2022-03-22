function varargout = fire(varargin)
% FIRE MATLAB code for fire.fig
%      FIRE, by itself, creates a new FIRE or raises the existing
%      singleton*.
%
%      H = FIRE returns the handle to a new FIRE or the handle to
%      the existing singleton*.
%
%      FIRE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIRE.M with the given input arguments.
%
%      FIRE('Property','Value',...) creates a new FIRE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fire_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fire_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fire

% Last Modified by GUIDE v2.5 10-Mar-2022 00:46:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fire_OpeningFcn, ...
                   'gui_OutputFcn',  @fire_OutputFcn, ...
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


% --- Executes just before fire is made visible.
function fire_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fire (see VARARGIN)
clc
handles.target = 100 * rand + 50;
plot(handles.target,0,'d','MarkerSize',10);
axis([0, handles.target*1.25, 0, handles.target*.35]);

% Choose default command line output for fire
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fire wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fire_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function editVelocity_Callback(hObject, eventdata, handles)
% hObject    handle to editVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVelocity as text
%        str2double(get(hObject,'String')) returns contents of editVelocity as a double


% --- Executes during object creation, after setting all properties.
function editVelocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVelocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editAngle_Callback(hObject, eventdata, handles)
% hObject    handle to editAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editAngle as text
%        str2double(get(hObject,'String')) returns contents of editAngle as a double


% --- Executes during object creation, after setting all properties.
function editAngle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editAngle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
velocity = str2num(get(handles.editVelocity,'String'));
angle = str2num(get(handles.editAngle,'String'));
time =0:.01:100000;

x= 0+velocity * cosd(angle) * time;
y= 0+velocity * sind(angle) * time + 1/2 * (-9.81) * time.^2;

goodvalues = find(y>=0);
goodys = y(goodvalues);
goodxs= x(goodvalues);
hold on
comet(goodxs,goodys)
finalx = max(goodxs);
if abs(handles.target-finalx) <=handles.target*0.05
    set(handles.infoTxt,'String','Hit!');
    playagain=menu('Do you want to play again?','Yes','No');
    if playagain == 1
        close
        fire
    else 
        msgbox('Thank you for playing!')
        pause(1)
        close
        close
    end        
        
elseif abs(handles.target-finalx) <=handles.target*0.20
    set(handles.infoTxt,'String','Close!')
else 
    set(handles.infoTxt,'String','Keep trying!')
end

    


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
