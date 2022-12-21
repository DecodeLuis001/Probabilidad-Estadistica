function varargout = Login(varargin)
% LOGIN MATLAB code for Login.fig
%      LOGIN, by itself, creates a new LOGIN or raises the existing
%      singleton*.
%
%      H = LOGIN returns the handle to a new LOGIN or the handle to
%      the existing singleton*.
%
%      LOGIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOGIN.M with the given input arguments.
%
%      LOGIN('Property','Value',...) creates a new LOGIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Login_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Login_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Login

% Last Modified by GUIDE v2.5 10-Dec-2020 20:07:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Login_OpeningFcn, ...
                   'gui_OutputFcn',  @Login_OutputFcn, ...
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

% --- Executes just before Login is made visible.
function Login_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Login (see VARARGIN)
%Fondos principal:
axes(handles.axes1);
[x, map]=imread('Escuela.jpg');
image(x)
colormap(map);
axis off
hold on
%Fondo logotipo.
axes(handles.axes2);
[x, map]=imread('Logo.jpg');
image(x)
colormap(map);
axis off
hold on

% Choose default command line output for Login
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Login wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Login_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
hfig=get(0,'CurrentFigure');
delete(hfig)
run('Binomial.m')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('Continuas.m')


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
set(hObject,'BackgroundColor','red');
message = sprintf('Ing: Irving Willihado Reyes Buenfil.\nBryan Ricardo Cervantes Mancera. \t \t  NUA: 146809\nJose Luis Arroyo Nunez. \t \t \t \t \t \t \t \t \t \t \t NUA: 390893');
try
	CreateStruct.Interpreter = 'tex';
	CreateStruct.WindowStyle = 'modal';
% 	CreateStruct.Title = 'MATLAB Message';
	
	fontSize = 18;
	% Embed the required tex code in before the string.
	latexMessage = sprintf('\\fontsize{%d} %s', fontSize, message);
	uiwait(msgbox(latexMessage, 'Sobre Nosotros!:', CreateStruct));
catch ME
	errorMessage = sprintf('Error in msgboxw():\n%s', ME.message);
	fprintf('%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
return;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles, message)
set(hObject,'BackgroundColor','red');
message = sprintf('Cervantes Mancera: \t br.cervantesmancera@ugto.mx\nArroyo Nunez: \t \t \t \t \t \t jl.arroyonunez@ugto.mx');
try
	CreateStruct.Interpreter = 'tex';
	CreateStruct.WindowStyle = 'modal';
% 	CreateStruct.Title = 'MATLAB Message';
	
	fontSize = 16;
	% Embed the required tex code in before the string.
	latexMessage = sprintf('\\fontsize{%d} %s', fontSize, message);
	uiwait(msgbox(latexMessage, 'E-mails:', CreateStruct));
catch ME
	errorMessage = sprintf('Error in msgboxw():\n%s', ME.message);
	fprintf('%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
return;

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles, message)
set(hObject,'BackgroundColor','magenta');
message = sprintf('V.A. discretas: son aquellas con valores de x definidos y contables.\n\nBinomial: Se usa cuando se tiene una probabilidad y multiples intentos de exito o fracaso.\n\nPoisson: se utiliza cuando se quiere determinar el numero de eventos que ocurren en un tiempo o espacio dado.\n');
try
	CreateStruct.Interpreter = 'tex';
	CreateStruct.WindowStyle = 'modal';
% 	CreateStruct.Title = 'MATLAB Message';
	
	fontSize = 18;
	% Embed the required tex code in before the string.
	latexMessage = sprintf('\\fontsize{%d} %s', fontSize, message);
	uiwait(msgbox(latexMessage, 'Definiciones:', CreateStruct));
catch ME
	errorMessage = sprintf('Error in msgboxw():\n%s', ME.message);
	fprintf('%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
return;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles, message)
set(hObject,'BackgroundColor','magenta');
message = sprintf('V.A. continuas: Aquellas que tienen un intervalo definidido con un infinto numero de valores. \n\nExponencial: Tiene como funcion expresar tambien el tiempo transcurrido entre eventos que se pueden contabilizar.\n\nNormal: Generalmente utilizada cuando tu numero de susesos es muy grande, y se puede tener una media probabilistica. \n');
try
	CreateStruct.Interpreter = 'tex';
	CreateStruct.WindowStyle = 'modal';
% 	CreateStruct.Title = 'MATLAB Message';
	
	fontSize = 18;
	% Embed the required tex code in before the string.
	latexMessage = sprintf('\\fontsize{%d} %s', fontSize, message);
	uiwait(msgbox(latexMessage, 'Definiciones:', CreateStruct));
catch ME
	errorMessage = sprintf('Error in msgboxw():\n%s', ME.message);
	fprintf('%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
return;
