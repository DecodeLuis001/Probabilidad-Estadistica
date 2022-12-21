function varargout = Continuas(varargin)
% CONTINUAS MATLAB code for Continuas.fig
%      CONTINUAS, by itself, creates a new CONTINUAS or raises the existing
%      singleton*.
%
%      H = CONTINUAS returns the handle to a new CONTINUAS or the handle to
%      the existing singleton*.
%
%      CONTINUAS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTINUAS.M with the given input arguments.
%
%      CONTINUAS('Property','Value',...) creates a new CONTINUAS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Continuas_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Continuas_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Continuas

% Last Modified by GUIDE v2.5 09-Dec-2020 21:18:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Continuas_OpeningFcn, ...
                   'gui_OutputFcn',  @Continuas_OutputFcn, ...
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


% --- Executes just before Continuas is made visible.
function Continuas_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Continuas (see VARARGIN)

% Choose default command line output for Continuas
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Continuas wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Continuas_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%MENU POP.
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(Continuas);
Login

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contenido1 = get(handles.popupmenu1, 'Value');

%Datos para la exponencial
x6 = str2double(get(handles.edit3,'String')); %Handless mando a llamar al elemnto.
c =  str2double(get(handles.edit4,'String'));
x61 = 0:0.1:x6;

%Datos para la Normal.
x70 = str2double(get(handles.edit7,'String'));
x70_A = str2double(get(handles.edit16,'String'));
x71 = str2double(get(handles.edit5,'String')); %Limite superior.
x72 = str2double(get(handles.edit6,'String')); %Limite inferior.
media = str2double(get(handles.edit2,'String'));
desv = str2double(get(handles.edit1,'String'));

%Intervalos para la normal
x70_0 = linspace(x70-(3*desv),x70+(3*desv)); %Para calcular prob. cuando x<=X
x70_0_A = linspace(x70_A-(3*desv),x70_A+(3*desv)); %Para calcular prob. cuando x >=X
x70_Intervalos = linspace(x72,x71);
x_Mayor_Intervalo = linspace(x70_A, x70_A+(3*desv));
x_Menor_Intervalo = linspace(x70-(3*desv), x70);

switch contenido1
    case 1
        disp(''); 
    case 2
        if isempty(get(handles.edit3,'String')) || isempty(get(handles.edit4, 'String'))
            warndlg('Rellene los campos para el valor de X y Landa.','Datos insuficientes');
        else
            if x6 > 0 && c >0
                %Aqui se calcula la densidad probabilistica.
                if x6 >=0                 
                   fx6 = c * exp( (-c * x61) ); %Para hacer la grafica.
                   fx6_1 = c * exp( (-c * x6) ); %Para mostrar un valor al usuaario.
                else
                   fx6 = 0; 
                end

                %Aqui se calcula de distribucion acumulativa.
                if x6 >= 0
                    x61 = 0:0.1:x6;

                    Fx6 = 1-exp(-c * x61); %Para la grafica.
                    Fx6_1 = 1-exp(-c * x6); %Para mostrar solo un valor al usuario.
                else
                    Fx6 = 0 ;
                end

                %Diseno de la grafica DENSIDAD
                axes(handles.axes1)
                cla;
                hold on
                plot(x61, fx6, '-r*',...
                    'LineWidth',2,... %Grosor de linea
                    'MarkerSize',6) %tamano de las figuras
                hold off
                title('Densidad probabilistica exponencial.', 'FontSize',14)
                xlabel('x', 'FontSize',12)
                ylabel('fx(x)', 'FontSize',12)
                grid on;

                %Mostrar el valor de la densidad probabilistica.
                a = fx6_1;
                set(handles.text27, 'String', a);

                %Diseno de la grafica ACUMULACION.
                axes(handles.axes2)
                cla;
                hold on
                plot(x61, Fx6, '-co',... % Color + figura
                    'LineWidth',3,... %Grosor de linea
                    'MarkerSize',5) %tama?o de las figuras
                hold off
                title('Distribucion acumulativa exponencial', 'FontSize',14)
                xlabel('x', 'FontSize',12)
                ylabel('Fx(x)', 'FontSize',12)
                grid on;

                %Mostrar el valor de la distirbucion acumulativa.
                b = Fx6_1;
                set(handles.text29, 'String', b);

                %Mostrar la esperanza matematica
                Ex6 = 1 / c ;
                set(handles.text30, 'String', Ex6)

                %Mostrar la varianza
                Varx6 = 1 / c^(2);
                set(handles.text31, 'String', Varx6)
            else
               errordlg('El valor de x y landa no puede ser negativo, rectifique.','Ilogico') 
            end
        end
    case 3
        %En el caso de que el usuario no introdusca desviacion o media.
        if isempty(get(handles.edit2,'String')) || isempty(get(handles.edit1, 'String'))
            warndlg('Rellene los campos para la media y la desviacion estandar.','Datos insuficientes');
        else
            if isempty(get(handles.edit5,'String')) && isempty(get(handles.edit6, 'String')) && isempty(get(handles.edit7,'String')) && isempty(get(handles.edit16, 'String'))
                errordlg('Debe rellenar alguno de los siguientes campos para usar esta seccion.\n Limites\n Valor para x<=X \n Valor para x>=X\n','Ilogico')
            else
                %Para la desviacion estandar.
                %--------x<=X
                if isempty(get(handles.edit5,'String')) && isempty(get(handles.edit6, 'String')) && isempty(get(handles.edit16, 'String'))
                   integral0 = @(x) exp( -(x.^2/2) );

                    z0 = abs((x70-media)/desv); %Error funcion de x deseada.

                    fx70_0 = (1/sqrt(2*pi) ) * integral(integral0 ,0, z0); %Probabilidad del valor deseado.

                    fx7_0 = (1 / (sqrt(2*pi) * media ) ) * exp( - ((x70_0 - media) ./ (2*desv) ).^2 );

                    %Mostrar el valor de x<=X
                    c = fx70_0;
                    set(handles.text37, 'String', c);

                    %Mostrar el valor de la densidad.
                    X_Menor = 0.5 - fx70_0;
                    d = X_Menor;
                    set(handles.text40, 'String', d);

                    %Grafica DENSIDAD
                    axes(handles.axes1)
                    cla;
                    hold on
                    plot(x70_0, fx7_0, ':gs',... 
                        'LineWidth',2,... %Grosor de linea.
                        'MarkerSize',8) %tama?o de las figuras.
                    fill(x_Menor_Intervalo ,fx7_0, 'r')
                    hold off
                    title('Densidad probabilistica Normal.', 'FontSize',14)
                    xlabel('x', 'FontSize',12)
                    ylabel('fx(x)', 'FontSize',12)
                    grid on;

                    %--------------ACUMULACION
                    %valor  de distribucion acumulada.
                    p1 = normcdf(x70,media,desv);
                    p_menor = 0.5 - p1;

                    %Mostrar el valor al usuario.
                    A1 = p_menor;
                    set(handles.text39, 'String', A1);

                    %Grafica acumulada para x<=X
                    axes(handles.axes2)
                    cla;
                    Fx7_0 = normcdf(x70_0, media, desv);
                    hold on
                    plot(x70_0, Fx7_0, '-.m',...
                        'LineWidth',2,... %Grosor de linea
                        'MarkerSize',9) %tama?o de las figuras.
                    hold off
                    title('Distribucion acumulativa normal.', 'FontSize',14)
                    xlabel('x', 'FontSize',12)
                    ylabel('Fx(x)', 'FontSize',12)
                    grid on;
                elseif isempty(get(handles.edit5,'String')) && isempty(get(handles.edit6, 'String')) && isempty(get(handles.edit7, 'String'))
                    integral0_A = @(x) exp( -(x.^2/2) );

                    z0_A = abs((x70_A-media)/desv); %Error funcion de x deseada.

                    fx70_0_A = (1/sqrt(2*pi) ) * integral(integral0_A ,0, z0_A); %Probabilidad del valor deseado.

                    fx7_0_A = (1 / (sqrt(2*pi) * media ) ) * exp( - ((x70_0_A - media) ./ (2*desv) ).^2 );

                    %Mostrar el valor de x>=X
                    e = fx70_0_A;
                    set(handles.text46, 'String', e);

                    %Mostrar el valor de la densidad.
                    X_Mayor = 0.5 + fx70_0_A;
                    f = X_Mayor;
                    set(handles.text40, 'String', f);

                    %Grafica de densidad.
                    axes(handles.axes1)
                    cla;
                    hold on
                    plot(x70_0_A, fx7_0_A, ':gs',... 
                        'LineWidth',2,... %Grosor de linea.
                        'MarkerSize',8) %tama?o de las figuras.
                    fill(x_Mayor_Intervalo ,fx7_0_A, 'r')
                    hold off
                    title('Densidad probabilistica Normal.', 'FontSize',14)
                    xlabel('x', 'FontSize',12)
                    ylabel('fx(x)', 'FontSize',12)
                    grid on;

                    %--------------ACUMULACION
                    %valor  de distribucion acumulada. Para x>=X
                    p2 = normcdf(x70_A,media,desv);
                    p_mayor = p2 + 0.5;

                    %Mostrar el valor de x>=X
                    B1 = p_mayor;
                    set(handles.text39, 'String', B1);

                    %Grafica acumulada para x>=X
                    axes(handles.axes2)
                    cla;
                    Fx7_1 = normcdf(x70_0_A, media, desv);
                    hold on
                    plot(x70_0_A, Fx7_1, '-.m',...
                        'LineWidth',2,... %Grosor de linea
                        'MarkerSize',9) %tama?o de las figuras.
                    hold off
                    title('Distribucion acumulativa normal.', 'FontSize',14)
                    xlabel('x', 'FontSize',12)
                    ylabel('Fx(x)', 'FontSize',12)
                    grid on;
                %--------x1 <= x <= x2
                elseif isempty(get(handles.edit7,'String')) && isempty(get(handles.edit16, 'String'))
                    if isempty(get(handles.edit5,'String')) || isempty(get(handles.edit6, 'String'))
                        warndlg('Se necesita un valor para ambos limites.','Datos insuficientes');
                    else
                        integral0_1 = @(x) exp( -(x.^2/2) );
                        integral0_2 = @(x) exp( -(x.^2/2) );

                        z1_1 = abs((x72-media)/desv); %Error funcion de x deseada limite inferior.
                        z2_1 = abs((x71-media)/desv); %Error funcion de x deseada limite superior.

                        z71_1 = (1/sqrt(2*pi) ) * integral(integral0_1 ,0, z1_1); %Probabilidad del error funcion de limite inferior.
                        z72_1 = (1/sqrt(2*pi) ) * integral(integral0_2 ,0, z2_1); %Probabilidad del error funcion de limite superior.

                        fx70_1 = z71_1 + z72_1; %Probabilidad del valor deseado.

                        fx7_1 = (1 / (sqrt(2*pi) * media ) ) * exp( - ((x70_Intervalos - media) ./ (2*desv) ).^2 );

                        %Mostar el valor de la distribucion acumulativa.
                        g = fx70_1;
                        set(handles.text40, 'String', g)

                        %Para hacer la grafica.
                        axes(handles.axes1)
                        cla;
                        hold on
                        plot(x70_Intervalos, fx7_1, ':gs',... %fill en lugar de plot.
                            'LineWidth',2,... %Grosor de linea.
                            'MarkerSize',8) %tama?o de las figuras.
                        fill(x70_Intervalos ,fx7_1, 'r')
                        hold off
                        title('Densidad probabilistica Normal.', 'FontSize',14)
                        xlabel('x', 'FontSize',12)
                        ylabel('fx(x)', 'FontSize',12)
                        grid on;

                        %Errores funciones, mostrarlos al usuario.
                        h =z1_1;
                        set(handles.text35, 'String', h)
                        i =z2_1;
                        set(handles.text36, 'String', i)

                        %Probabilidad individual de cada intervalo.
                        j =z71_1;
                        set(handles.text52, 'String', j)
                        k =z72_1;
                        set(handles.text53, 'String', k)

                        %------------------Acumulacion.
                        %Valor de distribucion acumulada para X entre intervalos.
                        p3 = normcdf(x72,media,desv); %Intervalo superior
                        p4 = normcdf(x71,media,desv); %Intervalo inferior
                        pt = abs(p4 - p3);

                        %Mostrar el valor al usuario.
                        C1 = pt;
                        set(handles.text39, 'String', C1)

                        %Grafica acumulada para X entre intervalos.
                        axes(handles.axes2)
                        cla;
                        Fx7_2 = normcdf(x70_Intervalos, media, desv);
                        hold on
                        plot(x70_Intervalos, Fx7_2, '-.m',...
                            'LineWidth',2,... %Grosor de linea
                            'MarkerSize',9) %tama?o de las figuras.
                        hold off
                        title('Distribucion acumulativa normal.', 'FontSize',14)
                        xlabel('x', 'FontSize',12)
                        ylabel('Fx(x)', 'FontSize',12)
                        grid on;
                    end
                end
            end

            %Para la experanza
            Ex7 = media ;
            set(handles.text30, 'String', Ex7)

            %Para la vairanza
            Varx7 = (desv)^(2);
            set(handles.text31, 'String', Varx7)
        end
    otherwise 
        disp('Su eleccion no esta dentro del rango de valores permitidos.')
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


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


% --- Executes on button press in pushbutton4. ESPERANZA
function pushbutton4_Callback(hObject, eventdata, handles, message)
message = sprintf('Es el valor medio obtenido del analisis de datos.\n');
try
	CreateStruct.Interpreter = 'tex';
	CreateStruct.WindowStyle = 'modal';
% 	CreateStruct.Title = 'MATLAB Message';
	
	fontSize = 14;
	% Embed the required tex code in before the string.
	latexMessage = sprintf('\\fontsize{%d} %s', fontSize, message);
	uiwait(msgbox(latexMessage, 'Que es la esperanza matematica?', CreateStruct));
catch ME
	errorMessage = sprintf('Error in msgboxw():\n%s', ME.message);
	fprintf('%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
return;


% --- Executes on button press in pushbutton5. VARIANZA
function pushbutton5_Callback(hObject, eventdata, handles)
message = sprintf('Es la dispercion de los datos analizados.\n');
try
	CreateStruct.Interpreter = 'tex';
	CreateStruct.WindowStyle = 'modal';
% 	CreateStruct.Title = 'MATLAB Message';
	
	fontSize = 14;
	% Embed the required tex code in before the string.
	latexMessage = sprintf('\\fontsize{%d} %s', fontSize, message);
	uiwait(msgbox(latexMessage, 'Que es la varianza?', CreateStruct));
catch ME
	errorMessage = sprintf('Error in msgboxw():\n%s', ME.message);
	fprintf('%s\n', errorMessage);
	uiwait(warndlg(errorMessage));
end
return;


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit18 as text
%        str2double(get(hObject,'String')) returns contents of edit18 as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
