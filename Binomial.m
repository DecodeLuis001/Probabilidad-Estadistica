function varargout = Binomial(varargin)
% BINOMIAL MATLAB code for Binomial.fig
%      BINOMIAL, by itself, creates a new BINOMIAL or raises the existing
%      singleton*.
%
%      H = BINOMIAL returns the handle to a new BINOMIAL or the handle to
%      the existing singleton*.
%
%      BINOMIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BINOMIAL.M with the given input arguments.
%
%      BINOMIAL('Property','Value',...) creates a new BINOMIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Binomial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Binomial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Binomial

% Last Modified by GUIDE v2.5 08-Dec-2020 20:55:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Binomial_OpeningFcn, ...
                   'gui_OutputFcn',  @Binomial_OutputFcn, ...
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


% --- Executes just before Binomial is made visible.
function Binomial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Binomial (see VARARGIN)

% Choose default command line output for Binomial
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Binomial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Binomial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Calcular.
function Calcular_Callback(hObject, eventdata, handles)

dst=get(handles.Dist,'Value');                  %Deteccion del menu pop
pr=str2double(get(handles.P,'String'));         %Optencion de valor de probabilidad
nm=round(str2double(get(handles.N,'String')));  %Obtencion de numero de repeticiones
set(handles.N,'String',num2str(nm))             %Reflejo del valor en la casilla de repeticiones, redondeando para evitar problemas

%Verificacion y control de la posibilidad de pasar del metodo binomial al
%de Poisson
if (nm*pr <= 5) && (nm>1) && (pr<1) && (dst==1)
    anw=questdlg('¿Quiere aplicar distribucion de Poisson para este caso?','Posibilidad','Si','No','Si');
    switch anw
        case 'Si'
            dst=2;
            set(handles.Dist,'Value',2)
        case 'No'
            dst=get(handles.Dist,'Value');
    end
end
% if
% end
switch dst
    case 1      %Caso en el que se dispone el usuario para el uso de la distribucion Binomal
        opc=get(handles.Selector,'Value');
        intr=zeros(1,2);
        intr(1,1)=0;
        pb=0;
         if isempty(get(handles.a,'String')) || isempty(get(handles.P,'String')) || isempty(get(handles.N,'String'))
             errordlg('Llene los campos faltantes estos puden ser a, b, P, N','Error')
             return
%         elseif isempty(get(handles.a,'String')) %|| isempty(get(handles.P,'String')) && isempty(get(handles.N,'String'))
%             errordlg('Llene el campos: a','Error')
%             return
%         elseif isempty(get(handles.P,'String')) %&& isempty(get(handles.P,'String')) || isempty(get(handles.N,'String'))
%             errordlg('Llene el campos: P','Error')
%             return
%         elseif not(isempty(get(handles.N,'String'))) %&& isempty(get(handles.P,'String')) || isempty(get(handles.N,'String'))
%             errordlg('Llene el campos: N','Error')
%             return
%         elseif isempty(get(handles.a,'String')) && isempty(get(handles.P,'String'))
%             errordlg('Llene el campos: a, P','Error')
%             return
         end
        %while pb ~= 1
        
        %Testeo de las probabilidades en caso de ser menor o igual a 0 o
        %mayor a 1
        
        P=str2double(get(handles.P,'String'));
        if P<0
            errordlg('La probabilidad no puede ser negativa','Error')
            P=0.1;
        elseif P==0
            errordlg('La probabilidad no puede ser 0','Error')
            P=0.1;
        elseif P>1
            errordlg('La probabildad no puede ser mayor a 1','Error')
            P=0.1;
        elseif P==1
            errordlg('La probabilidad no puede ser 1','Error')
            P=0.1;
        end
               
        
        
       % end
        n=str2double(get(handles.N,'String'));
        intr(1,2)=n;
        
        %Obtencion de los valores que conforman la densidad
        grf=zeros(1,n);
        for k=0:n
            fc=(factorial(n))./((factorial(k)).*(factorial(n-k)));
            grf(1,k+1)=(P.^k)*((1-P).^(n-k))*(fc);
            
        end
        
        %Realizacion de la acumulacion de la densidad
        acus=zeros(1,n);
        for s=1:intr(1,2)
            if s == 1
                acus(1,1)=acus(1,1)+grf(1,1);
            elseif s==n
                acus(1,n)=1;
            else
                acus(1,s)=acus(1,s-1)+grf(1,s);
            end
        end
        
        %Seccion para graficar las distribuciones acumulada o densidad
        x=intr(1,1):n;
        xx=linspace(intr(1,1),intr(1,2),n);
        %s(1)=subplot(1,4,[1,2]);
        stairs(handles.axes2,xx,acus,'-')
        axis(handles.axes2, [0 n 0 1])
        stem(handles.axes1,x,grf,'o')
        
        %subplot(1,4,[3,4]);
        
        
        
        switch opc
            case 1      %Cuando se quiere saber la probabilidad de un valor especifico X=x
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx > intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(n*P*(1-P));
                    set(handles.Desv,'String',num2str(ds))
                    
                    %             xc=['X=',num2str(vx),'=0'];
                    %             display(xc)
                    
                    %cont=input('Desea continuar con esta distribucion 1)No / 0)Si: ');
                elseif vx < intr(1,1)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    %             xc=['X=',num2str(vx),'=0'];
                    %             display(xc)
                    %cont=input('Desea continuar con esta distribucion 1)No / 0)Si: ');
                else
                    
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %fc=0;
                    %fin=0;
                    fc=(factorial(n))./((factorial(vx)).*(factorial(n-vx)));
                    fin=(P.^vx)*((1-P).^(n-vx)).*(fc);
                    
                    set(handles.Prob,'String',num2str(fin))
                    dlt=['P=',fin];
                    set(handles.prb,'String',dlt)
                    %         xc=['X=',num2str(vx),'=',num2str(fin)];
                    %         display(xc);
                    %cont=input('Desea continuar con esta distribucion 1)No / 0)Si: ');
                end
            case 2      %Cuando se quire saber la probabilidad de X<=x
                fc=0;
                fn=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %xc=['X<',num2str(vx),'=0'];
                    %display(xc)
                    %cont=input('Desea continuar con esta distribucion 1)No / 0)Si: ');
                elseif vx == intr(1,2)
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx >= intr(1,2)
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %xcc=['X<=',num2str(vx),'=1'];
                    %display(xcc)
                    %cont=input('Desea continuar con esta distribucion 1)No / 0)Si: ');
                elseif vx < intr(1,2)
                    for i=1:vx+1
                        fn=grf(1,i)+fn;
                    end
                    %exc=0;
                    set(handles.Prob,'String',num2str(fn))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx<0
                    fn=grf(1,1);
                    set(handles.Prob,'String',num2str(fn))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %fc=0;
                    %fin=0;
                    for i=1:vx+1
                        fn=grf(1,i)+fn;
                    end
                    %             for i=0:vx
                    % %                 if vx < 0
                    % %                     vx=0;
                    % %                     %rs= vx-i;
                    % %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    % %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    % %                     fn=prs+fn;
                    % %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    
                    set(handles.Prob,'String',num2str(fn))
                    dlt='P<=';
                    set(handles.prb,'String',dlt)
                    %             fn = espn(vx,P,n);
                    %             xc=['X<',num2str(vx),'=',num2str(fn)];
                    %             display(xc);
                    %cont=input('Desea continuar con esta distribucion 1)No / 0)Si: ');
                end
            case 3     %Probabilidad de X<x
                fc=0;
                fx=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif vx > intr(1,2)
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif vx==intr(1,2)
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx%vx+1
                        fx=grf(1,i)+fx;
                    end
                    set(handles.Prob,'String',num2str(fx))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx==0
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    fx=0;
                    set(handles.Prob,'String',num2str(fx))
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx%vx+1
                        fx=grf(1,i)+fx;
                    end
                    %             for i=0:vx-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    set(handles.Prob,'String',num2str(fx))
                end
            case 4      %Probabilidad de X>=x
                fc=0;
                fx=0;
                fvv=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx > intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx==intr(1,2)
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx%vx+1
                        fx=grf(1,i)+fx;
                    end
                    exc=1-fx;
                    set(handles.Prob,'String',num2str(exc))
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx%vx+1
                        fx=grf(1,i)+fx;
                    end
                    %             for i=0:vx-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    fvv=1-fx;
                    set(handles.Prob,'String',num2str(fvv))
                end
            case 5      %Probabilidad de X>x
                fc=0;
                fn=0;
                fv=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx > intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx==intr(1,2)
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                elseif vx<0
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx+1
                        fn=grf(1,i)+fn;
                    end
                    %             for i=0:vx
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    
                    fv=1-fn;
                    set(handles.Prob,'String',num2str(fv))
                end
            case 6      %Probabilidad de a<X<b
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fn=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                
                if intvls(1,1)>intr(1,2)% && (intvls(1,2)>intr(1,2))
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif intvls(1,2)<intr(1,1) %&& (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif intvls(1,2) > intr(1,2)
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %esp
                    %             for i=0:n-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    %
                    %             %espn
                    %             for i=0:intvls(1,1)
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    
                    %esp
                    for i=1:n%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fn=grf(1,i)+fn;
                    end
                    
                    vlrs=1-fn;
                    set(handles.Prob,'String',num2str(vlrs))
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %esp
                    %             for i=0:intvls(1,2)-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    %
                    %             %espn
                    %             for i=0:intvls(1,1)
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    %esp
                    for i=1:intvls(1,2)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fn=grf(1,i)+fn;
                    end
                    vlrs=fx-fn;
                    set(handles.Prob,'String',num2str(vlrs))
                end
            case 7          %Probabilidad de a<=X<=b
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fn=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                if intvls(1,1)>intr(1,2) %&& (intvls(1,2)>intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2)<intr(1,1)% && (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2) > intr(1,2)
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %espn
                    %             for i=0:n
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    %
                    %             %esp
                    %             for i=0:intvls(1,1)-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    %espn
                    for i=1:n+1
                        fn=grf(1,i)+fn;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    vlrs=1-fx;
                    set(handles.Prob,'String',num2str(vlrs))
                    
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %espn
                    %             for i=0:intvls(1,2)
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    %
                    %             %esp
                    %             for i=0:intvls(1,1)-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    %espn
                    for i=1:intvls(1,2)+1
                        fn=grf(1,i)+fn;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    vlrs=fn-fx;
                    set(handles.Prob,'String',num2str(vlrs))
                end
            case 8          %Probabilidad de a<=X<b
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fxx=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                if intvls(1,1)>intr(1,2)% && (intvls(1,2)>intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2)<intr(1,1)% && (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2) > intr(1,2)
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %esp
                    %             for i=0:n-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    %
                    %             %esp
                    %             for i=0:intvls(1,1)-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fxx=prs+fx;
                    %             end
                    %esp
                    for i=1:n%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=1-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %esp
                    %             for i=0:intvls(1,2)-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fx=prs+fx;
                    %             end
                    %
                    %             %esp
                    %             for i=0:intvls(1,1)-1%vx+1
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fx=prs+fx;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fxx=prs+fxx;
                    %             end
                    for i=1:intvls(1,2)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=fx-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                end
            case 9          %Probabilidad de a<X<=b
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fn=0;
                fxx=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                if intvls(1,1)>intr(1,2)% && (intvls(1,2)>intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2)<intr(1,1)% && (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2) > intr(1,2)
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %espn
                    %             for i=0:n
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    %
                    %             %espn
                    %             for i=0:intvls(1,1)
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fxx=prs+fxx;
                    %             end
                    %espn
                    for i=1:n+1
                        fn=grf(1,i)+fn;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=1-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                else
                    hp=n*P;
                    set(handles.Espe,'String',num2str(hp))
                    var=hp*(1-P);
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    %             %espn
                    %             for i=0:intvls(1,2)
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fn=prs+fn;
                    %             end
                    %
                    %             %espn
                    %             for i=0:intvls(1,1)
                    %                 if vx < 0
                    %                     vx=0;
                    %                     %rs= vx-i;
                    %                     fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                     prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                     fn=prs+fn;
                    %                 end
                    %                 %rs= vx-i;
                    %                 fc=(factorial(n))./((factorial(i)).*(factorial(n-i)));
                    %                 prs=(P.^i)*((1-P).^(n-i))*(fc);
                    %                 fxx=prs+fxx;
                    %             end
                    %espn
                    for i=1:intvls(1,2)+1
                        fn=grf(1,i)+fn;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=fn-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                end
        end
    case 2      %Cuando se selecciona en el menu pop la distribucion de Poisson
        opc=get(handles.Selector,'Value');
        p=str2double(get(handles.P,'String'));
        if p<0
            errordlg('La probabilidad no puede ser negativa','Error')
            p=0;
        elseif p==0
            errordlg('La probabilidad no puede ser 0','Error')
            p=0;
        elseif p>1
            errordlg('La probabildad no puede ser mayor a 1','Error')
            p=0;
        elseif p==1
            errordlg('La probabilidad no puede ser 1','Error')
            p=0;
        end
        n=round(str2double(get(handles.N,'String')));
        intr=zeros(1,2);
        vlr=0;
        cnt=0;
        s=0;
        lam=0;
        
        if isempty(get(handles.lam,'String')) || isempty(get(handles.a,'String')) && isempty(get(handles.b,'String'))
             errordlg('Llene los campos faltantes estos puden ser a, b, lam','Error')
             return
         end
        
        %Seccion de seleccion de la forma en la que se esta obteniendo la
        %lamnda necesitada para la distribucion, en la primera parete es en
        %el caso de que el campo de lamnda este vacio y toma los valores de
        %los campos N y P
        %En el segundo caso si se encuentra lleno el campo de la lamnda es
        %de este de donde obtendra el valor para aplicar la distribucion
        if isempty(get(handles.lam,'String')) %&& isempty(get(handles.P,'String')) && isempty(get(handles.N,'String'))
            lam=round(n*p);
            set(handles.lam,'String',num2str(lam))
        else
            %lam=round(str2double(get(handles.lam,'String')));
            lam=str2double(get(handles.lam,'String'));
            set(handles.lam,'String',num2str(lam))
        end
        
        %lam=round(str2double(get(handles.lam,'String')));
        
        if lam<0
            lam=0;
        end
        
        %Determinacion del numero de intervalos que se tendra en el
        %desarrollo para aplicar esta distribucion 
        while vlr ~= 1
            vlr=0;
            for i=0:s
                pp=exp(-lam).*((lam.^i)./(factorial(i)));
                vlr=pp+vlr;
                cnt=i;
            end
            if vlr>0.999999999999999%isnan(vlr)%vlr >= (1000000)*(10^-6)
                break
            end
            s=s+1;
        end
        
        %Seccion de determinacion de los valores para las graficas
        intr(1,1)=0;
        intr(1,2)=cnt;
        
        %Seccion donde se realiza la obtencion de los valores de la
        %distribucion
        grf=zeros(1,cnt);
        for k=0:cnt
            grf(1,k+1)=(exp(-lam))*((lam^k)/(factorial(k)));%(P.^k)*((1-P).^(n-k))*(fc);
        end
        
        %Seccion en donde se realiza la acumulacion de los valores
        %individuales de la seccion
        acus=zeros(1,cnt);
        for s=1:intr(1,2)
            
            if s == 1
                acus(1,1)=acus(1,1)+grf(1,1);
                
            elseif s==cnt
                acus(1,cnt)=1;
            else
                acus(1,s)=acus(1,s-1)+grf(1,s);
                
            end
        end
        
        %Seccion de las graficas
        x=intr(1,1):cnt;
        xx=linspace(intr(1,1),intr(1,2),cnt);
        
        stem(handles.axes1,x,grf,'o')
        
        stairs(handles.axes2,xx,acus,'-')
        %intr(1,1)=0;
        %P=str2double(get(handles.P,'String'));
        n=cnt;
        %intr(1,2)=n;
        switch opc
            case 1
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx > intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                elseif vx < intr(1,1)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                   
                else
                    
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                    fin=grf(1,vx+1);
                    
                    set(handles.Prob,'String',num2str(fin))
                    dlt=['P=',fin];
                    set(handles.prb,'String',dlt)
                   
                end
            case 2
                fc=0;
                fn=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                elseif vx >= intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                    for i=1:vx+1
                        fn=grf(1,i)+fn;
                    end
                                        
                    set(handles.Prob,'String',num2str(fn))
                    dlt='P<=';
                    set(handles.prb,'String',dlt)
                    
                end
            case 3
                fc=0;
                fx=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx >= intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    set(handles.Prob,'String',num2str(fx))
                end
            case 4
                fc=0;
                fx=0;
                fvv=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx > intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx==intr(1,2)
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    fvv=1-fx;
                    set(handles.Prob,'String',num2str(fvv))
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    fvv=1-fx;
                    set(handles.Prob,'String',num2str(fvv))
                end
            case 5
                fc=0;
                fn=0;
                fv=0;
                s=0;
                s=round(str2double(get(handles.a,'String')));
                vx=s;
                set(handles.a,'String',num2str(vx))
                if vx < intr(1,1)
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx >= intr(1,2)
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                elseif vx==intr(1,2)
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                elseif vx<0
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:vx+1
                        fn=grf(1,i)+fn;
                    end
                                        
                    fv=1-fn;
                    set(handles.Prob,'String',num2str(fv))
                end
            case 6
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fn=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                if intvls(1,1)>intr(1,2)% && (intvls(1,2)>intr(1,2))
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2)<intr(1,1) %&& (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2) > intr(1,2)
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                    for i=1:n%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fn=grf(1,i)+fn;
                    end
                    
                    vlrs=1-fn;
                    set(handles.Prob,'String',num2str(vlrs))
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                    for i=1:intvls(1,2)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fn=grf(1,i)+fn;
                    end
                    vlrs=fx-fn;
                    set(handles.Prob,'String',num2str(vlrs))
                end
            case 7
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fn=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                if intvls(1,1)>intr(1,2) %&& (intvls(1,2)>intr(1,2))
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2)<intr(1,1)% && (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2) > intr(1,2)
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:n
                        fn=grf(1,i)+fn;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    vlrs=1-fx;
                    set(handles.Prob,'String',num2str(vlrs))
                    
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:intvls(1,2)
                        fn=grf(1,i)+fn;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    vlrs=fn-fx;
                    set(handles.Prob,'String',num2str(vlrs))
                end
            case 8
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fxx=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                if intvls(1,1)>intr(1,2)% && (intvls(1,2)>intr(1,2))
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2)<intr(1,1)% && (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2) > intr(1,2)
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                   
                    for i=1:n%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=1-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:intvls(1,2)%vx+1
                        fx=grf(1,i)+fx;
                    end
                    
                    %esp
                    for i=1:intvls(1,1)%vx+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=fx-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                end
            case 9
                vlrs=0;
                s=0;
                s=str2double(get(handles.a,'String'));
                vx=s;
                intvls=zeros(1,2);
                fx=0;
                fxx=0;
                fn=0;
                intvls(1,1)=round(str2double(get(handles.a,'String')));
                set(handles.a,'String',num2str(intvls(1,1)))
                intvls(1,2)=round(str2double(get(handles.b,'String')));
                set(handles.b,'String',num2str(intvls(1,2)))
                if intvls(1,1) >= intvls(1,2) && intvls(1,2) <= intvls(1,1)
                    intvls(1,1)=0;
                    set(handles.a,'String',num2str(intvls(1,1)))
                    intvls(1,2)=round(str2double(get(handles.N,'String')));
                    set(handles.b,'String',num2str(intvls(1,2)))
                    errordlg('No puede ser a > b','Error')
                end
                if intvls(1,1)>intr(1,2)% && (intvls(1,2)>intr(1,2))
                    exc=1;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2)<intr(1,1)% && (intvls(1,2)<intr(1,2))
                    exc=0;
                    set(handles.Prob,'String',num2str(exc))
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                elseif intvls(1,2) > intr(1,2)
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    
                    for i=1:n+1
                        fn=grf(1,i)+fn;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=1-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                else
                    hp=lam;
                    set(handles.Espe,'String',num2str(hp))
                    var=lam;
                    set(handles.Varia,'String',num2str(var))
                    ds=sqrt(var);
                    set(handles.Desv,'String',num2str(ds))
                    for i=1:intvls(1,2)+1
                        fn=grf(1,i)+fn;
                    end
                    
                    %espn
                    for i=1:intvls(1,1)+1
                        fxx=grf(1,i)+fxx;
                    end
                    vlrs=fn-fxx;
                    set(handles.Prob,'String',num2str(vlrs))
                end
        end
end

% hObject    handle to Calcular (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function a_Callback(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a as text
%        str2double(get(hObject,'String')) returns contents of a as a double


% --- Executes during object creation, after setting all properties.
function a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_Callback(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b as text
%        str2double(get(hObject,'String')) returns contents of b as a double


% --- Executes during object creation, after setting all properties.
function b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Selector.
function Selector_Callback(hObject, eventdata, handles)
% hObject    handle to Selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Selector contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Selector




% --- Executes during object creation, after setting all properties.
function Selector_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Selector (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P_Callback(hObject, eventdata, handles)
% hObject    handle to P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P as text
%        str2double(get(hObject,'String')) returns contents of P as a double


% --- Executes during object creation, after setting all properties.
function P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on selection change in Dist.
function Dist_Callback(hObject, eventdata, handles)
% hObject    handle to Dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Dist contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Dist


% --- Executes during object creation, after setting all properties.
function Dist_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lam_Callback(hObject, eventdata, handles)
% hObject    handle to lam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lam as text
%        str2double(get(hObject,'String')) returns contents of lam as a double


% --- Executes during object creation, after setting all properties.
function lam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Regresar.
function Regresar_Callback(hObject, eventdata, handles)
hfig=get(0,'CurrentFigure');
delete(hfig)
run('Login.m')
% hObject    handle to Regresar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function Desv_Callback(hObject, eventdata, handles)
% hObject    handle to Desv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Desv as text
%        str2double(get(hObject,'String')) returns contents of Desv as a double


% --- Executes during object creation, after setting all properties.
function Desv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Desv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
