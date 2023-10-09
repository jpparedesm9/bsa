VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran232 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Movimientos de Cuentas de Ahorros"
   ClientHeight    =   5880
   ClientLeft      =   1200
   ClientTop       =   2325
   ClientWidth     =   9510
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
   HelpContextID   =   1044
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5880
   ScaleWidth      =   9510
   Tag             =   "3117"
   Begin VB.Frame FrmTarjetaDeb 
      Height          =   495
      Left            =   6720
      TabIndex        =   39
      Top             =   1200
      Width           =   1575
      Begin VB.OptionButton optTarjetaDebito 
         Caption         =   "Si"
         Enabled         =   0   'False
         Height          =   255
         Index           =   0
         Left            =   75
         TabIndex        =   41
         Top             =   150
         Width           =   615
      End
      Begin VB.OptionButton optTarjetaDebito 
         Caption         =   "No"
         Enabled         =   0   'False
         Height          =   255
         Index           =   1
         Left            =   780
         TabIndex        =   40
         Top             =   150
         Width           =   615
      End
   End
   Begin Crystal.CrystalReport rptReporte 
      Left            =   8928
      Top             =   120
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8610
      TabIndex        =   34
      Top             =   1995
      WhatsThisHelpID =   2027
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Firma"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8610
      TabIndex        =   4
      Top             =   2760
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
   End
   Begin MSGrid.Grid grdEstado 
      Height          =   2955
      Left            =   30
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   2865
      Width           =   8490
      _Version        =   65536
      _ExtentX        =   14975
      _ExtentY        =   5212
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   288
      Index           =   1
      Left            =   7140
      TabIndex        =   2
      Top             =   612
      Width           =   1344
      _ExtentX        =   2381
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   1940
      TabIndex        =   1
      Top             =   615
      Width           =   1350
      _ExtentX        =   2381
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1940
      TabIndex        =   0
      Top             =   15
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8610
      TabIndex        =   3
      Top             =   3525
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8595
      TabIndex        =   5
      Top             =   4305
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8595
      TabIndex        =   6
      Top             =   5070
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8610
      TabIndex        =   35
      Tag             =   "6335"
      Top             =   1230
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
   End
   Begin VB.Label LblTarjetaDeb 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tarjeta Débito:"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   5280
      TabIndex        =   42
      Top             =   1320
      WhatsThisHelpID =   5470
      Width           =   1335
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Alianza:"
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   15
      TabIndex        =   43
      Top             =   2200
      Width           =   735
   End
   Begin VB.Label Lblalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   1755
      TabIndex        =   44
      Top             =   2160
      Width           =   1050
   End
   Begin VB.Label lbldesalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   345
      Left            =   2835
      TabIndex        =   45
      Top             =   2160
      Width           =   5655
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   15
      Left            =   4320
      TabIndex        =   38
      Top             =   15
      WhatsThisHelpID =   5067
      Width           =   735
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   11
      Left            =   5040
      TabIndex        =   37
      Top             =   15
      Width           =   405
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   12
      Left            =   5460
      TabIndex        =   36
      Top             =   15
      Width           =   1725
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Teléfono:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   14
      Left            =   5670
      TabIndex        =   33
      Top             =   1215
      Visible         =   0   'False
      WhatsThisHelpID =   5334
      Width           =   900
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   10
      Left            =   6702
      TabIndex        =   32
      Top             =   1200
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   15
      X2              =   8565
      Y1              =   2535
      Y2              =   2535
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Transacciones:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   13
      Left            =   30
      TabIndex        =   31
      Top             =   2625
      WhatsThisHelpID =   5336
      Width           =   1395
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Saldo último corte:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   15
      TabIndex        =   30
      Top             =   1920
      WhatsThisHelpID =   5332
      Width           =   1680
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   9
      Left            =   1770
      TabIndex        =   29
      Top             =   1920
      Width           =   2775
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   8
      Left            =   1770
      TabIndex        =   28
      Top             =   1680
      Width           =   2775
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficial de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   15
      TabIndex        =   27
      Top             =   1692
      WhatsThisHelpID =   5014
      Width           =   1620
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   7
      Left            =   4515
      TabIndex        =   26
      Top             =   1200
      Visible         =   0   'False
      Width           =   1125
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Entidad:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   2880
      TabIndex        =   25
      Top             =   1215
      Visible         =   0   'False
      WhatsThisHelpID =   5036
      Width           =   795
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   6
      Left            =   1770
      TabIndex        =   24
      Top             =   1200
      Visible         =   0   'False
      Width           =   1050
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ciudad:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   15
      TabIndex        =   23
      Top             =   1185
      Visible         =   0   'False
      WhatsThisHelpID =   5035
      Width           =   735
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   3
      Left            =   7347
      TabIndex        =   22
      Top             =   1440
      Visible         =   0   'False
      Width           =   1125
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha próx. corte:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   5670
      TabIndex        =   21
      Top             =   1440
      Visible         =   0   'False
      WhatsThisHelpID =   5335
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Moneda:"
      ForeColor       =   &H00800000&
      Height          =   192
      Index           =   7
      Left            =   4788
      TabIndex        =   8
      Top             =   1692
      WhatsThisHelpID =   5209
      Width           =   828
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   4
      Left            =   5676
      TabIndex        =   9
      Top             =   1680
      Width           =   2796
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha último mov.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   15
      TabIndex        =   10
      Top             =   1440
      WhatsThisHelpID =   5331
      Width           =   1695
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   1
      Left            =   1770
      TabIndex        =   11
      Top             =   1440
      Width           =   1050
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha último corte:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   2850
      TabIndex        =   12
      Top             =   1440
      Visible         =   0   'False
      WhatsThisHelpID =   5333
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   2
      Left            =   4515
      TabIndex        =   13
      Top             =   1440
      Visible         =   0   'False
      Width           =   1125
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Dir. estado cta.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   15
      TabIndex        =   14
      Top             =   960
      WhatsThisHelpID =   5034
      Width           =   1470
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   5
      Left            =   1776
      TabIndex        =   15
      Top             =   960
      Width           =   6696
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   15
      TabIndex        =   20
      Top             =   315
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha desde:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   15
      TabIndex        =   19
      Top             =   660
      WhatsThisHelpID =   5172
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   18
      Top             =   15
      WhatsThisHelpID =   5016
      Width           =   1365
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8550
      Y1              =   930
      Y2              =   930
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8550
      X2              =   8550
      Y1              =   0
      Y2              =   5805
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1940
      TabIndex        =   17
      Top             =   315
      UseMnemonic     =   0   'False
      Width           =   6550
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   5745
      TabIndex        =   16
      Top             =   660
      WhatsThisHelpID =   5173
      Width           =   1200
   End
End
Attribute VB_Name = "FTran232"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran232.frm
' NOMBRE LOGICO:    FTran232
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
' Permite realizar la consulta de movimientos de la cuenta de
' ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
'Dim VLFormatoFecha As String
'CloVargas Oct/23/01 Manejo de Formato Fecha

Dim VLTranDiario As Integer
Dim VLTotalHistorico As Integer
Dim VLTotalDiario As Integer
Dim VLSecuencial As String
Dim VLSecAlterno As String
Dim VLhora As String
Dim VLFecha As String


Dim VLImpresion() As VGLineaImp
Dim VLColumnas%
Dim VLOrdenColImp(17) As Integer
Dim VLLin   As Integer
Dim Flag As Boolean
Dim VLFormatoFecha$
'Req. 371 Tarjeta Debito
Dim VLTarjeta As String

Dim VLPAG As Integer
Private Sub PLDetalleMovimiento()
'*************************************************************
' ARCHIVO:          FTran232.frm
' NOMBRE LOGICO:    PLDetalleMovimiento()
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
' CONSULTA EL DESGLOSE DE COMO SE RECIBIO EL MOVIMIENTO SELCIONADO-
' DEL GRID DE MOVIMIENTOS DE LA CUENTA CORRIENTES
' sulta.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Ene-07      P.COELLO        Emisión Inicial
'*************************************************************
Dim VTArreglo() As String
Dim VTFDesde As String
Dim archivos As String
Dim VTR As Integer
Dim reporte As String
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "232"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
        grdEstado.Col = 1
        VTFDesde = FMConvFecha(grdEstado.Text, VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fchdsde", 0, SQLDATETIME, VTFDesde
        PMPasoValores sqlconn&, "@i_fchhsta", 0, SQLDATETIME, VTFDesde
        
        'ENVIAR
        grdEstado.Col = 13
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, Trim$(grdEstado.Text)
        'ENVIAR
        grdEstado.Col = 17
        PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT2, grdEstado.Text
        PMPasoValores sqlconn&, "@i_diario", 0, SQLINT1, "0"
        PMPasoValores sqlconn&, "@i_frontn", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "M"
        PMPasoValores sqlconn&, "@o_hist", 1, SQLINT1, "0"
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_ahcoestcta", True, "Ok... Consulta de datos del movimiento") Then
            ReDim VTArreglo(10) As String
            VTR = FMMapeaArreglo(sqlconn&, VTArreglo())
            PMChequea sqlconn&
            
            Dim baseDatoss As Database
            Dim tablas1 As Recordset
                
            Screen.MousePointer = 11
            archivos = VGPath$ & "\solicitu.mdb"
            Set baseDatoss = DBEngine.OpenDatabase(archivos)
            Set tablas1 = baseDatoss.OpenRecordset("detmovimiento")
            baseDatoss.Execute "delete from detmovimiento"
            tablas1.AddNew
            tablas1("titulo") = "CONSULTA DE DETALLE DE MOVIMIENTO DE CUENTA DE AHORROS"
            grdEstado.Col = 2
            tablas1("subtitulo") = grdEstado.Text
            tablas1("cuenta") = mskCuenta.Text
            grdEstado.Col = 1
            tablas1("fecha") = grdEstado.Text
            tablas1("efectivo") = VTArreglo(1)
            tablas1("chqpropios") = VTArreglo(2)
            tablas1("chqlocales") = VTArreglo(3)
            tablas1("chqexterior") = VTArreglo(4)
            grdEstado.Col = 3
            If Trim$(grdEstado.Text) <> "" Then
               tablas1("monto") = grdEstado.Text
            Else
               grdEstado.Col = 4
               tablas1("total") = grdEstado.Text
            End If

            tablas1("cliente") = lblDescripcion(0).Caption
            tablas1.Update
            'Activamos el reporte
            reporte = VGPath$ + "\DETMOVIMIENTO.rpt"
            rptReporte.ReportFileName = reporte
            rptReporte.DataFiles(0) = archivos
            rptReporte.PageZoom (75)
            rptReporte.Destination = crptToWindow
            rptReporte.Action = 1
            tablas1.Close
            baseDatoss.Close
            Screen.MousePointer = 0
        Else
            PMChequea sqlconn&
            Exit Sub
        End If
End Sub


Private Sub Form_Load()
    Dim i As Integer
    FTran232.Left = 0   '15
    FTran232.Top = 0   '15
    FTran232.Width = 9600   '9420
    FTran232.Height = 6390   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    For i = 0 To 1
        mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
        mskValor(i).Text = Format$(VGFecha$, VGFormatoFecha$)
    Next i
    mskCuenta.Mask = VGMascaraCtaAho$

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTTipo As String
    Dim VTFDesde As String
    Dim VTFHasta As String
    Dim VTR As Integer
    Dim VTR1 As Integer
    Dim VTFono As String
    Dim VTalianza As String
    Dim VTdesalianza As String
    Dim VTResult As String
    Dim VTRecepGrid As String
    Dim i As Integer
    Dim j As Integer
    Select Case Index%
    Case 0
        ' Validacion de Mandatoriedades
        ' Numero de la Cuenta Corriente
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Fecha de inicio de la consulta
        If Trim$(mskValor(0).ClipText) = "" Then
            MsgBox "La fecha desde es mandatoria", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            Exit Sub
        End If

        ' Fecha de fin de la consulta
        If Trim$(mskValor(1).ClipText) = "" Then
            MsgBox "La fecha hasta es mandatoria", 0 + 16, "Mensaje de Error"
            mskValor(1).SetFocus
            Exit Sub
        End If

        VLTotalHistorico% = 0
        VLTotalDiario% = 0

        PMLimpiaGrid grdEstado
        grdEstado.FixedCols = 1
        grdEstado.FixedRows = 1
        'grdEstado.Cols = 15
        grdEstado.Cols = 18 'PCOELLO SE ANADE UNA COLUMNA QUE SERA PARA EL SECUENCIAL ALTERNO
        grdEstado.Row = 0
        grdEstado.ColWidth(1) = 750
        grdEstado.ColWidth(2) = 2000
        grdEstado.ColWidth(3) = 1200
        grdEstado.ColWidth(4) = 1200
        If VGCodPais$ <> "CO" Then
            grdEstado.ColWidth(5) = 1200
            grdEstado.ColWidth(6) = 1200
            grdEstado.ColWidth(7) = 1000   'idb
            grdEstado.ColWidth(8) = 1200
            grdEstado.ColWidth(9) = 800
            grdEstado.ColWidth(10) = 1200
            grdEstado.ColWidth(11) = 1000
            grdEstado.ColWidth(11) = 1200
            grdEstado.ColWidth(12) = 1600
            grdEstado.ColWidth(13) = 1600
            grdEstado.ColWidth(15) = 1  'PCOELLO EN LA ULTIMA COLUMNA ESTARA EL SECUENCIAL ALTERNO
        Else
            grdEstado.ColWidth(5) = 800
            grdEstado.ColWidth(6) = 800
            grdEstado.ColWidth(7) = 1200   'idb
            grdEstado.ColWidth(8) = 1200   'idb
            grdEstado.ColWidth(9) = 1000   'idb
            grdEstado.ColWidth(10) = 1200
            grdEstado.ColWidth(11) = 800
            grdEstado.ColWidth(12) = 1200
            grdEstado.ColWidth(13) = 1000
            grdEstado.ColWidth(14) = 1200
            grdEstado.ColWidth(15) = 1600
            grdEstado.ColWidth(16) = 1600
            grdEstado.ColWidth(17) = 1
        End If
        grdEstado.ColAlignment(2) = 0
        grdEstado.ColAlignment(3) = 1
        grdEstado.ColAlignment(4) = 1
        grdEstado.ColAlignment(5) = 1
        grdEstado.ColAlignment(6) = 1
        grdEstado.ColAlignment(7) = 1
        grdEstado.ColAlignment(8) = 1
        grdEstado.ColAlignment(9) = 1
        grdEstado.ColAlignment(10) = 1
        grdEstado.ColAlignment(11) = 1
        grdEstado.Col = 1
        grdEstado.Text = "FECHA"
        grdEstado.Col = 2
        grdEstado.Text = "DESCRIPCION"
        grdEstado.Col = 3
        grdEstado.Text = "DEBITO"
        grdEstado.Col = 4
        grdEstado.Text = "CREDITO"
        If VGCodPais$ <> "CO" Then
            grdEstado.Col = 5
            grdEstado.Text = "S. CONTABLE"
            grdEstado.Col = 6
            grdEstado.Text = "S. DISPONIBLE"
            grdEstado.Col = 7
            grdEstado.Text = "TERMINAL " '"IDB"    'idb
            grdEstado.Col = 8
            grdEstado.Text = "REFERENCIA"
            grdEstado.Col = 9
            grdEstado.Text = "OFICINA" '"LUGAR"
            grdEstado.Col = 10
            grdEstado.Text = "INTERESES"
            grdEstado.Col = 11
            grdEstado.Text = "SECUENCIAL"
            grdEstado.Col = 12 '13
            grdEstado.Text = "OPERADOR"
            grdEstado.Col = 13 '14
            grdEstado.Text = "HORA " '"CAUSA"
            grdEstado.Col = 14 '15
            grdEstado.Text = "CODIGO" '"CAUSA"
            'PCOELLO SE AÑADE EL SECUENCIAL ALTERNO PARA LA BUSQUEDA DEL DETALLE DEL MOVIMIENTO
            grdEstado.Col = 15 '15
            grdEstado.Text = "SEC.ALT."
        Else
            grdEstado.Col = 5
            grdEstado.Text = "IMP. GMF"
            grdEstado.Col = 6
            grdEstado.Text = "IVA"
            grdEstado.Col = 7
            grdEstado.Text = "S. CONTABLE"
            grdEstado.Col = 8
            grdEstado.Text = "S. DISPONIBLE"
            grdEstado.Col = 9
            grdEstado.Text = "TERMINAL "
            grdEstado.Col = 10
            grdEstado.Text = "REFERENCIA"
            grdEstado.Col = 11
            grdEstado.Text = "OFICINA"
            grdEstado.Col = 12
            grdEstado.Text = "INTERESES"
            grdEstado.Col = 13
            grdEstado.Text = "SECUENCIAL"
            grdEstado.Col = 14 '13
            grdEstado.Text = "OPERADOR"
            grdEstado.Col = 15 '14
            grdEstado.Text = "HORA "
            grdEstado.Col = 16 '15
            grdEstado.Text = "CODIGO"
            grdEstado.Col = 17
            grdEstado.Text = "SEC.ALT."
        End If
        ' Matriz temporal para recepcion de transacciones
        ReDim VTMatriz(210, 210) As String

        ' Arreglo temporal para recepcion de cabecera
        ReDim VTArregloCab(50) As String

        ' Variable de control de datos del historico
        VLTranDiario% = 0
                    
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "232"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
        VTFDesde = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fchdsde", 0, SQLDATETIME, VTFDesde
        VTFHasta = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fchhsta", 0, SQLDATETIME, VTFHasta
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT2, "0"
        PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT4, "-1"
        PMPasoValores sqlconn&, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM"
        PMPasoValores sqlconn&, "@i_diario", 0, SQLINT1, Str$(VLTranDiario%)
        PMPasoValores sqlconn&, "@i_frontn", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
        If VGCodPais = "CO" Then
           VTR = MsgBox("¿Esta transacción es solicitada por el cliente?", vbYesNo, "Mensaje del Sistema")
           If VTR = vbYes Then
               PMPasoValores sqlconn&, "@i_escliente", 0, SQLCHAR, "S"
               Flag = True
           Else
               PMPasoValores sqlconn&, "@i_escliente", 0, SQLCHAR, "N"
               Flag = False
           End If
        End If
        PMPasoValores sqlconn&, "@o_hist", 1, SQLINT1, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_ahcoestcta", True, "Ok... Consulta del Estado de Cuenta") Then
             VTR1 = FMMapeaArreglo(sqlconn&, VTArregloCab())
             PMMapeaVariable sqlconn&, VTFono
             PMMapeaVariable sqlconn&, VTalianza
             PMMapeaVariable sqlconn&, VTdesalianza
             VTResult = FMMapeaMatriz(sqlconn&, VTMatriz())
             PMChequea sqlconn&
             VLTranDiario% = Val(FMRetParam(sqlconn&, 1))
             
             For i = 1 To VTResult
                VTRecepGrid = ""
                grdEstado.Row = grdEstado.Rows - 1
                grdEstado.Col = 0
                
                VTRecepGrid = Str$(Val(grdEstado.Text) + 1) & Chr$(9)
                VLFecha$ = VTMatriz(0, i)
                VTRecepGrid = VTRecepGrid & VTMatriz(0, i) & Chr$(9)
                
                If VTMatriz(3, i) = "S" Then
                    VTRecepGrid = VTRecepGrid & "Corr-" & VTMatriz(4, i) & Chr$(9)
                Else
                    VTRecepGrid = VTRecepGrid & VTMatriz(4, i) & Chr$(9)
                End If
                If VTMatriz(5, i) = "D" Then
                    VTRecepGrid = VTRecepGrid & VTMatriz(6, i) & Chr$(9) & " " & Chr$(9)
                Else
                    VTRecepGrid = VTRecepGrid & " " & Chr$(9) & VTMatriz(6, i) & Chr$(9)
                End If
                VLSecuencial$ = VTMatriz(18, i) ' VTMatriz(11, i)
                VLSecAlterno$ = VTMatriz(12, i) '& Chr$(9)
                VLhora$ = VTMatriz(16, i) 'pcoello mayo del 2006
                VTRecepGrid = VTRecepGrid & VTMatriz(20, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(19, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(8, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(9, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(7, i) & Chr$(9) 'idb
                VTRecepGrid = VTRecepGrid & VTMatriz(11, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(2, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(10, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(18, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(15, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(16, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(17, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(12, i)  'PCOELLO SE REQUIERE AÑADIR EL CODIGO ALTERNO PARA LA CONSULTA DEL DETALLE DEL MOVIMIENTO
                grdEstado.AddItem VTRecepGrid
            Next i
        
            ' Grabar datos de la cabecera
            lblDescripcion(1).Caption = VTArregloCab(1)
            lblDescripcion(2).Caption = VTArregloCab(2)
            lblDescripcion(4).Caption = VTArregloCab(3)
            lblDescripcion(5).Caption = VTArregloCab(4)
            lblDescripcion(3).Caption = VTArregloCab(5)
            lblDescripcion(6).Caption = VTArregloCab(6)
            lblDescripcion(7).Caption = VTArregloCab(7)
            lblDescripcion(8).Caption = VTArregloCab(9)
            lblDescripcion(9).Caption = VTArregloCab(8)
            lblDescripcion(10).Caption = VTFono
            Lblalianza.Caption = VTalianza
            lbldesalianza.Caption = VTdesalianza
            lblDescripcion(11).Caption = VTArregloCab(10)
            lblDescripcion(12).Caption = VTArregloCab(11)
            
            ' Determianr si terminaron las transacciones del historico
            If VLTranDiario% = 1 Then
               VLSecuencial$ = "0"
               VLSecAlterno$ = "0"
               VLhora$ = "01/01/1900 12:00AM"     'pcoello mayo del 2006
               cmdBoton_Click (3)
            End If
            
            ' Activar/ Desactivar el boton de siguientes
            If VLTranDiario% = 3 Then
               cmdBoton(3).Enabled = False
            Else
               cmdBoton(3).Enabled = True
            End If

            mskCuenta.Enabled = False
            mskValor(0).Enabled = False
            mskValor(1).Enabled = False
            cmdBoton(5).Enabled = True
            If grdEstado.Rows > 2 Then
                grdEstado.RemoveItem 1
            End If
            
        End If
        
        'Req. 371 Tarjeta Debito
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "747"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "Q"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Consultando") Then
            PMMapeaVariable sqlconn&, VLTarjeta
            PMChequea sqlconn&
        Else
            Exit Sub
        End If
        
        'Si la cuenta esta relacionada con una tarjeta de debito
        If VLTarjeta = "S" Then
            optTarjetaDebito(0).Value = True
        Else
            optTarjetaDebito(1).Value = True
        End If

    Case 1
        'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        mskValor(0).Enabled = True
        mskValor(1).Enabled = True
        'mskCuenta.Enabled = True
        For i = 0 To 1
            'mskValor(i).Mask = ""
            mskValor(i).Text = Format$(VGFecha$, VGFormatoFecha$)
            'mskValor(i).Text = ""
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
        Next i
             
        For i = 1 To 12
            lblDescripcion(i).Caption = ""
        Next i
        PMLimpiaGrid grdEstado
        cmdBoton(4).Enabled = False
        cmdBoton(3).Enabled = False
        cmdBoton(5).Enabled = False
        Lblalianza.Caption = ""
        lbldesalianza.Caption = ""
        'mskCuenta.SetFocus
    Case 2
        Unload FTran232
    Case 3
        Dim VLTotalDebitos As Currency ''Almacena el total de Debitos
        Dim VLTotalCreditos As Currency ''Almacena el total de Creditos

        ' Validacion de Mandatoriedades

        ' Numero de la Cuenta Corriente
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Fecha de inicio de la Consulta
        If Trim$(mskValor(0).ClipText) = "" Then
            MsgBox "La fecha de inicio es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            Exit Sub
        End If

        ' Fecha de Fin de la Consulta
        If Trim$(mskValor(1).ClipText) = "" Then
            MsgBox "La fecha de fin es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(1).SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "232"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         VTFDesde = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
         PMPasoValores sqlconn&, "@i_fchdsde", 0, SQLDATETIME, VTFDesde
         VTFHasta = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
         PMPasoValores sqlconn&, "@i_fchhsta", 0, SQLDATETIME, VTFHasta
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, VLSecuencial$
         PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT4, VLSecAlterno$
         PMPasoValores sqlconn&, "@i_hora", 0, SQLDATETIME, VLhora$
         PMPasoValores sqlconn&, "@i_diario", 0, SQLINT1, Str$(VLTranDiario%)
         PMPasoValores sqlconn&, "@i_frontn", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
         PMPasoValores sqlconn&, "@o_hist", 1, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_ahcoestcta", True, "Ok... Consulta del estado de cuenta") Then
            ReDim VTMatriz(210, 210) As String
            VTResult = FMMapeaMatriz(sqlconn&, VTMatriz())
            PMChequea sqlconn&
            VLTranDiario% = Val(FMRetParam(sqlconn&, 1))
            For i = 1 To VTResult
                VTRecepGrid = ""
                grdEstado.Row = grdEstado.Rows - 1
                grdEstado.Col = 0
                VTRecepGrid = Str$(Val(grdEstado.Text) + 1) & Chr$(9)
                VLFecha$ = VTMatriz(0, i)
                VTRecepGrid = VTRecepGrid & VTMatriz(0, i) & Chr$(9)
                If VTMatriz(3, i) = "S" Then
                    VTRecepGrid = VTRecepGrid & "Corr-" & VTMatriz(4, i) & Chr$(9)
                Else
                    VTRecepGrid = VTRecepGrid & VTMatriz(4, i) & Chr$(9)
                End If
                
                If VTMatriz(5, i) = "D" Then
                    VTRecepGrid = VTRecepGrid & VTMatriz(6, i) & Chr$(9) & " " & Chr$(9)
                Else
                    VTRecepGrid = VTRecepGrid & " " & Chr$(9) & VTMatriz(6, i) & Chr$(9)
                End If
                VLSecuencial$ = VTMatriz(18, i)   'VTMatriz(11, i)
                VLSecAlterno$ = VTMatriz(12, i) '& Chr$(9)
                VLhora$ = VTMatriz(16, i)    'pcoello mayo del 2006
                VTRecepGrid = VTRecepGrid & VTMatriz(20, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(19, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(8, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(9, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(7, i) & Chr$(9)     'idb
                VTRecepGrid = VTRecepGrid & VTMatriz(11, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(2, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(10, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(18, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(15, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(16, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(17, i) & Chr$(9)
                VTRecepGrid = VTRecepGrid & VTMatriz(12, i)  'PCOELLO SE REQUIERE AÑADIR EL CODIGO ALTERNO PARA LA CONSULTA DEL DETALLE DEL MOVIMIENTO
                grdEstado.AddItem VTRecepGrid
            Next i

            mskValor(0).Enabled = False
            mskValor(1).Enabled = False
            VLTotalDebitos = 0
            VLTotalCreditos = 0

            ' Determianr si terminaron las transacciones del historico
            If VLTranDiario% = 1 Then
                VLSecuencial$ = "0"
                VLSecAlterno$ = "0"
                VLhora$ = "01/01/1900 12:00AM"     'pcoello mayo del 2006
            End If
            
            ' Activar/ Desactivar el boton de siguientes

            If VLTranDiario% = 3 Then
                'JHI. Calculo del total de Debitos y Creditos
                
                For i = 1 To grdEstado.Rows - 1
                    VTTipo = "D"
                    j = 3 ''Posición de la columna de los débitos
                    grdEstado.Row = i
                    grdEstado.Col = j
                    If grdEstado.Text <> "" And grdEstado.Text <> " " Then
                        VLTotalDebitos = VLTotalDebitos + Val(CCur(grdEstado.Text))
                    Else
                        VLTotalDebitos = VLTotalDebitos
                    End If
                    
                    j = 4 ''Posicion de la columna de los créditos
                    grdEstado.Row = i
                    grdEstado.Col = j
                    If grdEstado.Text <> "" And grdEstado.Text <> " " Then
                        VTTipo = "C"
                        VLTotalCreditos = VLTotalCreditos + Val(CCur(grdEstado.Text))
                    Else
                        VLTotalCreditos = VLTotalCreditos
                    End If

                    If VGCodPais$ = "CO" Then
                        j = 5 ''Posición de la columna de impuesto GMF
                        grdEstado.Row = i
                        grdEstado.Col = j
                        If grdEstado.Text <> "" And grdEstado.Text <> " " Then
                            If VTTipo = "D" Then VLTotalDebitos = VLTotalDebitos + Val(CCur(grdEstado.Text))
                            If VTTipo = "C" Then VLTotalCreditos = VLTotalCreditos + Val(CCur(grdEstado.Text))
                        Else
                            VLTotalDebitos = VLTotalDebitos
                        End If
                        j = 6 ''Posición de la columna de Impuesto IVA
                        grdEstado.Row = i
                        grdEstado.Col = j
                        If grdEstado.Text <> "" And grdEstado.Text <> " " Then
                            If VTTipo = "D" Then VLTotalDebitos = VLTotalDebitos + Val(CCur(grdEstado.Text))
                            If VTTipo = "C" Then VLTotalCreditos = VLTotalCreditos + Val(CCur(grdEstado.Text))
                        Else
                            VLTotalDebitos = VLTotalDebitos
                        End If
                    End If
                Next i
                
                'JHI. Ubicación de los totales al final del grid
                grdEstado.Rows = grdEstado.Rows + 2
                
                grdEstado.Row = grdEstado.Rows - 1
                grdEstado.Col = 1
                grdEstado.Text = "TOTALES :"
                grdEstado.Col = 3 ''Posición de la columna de los débitos
                grdEstado.Text = Format$(VLTotalDebitos, "#,##0.00")
                grdEstado.Col = 4 ''Posición de la columna de los créditos
                grdEstado.Text = Format$(VLTotalCreditos, "#,##0.00")
                
                cmdBoton(3).Enabled = False
            End If

        End If
    Case 4
        ' Consulta de firmas de la cuenta

        If mskCuenta.ClipText <> "" Then
            ReDim VGADatosI(3)
            VGADatosI(1) = mskCuenta.ClipText
            VGADatosI(2) = "AHO"
            VGADatosI(3) = "0"
            FImagenes.Caption = "Firmas y/o sellos de la Cuenta [" & mskCuenta.Text & "]"
            FImagenes.Show 1
        Else
            MsgBox "Se ha omitido el número de cuenta", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
        End If
    Case 5
        ' Imprimir
        PLImprimir
    End Select
End Sub


Private Sub grdEstado_Click()
    grdEstado.Col = 0
    grdEstado.SelStartCol = 1
    grdEstado.SelEndCol = grdEstado.Cols - 1
    If grdEstado.Row = 0 Then
        grdEstado.SelStartRow = 1
        grdEstado.SelEndRow = 1
    Else
        grdEstado.SelStartRow = grdEstado.Row
        grdEstado.SelEndRow = grdEstado.Row
    End If
End Sub

Private Sub grdEstado_DblClick()
    If grdEstado.Rows > 1 And grdEstado.Text <> "" Then
       PLDetalle
    End If
End Sub

Public Sub PLDetalle()
    Dim archivos As String
    Dim reporte As String
    Dim nota As String
    Dim monto As String
    Dim ndc As String
    Dim subtitulo As String
    nota = ""
    monto = ""
    grdEstado.Col = 2
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    ndc = Mid$(grdEstado.Text, 1, 3)
    Select Case ndc
        Case "N/D"
            nota = "NOTA DE DÉBITO"
            subtitulo = "Le informamos que en la presente fecha hemos debitado a su cuenta de ahorros:"
            grdEstado.Col = 3
            monto = grdEstado.Text
        Case "N/C"
            nota = "NOTA DE CRÉDITO"
            subtitulo = "Le informamos que en la presente fecha hemos acreditado a su cuenta de ahorros:"
            grdEstado.Col = 4
            monto = grdEstado.Text
        Case "DEP"  'PCOELLO CONSULTAR EL DETALLE DEL DEPOSITO PARA VER COMO SE RECIBIO
            PLDetalleMovimiento
            Exit Sub
        Case Else
         Exit Sub
    End Select
    
    Dim baseDatoss As Database
    Dim tablas1 As Recordset
        
    Screen.MousePointer = 11
    archivos = VGPath$ & "\solicitu.mdb"
    Set baseDatoss = DBEngine.OpenDatabase(archivos)
    Set tablas1 = baseDatoss.OpenRecordset("detndnc")
    baseDatoss.Execute "delete from detndnc"
    tablas1.AddNew
    tablas1("titulo") = nota
    tablas1("subtitulo") = subtitulo
    tablas1("cuenta") = mskCuenta.Text
    grdEstado.Col = 1
    tablas1("fecha") = grdEstado.Text
    tablas1("monto") = monto
     grdEstado.Col = 2
    tablas1("descripcion") = grdEstado.Text
    tablas1("cliente") = lblDescripcion(0).Caption
    tablas1("retener") = lblDescripcion(5).Caption
    tablas1.Update
    'Activamos el reporte
    reporte = VGPath$ + "\DETNDNC.rpt"
    rptReporte.ReportFileName = reporte
    rptReporte.DataFiles(0) = archivos
    rptReporte.PageZoom (75)
    rptReporte.Destination = crptToWindow
    rptReporte.Action = 1
    tablas1.Close
    baseDatoss.Close
    Screen.MousePointer = 0
End Sub


Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta de ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(4).Enabled = True
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(0).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
            lblDescripcion(0).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
End Sub

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Fecha inicial de la consulta [" & VGFormatoFecha & "]"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta [" & VGFormatoFecha & "]"
    End Select
    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)
End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub mskValor_LostFocus(Index As Integer)
'*********************************************************
'PORPOSITO: Verifica la validez de la fecha ingresada
'           de acuerdo con el formato de la fecha
'           ingresada
'INPUT    : Index    Identificador de campo
'OUTPUT   : ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    On Error Resume Next
    Dim VTValido As Integer
    Dim i As Integer
    Dim VTDias As Long
    Select Case Index%
    Case 0, 1
        If mskValor(Index%).ClipText <> "" Then
            VTValido = FMVerFormato((mskValor(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        Else
            For i = 0 To 1
                mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
            Next i
        End If
        
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VGFormatoFecha$)
            If VTDias < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
                    mskValor(i).Text = Format$(VGFecha$, VGFormatoFecha$)
                Next i
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        End If
    End Select
End Sub


Private Sub PLImprimir()
On Error GoTo EtError
Dim VTTotalTrn As Integer
Dim i As Integer
Dim j As Integer
Dim VLPAG As Integer
Dim VTRow As Integer
Dim VTTotal As Integer
Dim VTOffset As Integer
Dim VTDatos As String
Dim ret As Integer
'rutina de impresión
    grdEstado.Row = 1
    grdEstado.Col = 1
    VTTotalTrn% = 0
    If grdEstado.Text <> "" Then
        If Not FMSeleccionarPrinter Then Exit Sub
        Screen.MousePointer = 11
        
        VLPAG% = 0
        PLOrdenColImp
        PLCabecera

        For i = 1 To grdEstado.Rows - 1
            grdEstado.Row = i
            VTRow% = grdEstado.Row
            If VLLin% > 86 Then
                Printer.Print
'FIXIT: Replace 'Str' function with 'Str$' function                                        FixIT90210ae-R9757-R1B8ZE
                Printer.Print Tab(14); "SUBTOTAL : "; Tab(35); Str$(VTTotal%)
                Printer.Print
                Printer.NewPage
                PLCabecera
            End If
            VTOffset% = 6
            grdEstado.Row = VTRow%
            For j% = 1 To VLColumnas%
                grdEstado.Col = VLImpresion(j%).Col
                VTDatos$ = Left$(grdEstado.Text, VLImpresion(j%).length)
                VTOffset% = VTOffset% + VLImpresion(j%).length
                If j% = 1 Then
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
                    Printer.Print Tab(6); Left$(VTDatos$, VLImpresion(j%).length - 1); Tab(VTOffset%);
                Else
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
                    Printer.Print Left$(VTDatos$, VLImpresion(j%).length - 1); Tab(VTOffset%);
                End If
            Next j%
            Printer.Print
            grdEstado.Col = 0
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If (Trim$(grdEstado.Text) <> "") Then
                VTTotalTrn% = VTTotalTrn% + 1
            End If
            VLLin% = VLLin% + 1
        Next i
        Printer.Print
        Printer.FontBold = True
        Printer.FontSize = 8
'FIXIT: Replace 'Str' function with 'Str$' function                                        FixIT90210ae-R9757-R1B8ZE
        Printer.Print Tab(10); "TOTAL DE TRANSACCIONES :"; Str$(VTTotalTrn%)
        Printer.FontBold = False
        Printer.EndDoc
        Screen.MousePointer = 0
    Else
         ret% = MsgBox("No existen datos.", vbExclamation, "Impresión")
         Screen.MousePointer = 0
        Exit Sub
    End If
Exit Sub

EtError:
ret% = MsgBox(Err.Description, vbCritical, "Error en impresión")
Screen.MousePointer = 0
End Sub

Private Sub PLOrdenColImp()
    VLOrdenColImp(0) = 0
    VLOrdenColImp(1) = 1
    VLOrdenColImp(2) = 2
    VLOrdenColImp(3) = 3
    VLOrdenColImp(4) = 4
    VLOrdenColImp(5) = 5
    VLOrdenColImp(6) = 6
    VLOrdenColImp(7) = 7
    VLOrdenColImp(8) = 8
    VLOrdenColImp(9) = 10 '9
    VLOrdenColImp(10) = 11 '10
    VLOrdenColImp(11) = 12 '11
    VLOrdenColImp(12) = 13 '12
    VLOrdenColImp(13) = 13
    VLOrdenColImp(14) = 14
    ' No de Columnas a imprimir
    If VGCodPais = "CO" Then
        VLOrdenColImp(15) = 15
        VLOrdenColImp(16) = 16
        VLColumnas% = 10
    Else
        VLColumnas% = 14
    End If
End Sub

Private Sub PLCabecera()
    Dim i As Integer
    Dim j As Integer
    Dim VTTemp As Integer
    Dim VTLen As Integer
    Dim VTFecha As String
    Dim VTTitulo As String
    Dim VTOffset As Integer
    'define cabecera
        VTTemp% = 2
        ReDim VLImpresion(grdEstado.Cols - 1)
        grdEstado.Row = 0
        j% = 1
        For j% = 1 To VLColumnas%
            grdEstado.Col = VLOrdenColImp(j%)
            VLImpresion(j%).Texto = grdEstado.Text
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            Select Case Trim$(grdEstado.Text)
                Case "DESCRIPCION"
                    VTLen% = Len(grdEstado.Text) + 22
                Case "FECHA"
                    VTLen% = Len(grdEstado.Text) + 8
                Case "HORA"
                    VTLen% = Len(grdEstado.Text) + 18
                'mmorales 16/08/2008
                Case "DEBITO"
                    VTLen% = Len(grdEstado.Text) + 9 '14
                Case "CREDITO"
                    VTLen% = Len(grdEstado.Text) + 10 '14
                Case "S. CONTABLE"
                    VTLen% = Len(grdEstado.Text) + 5
                Case "S. DISPONIBLE"
                    VTLen% = Len(grdEstado.Text) + 5
                Case "IVA"
                     VTLen% = Len(grdEstado.Text) + 6
                Case "IMP. GMF"
                     VTLen% = Len(grdEstado.Text) + 3
                Case "REFERENCIA"
                     VTLen% = Len(grdEstado.Text) + 5
                'Case "OFICINA"
                     'VTLen% = Len(grdEstado.Text)
                Case Else
                      VTLen% = Len(grdEstado.Text) + VTTemp%
            End Select
            VLImpresion(j%).length = VTLen%
            VLImpresion(j%).Col = VLOrdenColImp(j%)
        Next j%
        
'FIXIT: Replace 'Str' function with 'Str$' function                                        FixIT90210ae-R9757-R1B8ZE
        VTFecha$ = Format(Now, VGFechaFormato) + " " + Str$(Time)
        VLColumnas = j% - 1 '6
        VLPAG% = VLPAG% + 1
        Printer.Orientation = VGImpOrientacion
        Printer.FontName = "Times New Roman"
        Printer.FontSize = 10
        Printer.CurrentX = 0
        Printer.CurrentY = 0
        Printer.FontBold = True
        Printer.Print
        Printer.Print
        Printer.Print
        Printer.Print
        Printer.Print
        If Flag Then
            Printer.Print Tab(6); VGNombreFilial
        End If
        Printer.FontName = "Verdana" '"Courier New"
        Printer.FontSize = 9
        Printer.CurrentX = 0
        Printer.CurrentY = Printer.CurrentY + 1
        Printer.FontBold = False 'True
        VTTitulo$ = Me.Caption
        Printer.Print Tab(6); VTTitulo$ '; Tab(90); "PAG.: "; Tab(98); Format$(VLPAG%, "000")
        Printer.Print Tab(6); "No. Cuenta: "; Tab(20); mskCuenta.Text
        Printer.Print Tab(6); "Estado: "; Tab(20); lblDescripcion(12).Caption
        Printer.Print Tab(6); "Nombre: "; Tab(20); lblDescripcion(0).Caption
        Printer.Print Tab(6); "Fecha Desde: "; Tab(20); mskValor(0).Text
        Printer.Print Tab(6); "Fecha Hasta: "; Tab(20); mskValor(1).Text

        Printer.Print
        Printer.FontSize = 7
        Printer.FontName = "Verdana"
        VTOffset% = 6
        For i = 1 To VLColumnas%
            VTOffset% = VTOffset% + VLImpresion(i).length
            If i = 1 Then
                Printer.Print Tab(6); VLImpresion(i).Texto; Tab(VTOffset%);
            Else
                Printer.Print VLImpresion(i).Texto; Tab(VTOffset%);
            End If
        Next i
        Printer.Print
        Printer.Print Tab(6); String$(200, "-") '(VTOffset%, "-")
        Printer.FontBold = False
        VLLin% = 8
End Sub


