VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cTaskBar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          cTaskBar.cls
' NOMBRE LOGICO:    cTaskBar
' PRODUCTO:         Terminal Administrativa
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
'cTaskBar.cls Clase para manipular la barra de tareas (taskbar)             (28/Sep/98)
'Métodos:
'   Save        Guarda los valores actuales
'   Restore     Restaura los valores que había al crear la clase o al guardar (*)
'   Hide        Oculta la barra de tareas
'   Show        Muestra la barra de tareas
'Propiedades:
'   AlwaysOnTop Devuelve o cambia el estado de Siempre visible
'   AutoHide    Devuelve o cambia el estado de Ocultar automáticamente (*)
'
'(*) No funciona la asignación de AutoHide (Ocultar automáticamente)
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************


Option Explicit

'Valores privados para el estado de la barra de tareas
Private m_AlwaysOnTop       As Boolean
Private m_AutoHide          As Boolean

'Valores del estado incial o el usado con el método Save
Private m_Saved_AlwaysOnTop As Boolean
Private m_Saved_AutoHide    As Boolean

'
Private m_hWnd              As Long ' El hWnd de la barra de tareas
Private m_uEdge             As Long ' La localización de la barra de tareas
Private m_Pos               As RECT ' Las coordenadas de la posición de la barra de tareas
'
'Los comentarios y los valores están sacados del fichero ShellAPI.h
'y de la ayuda Win32.hlp
'
'Constantes
Public Enum eTaskBar
    'Valores para dwMessage, Identifier of the appbar message to send
    '
    ABM_NEW = &H0           ' Registers a new appbar and specifies the message identifier that the system should use to send notification messages to the appbar
    ABM_REMOVE              ' Unregisters an appbar, removing bar from the system's internal list
    ABM_QUERYPOS            ' Requests a size and screen position for an appbar
    ABM_SETPOS              ' Sets the size and screen position of an appbar
    ABM_GETSTATE            ' Retrieves the autohide and always-on-top states of the Windows taskbar
    ABM_GETTASKBARPOS       ' Retrieves the bounding rectangle of the Windows taskbar
    ABM_ACTIVATE            ' Notifies the system that an appbar has been activated
                            '   // lParam == TRUE/FALSE means activate/deactivate
    ABM_GETAUTOHIDEBAR      ' Retrieves the handle of the autohide appbar associated with a particular edge of the screen
    ABM_SETAUTOHIDEBAR      ' Registers or unregisters an autohide appbar for an edge of the screen
                            '   // this can fail at any time.  MUST check the result
                            '   // lParam = TRUE/FALSE  Set/Unset
                            '   // uEdge = what edge
    ABM_WINDOWPOSCHANGED    ' Notifies the system when an appbar's position has changed
    '
    '// these are put in the wparam of callback messages
    ABN_STATECHANGE = &H0   ' 0x0000000
    ABN_POSCHANGED = &H1    ' 0x0000001
    ABN_FULLSCREENAPP = &H2 ' 0x0000002
    ABN_WINDOWARRANGE = &H3 ' 0x0000003 // lParam == TRUE means hide
End Enum
    '
Public Enum eTaskBarFlags
    '// flags for get state
    ABS_NONE = &H0          ' No es ni AutoHide ni AlwaysOntop
    ABS_AUTOHIDE = &H1      ' Es AutoHide
    ABS_ALWAYSONTOP = &H2   ' Es AlwaysOnTop
End Enum
    '
Public Enum eTaskBarEdge
    ' Usados para especificar los límites de la pantalla (ver uEdge)
    ABE_LEFT = &H0          ' 0
    ABE_TOP = &H1           ' 1
    ABE_RIGHT = &H2         ' 2
    ABE_BOTTOM = &H3        ' 3
End Enum

'Tipos definidos
Private Type RECT
    Left    As Long
    Top     As Long
    Right   As Long
    Bottom  As Long
End Type

Private Type APPBARDATA
    cbSize              As Long ' sizeof(APPBARDATA)
    hWnd                As Long ' handle of appbar
    uCallbackMessage    As Long ' Application-defined message identifier.
                                ' The application uses the specified identifier for notification messages
                                ' that it sends to the the appbar identified by the hWnd member.
                                ' This member is used when sending the ABM_NEW message
    uEdge               As Long ' Flag that specifies an edge of the screen.
                                ' This member can be one of the following values:
                                ' ABE_LEFT, ABE_RIGHT, ABE_BOTTOM, ABE_TOP
    rc                  As RECT ' RECT structure that contains the bounding rectangle,
                                ' in screen coordinates, of an appbar or the Windows taskbar.
                                ' This member is used when sending the ABM_GETTASKBARPOS, ABM_QUERYPOS, and ABM_SETPOS messages
    lParam              As Long ' Message-dependent value.
                                ' This member is used with the ABM_SETAUTOHIDEBAR message
End Type

'Función del API
'   dwMessage   Identifier of the appbar message to send.
'   pabd        Pointer to an APPBARDATA structure.
'               The content of the structure depends on the value of dwMessage.
'
'   Returns a message-dependent value. For more information, see the documentation for the individual appbar messages
'
Private Declare Function SHAppBarMessage Lib "shell32.dll" _
    (ByVal dwMessage As Long, pData As APPBARDATA) As Long

'
''Para notificar a la barra de tarea que se han cambiado los valores
'Const WM_WINDOWPOSCHANGED = &H47
'
'Private Declare Function SendMessage Lib "user32" Alias "SendMessageA" _
'    (ByVal hWnd As Long, ByVal wMsg As Long, _
'    ByVal wParam As Long, lParam As Any) As Long
'

'Los métodos para Ocultar y Mostrar la barra de tareas,
'lo saqué de un post de las news enviado por: Jason Cueny

'Constantes para SetWindowsPos
'   Valores de wFlags
Const SWP_NOSIZE = &H1
Const SWP_NOMOVE = &H2
Const SWP_NOACTIVATE = &H10
Const SWP_SHOWWINDOW = &H40
Const SWP_HIDEWINDOW = &H80

'   Valores de hwndInsertAfter
'! removed Const HWND_TOP As Long = 0

Const HWND_BOTTOM       As Long = 1
Const HWND_TOPMOST      As Long = -1
'! removed Const HWND_NOTOPMOST As Long = -2


Private Declare Function SetWindowPos Lib "user32" _
    (ByVal hWnd As Long, ByVal hWndInsertAfter As Long, _
    ByVal X As Long, ByVal Y As Long, _
    ByVal cx As Long, ByVal cy As Long, ByVal wFlags As Long) As Long

Private Declare Function FindWindow Lib "user32" Alias "FindWindowA" _
    (ByVal lpClassName As String, ByVal lpWindowName As String) As Long


'! Public Sub Hide()
'!     'Oculta la barra de tarea
'! 
'!     Call SetWindowPos(m_hWnd, 0, 0, 0, 0, 0, SWP_HIDEWINDOW)
'! End Sub
'! 
'! 
'! Public Sub Show()
'!     'Muestra la barra de tarea
'! 
'!     Call SetWindowPos(m_hWnd, 0, 0, 0, 0, 0, SWP_SHOWWINDOW)
'! End Sub
'! 
'! 
Public Sub Save()
    'Este método guarda el estado actual de la barra de tareas

    'Obtener el estado actual
    Call GetState
    'Guardar los valores
    m_Saved_AlwaysOnTop = m_AlwaysOnTop
    m_Saved_AutoHide = m_AutoHide
End Sub


'! Public Sub Restore()
'!     'Restaura el estado inicial o el guardado de la barra de tareas
'!     AlwaysOnTop = m_Saved_AlwaysOnTop
'!     AutoHide = m_Saved_AutoHide
'! End Sub
'! 
'! 
Private Sub Class_Initialize()
    'Asignar los valores iniciales
    m_hWnd = FindWindow("Shell_traywnd", "")

    'Obtener el tamaño y la posición de la barra de tareas
    Dim abd As APPBARDATA

    With abd
        .cbSize = Len(abd)
        .hWnd = m_hWnd
    End With
    Call SHAppBarMessage(ABM_GETTASKBARPOS, abd)

    'Asignar los valores a las variables a nivel de módulo
    With abd
        m_uEdge = .uEdge
        m_Pos.Bottom = .rc.Bottom
        m_Pos.Left = .rc.Left
        m_Pos.Right = .rc.Right
        m_Pos.Top = .rc.Top
    End With

    'Guardar los valores iniciales
    Save
End Sub


'! Public Property Get AlwaysOnTop() As Boolean
'!     'Devuelve el estado de Siempre visible
'!     'devolverá True si este valor está asignado
'!     '
'!     'Leer de nuevo el valor por si ha cambiado desde que se inició
'!     Call GetState
'!     AlwaysOnTop = m_AlwaysOnTop
'! End Property
'! 
'! 
Public Property Let AlwaysOnTop(ByVal bNewValue As Boolean)
    'Asigna el nuevo estado de Siempre visible
    '
    'ATENCION:  Este cambio no modifica el valor mostrado en las propiedades
    '           de la barra de tareas, pero si que modifica el estado
    '----------------------------------------------------------------------------------
    'Constante para los Flags de SetWindowPos
    Const wFlags As Long = SWP_NOMOVE Or SWP_NOSIZE Or SWP_NOACTIVATE

    'Sólo si ha cambiado desde la última vez
    If bNewValue <> m_AlwaysOnTop Then
        'Posicionarlo arriba o abajo, según el valor del parámetro
        Call SetWindowPos(m_hWnd, _
                        IIf(bNewValue, HWND_TOPMOST, HWND_BOTTOM), _
                            0, 0, 0, 0, wFlags)
        m_AlwaysOnTop = bNewValue
    End If

    'Esto es lo mismo que esto otro:
    '
    'If bNewValue Then
    '    Call SetWindowPos(m_hWnd, HWND_TOPMOST, 0, 0, 0, 0, wFlags)
    'Else
    '    Call SetWindowPos(m_hWnd, HWND_BOTTOM, 0, 0, 0, 0, wFlags)
    'End If
End Property


'! Public Property Get AutoHide() As Boolean
'!     'Devuelve el estado de Ocultar automáticamente
'!     'devolverá True si este valor está asignado
'!     '
'!     'Leer de nuevo el valor por si ha cambiado desde que se inició
'!     Call GetState
'!     AutoHide = m_AutoHide
'! End Property
'! 
'! 
Public Property Let AutoHide(ByVal bNewValue As Boolean)
    'Asigna el nuevo estado de Ocultar automáticamente
    '
    '$No funciona...
    '
    '----------------------------------------------------------------------------------
    Dim abd As APPBARDATA
    Dim ret As Long

    'Sólo cambiarlo si el nuevo valor es diferente
    If bNewValue <> m_AutoHide Then
        '
        With abd
            .cbSize = Len(abd)
            .hWnd = m_hWnd
            .uEdge = m_uEdge
            .lParam = -1 * bNewValue
        End With
        ret = SHAppBarMessage(ABM_SETAUTOHIDEBAR, abd)
        'Asignar el nuevo valor
        m_AutoHide = bNewValue
    End If
End Property


Private Function GetState() As eTaskBarFlags
    'Obtiene los valores actuales de la barra de tareas
    Dim abd As APPBARDATA
    Dim i As Long

    With abd
        .cbSize = Len(abd)
        .hWnd = m_hWnd
    End With

    i = SHAppBarMessage(ABM_GETSTATE, abd)

    'Asignar los valores del estado actual
    m_AlwaysOnTop = i And ABS_ALWAYSONTOP
    m_AutoHide = i And ABS_AUTOHIDE

    'Devolver el valor, valdrá cero si no es AutoHide ni AlwaysOnTop
    GetState = i
End Function






