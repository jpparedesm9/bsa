VERSION 5.00
Begin VB.Form FPresentacion 
   BackColor       =    &H8000000F&
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   3810
   ClientLeft      =   255
   ClientTop       =   1410
   ClientWidth     =   7095
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "FPRESENTACION.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FPRESENTACION.frx":000C
   ScaleHeight     =   3810
   ScaleWidth      =   7095
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.PictureBox PicLogoProducto 
      DrawMode        =   1  'Blackness
      FillColor       =   &H80000002&
      Height          =   1410
      Left            =   360
      Picture         =   "FPRESENTACION.frx":1E44E
      ScaleHeight     =   90
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   93
      TabIndex        =   8
      Top             =   1620
      Width           =   1455
   End
   Begin VB.Label lblC 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =    &H8000000F&
      BackStyle       =   0  'Transparent
      Caption         =   "©"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   3255
      TabIndex        =   9
      Top             =   2550
      Width           =   195
   End
   Begin VB.Label lblBanco 
      BackStyle       =   0  'Transparent
      Caption         =   "NOMBRE DEL BANCO"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   210
      Left            =   2460
      TabIndex        =   7
      Top             =   360
      Width           =   4500
   End
   Begin VB.Label lblProducto 
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre del Producto"
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   24
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   570
      Left            =   2055
      TabIndex        =   6
      Top             =   1500
      Width           =   4875
   End
   Begin VB.Label lblVersion 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Versión "
      BeginProperty Font 
         Name            =   "Times New Roman"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   2055
      TabIndex        =   5
      Top             =   2100
      WhatsThisHelpID =   5013
      Width           =   4530
   End
   Begin VB.Label lblWarning 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Este programa esta protegido por las leyes internacionales de derechos de autor."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   210
      Left            =   150
      TabIndex        =   4
      Top             =   3540
      WhatsThisHelpID =   5012
      Width           =   6780
   End
   Begin VB.Label lblCompany 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "MACOSA S.A"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   2415
      TabIndex        =   3
      Top             =   2835
      Width           =   1245
   End
   Begin VB.Label lblCopyright 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright       1994-1999"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Left            =   2415
      TabIndex        =   2
      Top             =   2580
      Width           =   2025
   End
   Begin VB.Label lblPais 
      BackStyle       =   0  'Transparent
      Caption         =   "PAIS"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   210
      Left            =   2460
      TabIndex        =   1
      Top             =   600
      Width           =   4515
   End
   Begin VB.Label Label1 
      BackStyle       =   0  'Transparent
      Caption         =   "El uso de este producto está autorizado a:"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   210
      Left            =   2445
      TabIndex        =   0
      Top             =   120
      WhatsThisHelpID =   5011
      Width           =   3525
   End
End
Attribute VB_Name = "FPresentacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*************************************************************
' ARCHIVO:          FPresentacion.frm
' NOMBRE LOGICO:    FPresentacion
' PRODUCTO:         GENERAL
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
' Muestra información sobre el módulo y sobre los derechos
' de autor. Esta pantalla es una versión adecuada para el
' funcionamiento en aplicativos COBIS que no usan recursos.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 22-Sep-99      S. Garcés       Emision Inicial
'*************************************************************

Option Explicit

Private Sub Form_Load()
'*************************************************************
' PROPOSITO: Inicializar y desplegar pantalla de información
'            del módulo, realiza la lectura del archivo
'            MAP.INI para tomar información sobre el banco o
'            institución financiera en donde se encuentra
'            instalado el módulo
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 22-Sep-99      S. Garcés       Emision Inicial
'*************************************************************

    Dim VTDirSystem As String
    Dim VTMapIni As String
    Dim VTLinea As String
    Dim VTFNum As Integer
    Dim VTLong As Integer
    Dim VTPos As Integer
    Dim VTRet As Integer
        
    'Abrir el  archivo Map.ini para obtener el nombre del Banco y del país.
    VTDirSystem$ = String$(255, 32)
    VTDirSystem$ = FMGetSystemDirectory()
    VTLong% = Len(VTDirSystem$)
        
    If VTLong% <= 0 Then
        VTRet% = MsgBox("No se pudo encontrar el directorio del sistema", vbCritical, "ERROR")
        Exit Sub
    End If
     
    'Path completo del archivo  map.ini
    VTMapIni$ = Mid$(VTDirSystem$, 1, VTLong%) + "\MAP.INI"
    VTFNum% = FLAbrirArchivo(VTMapIni$)
    If VTFNum% > 0 Then
        Line Input #VTFNum%, VTLinea$
        
        VTPos% = InStr(1, VTLinea$, ChrW$(9))
        If VTPos% = 0 Then
            VTRet% = MsgBox("<Map.ini> erróneo. Solicite autorización", vbCritical, "ERROR")
            Exit Sub
        End If
        VTLinea$ = Mid$(VTLinea$, 1, VTPos% - 1)
        
        VTPos% = InStr(1, VTLinea$, "-")
        If VTPos% = 0 Then
            VTRet% = MsgBox("<Map.ini> erróneo. Solicite autorización", vbCritical, "ERROR")
            Exit Sub
        End If
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        VGBanco$ = Trim$(Mid$(VTLinea$, 1, VTPos% - 1))
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        VGPais$ = Trim$(Mid$(VTLinea$, VTPos% + 1))
        Close #VTFNum%
    Else
        VTRet% = MsgBox("<Map.ini> erróneo. Solicite autorización", vbCritical, "ERROR")
        Exit Sub
    End If
    
    'Configurar etiquetas
    lblBanco.Caption = VGBanco$
    lblPais.Caption = VGPais$
    lblVersion.Caption = lblVersion.Caption & App.Major & "." & App.Minor & "." & App.revision
    lblProducto.Caption = App.Title
    
    FPresentacion.Show
    For VTRet% = 1 To 10000
        VTPos% = DoEvents()
    Next VTRet%
    FPrincipal.Show
    Unload Me
End Sub

Function FLAbrirArchivo(Filename As String) As Integer
'*************************************************************
' PROPOSITO: Maneja la apertura de un archivo
' INPUT    : Ninguno
' OUTPUT   : Ninguno
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


