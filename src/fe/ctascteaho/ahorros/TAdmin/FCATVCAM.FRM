VERSION 5.00
Begin VB.Form FCatVerCam 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Registros Seleccionados"
   ClientHeight    =   1110
   ClientLeft      =   2325
   ClientTop       =   1650
   ClientWidth     =   6810
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1110
   ScaleWidth      =   6810
   Begin VB.CommandButton cmdEscoger 
      Appearance      =   0  'Flat
      Caption         =   "* &Aceptar"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   5760
      TabIndex        =   2
      Top             =   690
      WhatsThisHelpID =   2011
      Width           =   960
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   30
      MaxLength       =   64
      TabIndex        =   0
      Top             =   300
      Width           =   6690
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Observación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   1
      Top             =   60
      Width           =   1140
   End
End
Attribute VB_Name = "FCatVerCam"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
'*************************************************************
' ARCHIVO:          FCATVCAM.frm
' NOMBRE LOGICO:    FCatVerCam
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
' Muestra en pantalla los cheques de cámara a ser rescatados
' o verificados, las causas de dichos procesos, y permite
' poner una observación final.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Private Sub cmdEscoger_Click()

    VGACatalogo.Codigo$ = "1"
    VGACatalogo.Descripcion$ = "AUTORIZADO POR EL OFICIAL"
    VGComentario$ = txtCampo.Text
    Unload FCatVerCam

End Sub

Private Sub Form_Activate()
'*********************************************************
'PROPOSITO: Permite activar o desactivar el boton de
'           siguientes de la lista de ayuda seleccionada
'INPUT:     ninguna
'OUTPUT:    ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    
    'If lstCatalogo.ListCount < 20 Then
    '    cmdSiguientes.Enabled = False
    'Else
    '    cmdSiguientes.Enabled = True
    'End If
    'If (lstCatalogo.ListIndex = -1) And (lstCatalogo.ListCount > 0) Then
    '  lstCatalogo.ListIndex = 0
    'End If
    VGACatalogo.Descripcion$ = ""

End Sub

Private Sub Form_Load()
    'grdRegistros.Cols = 6
    'grdRegistros.ColWidth(0) = 1000
    'grdRegistros.ColWidth(1) = 1000
    'grdRegistros.ColWidth(2) = 1000
    'grdRegistros.ColWidth(3) = 1000
    'grdRegistros.ColWidth(4) = 1000
    'grdRegistros.ColWidth(5) = 3000
    
    PMLoadResStrings Me
    PMLoadResIcons Me
 
End Sub




Private Sub txtCampo_KeyPress(KeyAscii As Integer)
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

