VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form Ftran220 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta Monetaria a la Cuenta de Ahorros"
   ClientHeight    =   6000
   ClientLeft      =   1530
   ClientTop       =   2175
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
   HelpContextID   =   1050
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6000
   ScaleWidth      =   9510
   Tag             =   "3021"
   Begin VB.Frame FrmTarjetaDeb 
      Height          =   495
      Left            =   6210
      TabIndex        =   130
      Top             =   1530
      Width           =   1575
      Begin VB.OptionButton optTarjetaDebito 
         Caption         =   "Si"
         Enabled         =   0   'False
         Height          =   255
         Index           =   0
         Left            =   75
         TabIndex        =   132
         Top             =   135
         Width           =   615
      End
      Begin VB.OptionButton optTarjetaDebito 
         Caption         =   "No"
         Enabled         =   0   'False
         Height          =   255
         Index           =   1
         Left            =   780
         TabIndex        =   131
         Top             =   150
         Width           =   615
      End
   End
   Begin Threed.SSFrame frmhistdeb 
      Height          =   1968
      Left            =   6204
      TabIndex        =   92
      Top             =   2160
      Visible         =   0   'False
      WhatsThisHelpID =   5365
      Width           =   2256
      _Version        =   65536
      _ExtentX        =   3979
      _ExtentY        =   3471
      _StockProps     =   14
      Caption         =   "*HISTORICO DE DEBITOS"
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   14
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "6."
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
         Index           =   52
         Left            =   75
         TabIndex        =   117
         Top             =   1470
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "5."
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
         Index           =   51
         Left            =   75
         TabIndex        =   116
         Top             =   1230
         Width           =   135
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "4."
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
         Index           =   50
         Left            =   75
         TabIndex        =   115
         Top             =   990
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "3."
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
         Index           =   49
         Left            =   75
         TabIndex        =   114
         Top             =   750
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "2."
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
         Index           =   48
         Left            =   75
         TabIndex        =   113
         Top             =   510
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "1."
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
         Index           =   47
         Left            =   80
         TabIndex        =   112
         Top             =   265
         Width           =   120
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   225
         Index           =   45
         Left            =   320
         TabIndex        =   99
         Top             =   510
         Width           =   1905
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   225
         Index           =   46
         Left            =   320
         TabIndex        =   98
         Top             =   755
         Width           =   1905
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   225
         Index           =   47
         Left            =   320
         TabIndex        =   97
         Top             =   990
         Width           =   1905
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   225
         Index           =   48
         Left            =   320
         TabIndex        =   96
         Top             =   1235
         Width           =   1905
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   225
         Index           =   49
         Left            =   320
         TabIndex        =   95
         Top             =   1470
         Width           =   1905
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   225
         Index           =   44
         Left            =   320
         TabIndex        =   94
         Top             =   265
         Width           =   1905
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8595
      TabIndex        =   66
      Top             =   0
      WhatsThisHelpID =   2027
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Firma"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8595
      TabIndex        =   31
      Tag             =   "6335"
      Top             =   760
      WhatsThisHelpID =   2009
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8595
      TabIndex        =   4
      Top             =   5190
      WhatsThisHelpID =   2008
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8595
      TabIndex        =   3
      Top             =   4425
      WhatsThisHelpID =   2003
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8595
      TabIndex        =   2
      Top             =   2895
      WhatsThisHelpID =   2007
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
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
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   1
      Top             =   90
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSFrame frmhistcre 
      Height          =   1965
      Left            =   6210
      TabIndex        =   93
      Top             =   2160
      Visible         =   0   'False
      Width           =   2250
      _Version        =   65536
      _ExtentX        =   3969
      _ExtentY        =   3466
      _StockProps     =   14
      Caption         =   "HISTORICO DE CREDITOS"
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MousePointer    =   14
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "2."
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
         Index           =   46
         Left            =   75
         TabIndex        =   111
         Top             =   510
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "3."
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
         Index           =   45
         Left            =   75
         TabIndex        =   110
         Top             =   750
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "4."
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
         Index           =   44
         Left            =   75
         TabIndex        =   109
         Top             =   990
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "5."
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
         Index           =   43
         Left            =   75
         TabIndex        =   108
         Top             =   1230
         Width           =   135
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "6."
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
         Index           =   42
         Left            =   75
         TabIndex        =   107
         Top             =   1470
         Width           =   150
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "1."
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
         Index           =   41
         Left            =   80
         TabIndex        =   106
         Top             =   265
         Width           =   120
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
         Index           =   50
         Left            =   320
         TabIndex        =   105
         Top             =   265
         Width           =   1905
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
         Index           =   51
         Left            =   320
         TabIndex        =   104
         Top             =   510
         Width           =   1905
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
         Index           =   52
         Left            =   320
         TabIndex        =   103
         Top             =   755
         Width           =   1905
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
         Index           =   53
         Left            =   320
         TabIndex        =   102
         Top             =   990
         Width           =   1905
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
         Index           =   54
         Left            =   320
         TabIndex        =   101
         Top             =   1235
         Width           =   1905
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
         Index           =   55
         Left            =   320
         TabIndex        =   100
         Top             =   1470
         Width           =   1905
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8595
      TabIndex        =   129
      Top             =   3660
      WhatsThisHelpID =   2044
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
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
      Caption         =   "Tarj. Deb.:"
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
      Left            =   5460
      TabIndex        =   133
      Top             =   1650
      WhatsThisHelpID =   5471
      Width           =   1335
   End
   Begin VB.Label lbldesalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   407
      Left            =   3435
      TabIndex        =   134
      Top             =   5560
      Width           =   4935
   End
   Begin VB.Label Lblalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   1770
      TabIndex        =   135
      Top             =   5560
      Width           =   1650
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "ALIANZA COMERCIAL:"
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
      Height          =   270
      Left            =   0
      TabIndex        =   136
      Top             =   5650
      Width           =   2040
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   61
      Left            =   1185
      TabIndex        =   128
      Top             =   2030
      Width           =   1935
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
      Height          =   144
      Index           =   57
      Left            =   0
      TabIndex        =   127
      Top             =   2040
      WhatsThisHelpID =   5233
      Width           =   912
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   60
      Left            =   1710
      TabIndex        =   126
      Top             =   2310
      Width           =   3615
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*PATENTE COMERCIAL:"
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
      Height          =   180
      Index           =   71
      Left            =   0
      TabIndex        =   125
      Top             =   2280
      WhatsThisHelpID =   5163
      Width           =   1815
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   35
      Left            =   1770
      TabIndex        =   71
      Top             =   4590
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Mes:"
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
      Height          =   144
      Index           =   37
      Left            =   48
      TabIndex        =   70
      Top             =   4596
      WhatsThisHelpID =   5307
      Width           =   384
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   59
      Left            =   1770
      TabIndex        =   124
      Top             =   3870
      Visible         =   0   'False
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Chq Ext. Ayer:"
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
      Height          =   144
      Index           =   56
      Left            =   48
      TabIndex        =   123
      Top             =   3876
      Visible         =   0   'False
      WhatsThisHelpID =   5217
      Width           =   1008
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*T. Cuota:"
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
      Height          =   144
      Index           =   55
      Left            =   5460
      TabIndex        =   122
      Top             =   1548
      WhatsThisHelpID =   5316
      Width           =   684
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   468
      Index           =   58
      Left            =   6720
      TabIndex        =   121
      Top             =   1536
      Width           =   1740
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   57
      Left            =   6204
      TabIndex        =   120
      Top             =   1536
      Width           =   516
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Mant. Valor:"
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
      Index           =   54
      Left            =   3480
      TabIndex        =   119
      Top             =   4830
      WhatsThisHelpID =   5146
      Width           =   870
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   56
      Left            =   4545
      TabIndex        =   118
      Top             =   4830
      Width           =   1650
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   43
      Left            =   6564
      TabIndex        =   91
      Top             =   5076
      Visible         =   0   'False
      Width           =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*MONTO BLOQUEADO:"
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
      Height          =   156
      Index           =   40
      Left            =   6276
      TabIndex        =   90
      Top             =   4920
      Visible         =   0   'False
      WhatsThisHelpID =   5138
      Width           =   1608
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   288
      Index           =   42
      Left            =   4164
      TabIndex        =   89
      Top             =   96
      Visible         =   0   'False
      Width           =   4332
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Interés Mes:"
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
      Index           =   39
      Left            =   3480
      TabIndex        =   88
      Top             =   4350
      WhatsThisHelpID =   5037
      Width           =   870
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   41
      Left            =   4545
      TabIndex        =   87
      Top             =   4350
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ult. Interés:"
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
      Index           =   36
      Left            =   3480
      TabIndex        =   86
      Top             =   4110
      Visible         =   0   'False
      WhatsThisHelpID =   5317
      Width           =   840
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   39
      Left            =   4545
      TabIndex        =   85
      Top             =   4110
      Visible         =   0   'False
      Width           =   1650
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   38
      Left            =   1185
      TabIndex        =   84
      Top             =   1790
      Width           =   510
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Prod. Banc.:"
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
      Height          =   144
      Index           =   35
      Left            =   36
      TabIndex        =   83
      Top             =   1788
      WhatsThisHelpID =   5301
      Width           =   912
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   37
      Left            =   1710
      TabIndex        =   82
      Top             =   1790
      Width           =   3615
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   36
      Left            =   4545
      TabIndex        =   81
      Top             =   3870
      Visible         =   0   'False
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tasa Interés:"
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
      Index           =   53
      Left            =   3480
      TabIndex        =   80
      Top             =   3870
      Visible         =   0   'False
      WhatsThisHelpID =   5147
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*MONTO EMBARGADO:"
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
      Height          =   156
      Index           =   33
      Left            =   6276
      TabIndex        =   79
      Top             =   4548
      WhatsThisHelpID =   5315
      Width           =   1668
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   14
      Left            =   6564
      TabIndex        =   78
      Top             =   4704
      Width           =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*CREDITOS:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   165
      Index           =   22
      Left            =   15
      MousePointer    =   14  'Arrow and Question
      TabIndex        =   8
      Top             =   4845
      WhatsThisHelpID =   5305
      Width           =   960
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   32
      Left            =   1770
      TabIndex        =   9
      Top             =   5070
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Hoy:"
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
      Height          =   144
      Index           =   26
      Left            =   48
      TabIndex        =   10
      Top             =   5076
      WhatsThisHelpID =   5306
      Width           =   372
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   33
      Left            =   1770
      TabIndex        =   75
      Top             =   5310
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Mes:"
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
      Height          =   144
      Index           =   29
      Left            =   48
      TabIndex        =   74
      Top             =   5316
      WhatsThisHelpID =   5307
      Width           =   384
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   34
      Left            =   1770
      TabIndex        =   73
      Top             =   4350
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Hoy:"
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
      Height          =   144
      Index           =   30
      Left            =   48
      TabIndex        =   72
      Top             =   4356
      WhatsThisHelpID =   5306
      Width           =   372
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*DEBITOS:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   165
      Index           =   38
      Left            =   15
      MousePointer    =   14  'Arrow and Question
      TabIndex        =   69
      Top             =   4140
      WhatsThisHelpID =   5313
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Prom. Disp.:"
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
      Index           =   20
      Left            =   3480
      TabIndex        =   68
      Top             =   3150
      WhatsThisHelpID =   5310
      Width           =   870
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   31
      Left            =   4545
      TabIndex        =   67
      Top             =   3150
      Width           =   1650
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
      Index           =   40
      Left            =   6450
      TabIndex        =   33
      Top             =   3870
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "P:"
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
      Height          =   165
      Index           =   19
      Left            =   6210
      TabIndex        =   34
      Top             =   3870
      Width           =   180
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   12
      Left            =   1710
      TabIndex        =   11
      Top             =   1540
      Width           =   3615
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Capitalización:"
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
      Height          =   144
      Index           =   25
      Left            =   36
      TabIndex        =   12
      Top             =   1548
      WhatsThisHelpID =   5300
      Width           =   1068
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   11
      Left            =   1185
      TabIndex        =   13
      Top             =   1540
      Width           =   510
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   10
      Left            =   6720
      TabIndex        =   14
      Top             =   1296
      Width           =   1740
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   8
      Left            =   1710
      TabIndex        =   15
      Top             =   820
      Width           =   3615
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficial cta.:"
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
      Height          =   144
      Index           =   28
      Left            =   36
      TabIndex        =   16
      Top             =   828
      WhatsThisHelpID =   5298
      Width           =   852
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   7
      Left            =   1185
      TabIndex        =   17
      Top             =   820
      Width           =   510
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   6
      Left            =   1710
      TabIndex        =   18
      Top             =   1300
      Width           =   3615
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
      Height          =   144
      Index           =   27
      Left            =   36
      TabIndex        =   19
      Top             =   1308
      WhatsThisHelpID =   5130
      Width           =   780
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   5
      Left            =   1185
      TabIndex        =   20
      Top             =   1300
      Width           =   510
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   4
      Left            =   6720
      TabIndex        =   21
      Top             =   1056
      Width           =   1740
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
      Height          =   144
      Index           =   9
      Left            =   5460
      TabIndex        =   22
      Top             =   1068
      WhatsThisHelpID =   5067
      Width           =   576
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   3
      Left            =   6204
      TabIndex        =   23
      Top             =   1056
      Width           =   516
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   2
      Left            =   1710
      TabIndex        =   24
      Top             =   1060
      Width           =   3615
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
      Height          =   144
      Index           =   7
      Left            =   36
      TabIndex        =   25
      Top             =   1068
      WhatsThisHelpID =   5209
      Width           =   648
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   1
      Left            =   1185
      TabIndex        =   26
      Top             =   1060
      Width           =   510
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Chq Exterior:"
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
      Height          =   144
      Index           =   5
      Left            =   48
      TabIndex        =   27
      Top             =   2916
      WhatsThisHelpID =   5081
      Width           =   924
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   29
      Left            =   6564
      TabIndex        =   0
      Top             =   4296
      Width           =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*MONTOS BLOQUEADOS:"
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
      Height          =   156
      Index           =   24
      Left            =   6276
      TabIndex        =   28
      Top             =   4152
      WhatsThisHelpID =   5138
      Width           =   1788
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   22
      Left            =   4545
      TabIndex        =   29
      Top             =   4590
      Visible         =   0   'False
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Int. Periodo:"
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
      Left            =   3480
      TabIndex        =   30
      Top             =   4590
      Visible         =   0   'False
      WhatsThisHelpID =   5318
      Width           =   885
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   30
      Left            =   6720
      TabIndex        =   32
      Top             =   816
      Width           =   1740
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ultimo Mov:"
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
      Height          =   144
      Index           =   18
      Left            =   5460
      TabIndex        =   36
      Top             =   828
      WhatsThisHelpID =   5302
      Width           =   828
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
      Index           =   28
      Left            =   6450
      TabIndex        =   37
      Top             =   3630
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "6:"
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
      Height          =   165
      Index           =   17
      Left            =   6210
      TabIndex        =   38
      Top             =   3630
      Width           =   150
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
      Index           =   27
      Left            =   6450
      TabIndex        =   39
      Top             =   3390
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "5:"
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
      Height          =   165
      Index           =   16
      Left            =   6210
      TabIndex        =   40
      Top             =   3390
      Width           =   150
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
      Index           =   26
      Left            =   6450
      TabIndex        =   41
      Top             =   3150
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "4:"
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
      Height          =   165
      Index           =   15
      Left            =   6210
      TabIndex        =   42
      Top             =   3150
      Width           =   150
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
      Index           =   25
      Left            =   6450
      TabIndex        =   43
      Top             =   2910
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "3:"
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
      Height          =   165
      Index           =   14
      Left            =   6210
      TabIndex        =   44
      Top             =   2895
      Width           =   150
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
      Index           =   24
      Left            =   6450
      TabIndex        =   45
      Top             =   2670
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "2:"
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
      Height          =   165
      Index           =   13
      Left            =   6210
      TabIndex        =   46
      Top             =   2670
      Width           =   150
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
      Index           =   23
      Left            =   6450
      TabIndex        =   47
      Top             =   2430
      Width           =   1905
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "1:"
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
      Height          =   165
      Index           =   12
      Left            =   6210
      TabIndex        =   48
      Top             =   2430
      Width           =   120
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   228
      Index           =   9
      Left            =   6204
      TabIndex        =   49
      Top             =   1296
      Width           =   516
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*T. Prom:"
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
      Height          =   144
      Index           =   11
      Left            =   5460
      TabIndex        =   50
      Top             =   1308
      WhatsThisHelpID =   5303
      Width           =   624
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Disp. A Girar:"
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
      Left            =   3480
      TabIndex        =   51
      Top             =   3630
      WhatsThisHelpID =   5311
      Width           =   945
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   20
      Left            =   4545
      TabIndex        =   52
      Top             =   3390
      Width           =   1650
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   19
      Left            =   4545
      TabIndex        =   53
      Top             =   2910
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Chq exterior hoy:"
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
      Height          =   144
      Index           =   8
      Left            =   48
      TabIndex        =   54
      Top             =   3156
      WhatsThisHelpID =   5082
      Width           =   1200
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   18
      Left            =   1770
      TabIndex        =   55
      Top             =   3630
      Width           =   1650
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   17
      Left            =   1770
      TabIndex        =   56
      Top             =   3390
      Width           =   1650
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   16
      Left            =   1770
      TabIndex        =   57
      Top             =   3150
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Libera prox. dia:"
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
      Height          =   144
      Index           =   4
      Left            =   48
      TabIndex        =   58
      Top             =   3396
      WhatsThisHelpID =   5021
      Width           =   1152
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   15
      Left            =   1770
      TabIndex        =   59
      Top             =   2910
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*A Liberar Hoy:"
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
      Height          =   144
      Index           =   3
      Left            =   48
      TabIndex        =   60
      Top             =   3636
      WhatsThisHelpID =   5080
      Width           =   1008
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Disponible:"
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
      Index           =   2
      Left            =   3480
      TabIndex        =   61
      Top             =   2910
      WhatsThisHelpID =   5309
      Width           =   810
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   225
      Index           =   21
      Left            =   4545
      TabIndex        =   62
      Top             =   3630
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Sld Contable:"
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
      Left            =   3480
      TabIndex        =   63
      Top             =   3390
      WhatsThisHelpID =   5162
      Width           =   975
   End
   Begin VB.Label lblEtiqueta 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*RESERVAS"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   165
      Index           =   31
      Left            =   15
      TabIndex        =   35
      Top             =   2640
      WhatsThisHelpID =   5145
      Width           =   975
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "PROMEDIOS"
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
      Height          =   165
      Index           =   32
      Left            =   6200
      TabIndex        =   65
      Top             =   2160
      Width           =   1020
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*SALDOS"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   165
      Index           =   34
      Left            =   3525
      TabIndex        =   64
      Top             =   2640
      WhatsThisHelpID =   5308
      Width           =   735
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8550
      Y1              =   795
      Y2              =   795
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   7
      Top             =   390
      UseMnemonic     =   0   'False
      Width           =   6550
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta ahorro:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   6
      Top             =   90
      WhatsThisHelpID =   5254
      Width           =   1965
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
      TabIndex        =   5
      Top             =   390
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   225
      Index           =   13
      Left            =   1770
      TabIndex        =   77
      Top             =   4590
      Visible         =   0   'False
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*IDB Mes:"
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
      Height          =   144
      Index           =   21
      Left            =   48
      TabIndex        =   76
      Top             =   4596
      Visible         =   0   'False
      WhatsThisHelpID =   5314
      Width           =   648
   End
End
Attribute VB_Name = "Ftran220"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran220.frm
' NOMBRE LOGICO:    FTran220
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
' Permite realizar la consulta monetaria a la cuenta de ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 28-Feb-05      L. Bernuil      Mapeo Valores en Suspenso
'*************************************************************
Dim VLTipoEnte As String
'Req. 371 Tarjeta Debito
Dim VLTarjeta As String
Dim VLPaso As Boolean
Private Sub cmdBoton_Click(Index As Integer)
    Dim VTR As Integer
    Dim VLContractual As String
    Dim VTR1 As Integer
    Dim i As Integer
    Dim VTPromedio As Integer
    Dim VTEmbargada As String
    
    Select Case Index%
    Case 0  'Transmitir
        If mskCuenta.ClipText <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "220"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
             If VGCodPais = "CO" Then
                VTR% = MsgBox("¿Esta transacción es solicitada por el cliente?", vbYesNo, "Mensaje del Sistema")
                If VTR% = vbYes Then
                    PMPasoValores sqlconn&, "@i_escliente", 0, SQLCHAR, "S"
                Else
                    PMPasoValores sqlconn&, "@i_escliente", 0, SQLCHAR, "N"
                End If
             End If
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_con_ahr_mon", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(1), lblDescripcion(2)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(3), lblDescripcion(4)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(5), lblDescripcion(6)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(7), lblDescripcion(8)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(9), lblDescripcion(10)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(11), lblDescripcion(12)
                 PMMapeaObjetoAB sqlconn&, lblDescripcion(38), lblDescripcion(37)
                 PMMapeaVariable sqlconn&, VLContractual$
                 PMMapeaVariable sqlconn&, VLTipoEnte
                 If VGCodPais <> "CO" Then
                     PMMapeaObjetoAB sqlconn&, lblDescripcion(57), lblDescripcion(58)  'T. Cuota
                 End If
                'ReDim VTArreglo(40) As String
                 ReDim VTArreglo(46) As String 'VTArreglo(41) As String
                 VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                 PMChequea sqlconn&
                For i% = 1 To 16
                    lblDescripcion(i% + 14).Caption = VTArreglo(i%)
                Next i%
                VTPromedio = 0
                For i% = 23 To 28
                    VTPromedio = VTPromedio + CCur(lblDescripcion(i%).Caption)
                Next i%
                lblDescripcion(13).Caption = VTArreglo(22)
                lblDescripcion(14).Caption = VTArreglo(28)
                lblDescripcion(40).Caption = Format$(VTPromedio / 6, "#,##0.00")
                lblDescripcion(31).Caption = VTArreglo(17)
                lblDescripcion(32).Caption = VTArreglo(18)
                lblDescripcion(33).Caption = VTArreglo(19)
                lblDescripcion(34).Caption = VTArreglo(20)
                lblDescripcion(35).Caption = VTArreglo(21)
                lblDescripcion(36).Caption = VTArreglo(25)
                lblDescripcion(39).Caption = VTArreglo(26)
                lblDescripcion(41).Caption = VTArreglo(8) ' Saldo Interes
                lblDescripcion(43).Caption = VTArreglo(28)
                lblDescripcion(59).Caption = VTArreglo(30)
                
                lblDescripcion(60).Caption = VTArreglo(42)
                lblDescripcion(61).Caption = VTArreglo(43)
                Lblalianza.Caption = VTArreglo(44)
                lbldesalianza.Caption = VTArreglo(45)
                
                VTEmbargada$ = VTArreglo(29)
                lblDescripcion(44).Caption = VTArreglo(21)
                For i% = 30 To 34
                    lblDescripcion(i% + 15).Caption = VTArreglo(i%)
                Next i%
                lblDescripcion(50).Caption = VTArreglo(19)
                For i% = 35 To 39
                    lblDescripcion(i% + 16).Caption = VTArreglo(i%)
                Next i%
                'lblDescripcion(56).Caption = VTArreglo(40) 'Saldo Mant. Valor
                lblDescripcion(56).Caption = VTArreglo(40) 'Saldo en Suspenso
                cmdBoton(3).Enabled = True
                mskCuenta.Enabled = False
                If VTEmbargada$ <> "N" Then
                    lblDescripcion(42).Visible = True
                    lblDescripcion(42).Caption = "CTA. CON EMBARGO"
                Else
                    lblDescripcion(42).Visible = False
                    lblDescripcion(42).Caption = ""
                End If
                If VLContractual$ = "S" Then
                   cmdBoton(6).Enabled = True
                End If
                cmdBoton(0).Enabled = False

            End If
        Else
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
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
    Case 1  'Limpiar
        'mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        For i% = 1 To 61 '59
            lblDescripcion(i%).Caption = ""
        Next i%
        lblDescripcion(42).Visible = False
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        'mskCuenta.Enabled = True
        'mskCuenta.SetFocus
        frmhistdeb.Visible = False
        frmhistcre.Visible = False
        Lblalianza.Caption = ""
        lbldesalianza.Caption = ""
    Case 2  'Salir
        Unload Ftran220
    Case 3
        ' Impresion de los saldos de la cuenta
        PLImprimir
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
    Case 6
        PLBuscar_marca
    End Select
End Sub

Private Sub Form_Load()
    Ftran220.Left = 0
    Ftran220.Top = 0
    Ftran220.Width = 9600
    Ftran220.Height = 6510
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte$
    If VGCodPais = "CO" Then
        lblEtiqueta(55).Visible = False
        lblDescripcion(57).Visible = False
        lblDescripcion(58).Visible = False
        lblEtiqueta(57).Visible = False
        lblDescripcion(61).Visible = False
        lblEtiqueta(71).Visible = False
        lblDescripcion(60).Visible = False
    End If
    
End Sub
Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub
Private Sub frmhistcre_Click()
    frmhistcre.Visible = False
End Sub
Private Sub frmhistdeb_Click()
    frmhistdeb.Visible = False
End Sub
Private Sub lblEtiqueta_Click(Index As Integer)
Select Case Index
    Case 22
        If frmhistdeb.Visible = True Then
            frmhistdeb.Visible = False
        End If
        frmhistcre.Visible = True
    Case 38
        If frmhistcre.Visible = True Then
            frmhistcre.Visible = False
        End If
        frmhistdeb.Visible = True
End Select
End Sub

Private Sub lblEtiqueta_MouseMove(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
Select Case Index
    Case 22
        lblEtiqueta(22).ToolTipText = "Histórico de Débitos"
        FPrincipal!pnlHelpLine.Caption = "Consulta de Histórico de Débitos"
    Case 38
        lblEtiqueta(38).ToolTipText = "Histórico de Créditos"
        FPrincipal!pnlHelpLine.Caption = "Consulta de Histórico de Créditos"
End Select

End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Ftran220 - VSS 4-Número de la cuenta de ahorros "
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
        VLPaso = True
        ReDim VGADatosO(1) As String
        FHelpCta.Show 1
        If Trim$(VGADatosO(0)) <> "" Then
           mskCuenta.Text = VGADatosO(0)
        End If
        VLPaso = True
    End If
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
'*************************************************************
' PROPOSITO: Imprime un reporte con los datos de la consulta
'            monetaria de la cuenta.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLDiferido As Currency
Dim VLProdbanc As String

    If MsgBox("¿Está seguro de imprimir los saldos de la cuenta?", 1 + 32 + 0, "Mensaje del Sistema") = 1 Then
        Screen.MousePointer = 11
        'FMCabeceraReporte VGBanco$, Date, "CONSULTA DE SALDOS",
        FMCabeceraReporte VGBanco$, Date, "CONSULTA DE SALDOS Y PROMEDIOS DE CUENTA DE AHORROS", _
                          Time(), Me.Caption, VGFecha$, 1 'Printer.Page
        
        Printer.FontSize = 8
        Printer.Print Tab(4); "No de Cuenta                 : "; mskCuenta.Text
        Printer.Print ""
        Printer.Print Tab(4); "Fecha de proceso             : "; VGFecha$
        Printer.Print ""
        Printer.Print Tab(4); "Nombre y Apellido del Titular: "; lblDescripcion(0).Caption
        Printer.Print ""
        VLProdbanc = lblDescripcion(38).Caption + " - " + lblDescripcion(37).Caption
        Printer.Print Tab(4); "Producto Bancario            : "; VLProdbanc
        Printer.Print ""
        Printer.Print Tab(4); "Saldo disponible             : "; lblDescripcion(19).Caption
        Printer.Print ""
        Printer.Print Tab(4); "Saldo Contable               : "; lblDescripcion(20).Caption
        Printer.Print ""
        Printer.Print Tab(4); "Saldo disponible para girar  : "; lblDescripcion(21).Caption
        Printer.Print ""
        
        VLDiferido = CCur(lblDescripcion(18).Caption) + CCur(lblDescripcion(17).Caption) + CCur(lblDescripcion(15).Caption)

        'Printer.Print Tab(4); "Saldo diferido               : "; Format$(VLDiferido, "#,##0.00")
        Printer.Print Tab(4); "Saldo en canje               : "; Format$(VLDiferido, "#,##0.00")
        Printer.Print ""
        Printer.Print Tab(4); "Monto Bloqueado              : "; Format$(lblDescripcion(29).Caption, "#,##0.00")
        Printer.Print ""
        'Printer.Print Tab(4); "Monto Consumos               : "; Format$(lblDescripcion(14).Caption, "#,##0.00")
        Printer.Print Tab(4); "Monto Embargado / Secuestrado: "; Format$(lblDescripcion(14).Caption, "#,##0.00")
        Printer.Print ""
        
        If VGCodPais$ <> "CO" Then
            Printer.Print Tab(4); "Patente Comercial              : "; lblDescripcion(60).Caption
            Printer.Print ""
            Printer.Print Tab(4); "Fideicomiso                    : "; lblDescripcion(61).Caption
            Printer.Print ""
        End If
        
        Printer.Print String$(124, "_")
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "_________________"
        Printer.Print "  PROCESADO POR  "
        
        Printer.EndDoc
        Screen.MousePointer = 0
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
Dim VLParametro(15, 2) As String
Dim VTCambiaCategoria As String
Dim VTContractual As String
Dim VTR1 As Integer
Dim VLProdfinal As String
Dim VLParametriza As String

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHCT"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(6, 1) = lblDescripcion(38).Caption Then
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
    If VLParametro(6, 1) = lblDescripcion(38).Caption Then
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
    If VLParametro(3, 1) = lblDescripcion(5).Caption Then
        VTCambiaCategoria = "S"
    Else
        VTCambiaCategoria = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 734
PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, lblDescripcion(5).Caption
PMPasoValores sqlconn&, "@i_prodban", 0, SQLVARCHAR, lblDescripcion(38).Caption
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
PMPasoValores sqlconn&, "@i_tipoente", 0, SQLCHAR, VLTipoEnte

If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mto_aho_contractual", True, "Ok... Consulta Marca Contractual") Then
   PMMapeaVariable sqlconn&, VTContractual$
   PMMapeaVariable sqlconn&, VLProdfinal$
   PMMapeaVariable sqlconn&, VLParametriza$
   PMChequea sqlconn&
   
   If VGContractual$ = "S" Or VGProgresivo$ = "S" Then
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


