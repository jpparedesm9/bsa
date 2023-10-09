VERSION 5.00
Begin VB.Form FAcerca 
   BackColor       =    &H8000000F&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Acerca de"
   ClientHeight    =   5190
   ClientLeft      =   2340
   ClientTop       =   1935
   ClientWidth     =   7245
   ClipControls    =   0   'False
   Icon            =   "FAbout.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3582.23
   ScaleMode       =   0  'User
   ScaleWidth      =   6803.43
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdSysInfo 
      Caption         =   "&Info. del Sistema..."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   3825
      TabIndex        =   11
      Top             =   4665
      Width           =   1845
   End
   Begin VB.CommandButton cmdOK 
      Cancel          =   -1  'True
      Caption         =   "Aceptar"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   1485
      TabIndex        =   10
      Top             =   4665
      Width           =   1845
   End
   Begin VB.PictureBox picIcon 
      BackColor       =   &H00FFFFFF&
      FillColor       =   &H80000002&
      Height          =   1425
      Left            =   120
      Picture         =   "FAbout.frx":030A
      ScaleHeight     =   1365
      ScaleWidth      =   2745
      TabIndex        =   2
      Top             =   825
      Width           =   2805
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      Index           =   2
      X1              =   98.6
      X2              =   6718.916
      Y1              =   3074.92
      Y2              =   3085.273
   End
   Begin VB.Line Line1 
      BorderWidth     =   2
      Index           =   1
      X1              =   98.6
      X2              =   6662.573
      Y1              =   1873.941
      Y2              =   1873.941
   End
   Begin VB.Label lblTexto 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   $"FAbout.frx":23E4
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   1560
      Left            =   330
      TabIndex        =   9
      Top             =   2805
      Width           =   6645
      WordWrap        =   -1  'True
   End
   Begin VB.Label lblCountry 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Pais"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3090
      TabIndex        =   8
      Top             =   2400
      Width           =   375
   End
   Begin VB.Label lblBank 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre del Banco"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3090
      TabIndex        =   7
      Top             =   2190
      Width           =   1575
   End
   Begin VB.Label lblAutorizadoA 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "El uso de este producto está autorizado a:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3090
      TabIndex        =   6
      Top             =   1935
      Width           =   3885
   End
   Begin VB.Label lblDesarrolladoPor 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Este Producto ha sido desarrollado por MACOSA S.A. - Ecuador"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   390
      Left            =   3090
      TabIndex        =   5
      Top             =   1425
      Width           =   3885
      WordWrap        =   -1  'True
   End
   Begin VB.Label lblCopyright 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright© 1997      MACOSA S.A."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3090
      TabIndex        =   4
      Top             =   1200
      Width           =   2985
   End
   Begin VB.Label lblCobis 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Cooperative, Open Banking Information System"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   300
      Left            =   750
      TabIndex        =   3
      Top             =   135
      Width           =   5745
   End
   Begin VB.Label lblTitle 
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre del Módulo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Left            =   3090
      TabIndex        =   0
      Top             =   570
      Width           =   3885
   End
   Begin VB.Label lblVersion 
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "Versión"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Left            =   3090
      TabIndex        =   1
      Top             =   810
      Width           =   3885
   End
End
Attribute VB_Name = "FAcerca"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'**************************************************************
'   Archivo:        FABOUT.FRM
'   Forma:          FAbout
'   Diseñado por:   Santiago Garcés
'   Fecha:          21-Nov-97
'**************************************************************
'                        IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios propiedad
' de MACOSA, representantes exclusivos para  el Ecuador de  la
' NCR CORPORATION.  Su uso  no  autorizado queda  expresamente
' prohibido así como cualquier alteración o agregado hecho por
' alguno  de sus  usuarios  sin el debido  consentimiento  por
' escrito  de  la   Presidencia  Ejecutiva   de  MACOSA  o  su
' representante
'*************************************************************
'                         PROPOSITO
' Muestra información sobre el módulo y sobre los derechos
' de autor del mismo, adicionalmente permite desplegar
' información sobre el equipo.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21-Nov-97      S. Garcés       Emision Inicial
'*************************************************************

Option Explicit

'Clave de reghistro: Opciones de seguridad...
'Const READ_CONTROL = &H20000
'Const KEY_QUERY_VALUE = &H1
'Const KEY_SET_VALUE = &H2
'Const KEY_CREATE_SUB_KEY = &H4
'Const KEY_ENUMERATE_SUB_KEYS = &H8
'Const KEY_NOTIFY = &H10
'Const KEY_CREATE_LINK = &H20
'Const KEY_ALL_ACCESS = KEY_QUERY_VALUE + KEY_SET_VALUE + _
'                       KEY_CREATE_SUB_KEY + KEY_ENUMERATE_SUB_KEYS + _
'                       KEY_NOTIFY + KEY_CREATE_LINK + READ_CONTROL
' Clave de registro: Tipos ROOT
'Const CG_HKEY_LOCAL_MACHINE = &H80000002
'Const ERROR_SUCCESS = 0
'Const REG_SZ = 1
'Const REG_DWORD = 4


'Private Declare Function RegOpenKeyEx Lib "advapi32" Alias "RegOpenKeyExA" (ByVal hKey As Long, ByVal lpSubKey As String, ByVal ulOptions As Long, ByVal samDesired As Long, ByRef phkResult As Long) As Long
'Private Declare Function RegQueryValueEx Lib "advapi32" Alias "RegQueryValueExA" (ByVal hKey As Long, ByVal lpValueName As String, ByVal lpReserved As Long, ByRef lpType As Long, ByVal lpData As String, ByRef lpcbData As Long) As Long
'Private Declare Function RegCloseKey Lib "advapi32" (ByVal hKey As Long) As Long
Const CL_REG_KEY_SYS_INFO_LOC = "SOFTWARE\Microsoft\Shared Tools Location"
Const CL_REG_VAL_SYS_INFO_LOC = "MSINFO"
Const CL_REG_KEY_SYS_INFO = "SOFTWARE\Microsoft\Shared Tools\MSINFO"
Const CL_REG_VAL_SYS_INFO = "PATH"

Private Sub cmdSysInfo_Click()
    Call FLInformacionSistema
End Sub

Private Sub cmdOK_Click()
    Unload Me
End Sub

Private Sub Form_Load()
'*************************************************************
' Objetivo:  Desplegar pantalla de información del módulo
' Input   :  Ninguno
' Output  :  Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21-Nov-97      S. Garcés       Emision Inicial
'*************************************************************
    Dim VTEmpresa As String
    Dim VTPais As String
    Dim VTDirSystem As String
    Dim VTMapIni As String
    Dim VTLinea As String
    Dim VTFNum As Integer
    Dim VTLong As Integer
    Dim VTPos As Integer
    
    'Abrir el  archivo Map.ini para obtener el nombre del Banco y del país.
    VTDirSystem$ = String$(255, 32)
    VTDirSystem$ = FMGetSystemDirectory()
    VTLong% = Len(VTDirSystem$)
        
    If VTLong% <= 0 Then
        MsgBox "No se pudo encontrar el directorio del sistema.", 16, App.Title
        Exit Sub
    End If
     
    'Path completo del archivo  map.ini
    VTMapIni$ = Mid$(VTDirSystem$, 1, VTLong%) + "\MAP.INI"
    VTFNum% = FLAbrirArchivo(VTMapIni$)
    If VTFNum% > 0 Then
        Line Input #VTFNum%, VTLinea$
        
        VTPos% = InStr(1, VTLinea$, ChrW$(9))
        If VTPos% = 0 Then
            MsgBox "<Map.ini> erróneo. Solicite autorización", 16, App.Title
            Exit Sub
        End If
        VTLinea$ = Mid$(VTLinea$, 1, VTPos% - 1)
        
        VTPos% = InStr(1, VTLinea$, "-")
        If VTPos% = 0 Then
            MsgBox "<Map.ini> erróneo. Solicite autorización", 16, App.Title
            Exit Sub
        End If
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        VTEmpresa$ = Trim$(Mid$(VTLinea$, 1, VTPos% - 1))
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        VTPais$ = Trim$(Mid$(VTLinea$, VTPos% + 1))
        Close #VTFNum%
    Else
        MsgBox "Archivo " + VTMapIni$ + " no encontrado.  Solicite autorización.", 16, App.Title
        Exit Sub
    End If
    
    Me.Caption = "Acerca de " & App.Title
    'lblVersion.Caption = "Versión " & App.Major & "." & App.Minor & "." & App.revision
    lblVersion.Caption = "Version: " + CStr(App.Major) + "." + CStr(App.Minor) + "." + CStr(App.revision) + " - " + App.CompanyName
    lblTitle.Caption = App.Title
    lblBank.Caption = VTEmpresa$
    lblCountry.Caption = VTPais$
End Sub

Public Sub FLInformacionSistema()
'*************************************************************
' Objetivo:  Obtener path del MSINFO32.EXE y ejecutarlo
' Input   :  Ninguno
' Output  :  Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21-Nov-97      S. Garcés       Emision Inicial
'*************************************************************

    On Error GoTo InformacionSistemaErr
  
    Dim VTPathInfo As String
    
    'Buscar del Registro el nombre y path del programa System Info
    If FMGetKeyValue(CG_HKEY_LOCAL_MACHINE, CL_REG_KEY_SYS_INFO, CL_REG_VAL_SYS_INFO, VTPathInfo$) Then
    'Buscar del Registro solamente el path del programa System Info
    ElseIf FMGetKeyValue(CG_HKEY_LOCAL_MACHINE, CL_REG_KEY_SYS_INFO_LOC, CL_REG_VAL_SYS_INFO_LOC, VTPathInfo$) Then
        'Validar existencia o conocimiento del programa
        If (Dir(VTPathInfo$ & "\MSINFO32.EXE") <> "") Then
            VTPathInfo$ = VTPathInfo$ & "\MSINFO32.EXE"
        Else
            'Error - Archivo no encontrado...
            GoTo InformacionSistemaErr
        End If
    Else
        'Error - Entradad al registro no encontrado...
        GoTo InformacionSistemaErr
    End If
    
    'Abrir ventana de información del sistema
    Call Shell(VTPathInfo$, vbNormalFocus)
    
    Exit Sub
InformacionSistemaErr:
    MsgBox "Información del sistema no disponible por el momento", vbOKOnly
End Sub



Function FLAbrirArchivo(Filename As String) As Integer
'*************************************************************
' Objetivo:  Abre un archivo y devuelve el FileHandler asig-
'            nado a ese archivo
' Input   :  Filename        'Nombre del archivo
' Output  :  FLAbrirArchivo  'FileHandler del archivo abierto
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21-Nov-97      S. Garcés       Emision Inicial
'*************************************************************
    
    On Error GoTo AbrirArchivoError
'FIXIT: Declare 'VTFNum' with an early-bound data type                                     FixIT90210ae-R1672-R1B8ZE
    Dim VTFNum As Integer

    VTFNum = FreeFile
    Open Filename For Input As #VTFNum
    FLAbrirArchivo = VTFNum
    Exit Function
    
AbrirArchivoError:
    FLAbrirArchivo = 0
    Exit Function
End Function


