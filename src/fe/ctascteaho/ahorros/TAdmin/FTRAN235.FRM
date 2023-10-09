VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran235 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta no Monetaria a la Cuenta de Ahorros"
   ClientHeight    =   6120
   ClientLeft      =   120
   ClientTop       =   1350
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
   HelpContextID   =   1052
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6120
   ScaleWidth      =   9510
   Tag             =   "3866"
   Begin VB.Frame FrmTarjetaDeb 
      Height          =   495
      Left            =   6675
      TabIndex        =   77
      Top             =   3120
      Width           =   1575
      Begin VB.OptionButton optTarjetaDebito 
         Caption         =   "No"
         Enabled         =   0   'False
         Height          =   255
         Index           =   1
         Left            =   780
         TabIndex        =   79
         Top             =   150
         Width           =   615
      End
      Begin VB.OptionButton optTarjetaDebito 
         Caption         =   "Si"
         Enabled         =   0   'False
         Height          =   255
         Index           =   0
         Left            =   75
         TabIndex        =   78
         Top             =   135
         Width           =   615
      End
   End
   Begin MSGrid.Grid grdBloqueos 
      Height          =   696
      Left            =   1488
      TabIndex        =   62
      Top             =   5040
      Width           =   7020
      _Version        =   65536
      _ExtentX        =   12382
      _ExtentY        =   1228
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   0
      Top             =   30
      Width           =   2085
      _ExtentX        =   3678
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8600
      TabIndex        =   1
      Top             =   50
      WhatsThisHelpID =   2026
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "*&Propiet."
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
   Begin MSGrid.Grid grdPropietarios 
      Height          =   708
      Left            =   15
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   1008
      Width           =   8520
      _Version        =   65536
      _ExtentX        =   15028
      _ExtentY        =   1249
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8595
      TabIndex        =   3
      Top             =   2955
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "&Transmitir"
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
      TabIndex        =   4
      Top             =   4485
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
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
      TabIndex        =   5
      Top             =   5250
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Height          =   756
      Index           =   5
      Left            =   8600
      TabIndex        =   66
      Top             =   50
      Visible         =   0   'False
      WhatsThisHelpID =   2067
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "Bene&ficiarios"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   4
      Left            =   8600
      TabIndex        =   2
      Top             =   810
      WhatsThisHelpID =   2027
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
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
      Index           =   6
      Left            =   8595
      TabIndex        =   76
      Top             =   3720
      WhatsThisHelpID =   2044
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&te"
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
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   5400
      TabIndex        =   80
      Top             =   3285
      WhatsThisHelpID =   5470
      Width           =   1335
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Alianza:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   90
      TabIndex        =   81
      Top             =   5780
      Width           =   735
   End
   Begin VB.Label Lblalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   1500
      TabIndex        =   82
      Top             =   5745
      Width           =   690
   End
   Begin VB.Label lbldesalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   345
      Left            =   2220
      TabIndex        =   83
      Top             =   5745
      Width           =   6270
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   34
      Left            =   1485
      TabIndex        =   75
      Top             =   3360
      Width           =   2175
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fideicomiso:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   29
      Left            =   90
      TabIndex        =   74
      Top             =   3390
      WhatsThisHelpID =   5233
      Width           =   885
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   32
      Left            =   1485
      TabIndex        =   73
      Top             =   3840
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Personalizada:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   28
      Left            =   120
      TabIndex        =   72
      Top             =   3840
      WhatsThisHelpID =   5136
      Width           =   1065
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   33
      Left            =   3630
      TabIndex        =   71
      Top             =   2400
      Width           =   1740
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Num.Sol:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   31
      Left            =   2970
      TabIndex        =   70
      Top             =   2415
      WhatsThisHelpID =   5044
      Width           =   675
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Caption         =   "CTA. EMBARGADA"
      ForeColor       =   &H000000FF&
      Height          =   285
      Index           =   57
      Left            =   4560
      TabIndex        =   69
      Top             =   35
      Visible         =   0   'False
      Width           =   2040
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   30
      Left            =   6675
      TabIndex        =   68
      Top             =   3120
      Width           =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Num. Libreta:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   27
      Left            =   5370
      TabIndex        =   67
      Top             =   3165
      WhatsThisHelpID =   5169
      Width           =   975
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha cierre:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   21
      Left            =   5400
      TabIndex        =   65
      Top             =   2910
      WhatsThisHelpID =   5322
      Width           =   945
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
      Index           =   31
      Left            =   6675
      TabIndex        =   64
      Top             =   2880
      Width           =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*BLOQUEOS:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   150
      Index           =   26
      Left            =   45
      TabIndex        =   63
      Top             =   5025
      WhatsThisHelpID =   5330
      Width           =   900
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*SALDOS:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   150
      Index           =   20
      Left            =   2805
      TabIndex        =   7
      Top             =   4110
      WhatsThisHelpID =   5308
      Width           =   690
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*FECHAS:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   150
      Index           =   19
      Left            =   45
      TabIndex        =   58
      Top             =   4110
      WhatsThisHelpID =   5327
      Width           =   690
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*PERSONALIZACION:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   150
      Index           =   2
      Left            =   45
      TabIndex        =   61
      Top             =   3630
      WhatsThisHelpID =   5324
      Width           =   1485
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   1
      Left            =   1485
      TabIndex        =   47
      Top             =   1770
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Dirección  E. C."
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   1
      Left            =   90
      TabIndex        =   8
      Top             =   1800
      WhatsThisHelpID =   5034
      Width           =   1140
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
      Index           =   3
      Left            =   6675
      TabIndex        =   9
      Top             =   2640
      Width           =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha apertura:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   3
      Left            =   5400
      TabIndex        =   10
      Top             =   2655
      WhatsThisHelpID =   5321
      Width           =   1125
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
      Index           =   4
      Left            =   1485
      TabIndex        =   11
      Top             =   4545
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Próximo corte:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   4
      Left            =   90
      TabIndex        =   12
      Top             =   4545
      WhatsThisHelpID =   5329
      Width           =   1080
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
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
      Index           =   5
      Left            =   4095
      TabIndex        =   13
      Top             =   4785
      Width           =   1680
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ret. Remesas:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   5
      Left            =   2805
      TabIndex        =   17
      Top             =   4785
      WhatsThisHelpID =   5135
      Width           =   1035
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
      Index           =   6
      Left            =   1485
      TabIndex        =   18
      Top             =   4785
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ultimo mov.:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   7
      Left            =   90
      TabIndex        =   19
      Top             =   4785
      WhatsThisHelpID =   5302
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
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
      Index           =   7
      Left            =   4095
      TabIndex        =   20
      Top             =   4545
      Width           =   1680
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ult. corte:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   8
      Left            =   2805
      TabIndex        =   21
      Top             =   4545
      WhatsThisHelpID =   5328
      Width           =   780
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   10
      Left            =   1485
      TabIndex        =   22
      Top             =   2160
      Width           =   1455
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cliente:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   9
      Left            =   90
      TabIndex        =   23
      Top             =   2175
      WhatsThisHelpID =   5252
      Width           =   600
   End
   Begin VB.Label lblDescripcion 
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
      Left            =   3630
      TabIndex        =   24
      Top             =   2160
      Width           =   1740
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Sucursal:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   10
      Left            =   2970
      TabIndex        =   25
      Top             =   2175
      WhatsThisHelpID =   5202
      Width           =   690
   End
   Begin VB.Label lblDescripcion 
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
      Left            =   6260
      TabIndex        =   26
      Top             =   2160
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Estado:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   12
      Left            =   5400
      TabIndex        =   27
      Top             =   2205
      WhatsThisHelpID =   5067
      Width           =   600
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   13
      Left            =   6675
      TabIndex        =   28
      Top             =   2160
      Width           =   1800
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   18
      Left            =   6260
      TabIndex        =   29
      Top             =   3360
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo deft."
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   13
      Left            =   5400
      TabIndex        =   30
      Top             =   3405
      Visible         =   0   'False
      WhatsThisHelpID =   5323
      Width           =   765
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   19
      Left            =   6675
      TabIndex        =   31
      Top             =   3360
      Visible         =   0   'False
      Width           =   1800
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   16
      Left            =   1485
      TabIndex        =   32
      Top             =   3120
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Promedio:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   14
      Left            =   90
      TabIndex        =   33
      Top             =   3165
      WhatsThisHelpID =   5320
      Width           =   765
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   17
      Left            =   1890
      TabIndex        =   34
      Top             =   3120
      Width           =   3480
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   20
      Left            =   1440
      TabIndex        =   35
      Top             =   3840
      Visible         =   0   'False
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Descrip. default:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   15
      Left            =   120
      TabIndex        =   36
      Top             =   3840
      Visible         =   0   'False
      WhatsThisHelpID =   5326
      Width           =   1215
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   21
      Left            =   2625
      TabIndex        =   37
      Top             =   3840
      Visible         =   0   'False
      Width           =   5730
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   24
      Left            =   1485
      TabIndex        =   38
      Top             =   2400
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Moneda:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   16
      Left            =   90
      TabIndex        =   39
      Top             =   2415
      WhatsThisHelpID =   5209
      Width           =   660
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   25
      Left            =   1890
      TabIndex        =   40
      Top             =   2400
      Width           =   1035
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   26
      Left            =   1485
      TabIndex        =   41
      Top             =   2640
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficial:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   17
      Left            =   90
      TabIndex        =   42
      Top             =   2685
      WhatsThisHelpID =   5319
      Width           =   570
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   27
      Left            =   1890
      TabIndex        =   43
      Top             =   2640
      Width           =   3480
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   28
      Left            =   6260
      TabIndex        =   44
      Top             =   2400
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ciclo:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   18
      Left            =   5400
      TabIndex        =   45
      Top             =   2415
      WhatsThisHelpID =   5261
      Width           =   480
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   29
      Left            =   6675
      TabIndex        =   46
      Top             =   2400
      Width           =   1800
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   14
      Left            =   1485
      TabIndex        =   53
      Top             =   2880
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Categoría:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   22
      Left            =   90
      TabIndex        =   54
      Top             =   2895
      WhatsThisHelpID =   5130
      Width           =   810
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   15
      Left            =   1890
      TabIndex        =   55
      Top             =   2880
      Width           =   3480
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   22
      Left            =   1485
      TabIndex        =   56
      Top             =   3840
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Rol del cliente:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   23
      Left            =   90
      TabIndex        =   48
      Top             =   3840
      Visible         =   0   'False
      WhatsThisHelpID =   5325
      Width           =   1110
   End
   Begin VB.Label lblDescripcion 
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
      Index           =   23
      Left            =   1770
      TabIndex        =   49
      Top             =   3840
      Visible         =   0   'False
      Width           =   3480
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*De ayer:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   24
      Left            =   2805
      TabIndex        =   50
      Top             =   4305
      WhatsThisHelpID =   5134
      Width           =   630
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
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
      Index           =   8
      Left            =   4095
      TabIndex        =   51
      Top             =   4305
      Width           =   1680
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ultimo corte:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   150
      Index           =   25
      Left            =   90
      TabIndex        =   52
      Top             =   4305
      WhatsThisHelpID =   5328
      Width           =   975
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
      Index           =   9
      Left            =   1485
      TabIndex        =   60
      Top             =   4305
      Width           =   1245
   End
   Begin VB.Label lblDescripcion 
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
      Height          =   372
      Index           =   2
      Left            =   1896
      TabIndex        =   59
      Top             =   1776
      Width           =   6576
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   30
      TabIndex        =   57
      Top             =   780
      WhatsThisHelpID =   5055
      Width           =   1155
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8550
      Y1              =   1740
      Y2              =   1740
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
      TabIndex        =   14
      Top             =   330
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta de ahorros:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   0
      Left            =   15
      TabIndex        =   15
      Top             =   30
      WhatsThisHelpID =   5016
      Width           =   2145
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8550
      Y1              =   765
      Y2              =   765
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8550
      X2              =   8550
      Y1              =   0
      Y2              =   6000
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   16
      Top             =   336
      UseMnemonic     =   0   'False
      Width           =   6550
   End
End
Attribute VB_Name = "FTran235"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran235.frm
' NOMBRE LOGICO:    FTran235
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
' Permite realizar la consulta no monetaria a una cuenta de
' ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLBeneficiarios As Boolean
Dim VLProdbanc As Integer
Dim VLTipoEnte As String
'Req. 371 Tarjeta Debito
Dim VLTarjeta As String

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTR1 As Integer
    Dim i As Integer
    Dim VTPersonalizada As String
    Dim VTEmbargada As String
    Dim VTContractual As String
    Dim VTalianza As String
    Dim VTdesalianza As String
    Dim j As Integer
    Select Case Index%
    Case 0 'Transmitir
        If mskCuenta.ClipText <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "235"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_cons_gral_ah", True, " Ok... Consulta de Ahorros " & "[" & mskCuenta.Text & "]") Then
                ReDim VTArreglo(20) As String
                 VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                For i% = 1 To 11
                    lblDescripcion(i%).Caption = VTArreglo(i%)
                Next i%
                   lblDescripcion(11).Caption = VTArreglo(12)
                   lblDescripcion(10).Caption = VTArreglo(13)
                   
                   lblDescripcion(33).Caption = VTArreglo(14) 'Numero de solicitud
                   lblDescripcion(34).Caption = VTArreglo(15)
                   VLProdbanc = VTArreglo(16)
                   VLTipoEnte = VTArreglo(17)
                   
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(12), lblDescripcion(13)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(14), lblDescripcion(15)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(16), lblDescripcion(17)
                ReDim VTArreglo(20) As String
                 VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                lblDescripcion(18).Caption = VTArreglo(1)
                lblDescripcion(19).Caption = VTArreglo(2)
                lblDescripcion(20).Caption = VTArreglo(3)
                lblDescripcion(21).Caption = VTArreglo(4)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(22), lblDescripcion(23)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(24), lblDescripcion(25)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(26), lblDescripcion(27)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(28), lblDescripcion(29)
                 PMMapeaObjeto sqlconn&, lblDescripcion(31)
                 PMMapeaGrid sqlconn&, grdBloqueos, False
                 
                 PMMapeaObjeto sqlconn&, lblDescripcion(30) 'Numero de Libreta
                 
                 'LBM220705 - Mapeo de la variable de Personalizacion
                 PMMapeaVariable sqlconn&, VTPersonalizada$
                 
                 'LBM220705 - Mapeo de la variable de Embargo
                 PMMapeaVariable sqlconn&, VTEmbargada$
                 
                 'Mapeo de la variable de Ahorro Contractual
                 PMMapeaVariable sqlconn&, VTContractual$
                 
                 PMMapeaVariable sqlconn&, VTalianza$
                 
                 PMMapeaVariable sqlconn&, VTdesalianza$
                 PMChequea sqlconn&
                If Trim$(lblDescripcion(22).Caption) = "1" Then
                    lblDescripcion(23).Caption = "PROPIETARIO"
                End If
                If Trim$(lblDescripcion(20).Caption) = "0" Then
                    lblDescripcion(20).Caption = ""
                End If
                
                lblDescripcion(32).Caption = VTPersonalizada$
                
                If VTEmbargada$ <> "N" Then
                    lblDescripcion(57).Visible = True
                    lblDescripcion(57).Caption = "CTA. CON EMBARGO"
                Else
                    lblDescripcion(57).Visible = False
                    lblDescripcion(57).Caption = ""
                End If
                If VTContractual$ = "S" Then
                   cmdBoton(6).Enabled = True
                End If
                                
                Lblalianza.Caption = VTalianza$
                                 
                lbldesalianza.Caption = VTdesalianza$
                cmdBoton(0).Enabled = False
            End If
        Else
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
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
        
    Case 1 'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        lblDescripcion(0).Caption = ""
        cmdBoton(3).Enabled = False
        For i% = 1 To 29
            lblDescripcion(i%).Caption = ""
        Next i%
        lblDescripcion(31).Caption = ""
        PMLimpiaGrid grdPropietarios
        'Limpiar Grid de Bloqueos
        grdBloqueos.Rows = 2
        grdBloqueos.Cols = 2
        For i% = 0 To 1
            grdBloqueos.Col = i%
            For j% = 0 To 1
                grdBloqueos.Row = j%
                grdBloqueos.Text = ""
            Next j%
        Next i%
        cmdBoton(5).Enabled = False 'Beneficiarios
        cmdBoton(6).Enabled = False 'Siguientes
        cmdBoton(0).Enabled = True  'Transmitir
        
        'Limpiar literatura de cta embargada
        lblDescripcion(57).Visible = False
        lblDescripcion(57).Caption = ""
                        
        lblDescripcion(30).Caption = ""
        
        lblDescripcion(32).Caption = "" 'Personalizada
        lblDescripcion(33).Caption = "" 'No. de Solicitud
        lblDescripcion(34).Caption = ""
        
        If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
                
        cmdBoton(4).Enabled = False
        
        Lblalianza.Caption = ""
        lbldesalianza.Caption = ""
    Case 2 'Salir
        Unload FTran235
    Case 3  'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "298"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"

         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
             'Valida si la cuenta pertenece a una persona natural
             grdPropietarios.Col = 5
             If grdPropietarios.Text = "T" Then
               grdPropietarios.Col = 6
              If grdPropietarios.Text = "P" Then
                  VLBeneficiarios = True
               End If
            End If
            If VLBeneficiarios Then
                    VLBeneficiarios = False
                    cmdBoton(5).Enabled = True 'Beneficiarios
            End If
        Else
            PMLimpiaGrid grdPropietarios
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
            If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
        End If

'    Case 5 'Beneficiarios
'        ReDim VGADatosI(3) As String
'        VGADatosI(0) = mskCuenta.ClipText
'        VGADatosI(1) = lblDescripcion(0).Caption
'        VGADatosI(2) = "4"
'        VGADatosI(3) = "consulta" 'Consulta de beneficiarios
'        FBenCta.Show 1
     Case 6
         PLBuscar_marca
    End Select
End Sub

Private Sub Form_Load()
    FTran235.Left = 0
    FTran235.Top = 0
    FTran235.Width = 9600
    FTran235.Height = 6630
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaAho$
    If VGCodPais$ = "CO" Then
        lblEtiqueta(29).Visible = False
        lblDescripcion(34).Visible = False
        lblEtiqueta(27).Visible = False
        lblDescripcion(30).Visible = False
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdPropietarios_Click()
    grdPropietarios.Col = 0
    grdPropietarios.SelStartCol = 1
    grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
    If grdPropietarios.Row = 0 Then
        grdPropietarios.SelStartRow = 1
        grdPropietarios.SelEndRow = 1
    Else
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
    End If
End Sub

Private Sub mskCuenta_GotFocus()
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
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                PMMapeaObjeto sqlconn&, lblDescripcion(0)
                PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
                cmdBoton(5).Enabled = False
                
                cmdBoton(4).Enabled = True
             Else
             
                cmdBoton(4).Enabled = False
                
                cmdBoton_Click (1)
                Exit Sub
             End If
        Else
             MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
             
             cmdBoton(4).Enabled = False
             
             cmdBoton_Click (1)
             Exit Sub
        End If
    End If
End Sub
Private Sub PLBuscar_marca()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Mar-2011   S. Molano        Emisión Inicial
'*************************************************************
' PARAMETRO AHORRO CONTRACTUAL
Dim VLParametro(15, 2) As String
Dim VTCambiaCategoria As String
Dim VTR1 As Integer
Dim VLMarca As String
Dim VLProdfinal As String
Dim VLParametriza As String
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHCT"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(6, 1) = VLProdbanc Then
        VGContractual$ = "S"
    Else
        VGContractual$ = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHPR"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(6, 1) = VLProdbanc Then
        VGProgresivo$ = "S"
    Else
        VGProgresivo$ = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "CAMCAT"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(3, 1) = lblDescripcion(14).Caption Then
        VTCambiaCategoria = "S"
    Else
        VTCambiaCategoria = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 734
PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, lblDescripcion(14).Caption
PMPasoValores sqlconn&, "@i_prodban", 0, SQLVARCHAR, VLProdbanc
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
PMPasoValores sqlconn&, "@i_tipoente", 0, SQLCHAR, VLTipoEnte

If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mto_aho_contractual", True, "Ok... Consulta Marca Contractual") Then
   PMMapeaVariable sqlconn&, VLMarca$
   PMMapeaVariable sqlconn&, VLProdfinal$
   PMMapeaVariable sqlconn&, VLParametriza$
   PMChequea sqlconn&
   
   If VLMarca$ = "S" Then
      If VLParametriza$ <> 0 Or VTCambiaCategoria = "S" Then
         VGcategoria = lblDescripcion(14).Caption
         VGprofinal = VLProdfinal$
         VGCuenta = mskCuenta.ClipText
         VGOrigen = "1"
         Ftran434.Show 1
      Else
        MsgBox "Categoria Sin Caracteristicas Especiales " + VLProdfinal$ + " y Categoria " + lblDescripcion(14).Caption + " ", 0 + 16, "Mensaje de Error"
      End If
   Else
     VGCancelar = "N"
   End If
   PMChequea sqlconn&
End If
End Sub

