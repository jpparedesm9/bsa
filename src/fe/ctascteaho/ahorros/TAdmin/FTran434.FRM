VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form Ftran434 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Parametros Cuentas con Caracteristicas Especiales"
   ClientHeight    =   5655
   ClientLeft      =   420
   ClientTop       =   1845
   ClientWidth     =   9345
   ControlBox      =   0   'False
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
   HelpContextID   =   133
   Icon            =   "FTran434.frx":0000
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5655
   ScaleWidth      =   9345
   Begin Threed.SSFrame fraAtributo 
      Height          =   2550
      Left            =   30
      TabIndex        =   19
      Top             =   700
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14631
      _ExtentY        =   4498
      _StockProps     =   14
      Caption         =   "Parametros Cuenta Categoria  Especial :"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Index           =   4
         Left            =   1900
         MaxLength       =   4
         TabIndex        =   5
         Top             =   960
         Width           =   975
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Index           =   3
         Left            =   1900
         MaxLength       =   4
         TabIndex        =   7
         Top             =   1260
         Width           =   975
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Index           =   1
         Left            =   1900
         MaxLength       =   4
         TabIndex        =   3
         Top             =   660
         Width           =   975
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Index           =   0
         Left            =   1900
         MaxLength       =   4
         TabIndex        =   1
         Top             =   360
         Width           =   975
      End
      Begin VB.TextBox txtPlazo 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   4440
         MaxLength       =   3
         TabIndex        =   8
         Top             =   1260
         Width           =   855
      End
      Begin MSMask.MaskEdBox MskValor 
         Height          =   285
         Index           =   1
         Left            =   1905
         TabIndex        =   10
         Top             =   1860
         Width           =   2415
         _ExtentX        =   4260
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         Enabled         =   0   'False
         MaxLength       =   30
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin MhinrelLib.MhRealInput mskMonto 
         Height          =   285
         Left            =   1905
         TabIndex        =   9
         Tag             =   "7"
         Top             =   1560
         Width           =   2415
         _Version        =   458753
         _ExtentX        =   4260
         _ExtentY        =   503
         _StockProps     =   205
         ForeColor       =   -2147483630
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Alignment       =   0
         FillColor       =   16777215
         MaxReal         =   3.4E+38
         MinReal         =   0
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         CaretVisible    =   -1  'True
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   1905
         TabIndex        =   29
         Top             =   2160
         Width           =   975
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   4440
         TabIndex        =   28
         Top             =   2160
         Width           =   855
      End
      Begin VB.Label lblplazoacum 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Meses Transcurridos:"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   9
         Left            =   120
         TabIndex        =   27
         Top             =   2160
         WhatsThisHelpID =   5457
         Width           =   1680
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   7320
         TabIndex        =   26
         Top             =   1560
         Visible         =   0   'False
         Width           =   855
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   7320
         TabIndex        =   25
         Top             =   1920
         Visible         =   0   'False
         Width           =   855
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   2895
         TabIndex        =   4
         Top             =   660
         Width           =   2400
      End
      Begin VB.Label lblcategoria 
         Appearance      =   0  'Flat
         Caption         =   "Categoria :"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   2
         Left            =   120
         TabIndex        =   24
         Top             =   660
         WhatsThisHelpID =   5130
         Width           =   1215
         WordWrap        =   -1  'True
      End
      Begin VB.Label lbldiasmora 
         Appearance      =   0  'Flat
         Caption         =   "Periodos Incumplidos :"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   345
         Index           =   4
         Left            =   3000
         TabIndex        =   23
         Top             =   2160
         WhatsThisHelpID =   5452
         Width           =   1095
         WordWrap        =   -1  'True
      End
      Begin VB.Label lblPeriodicidad 
         Appearance      =   0  'Flat
         Caption         =   "Periodicidad :"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   3
         Left            =   120
         TabIndex        =   22
         Top             =   960
         WhatsThisHelpID =   5193
         Width           =   1215
         WordWrap        =   -1  'True
      End
      Begin VB.Label lblproducto 
         Appearance      =   0  'Flat
         Caption         =   "Producto :"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   345
         Index           =   1
         Left            =   120
         TabIndex        =   21
         Top             =   360
         WhatsThisHelpID =   5048
         Width           =   1215
         WordWrap        =   -1  'True
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   2895
         TabIndex        =   6
         Top             =   960
         Width           =   2400
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   2895
         TabIndex        =   2
         Top             =   360
         Width           =   5040
      End
      Begin VB.Label Label2 
         Caption         =   "Label2"
         Height          =   135
         Index           =   0
         Left            =   2400
         TabIndex        =   20
         Top             =   480
         Width           =   15
      End
      Begin VB.Label Lblmontofin 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Monto Final:"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   8
         Left            =   120
         TabIndex        =   0
         Top             =   1860
         WhatsThisHelpID =   5456
         Width           =   990
      End
      Begin VB.Label lblpuntos 
         Appearance      =   0  'Flat
         Caption         =   "Puntos de Premio :"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   5
         Left            =   120
         TabIndex        =   18
         Top             =   1260
         WhatsThisHelpID =   5453
         Width           =   1575
         WordWrap        =   -1  'True
      End
      Begin VB.Label lblcuota 
         Appearance      =   0  'Flat
         Caption         =   "Valor Cuota :"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   345
         Index           =   7
         Left            =   120
         TabIndex        =   16
         Top             =   1560
         WhatsThisHelpID =   5455
         Width           =   1455
         WordWrap        =   -1  'True
      End
      Begin VB.Label lblplazo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Meses Pactados:"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   6
         Left            =   3000
         TabIndex        =   17
         Top             =   1260
         WhatsThisHelpID =   5454
         Width           =   1350
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   0
      Left            =   8400
      TabIndex        =   12
      Top             =   1660
      WhatsThisHelpID =   2030
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Aceptar."
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
      Height          =   795
      Index           =   1
      Left            =   8400
      TabIndex        =   13
      Top             =   2480
      WhatsThisHelpID =   2023
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Cancelar."
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
      Height          =   795
      Index           =   2
      Left            =   8400
      TabIndex        =   15
      Top             =   4850
      Visible         =   0   'False
      WhatsThisHelpID =   2008
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Salir."
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
      Height          =   795
      Index           =   3
      Left            =   8400
      TabIndex        =   11
      Top             =   10
      WhatsThisHelpID =   2000
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Buscar"
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
   Begin MSGrid.Grid grdRegistros 
      Height          =   2050
      Left            =   30
      TabIndex        =   30
      TabStop         =   0   'False
      Top             =   3550
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   3616
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.03
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   32
      Top             =   0
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   4
      Left            =   8400
      TabIndex        =   14
      Top             =   4040
      Visible         =   0   'False
      WhatsThisHelpID =   2009
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1402
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
   Begin MSGrid.Grid grdCabecera 
      Height          =   855
      Left            =   0
      TabIndex        =   36
      TabStop         =   0   'False
      Top             =   5760
      Visible         =   0   'False
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   1508
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
   Begin Crystal.CrystalReport rptReporte 
      Left            =   8640
      Top             =   960
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
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
      Left            =   30
      TabIndex        =   35
      Top             =   300
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   30
      TabIndex        =   34
      Top             =   0
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   8280
      Y1              =   615
      Y2              =   615
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   5
      Left            =   1950
      TabIndex        =   33
      Top             =   300
      UseMnemonic     =   0   'False
      Width           =   6345
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8395
      Y1              =   3300
      Y2              =   3300
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Consulta Plan de Pago :"
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   0
      Left            =   30
      TabIndex        =   31
      Top             =   3330
      Width           =   2070
   End
End
Attribute VB_Name = "Ftran434"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        Ftran434.FRM
'   Producto:       Master Information Subsystem
'   Diseñado por:   Myriam Dávila
'   Fecha de Documentación: 06/May/94
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
' Forma: Ftran434
' Descripcion:  Esta Forma nos permite asignar/eliminar/
'               modificar atributos de relaciones.
'               Las Instancias de una relación pueden
'               tomar uno o más de estos atributos aqui
'               definidos
' VARIABLES GLOBALES:
'           ServerName        nombre del servidor
' MODULOS:
'           MHELPG.BAS = Rutinas para usar la ventana de ayuda
' LLAMADA:
'           Para llamar a esta forma es necesario invocar
'           únicamente al evento Show de la misma
'           Hay que llenar el código y la descripción de
'           la Relación
'*********************************************************
Option Explicit
Const IDYES = 6
Dim CGTeclaMenos As Integer
Dim VLcuotaMin As String
Dim VLPlazo As String
Dim VTPlanPago As String
Dim VTArregloCab() As String
Dim VLEstado As String
Dim VLEstado_Cta As String
Dim VLCuotas As Integer
Dim SecGrid As Integer
'FIXIT: Declare 'VLImprimir' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
Dim VLImprimir As String

'! Private Sub cmbTDato_GotFocus()
'! '*********************************************************
'! 'Objetivo:  Despliega el mensaje de ayuda apropiado
'! 'Input   :  ninguno
'! 'Output  :  ninguno
'! '*********************************************************
'! '                    MODIFICACIONES
'! 'FECHA      AUTOR               RAZON
'! '06/May/94  M.Davila            Emisión Inicial
'! '*********************************************************
'!     FPrincipal!pnlTransaccionLine.Caption = ""
'!     FPrincipal!pnlHelpLine.Caption = " Escoja un Tipo de Dato para el Atributo"
'! End Sub
Private Sub cmdBoton_Click(Index As Integer)
 Select Case Index
  Case 0 'Transmitir
         PLTransmitir
  Case 1 ' Cancelar
         PLCancelar
  Case 2 ' Salir
         Unload Ftran434
  Case 3 ' Salir
         PLBuscar
  Case 4 ' Salir
         PLImprimir
End Select
End Sub

Private Sub Form_Load()
'*********************************************************
'Objetivo:  Setea las variables apropiadas para el inicio
'           de la operación de la forma.
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'31/Mar/2011  M.Davila            Emisión Inicial
'*********************************************************
  PMLoadResStrings Me
  PMLoadResIcons Me
  txtPlazo.Enabled = False
  mskMonto.Enabled = False
  
  If VGOrigen = "0" Then 'Apertura
     Ftran434.Width = 9405
     Ftran434.Height = 3765
     lbldiasmora(4).Visible = False
     lblDescripcion(3).Visible = False
     lblplazoacum(9).Visible = False
     lblDescripcion(3).Visible = False
     lblDescripcion(4).Visible = False
     lblDescripcion(5).Caption = VGNombreCuenta
      mskCuenta.Enabled = True
      VGCuenta = ""
      Ftran434.mskCuenta.Mask = VGMascaraCtaAho
      Ftran434.mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
      mskCuenta_LostFocus
      mskCuenta.Enabled = False
      lblEtiqueta(0).Visible = False
      grdRegistros.Visible = False
      cmdBoton(2).Visible = False
      cmdBoton(3).Visible = False
      cmdBoton(4).Visible = False
      VGCancelar = "N"
      PLBuscar_parametro
  End If

  If VGOrigen = "1" Then 'Consultas
     If VGContractual = "S" Then
        Ftran434.Width = 9405
        Ftran434.Height = 3765
        lbldiasmora(4).Visible = True
        lblDescripcion(3).Visible = True
        lblplazoacum(9).Visible = True
        lblDescripcion(4).Visible = True
        lblDescripcion(5).Caption = VGNombreCuenta
        mskCuenta.Enabled = True
        Ftran434.mskCuenta.Mask = VGMascaraCtaAho
        Ftran434.mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
        mskCuenta_LostFocus
        mskCuenta.Enabled = False
        lblEtiqueta(0).Visible = False
        grdRegistros.Visible = False
        cmdBoton(0).Visible = False
        cmdBoton(1).Visible = False
        cmdBoton(3).Visible = False
        cmdBoton(4).Visible = False
        cmdBoton(2).Visible = True
        cmdBoton(2).Top = 2480
        cmdBoton(2).Enabled = True
        cmdBoton(2).Refresh
        If VGCuenta = "" Then
            PLBuscar_parametro
        Else
            PLBuscar_Cuenta
        End If
     Else
        If VGProgresivo = "S" Then
            Ftran434.Width = 9405
            Ftran434.Height = 6120
            lblEtiqueta(0).Visible = True
            cmdBoton(0).Visible = False
            cmdBoton(1).Visible = False
            cmdBoton(2).Visible = True 'salir
            cmdBoton(2).Enabled = True 'salir
            cmdBoton(3).Enabled = True 'buscar
            grdRegistros.Visible = True
            txtPlazo.Enabled = False
            mskMonto.Enabled = False
            Ftran434.mskCuenta.Mask = VGMascaraCtaAho
            Ftran434.mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
            mskCuenta_LostFocus
            mskCuenta_LostFocus
            PLBuscar_Cuenta
        End If
    End If
  End If
  
End Sub

Private Sub Form_Unload(Cancel As Integer)
'*********************************************************
'Objetivo:  Limpia las líneas de Mensaje y Transaccion
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'09/May/94  M.Davila            Emisión Inicial
'*********************************************************
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub
Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Mar-2011   S. Molano        Emisión Inicial
'*************************************************************
If Val(VLPlazo) > Val(txtPlazo.Text) Then
    MsgBox "Meses Pactados Inferiores Plazo Mínimo del Producto", 0 + 16, "Mensaje de Error"
    txtPlazo.SetFocus
    Exit Sub
End If
If Int(VLcuotaMin) > Int(mskMonto.Text) Then
    MsgBox "Cuota Pactada Inferior al Monto Mínimo", 0 + 16, "Mensaje de Error"
    mskMonto.SetFocus
    Exit Sub
End If

VGPlazo = txtPlazo.Text
VGDeposito = mskMonto.Text
VGPuntos = txtCampo(3).Text
VGPeriodicidad = txtCampo(4).Text
VGMontoFinal = MskValor(1)
VGEstado = "A"
VGCuenta = ""
Unload Ftran434

End Sub
Private Sub PLBuscar_parametro()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Mar-2011   S. Molano        Emisión Inicial
'*************************************************************
Dim VTR1 As Integer
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4123
PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, VGcategoria
PMPasoValores sqlconn&, "@i_profinal", 0, SQLVARCHAR, VGprofinal
PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "S"

If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_producto_contractual", True, "Ok... Consulta de Servicios Marcados") Then
   ReDim VTArreglo(20) As String
   VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
   PMChequea sqlconn&
   txtCampo(0).Text = VTArreglo(19)            'Codigo producto
   lblDescripcion(0).Caption = VTArreglo(20)   'Producto
   txtCampo(1).Text = VTArreglo(3)            'Codigo categoria
   lblDescripcion(1).Caption = VTArreglo(4)   'Categoria
   txtPlazo.Text = VTArreglo(5)               'Plazo
   lblEtiqueta(3).Caption = VTArreglo(6)      'Negociacion Plazo
   mskMonto.Text = VTArreglo(7)               'Cuota
   lblEtiqueta(4).Caption = VTArreglo(8)      'Negociacion Cuota
   txtCampo(4).Text = VTArreglo(9)            'Codigo Periodicidad
   lblDescripcion(2).Caption = VTArreglo(10)  'Periodicidad
   MskValor(1).Text = VTArreglo(11)           'Monto Final
   txtCampo(3).Text = VTArreglo(14)           'Puntos premio

   VLEstado = VTArreglo(12)                   'Estado parametrizacion
   If VLEstado = "V" Then
      VGProdFinal = VTArreglo(1)
      VLcuotaMin = VTArreglo(7)                  'Cuota
      VLPlazo = VTArreglo(5)                     'Plazo
   
      If lblEtiqueta(4).Caption = "S" Then
         mskMonto.Enabled = True
      End If
      If lblEtiqueta(3).Caption = "S" Then
         txtPlazo.Enabled = True
      End If
   Else
      MsgBox "Cuota Pactada Inferior al Monto Mínimo", 0 + 16, "Mensaje de Error"
      Exit Sub
   End If
Else
   Unload Ftran434
End If
End Sub
Private Sub PLBuscar_Cuenta()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Mar-2011   S. Molano        Emisión Inicial
'*************************************************************
Dim VTR1 As Integer
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 734
PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, VGcategoria
PMPasoValores sqlconn&, "@i_profinal", 0, SQLVARCHAR, VGprofinal
PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, VGCuenta
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"

If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_mto_aho_contractual", True, "Ok... Consulta de Servicios Marcados") Then
   ReDim VTArreglo(20) As String
   VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
   PMChequea sqlconn&
   txtCampo(0).Text = VTArreglo(1)            'Codigo producto
   lblDescripcion(0).Caption = VTArreglo(2)   'Producto
   txtCampo(1).Text = VTArreglo(3)            'Codigo categoria
   lblDescripcion(1).Caption = VTArreglo(4)   'Categoria
   txtPlazo.Text = VTArreglo(5)               'Plazo
   mskMonto.Text = VTArreglo(6)               'Cuota
   txtCampo(4).Text = VTArreglo(7)            'Codigo Periodicidad
   lblDescripcion(2).Caption = VTArreglo(8)   'Periodicidad
   MskValor(1).Text = VTArreglo(9)            'Monto Final
   txtCampo(3).Text = VTArreglo(10)           'Puntos premio
   lblDescripcion(3).Caption = VTArreglo(11)  'Dias maximo mora acumulado
   lblDescripcion(4).Caption = VTArreglo(12)  'Dias Plazo acumulado
   VLImprimir = VTArreglo(13)
   
   If VLImprimir = "S" Then
      cmdBoton(4).Visible = True
   End If
   
   VLcuotaMin = VTArreglo(7)                  'Cuota
   VLPlazo = VTArreglo(5)                     'Plazo
   
   If lblEtiqueta(4).Caption = "S" Then
      mskMonto.Enabled = True
   End If
   If lblEtiqueta(3).Caption = "S" Then
      txtPlazo.Enabled = True
   End If
Else
  Unload Ftran434
End If
End Sub

Private Sub PLCancelar()
   VGCancelar = "S"
   Unload Ftran434
End Sub

Private Sub mskMonto_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del Tope"
    mskMonto.SelStart = 0
    mskMonto.SelLength = Len(mskMonto.Text)
End Sub
Private Sub mskMonto_KeyPress(KeyAscii As Integer)
    If VGDecimales = "#,##0" Then
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
    Else
        If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
    End If
    KeyAscii = FMValidarNumero((mskMonto.Text), 13, KeyAscii, "105")
End Sub

Private Sub mskMonto_LostFocus()
If Val(mskMonto.Text) <> VLcuotaMin Or txtPlazo.Text <> VLPlazo Then
   MskValor(1).Text = CCur(mskMonto.Text) * txtPlazo.Text
End If
End Sub
Function FMValidarNumero(parValor As String, parLongitud As Integer, parcaracter As Integer, parNemonico As String) As Integer

  Dim VTDecimal As Integer
  Dim VTSeparadorDecimal As String

  VTSeparadorDecimal = "."

  VTDecimal = 2
  'If parcaracter = CGTeclaMenos Then
  '  FMValidarNumero% = 0
  '  Exit Function
  'End If
  
  If parcaracter = CGTeclaMenos Then
    FMValidarNumero% = 0
    Exit Function
  End If

  If (VTDecimal > 0) Then
      If (InStr(1, parValor, VTSeparadorDecimal)) >= (parLongitud + (VTDecimal) + 1) Then
        FMValidarNumero = 0
      Else
        FMValidarNumero = parcaracter
      End If
  Else
    If Len(parValor) >= parLongitud Then
      FMValidarNumero = 0
    Else
      FMValidarNumero = parcaracter
    End If
  End If

End Function
Private Sub PLBuscar()
Dim VTPlanPago As String
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "393"
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT2, "0"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, VGCuenta
        PMPasoValores sqlconn&, "@i_frontn", 0, SQLCHAR, "S"

        ReDim VTArregloCab(5) As String

        If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_imprime_plan_pago", True, "Ok... Imprime Plan de Pagos") Then
           PMMapeaGrid sqlconn&, grdCabecera, False
           PMMapeaVariable sqlconn&, VTPlanPago
           grdCabecera.Col = 6  'Estado Cuenta
           VLEstado_Cta = grdCabecera.Text
           
           If VLEstado_Cta <> "A" Then
              MsgBox "Estado de Cuenta NO Activo; No permite Impresion", 0 + 16, "Mensaje de Error"
           Else
              PMMapeaGrid sqlconn&, grdRegistros, False
              PMChequea sqlconn&
              VLCuotas = Int(txtPlazo.Text)
              grdRegistros.Row = grdRegistros.Rows - 1
              grdRegistros.Col = 1
              SecGrid = grdRegistros.Text
           
              Do While (VLCuotas > SecGrid)
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "393"
                 PMPasoValores sqlconn&, "@i_sec", 0, SQLINT2, SecGrid
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, VGCuenta
                 PMPasoValores sqlconn&, "@i_frontn", 0, SQLCHAR, "S"
                 If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_imprime_plan_pago", True, "Ok... Imprime Plan de Pagos") Then
                    PMMapeaGrid sqlconn&, grdRegistros, True
                    PMChequea sqlconn&
                 End If
                 grdRegistros.Row = grdRegistros.Rows - 1
                 grdRegistros.Col = 1
                 SecGrid = grdRegistros.Text
              Loop
           End If
           If VLImprimir = "S" And VLEstado_Cta = "A" Then
              cmdBoton(4).Enabled = True
           End If
        End If
End Sub
Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, VGCuenta
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(5)
                 PMChequea sqlconn&
                 cmdBoton(3).Enabled = True
            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
    End If
End Sub
Private Sub PLImprimir()
Dim archivos As String
Dim VTMsg As String
Dim VTR As Integer
Dim reportes As String
Dim tablas3 As Recordset
Dim i As Integer
    If MsgBox("Esta seguro de imprimir la consulta?", 1 + 32 + 0, "Mensaje del Sistema") = 1 Then
        Screen.MousePointer = 11
        
           Dim BaseDatos As Database
           Dim tablas1 As Recordset
           Dim tablas2 As Recordset
           archivos = VGPath & "\SOCTAAHO.MDB"
           Set BaseDatos = DBEngine.OpenDatabase(archivos)
           Set tablas1 = BaseDatos.OpenRecordset("ctacontractual")
           Set tablas2 = BaseDatos.OpenRecordset("datoscta")
           Set tablas3 = BaseDatos.OpenRecordset("cuotas")
           
           BaseDatos.Execute "delete from ctacontractual"
           BaseDatos.Execute "delete from datoscta"
           BaseDatos.Execute "delete from cuotas"
           
           tablas1.AddNew
           tablas1("Cuenta") = VGCuenta
           tablas1("Categoria") = txtCampo(1).Text + "  " + lblDescripcion(1).Caption
           tablas1("Plazo") = txtPlazo
           tablas1("cuota") = mskMonto
           tablas1("fecha_rep") = VGFecha
           
           grdCabecera.Col = 4  'Producto
           tablas1("Producto") = grdCabecera.Text
               
           grdCabecera.Col = 5  'Fecha apertura
           tablas1("fecha_aper") = grdCabecera.Text
                 
           tablas1.Update
           tablas1.Close
           
           For i = 1 To (grdCabecera.Rows - 1)
               grdCabecera.Row = i
               tablas2.AddNew

               tablas2("Cuenta") = VGCuenta

               grdCabecera.Col = 1 'Nombres
               tablas2("nombres") = grdCabecera.Text
            
               grdCabecera.Col = 2  'Documentos
               tablas2("Cedula") = grdCabecera.Text
            
               grdCabecera.Col = 3  'Rol
               tablas2("rol") = grdCabecera.Text
    
               tablas2.Update
           Next i
           tablas2.Close
    
           For i = 1 To (grdRegistros.Rows - 1)
               grdRegistros.Row = i
               tablas3.AddNew

              tablas3("cuenta") = VGCuenta

              grdRegistros.Col = 1 'Numero Cuota
              tablas3("cuota_num") = grdRegistros.Text
            
              grdRegistros.Col = 2  'mes_ahorro
              tablas3("mes_ahorro") = grdRegistros.Text
            
              grdRegistros.Col = 3  'Monto
              tablas3("monto") = grdRegistros.Text
            
              grdRegistros.Col = 4 'Cta Deposito
              tablas3("saldo_esp") = grdRegistros.Text
            
              grdRegistros.Col = 5 'Cheque
              tablas3("saldo_mes") = grdRegistros.Text
            
              grdRegistros.Col = 6 'valor
              tablas3("diferencia") = grdRegistros.Text
              
              grdRegistros.Col = 7 'estado
              tablas3("estado") = grdRegistros.Text
                    
              tablas3.Update
           Next i
           tablas3.Close

           VTMsg = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
           VTR = MsgBox(VTMsg, 36, "Control de impresión de Datos.")

           If VTR = IDYES Then
           
                If VTPlanPago = "S" Then
                   reportes = VGPath & "\PLANPAGAHO.RPT"
                Else
                   reportes = VGPath & "\EXTAHOCONT.RPT"
                End If
                rptReporte.ReportFileName = reportes
                rptReporte.DataFiles(0) = archivos
                rptReporte.Destination = 0
                rptReporte.Action = 0
           End If
           
           Screen.MousePointer = 0
           BaseDatos.Close
       Else
           MsgBox "No se genera impresion", vbInformation, "Control de Información"
           Screen.MousePointer = 0
       End If

 Exit Sub

ErrorImp:
    MsgBox "Error en la Impresión del Reporte " + Err.Description, 0 + 16, "Mensaje de Error"
    Screen.MousePointer = 0
    Exit Sub

End Sub
Private Sub txtPlazo_LostFocus()
If Val(mskMonto.Text) <> "0.00" Then
   MskValor(1).Text = CCur(mskMonto.Text) * txtPlazo.Text
End If
End Sub

 

