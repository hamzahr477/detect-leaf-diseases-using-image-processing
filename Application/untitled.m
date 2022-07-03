function varargout = untitled(varargin)
% UNTITLED MATLAB code for untitled.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled

% Last Modified by GUIDE v2.5 12-Jul-2021 18:45:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled_OutputFcn, ...
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


% --- Executes just before untitled is made visible.
function untitled_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled (see VARARGIN)

% Choose default command line output for untitled
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global I;
[image, path] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Choisissez une image');
I = imread([path,image]);
set(handles.axes1,'Units','pixels');
resizePos = get(handles.axes1,'Position');
IShow= imresize(I, [resizePos(3) resizePos(3)]);
axes(handles.axes1);
imshow(IShow);
set(handles.axes1,'Units','normalized');
cla(handles.axes2);
cla(handles.axes3);
myString=sprintf("Taille de feuille  : \nTaille de maladie : \nPourcentage d'infectation : ");
set(handles.text7, 'String', myString);

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
global algo;
try
    % Get value of popup
    selectedIndex = get(handles.popupmenu1, 'value');
    % Take action based upon selection
    if selectedIndex  == 1
        algo="algo1";
        set(handles.pushbutton2, 'Visible', 'on');
    elseif selectedIndex == 2
        algo="algo2";
        set(handles.pushbutton2, 'Visible', 'off');
    elseif selectedIndex == 3
        algo="algo3";
        set(handles.pushbutton2, 'Visible', 'on');
    end
catch ME
  errorMessage = sprintf('Error in function %s() at line %d.\n\nError Message:\n%s', ...
    ME.stack(1).name, ME.stack(1).line, ME.message);
  fprintf(1, '%s\n', errorMessage);
  uiwait(warndlg(errorMessage));
end
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
global plantnumber;
global I;
global clust;
global algo;
allItems = get(handles.popupmenu1,'string');
    switch get(handles.popupmenu1,'value')
         case 1
             algo="algo1";
            plants = plantdetection(I);
            figure
            for i=1:size(plants,3)
                subplot(1,size(plants,3),i);
                imshow(uint8(plants(:,:,i).*double(I)));
                title(["cluster";i]);
            end
            prompt = {'Quelle plante vous voulez faire le traitement'};
            dlgtitle = 'Plante nombre';
            definput = {'1'};
            dims = [1 40];
            opts.Interpreter = 'tex';
            plantnumber = inputdlg(prompt,dlgtitle,dims,definput,opts);
            clust=uint8(plants(:,:,str2double(plantnumber)).*double(I));
            set(handles.axes2,'Units','pixels');
            resizePos = get(handles.axes2,'Position');
            clustshow= imresize(clust, [resizePos(3) resizePos(3)]);
            axes(handles.axes2);
            imshow(clustshow);
            set(handles.axes2,'Units','normalized');
         case 2
             algo="algo2";
         case 3
            fprintf(allItems{3});
    end
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global algo;
global clust
global I;
fprintf(algo);
switch algo
    case "algo1"
        malade=maladedetection(clust);
        set(handles.axes3,'Units','pixels');
        resizePos = get(handles.axes3,'Position');
        maladeshow= imresize(malade, [resizePos(3) resizePos(3)]);
        axes(handles.axes3);
        imshow(maladeshow);
                figure;        imshow(maladeshow);
        set(handles.axes3,'Units','normalized');
        [A1,A2,p]=pourcentageofmalad(clust,malade);
        myString = sprintf("Taille de feuille  :%g\nTaille de maladie :%g\nPourcentage d'infectation :%g%% \n",A2,A1,p);
        set(handles.text7, 'String', myString);
    case "algo2"
        [A1,A2,p,plant,malade]=maladedetectionKmeans(I);
        set(handles.axes2,'Units','pixels');
        resizePos = get(handles.axes2,'Position');
        plantshow= imresize(plant, [resizePos(3) resizePos(3)]);
        axes(handles.axes2);
        imshow(plantshow);
        set(handles.axes2,'Units','normalized');
        set(handles.axes3,'Units','pixels');
        resizePos = get(handles.axes3,'Position');
        maladeshow= imresize(malade, [resizePos(3) resizePos(3)]);
        axes(handles.axes3);
        imshow(maladeshow);    
                        figure;        imshow(maladeshow);

        [A11,A22,pp]=pourcentageofmalad(plant,malade);
        set(handles.axes3,'Units','normalized');
        myString = sprintf("Methode 1 : \nTaille de feuille  :%g\nTaille de maladie :%g\nPourcentage d'infectation :%g%% \nMethode 2 : \nTaille de feuille  :%g\nTaille de maladie :%g\nPourcentage d'infectation :%g%% \n",A2,A1,p,A22,A11,pp);
        set(handles.text7, 'String', myString);
    case "algo3"
end
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
