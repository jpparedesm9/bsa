VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FMantenimientoCB 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mantenimiento de Corresponsal Bancario Red Posicionada"
   ClientHeight    =   7020
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9795
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   7020
   ScaleWidth      =   9795
   Begin MSGrid.Grid grdCorresponsales 
      Height          =   3375
      Left            =   120
      TabIndex        =   36
      Top             =   3360
      Width           =   8535
      _Version        =   65536
      _ExtentX        =   15055
      _ExtentY        =   5953
      _StockProps     =   77
      BackColor       =   16777215
   End
   Begin VB.TextBox txtEstado 
      Height          =   285
      Left            =   6240
      MaxLength       =   10
      TabIndex        =   2
      Top             =   2160
      Width           =   615
   End
   Begin VB.TextBox txtNumContrato 
      Height          =   285
      Left            =   1920
      MaxLength       =   20
      TabIndex        =   3
      Top             =   2520
      Width           =   1815
   End
   Begin VB.TextBox txtCodRed 
      Height          =   285
      Left            =   1920
      MaxLength       =   20
      TabIndex        =   1
      Top             =   2160
      Width           =   1815
   End
   Begin VB.TextBox txtCorresponsal 
      Height          =   285
      Left            =   1935
      MaxLength       =   5
      TabIndex        =   0
      Top             =   120
      Width           =   735
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   2
      Left            =   8880
      TabIndex        =   9
      Top             =   1800
      WhatsThisHelpID =   2007
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1614
      _ExtentY        =   1455
      _StockProps     =   78
      Caption         =   "&Transmitir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FMANTCB.frx":0000
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Left            =   6960
      TabIndex        =   4
      Top             =   2520
      Width           =   1575
      _ExtentX        =   2778
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCuentaCupo 
      Height          =   255
      Left            =   1920
      TabIndex        =   5
      Top             =   2880
      Width           =   1845
      _ExtentX        =   3254
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCuentaComision 
      Height          =   255
      Left            =   6960
      TabIndex        =   6
      Top             =   2880
      Width           =   1560
      _ExtentX        =   2752
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   3
      Left            =   8880
      TabIndex        =   10
      Tag             =   "386"
      Top             =   2640
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1614
      _ExtentY        =   1455
      _StockProps     =   78
      Caption         =   "&Puntos"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FMANTCB.frx":0376
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   0
      Left            =   8880
      TabIndex        =   7
      Tag             =   "388;389"
      Top             =   120
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FMANTCB.frx":0C50
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   1
      Left            =   8880
      TabIndex        =   8
      Tag             =   "388;389"
      Top             =   960
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "Si&guiente"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      Picture         =   "FMANTCB.frx":21E2
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   4
      Left            =   8880
      TabIndex        =   11
      Top             =   5040
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FMANTCB.frx":2ABC
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   5
      Left            =   8880
      TabIndex        =   12
      Top             =   5880
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FMANTCB.frx":3396
   End
   Begin VB.Label lblEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   6960
      TabIndex        =   37
      Top             =   2160
      Width           =   1575
   End
   Begin VB.Label lblDescRegimen 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2730
      TabIndex        =   35
      Top             =   1740
      Width           =   5805
   End
   Begin VB.Label lblDescCiudad 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2730
      TabIndex        =   34
      Top             =   1410
      Width           =   5805
   End
   Begin VB.Label lblDescDepto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2730
      TabIndex        =   33
      Top             =   1080
      Width           =   5805
   End
   Begin VB.Label lblRegimen 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   1920
      TabIndex        =   32
      Top             =   1740
      Width           =   765
   End
   Begin VB.Label lblCiudad 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   1920
      TabIndex        =   31
      Top             =   1410
      Width           =   765
   End
   Begin VB.Label lblDepartamento 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   1920
      TabIndex        =   30
      Top             =   1080
      Width           =   765
   End
   Begin VB.Label lblNumDocDig 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   4320
      TabIndex        =   29
      Top             =   750
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Label lblNumDoc 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   1920
      TabIndex        =   28
      Top             =   750
      Width           =   2325
   End
   Begin VB.Label lblDescTipoDoc 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2715
      TabIndex        =   27
      Top             =   435
      Width           =   5805
   End
   Begin VB.Label lblTipoDoc 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   1920
      TabIndex        =   26
      Top             =   435
      Width           =   765
   End
   Begin VB.Label lblCorresponsal 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
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
      Height          =   285
      Left            =   2715
      TabIndex        =   25
      Top             =   105
      Width           =   5805
   End
   Begin VB.Line Line3 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   120
      X2              =   8760
      Y1              =   3240
      Y2              =   3240
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro Cuenta para Comisiones:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   4305
      TabIndex        =   24
      Top             =   2910
      Width           =   2475
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Vencimiento Contrato:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   4290
      TabIndex        =   23
      Top             =   2580
      Width           =   2475
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   4320
      TabIndex        =   22
      Top             =   2280
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro Cuenta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   135
      TabIndex        =   21
      Top             =   2955
      Width           =   1035
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro Contrato:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   105
      TabIndex        =   20
      Top             =   2595
      Width           =   1155
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cod Red:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   120
      TabIndex        =   19
      Top             =   2280
      Width           =   810
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   120
      X2              =   8760
      Y1              =   2085
      Y2              =   2085
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Régimen Fiscal:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   120
      TabIndex        =   18
      Top             =   1800
      Width           =   1365
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Ciudad:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   120
      TabIndex        =   17
      Top             =   1440
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Departamento:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   16
      Top             =   1125
      Width           =   1260
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro Identificación:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   15
      Top             =   795
      Width           =   1590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Identificación:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   14
      Top             =   480
      Width           =   1665
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Corresponsal:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   13
      Top             =   120
      Width           =   1170
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8760
      X2              =   8760
      Y1              =   0
      Y2              =   6960
   End
End
Attribute VB_Name = "FMantenimientoCB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FConsMovCB.frm
' NOMBRE LOGICO:    FCONSMOVCB
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
' Permite realizar el mantenimiento del CB
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-Ene-14      C. Avedaño      Emisión Inicial
'*************************************************************
Option Explicit
Dim VLOperacion As String
Dim VLResultado As Boolean
Dim VLValida As Boolean
Dim VLCliente As Boolean
Dim VLEnte As String
Dim VLPaso As Integer
Dim VTR1 As Integer
Dim VTFecha As String


Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0 'Buscar
        PLBuscar
    Case 1 '
        PLSiguientes
    Case 2 'Transmitir
        If VLOperacion = "I" Then
            PLTransmitir
        End If
        If VLOperacion = "U" Then
            PLModificar
        End If
    Case 3 'Puntos
        If txtCorresponsal.Text = "" Then
           MsgBox "NO SE HA SELECCIONADO UN CORRESPONSAL", vbInformation
           txtCorresponsal.SetFocus
           Exit Sub
        End If
        If txtEstado.Text <> "H" Then
            MsgBox "RED CORRESPONSAL DESHABILITADA. NO SE PUEDE MODIFICAR PUNTOS DE ATENCIÓN", vbInformation
            Exit Sub
        End If
        'FPUNTOCB.txtCodPunto.Text = VGCorresponsal
        VGCorresponsal = txtCorresponsal.Text
        FPUNTOCB.Show
    Case 4 'Limpiar
        PLLimpiar
        'PLBuscar
    Case 5 ' Salir
        Unload FMantenimientoCB
    End Select
End Sub

Private Sub Form_Load()
    PMLoadResStrings Me
    PMLoadResIcons Me
    FMantenimientoCB.Left = 15
    FMantenimientoCB.Top = 15
    FMantenimientoCB.Width = 9915
    FMantenimientoCB.Height = 7530
    mskCuentaCupo.Mask = VGMascaraCtaAho
    mskCuentaComision.Mask = VGMascaraCtaAho
    VLOperacion = "I"
    txtEstado.Text = "H"
    txtEstado_lostfocus
    txtEstado.Enabled = False
    cmdBoton(3).Enabled = False
End Sub


Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 2 Then
        Button = 0
    End If
End Sub

Private Sub grdCorresponsales_DblClick()
    Dim VLCuentaCupo As String
    Dim VLCuentaComision As String
    txtEstado.Enabled = True
    VLOperacion = "U"
    grdCorresponsales.Col = 1
    txtCorresponsal.Text = grdCorresponsales.Text
    txtCorresponsal_LostFocus
    'If VLCliente = False Then
    '    Exit Sub
    'End If
    grdCorresponsales.Col = 2
    txtCodRed.Text = grdCorresponsales.Text
    
    grdCorresponsales.Col = 4
    txtNumContrato.Text = grdCorresponsales.Text
    
    grdCorresponsales.Col = 5
    mskFecha.Text = grdCorresponsales.Text
    
    grdCorresponsales.Col = 6
    VLCuentaCupo$ = grdCorresponsales.Text
    mskCuentaCupo.Text = FMMascara(VLCuentaCupo$, VGMascaraCtaAho$)
    
    grdCorresponsales.Col = 7
    VLCuentaComision$ = grdCorresponsales.Text
    mskCuentaComision.Text = FMMascara(VLCuentaComision$, VGMascaraCtaAho$)

    grdCorresponsales.Col = 8
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    txtEstado.Text = Mid$(grdCorresponsales.Text, 1, 1)
    txtEstado_lostfocus
    
End Sub

Private Sub mskCuentaComision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de Cuenta para Comisión "
End Sub

Private Sub mskCuentaComision_LostFocus()
    If mskCuentaComision.ClipText <> "" Then
        PLValida mskCuentaComision.ClipText, "N"
        If VLResultado = False Then
            mskCuentaComision.Mask = ""
            mskCuentaComision.Text = ""
            mskCuentaComision.Mask = VGMascaraCtaAho$
            mskCuentaComision.SetFocus
            Exit Sub
        End If
    End If
End Sub

Private Sub mskCuentaCupo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de Cuenta de Cupo "
End Sub

Private Sub mskCuentaCupo_LostFocus()
    If mskCuentaCupo.ClipText <> "" Then
        PLValida mskCuentaCupo.ClipText, "S"
        If VLResultado = False Then
            mskCuentaCupo.Mask = ""
            mskCuentaCupo.Text = ""
            mskCuentaCupo.Mask = VGMascaraCtaAho$
            mskCuentaCupo.SetFocus
        End If
    End If
End Sub

Private Sub mskFecha_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Fecha de Vencimiento de Contrato (" + VGFormatoFecha$ + ")"
End Sub

Private Sub mskFecha_KeyPress(KeyAscii As Integer)
If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub MskFecha_LostFocus()
Dim VTValido As Integer
If mskFecha.ClipText <> "" Then
    VTValido% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha$)
    If Not VTValido% Then
        MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
        mskFecha.Mask = ""
        mskFecha.Text = ""
        mskFecha.Mask = FMMascaraFecha(VGFecha_Pref)
        mskFecha.SetFocus
        Exit Sub
    End If
    If CDate(mskFecha.FormattedText) < CDate(VGFecha) Then
        MsgBox "Fecha de vencimiento no puede ser menor a la fecha del sistema", 48, "Mensaje de Error"
        mskFecha.SetFocus
    End If
End If
End Sub

Private Sub txtCodRed_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Código de Red "
End Sub

Private Sub txtCodRed_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtCorresponsal_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado e ini-
'           cializa la variable que chequea los cambios
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'10/Dic/2013 C. Avendaño         Emisión Inicial
'*********************************************************
    'VLPaso% = True
    'FPrincipal!pnlTransaccionLine.Caption = ""
    FPrincipal!pnlHelpLine.Caption = " Código del Corresponsal  [F5] Ayuda"
    txtCorresponsal.SelStart = 0
    txtCorresponsal.SelLength = Len(txtCorresponsal.Text)
End Sub

Private Sub txtCorresponsal_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
        '*********************************************************
        'Objetivo:  Llama a la forma FBuscarCliente para traer
        '           los datos de un cliente
        'Input   :  KeyCode     código de la tecla F5
        'Output  :  ninguno
        '*********************************************************
        '                    MODIFICACIONES
        'FECHA       AUTOR               RAZON
        '10/Dic/2013 C. Avendaño         Emisión Inicial
        '*********************************************************
        PLLimpiar
        txtCorresponsal.Enabled = True
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "1052"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR&, "S1"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2&, "2"
        PMHelpG "cobis", "sp_clasoser", 3, 1
        PMBuscarG 1, "@t_trn", "1052", SQLINT2&
        PMBuscarG 2, "@i_operacion", "S1", SQLVARCHAR&
        PMBuscarG 3, "@i_modo", "2", SQLINT2&
        'PMBuscarG 4, "@i_siguiente", "", SQLINT2&
        PMSigteG 1, "@i_siguiente", 1, SQLINT4&
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_clasoser", True, "OK.. Verifica Corresponsal") Then
           PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
           PMChequea sqlconn&
           PMProcesG
           VLPaso% = True
           grid_valores.Show 1
           If Temporales(1) <> "" Then
               txtCorresponsal.Text = Temporales(1)
               VGCorresponsal = Temporales(1)
               lblCorresponsal.Caption = Temporales(2)
               VLEnte = Temporales(3)
               PLDatos_Cliente
            Else
               txtCorresponsal.Text = ""
               txtCorresponsal.SetFocus
               lblCorresponsal.Caption = ""
            End If
        Else
           VLPaso% = False
           PLLimpiar
           txtCorresponsal.SetFocus
        End If
    End If
End Sub

Private Sub txtCorresponsal_KeyPress(KeyAscii As Integer)
'*********************************************************
'Objetivo:  controla que el texto sea numerico
'Input   :  KeyAscii    codigo ascii de la tecla presionada
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'10/Dic/2013 C. Avendaño         Emisión Inicial
'*********************************************************
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtCorresponsal_LostFocus()
'*********************************************************
'Objetivo:  Cuando el contenido del campo se modifica
'           manualmente, se invoca al sp que trae la des-
'           cripción del código
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA       AUTOR               RAZON
'10/Dic/2013 C. Avendaño         Emisión Inicial
'*********************************************************
ReDim VTArregloCab(3) As String
txtCorresponsal.Enabled = True
If Trim$(txtCorresponsal.Text) <> "" Then
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "1052"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR&, "S1"
    If VLOperacion = "U" Then
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4&, 5
    Else
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4&, 4
    End If
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4&, CStr(txtCorresponsal.Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_clasoser", True, "OK.. Verifica Corresponsal") Then
        VTR1% = FMMapeaArreglo(sqlconn&, VTArregloCab())
        PMChequea sqlconn&
        lblCorresponsal.Caption = VTArregloCab(2)
        VGCorresponsal = txtCorresponsal.Text
        VLEnte = VTArregloCab(3)
        PLDatos_Cliente
        cmdBoton(3).Enabled = True
    Else
        VLPaso% = False
        txtCorresponsal.Text = ""
        txtCorresponsal.SetFocus
        lblCorresponsal.Caption = ""
        PLLimpiar
        'PLBuscar
    End If
End If
End Sub

Private Sub txtCorresponsal_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 2 Then
        'Dim SCM As Menu
        'Set SCM = mnuShortCut
        'PopupMenu SCM
        txtCorresponsal.Enabled = False
        txtCorresponsal.Enabled = True
        'Exit Sub
    End If
End Sub

Private Sub txtCorresponsal_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = 2 Then
        Exit Sub
    End If
End Sub

Private Sub txtEstado_Change()
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
    txtEstado.Text = UCase$(txtEstado.Text)
End Sub

Private Sub txtEstado_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Estado [F5] Ayuda"
End Sub

Private Sub txtEstado_KeyDown(Keycode As Integer, Shift As Integer)
If Keycode% = VGTeclaAyuda% Then
   txtEstado.Text = ""
   lblEstado.Caption = ""
   PMLimpiaG grid_valores!gr_SQL
   PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "A"
   PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "re_estado_servicio"
   PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
   If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, "Ayuda Catalogo") Then
      PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
      PMChequea sqlconn&
      PMProcesG
      grid_valores.Show 1
      If Temporales(1) <> "" Then
         txtEstado.Text = Temporales(1)
         lblEstado.Caption = Temporales(2)
      Else
         txtEstado.Text = ""
         txtEstado.SetFocus
         lblEstado.Caption = ""
      End If
   End If
End If
End Sub

Sub PLDatos_Cliente()
    '*********************************************************
    'Objetivo:  Indica que el contenido del campo ha cambiado
    'Input   :  ninguno
    'Output  :  ninguno
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '01/Nov/93  M.Davila            Emisión Inicial
    '*********************************************************
    Dim VTR As Integer
    ReDim VTArreglo(500) As String
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "1218"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
    PMPasoValores sqlconn&, "@i_compania", 0, SQLINT4&, CStr(VLEnte)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_compania_cons", True, "") Then
        VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        lblTipoDoc.Caption = VTArreglo(2)
        If lblTipoDoc.Caption = "N" Then
            lblDescTipoDoc.Visible = True
        End If
        PMValida_TipoDoc lblTipoDoc.Caption, "C"
        lblDescTipoDoc.Caption = VGMTipoDoc(1)
        lblNumDoc.Caption = VTArreglo(3)
        lblRegimen.Caption = VTArreglo(55)
        lblDescRegimen.Caption = VTArreglo(56)
    End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "1227"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, CStr(VLEnte)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, "") Then
        VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        lblDepartamento.Caption = VTArreglo(8)
        lblDescDepto.Caption = VTArreglo(9)
        lblCiudad.Caption = VTArreglo(3)
        lblDescCiudad.Caption = VTArreglo(4)
    End If
End Sub
Sub PLLimpiar()
    lblCiudad.Caption = ""
    lblCorresponsal.Caption = ""
    lblDepartamento.Caption = ""
    lblDescCiudad.Caption = ""
    lblDescDepto.Caption = ""
    lblDescRegimen.Caption = ""
    lblDescTipoDoc.Caption = ""
    lblEstado.Caption = ""
    lblNumDoc.Caption = ""
    lblNumDocDig.Caption = ""
    lblRegimen.Caption = ""
    lblTipoDoc.Caption = ""
    txtCodRed.Text = ""
    txtCorresponsal.Text = ""
    txtEstado.Text = ""
    txtNumContrato.Text = ""
    mskCuentaComision.Mask = ""
    mskCuentaCupo.Mask = ""
    mskFecha.Mask = ""
    mskCuentaComision.Text = ""
    mskCuentaCupo.Text = ""
    mskFecha.Text = ""
    mskCuentaCupo.Mask = VGMascaraCtaAho
    mskCuentaComision.Mask = VGMascaraCtaAho
    mskFecha.Mask = FMMascaraFecha(VGFecha_Pref)
    PMLimpiaG grdCorresponsales
    VLOperacion = "I"
    txtEstado.Text = "H"
    txtEstado_lostfocus
    txtEstado.Enabled = False
    cmdBoton(3).Enabled = False
End Sub

Private Sub txtEstado_lostfocus()
If VLPaso% = False Then
    If txtEstado.Text <> "" Then
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_estado_servicio"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtEstado.Text)
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtEstado.Text & "]") Then
             PMMapeaObjeto sqlconn&, lblEstado
             PMChequea sqlconn&
        Else
            VLPaso% = True
            txtEstado.Text = ""
            lblEstado.Caption = ""
            txtEstado.SetFocus
        End If
    Else
        lblEstado.Caption = ""
    End If
End If
End Sub
Sub PLBuscar()
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "396"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
        PMMapeaGrid sqlconn&, grdCorresponsales, False
        PMChequea sqlconn&
        If Val(grdCorresponsales.Tag) = 20 Then
            cmdBoton(1).Enabled = True
        Else
            cmdBoton(1).Enabled = False
        End If
    Else
        PMChequea sqlconn&
    End If
    cmdBoton(3).Enabled = True
End Sub
Sub PLSiguientes()
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "396"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    grdCorresponsales.Col = 1
    grdCorresponsales.Row = grdCorresponsales.Rows - 1
    PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLINT4&, grdCorresponsales.Text
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
        PMMapeaGrid sqlconn&, grdCorresponsales, False
        PMChequea sqlconn&
        If Val(grdCorresponsales.Tag) = 20 Then
            cmdBoton(1).Enabled = True
        Else
            cmdBoton(1).Enabled = False
        End If
    Else
        PMChequea sqlconn&
    End If
    cmdBoton(3).Enabled = True
End Sub
Sub PLTransmitir()
    PLValidarCampos
    If VLValida = True Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "396"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, VLOperacion
        PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLINT4&, VGCorresponsal
        PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLVARCHAR&, (txtCodRed.Text)
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, (txtEstado.Text)
        PMPasoValores sqlconn&, "@i_num_contrato", 0, SQLVARCHAR&, (txtNumContrato.Text)
        PMPasoValores sqlconn&, "@i_cta_cupo", 0, SQLVARCHAR&, mskCuentaCupo.ClipText
        PMPasoValores sqlconn&, "@i_cta_comision", 0, SQLVARCHAR&, mskCuentaComision.ClipText
        VTFecha$ = FMConvFecha((mskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_ven", 0, SQLDATETIME, VTFecha$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
            PMChequea sqlconn&
            PLLimpiar
            PLBuscar
            cmdBoton(3).Enabled = True
        End If
    End If
End Sub
Sub PLModificar()
    PLValidarCampos
    If VLValida = True Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "396"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, VLOperacion
        PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLINT4&, (txtCorresponsal.Text)
        PMPasoValores sqlconn&, "@i_codigo_red", 0, SQLVARCHAR&, (txtCodRed.Text)
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, (txtEstado.Text)
        PMPasoValores sqlconn&, "@i_num_contrato", 0, SQLVARCHAR&, (txtNumContrato.Text)
        PMPasoValores sqlconn&, "@i_cta_cupo", 0, SQLVARCHAR&, mskCuentaCupo.ClipText
        PMPasoValores sqlconn&, "@i_cta_comision", 0, SQLVARCHAR&, mskCuentaComision.ClipText
        VTFecha$ = FMConvFecha((mskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_ven", 0, SQLDATETIME, VTFecha$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cb", True, "") Then
            PMChequea sqlconn&
            PLLimpiar
            PLBuscar
        Else
            PMChequea sqlconn&
        End If
    End If
End Sub

Sub PLValida(Cuenta As String, CB As String)
    Dim VLEstado As String
    If txtCorresponsal.Text <> "" Then
        If FMChequeaCtaAho(Cuenta) Then
            PMPasoValores sqlconn&, "@i_ctaint", 0, SQLINT2&, "0"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "206"
            'PMPasoValores sqlconn&, "@i_codcliente", 0, SQLVARCHAR&, txtCorresponsal.Text
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR&, Cuenta
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR&, "N"
            PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2&, Me.Tag
            PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, CB
            PMPasoValores sqlconn&, "@o_estado", 1, SQLCHAR&, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "Ok.. Verificación Cuenta") Then
                VLEstado$ = FMRetParam(sqlconn&, 1)
                PMChequea sqlconn&
                VLResultado = True
            Else
                VLResultado = False
                PMChequea sqlconn&
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            VLResultado = False
            Exit Sub
        End If
    Else
        MsgBox "CODIGO DE CORRESPONSAL ES REQUERIDO", vbInformation
        VLResultado = False
    End If
End Sub
Sub PLValidarCampos()
    If txtCorresponsal.Text = "" Then
       MsgBox "INGRESE CODIGO DE CORRESPONSAL", vbInformation
       txtCorresponsal.SetFocus
       cmdBoton(3).Enabled = False
       VLValida = False
       Exit Sub
    End If
    If txtCodRed.Text = "" Then
       MsgBox "INGRESE CODIGO DE RED", vbInformation
       txtCodRed.SetFocus
       cmdBoton(3).Enabled = False
       VLValida = False
       Exit Sub
    End If
    If txtNumContrato.Text = "" Then
       MsgBox "INGRESE NUMERO DE CONTRATO", vbInformation
       txtNumContrato.SetFocus
       cmdBoton(3).Enabled = False
       VLValida = False
       Exit Sub
    End If
    If mskCuentaCupo.ClipText = "" Then
        MsgBox "INGRESE NUMERO DE CUENTA DEL CORRESPONSAL", vbInformation
        mskCuentaCupo.SetFocus
        cmdBoton(3).Enabled = False
        VLValida = False
        Exit Sub
    End If
    If txtEstado.Text = "" And lblEstado.Caption = "" Then
        MsgBox "INGRESE EL ESTADO", vbInformation
        txtEstado.SetFocus
        cmdBoton(3).Enabled = False
        VLValida = False
        Exit Sub
    End If
    If txtEstado.Text = "N" And VLOperacion = "I" Then
        MsgBox "EL ESTADO DEBE SER HABILITADO", vbInformation
        txtEstado.Text = ""
        VLValida = False
        lblEstado.Caption = ""
        txtEstado.SetFocus
        cmdBoton(3).Enabled = False
        Exit Sub
    End If
    If mskFecha.ClipText = "" Then
        MsgBox "INGRESE LA FECHA", vbInformation
        mskFecha.SetFocus
        cmdBoton(3).Enabled = False
        VLValida = False
        Exit Sub
    End If
    
    If CDate(mskFecha) < VGFecha Then
        MsgBox "LA FECHA DE VENCIMIENTO NO PUEDE MENOR A LA FECHA DEL SISTEMA", vbInformation
        mskFecha.SetFocus
        cmdBoton(3).Enabled = False
        VLValida = False
        Exit Sub
    End If
    VLValida = True
End Sub

Private Sub txtNumContrato_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de Contrato "
End Sub

Private Sub txtNumContrato_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

