function varargout = Menu(varargin)
% MENU MATLAB code for Menu.fig
%      MENU, by itself, creates a new MENU or raises the existing
%      singleton*.
%
%      H = MENU returns the handle to a new MENU or the handle to
%      the existing singleton*.
%
%      MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENU.M with the given input arguments.
%
%      MENU('Property','Value',...) creates a new MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Menu

% Last Modified by GUIDE v2.5 22-Jun-2021 16:25:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Menu_OutputFcn, ...
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


% --- Executes just before Menu is made visible.
function Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Menu (see VARARGIN)

% Choose default command line output for Menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[baseFileName, folder] = uigetfile({'*.jpg';'*.png';'*.bmp'});
fullFileName = fullfile(folder, baseFileName);
img = imread(fullFileName);
[m,n]=size(img);
handles.img= img;
handles.m = m;
n=n/3;
handles.n=n;
guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


fileID = fopen(uigetfile({'*.txt'},'Selecciona archivo'));
degrees = char(176);
A = fscanf(fileID, ['%c' ]);
fclose(fileID);
Alphabet = A;
[ii, lo] = ismember(Alphabet,' ':'z');
codigos = lo(ii);
handles.codigos=codigos;
guidata(hObject,handles);




% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
codigos = handles.codigos;
m = handles.m;
n = handles.n;
[h,y]=size(codigos);
matriz=zeros(m,n);
co=1;
for k=1:m
    for u=1:n
        if(co<= y)
            matriz(k,u)=codigos(1,co);
            %mati(k,u);
            %disp(  matriz(k,u))
            
        end
        
       
        if (co> y)
            matriz(k,u)=93;
        end
        co=co+1;
            
    end
end
img = handles.img;
img(:,:,3) = matriz;
f2 = figure;
imshow(img);
imwrite(img,'kabo1.png');
guidata(hObject,handles);


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[baseFileName, folder] = uigetfile({'*.png'}); 
fullFileName = fullfile(folder, baseFileName); 
img = imread(fullFileName);
handles.img = img;
guidata(hObject,handles);

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

img = handles.img;
[m,n]=size(img);
n=n/3;
o=img(:,:,3);
disp(o(1,90));
contador=1;
cone=0;
for i=1:m
    for j=1:n
        if(o(i,j)~=93)
          
            cone=contador; 
        end
        contador=contador+1;
       
            
    end 
end



matr=zeros(1,cone);
cuenta=1;  
contad=1;
for i=1:m
    for j=1:n
        if(cuenta<=cone)
           
             matr(1,cuenta)=o(i,j);
          
        cuenta=cuenta+1;
        end
            
    end 
end 
Alphabet = ' ':'z';
[w,h]=size(matr);
letters = Alphabet(matr);
fileID = fopen('mensajedeco.txt','w');
fprintf(fileID,'%c',letters);
fclose(fileID);
f=msgbox(letters,'El mensaje decodificado es:');
f=msgbox('Se ha creado mensajedeco.txt en la carpeta del programa');
guidata(hObject,handles);