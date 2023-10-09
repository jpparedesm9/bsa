VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran493 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenimiento de Transacciones a Contabilizar"
   ClientHeight    =   5355
   ClientLeft      =   120
   ClientTop       =   1740
   ClientWidth     =   9300
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
   HelpContextID   =   1134
   Icon            =   "FTRAN493.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5355
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   12
      Left            =   5160
      MaxLength       =   5
      TabIndex        =   12
      Top             =   2160
      Width           =   700
   End
   Begin MSGrid.Grid grdConta 
      Height          =   495
      Left            =   8460
      TabIndex        =   36
      Top             =   900
      Visible         =   0   'False
      Width           =   615
      _Version        =   65536
      _ExtentX        =   1085
      _ExtentY        =   873
      _StockProps     =   77
      ForeColor       =   4210752
      BackColor       =   16777215
   End
   Begin VB.ComboBox CmbContab 
      Height          =   288
      ItemData        =   "FTRAN493.frx":030A
      Left            =   6460
      List            =   "FTRAN493.frx":030C
      Style           =   2  'Dropdown List
      TabIndex        =   9
      Top             =   1550
      Width           =   1860
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   11
      Left            =   5160
      MaxLength       =   2
      TabIndex        =   11
      Top             =   1900
      Width           =   700
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   10
      Left            =   1440
      MaxLength       =   2
      TabIndex        =   10
      Top             =   1900
      Width           =   700
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   9
      Left            =   5000
      MaxLength       =   5
      TabIndex        =   5
      Top             =   1035
      Width           =   750
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   8
      Left            =   4224
      MaxLength       =   5
      TabIndex        =   8
      Top             =   1550
      Visible         =   0   'False
      Width           =   555
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   732
      Index           =   1
      Left            =   8424
      TabIndex        =   17
      Top             =   3744
      WhatsThisHelpID =   2003
      Width           =   852
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1296
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
      Picture         =   "FTRAN493.frx":030E
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   7
      Left            =   1440
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   700
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   6
      Left            =   1440
      MaxLength       =   5
      TabIndex        =   2
      Top             =   525
      Width           =   700
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   4
      Left            =   1440
      MaxLength       =   16
      TabIndex        =   7
      Top             =   1550
      Width           =   1584
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   2
      Left            =   1440
      MaxLength       =   2
      TabIndex        =   4
      Top             =   1035
      Width           =   700
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   1
      Left            =   1440
      MaxLength       =   5
      TabIndex        =   3
      Top             =   780
      Width           =   700
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2592
      Left            =   36
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   2736
      Width           =   8292
      _Version        =   65536
      _ExtentX        =   14626
      _ExtentY        =   4572
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   2
      Left            =   8418
      TabIndex        =   15
      Tag             =   "8001"
      Top             =   750
      WhatsThisHelpID =   2030
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Ingresar"
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
      Picture         =   "FTRAN493.frx":032A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   3
      Left            =   8418
      TabIndex        =   16
      Tag             =   "8002"
      Top             =   1500
      WhatsThisHelpID =   2031
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Modificar"
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
      Picture         =   "FTRAN493.frx":0346
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   0
      Left            =   8418
      TabIndex        =   13
      Tag             =   "8005;8006"
      Top             =   0
      WhatsThisHelpID =   2000
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Buscar"
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
      Picture         =   "FTRAN493.frx":0362
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   5
      Left            =   8418
      TabIndex        =   18
      Top             =   4515
      WhatsThisHelpID =   2008
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1296
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
      Picture         =   "FTRAN493.frx":037E
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   3
      Left            =   1440
      MaxLength       =   64
      TabIndex        =   6
      Top             =   1290
      Width           =   6870
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   240
      Index           =   0
      Left            =   1440
      MaxLength       =   4
      TabIndex        =   1
      Top             =   270
      Width           =   700
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   4
      Left            =   8418
      TabIndex        =   39
      Tag             =   "8002"
      Top             =   2250
      WhatsThisHelpID =   2009
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1296
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
      Picture         =   "FTRAN493.frx":039A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   6
      Left            =   8418
      TabIndex        =   40
      Tag             =   "2516"
      Top             =   3015
      WhatsThisHelpID =   2006
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Eliminar"
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
      Picture         =   "FTRAN493.frx":03B6
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   2
      Left            =   2172
      TabIndex        =   44
      Top             =   1032
      Width           =   1992
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causa Destino:"
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
      Height          =   168
      Index           =   9
      Left            =   3070
      TabIndex        =   43
      Top             =   1584
      Visible         =   0   'False
      Width           =   1188
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Prod. Bancario:"
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
      Index           =   11
      Left            =   90
      TabIndex        =   42
      Top             =   1905
      Width           =   1215
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Clase:"
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
      Index           =   12
      Left            =   4620
      TabIndex        =   41
      Top             =   1905
      Width           =   495
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   8
      Left            =   5880
      TabIndex        =   38
      Top             =   2160
      Width           =   2445
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Totaliza:"
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
      Height          =   156
      Index           =   13
      Left            =   4467
      TabIndex        =   37
      Top             =   2160
      Width           =   648
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   7
      Left            =   5880
      TabIndex        =   35
      Top             =   1900
      Width           =   2445
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   6
      Left            =   2160
      TabIndex        =   34
      Top             =   1896
      Width           =   2280
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
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
      Index           =   10
      Left            =   4365
      TabIndex        =   33
      Top             =   1065
      Width           =   600
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   5
      Left            =   5772
      TabIndex        =   32
      Top             =   1032
      Width           =   2540
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   4
      Left            =   2172
      TabIndex        =   31
      Top             =   528
      Width           =   6140
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto:"
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
      Left            =   90
      TabIndex        =   30
      Top             =   45
      Width           =   780
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   3
      Left            =   2172
      TabIndex        =   29
      Top             =   12
      Width           =   6140
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Signo Créd/Déb:"
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
      Index           =   7
      Left            =   90
      TabIndex        =   28
      Top             =   555
      Width           =   1260
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Campo a Contabilizar:"
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
      Height          =   156
      Index           =   6
      Left            =   4840
      TabIndex        =   21
      Top             =   1580
      Width           =   1632
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Perfil Contable:"
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
      Index           =   5
      Left            =   90
      TabIndex        =   22
      Top             =   1545
      Width           =   1215
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   1
      Left            =   2172
      TabIndex        =   23
      Top             =   780
      Width           =   6140
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   0
      Left            =   2172
      TabIndex        =   24
      Top             =   276
      Width           =   6140
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Indicador:"
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
      Index           =   4
      Left            =   90
      TabIndex        =   25
      Top             =   1035
      Width           =   765
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causa Origen:"
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
      Index           =   3
      Left            =   90
      TabIndex        =   26
      Top             =   810
      Width           =   1080
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   -12
      X2              =   8352
      Y1              =   2448
      Y2              =   2448
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Transacciones a Contabilizar:"
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
      Index           =   1
      Left            =   30
      TabIndex        =   27
      Top             =   2500
      Width           =   2925
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderStyle     =   6  'Inside Solid
      BorderWidth     =   2
      Index           =   1
      X1              =   8355
      X2              =   8355
      Y1              =   0
      Y2              =   5340
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Descripción:"
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
      Index           =   2
      Left            =   90
      TabIndex        =   20
      Top             =   1290
      Width           =   975
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cód. Transacción:"
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
      Index           =   0
      Left            =   90
      TabIndex        =   19
      Top             =   300
      Width           =   1410
   End
End
Attribute VB_Name = "FTran493"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Integer
Dim VLTabla As String
Dim VLSecuencial As String
Dim VLMatrizTrans(2, 80) As String
Dim VLTrnCaus As Integer
Dim VLFlag As Integer
Dim VLBuscar As String
Dim VLCausa As String
Dim VLBorra As Boolean
Dim VLPosGrid As Integer
Dim VLValorMin As Integer
Dim VLPos As Integer
Dim VLValorInter As Integer
Dim VLClip As String
Dim VLTransac As Integer


Private Sub PLEliminar()

    If VLSecuencial$ <> "" Then
   
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "689"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, VLSecuencial$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK Eliminación de Transacción a Contabilizar") Then
             PMChequea sqlconn&
             PLBuscar
             cmdBoton(3).Enabled = False
             cmdBoton(6).Enabled = False
        End If
        
    Else
        MsgBox "Transacción a eliminarse no seleccionada", 0 + 16, "Mensaje de Error"
    End If
   

End Sub

Private Sub CmbContab_GotFocus()
FPrincipal!pnlHelpLine.Caption = " Campo Contable"
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim Msg As String
    Select Case Index%
    Case 0
        VLBuscar$ = "S"
        PLBuscar
    Case 1
        PLLimpiar
    Case 2
        PLIngresar
    Case 3
        PLModificar
    Case 4
        PLImprimir
    Case 5
        Unload FTran493
    Case 6
        grdRegistros.Col = 0
        Msg = "Esta Seguro de Eliminar el Registro Nro: " + grdRegistros.Text + " ?"
        If MsgBox(Msg, 4) = 6 Then
            VLBuscar$ = "N"
            PLEliminar
        End If
    End Select
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Ingresar el programa"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Modificar el programa"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Eliminar el programa"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Consultar los programas existentes"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Limpiar la pantalla"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Salir de la pantalla"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Consulta de los parámetros asociados al programa"
    End Select
End Sub

Private Sub Form_Load()
    Dim i As Integer
    Dim VTFecha As String
    FTran493.Left = 15
    FTran493.Top = 15
    FTran493.Width = 9420
    FTran493.Height = 5730
    VTFecha$ = Format$(Now, Get_Preferencia("FORMATO-FECHA"))
    VLFlag = 0
    VLBuscar$ = "S"
    ' Carga los datos de las Transacciones que tienen causa para la contabilidad
     PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_trn_causa_contb"
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de las transacciones con causa cont.") Then
         VLTrnCaus% = FMMapeaMatriz(sqlconn&, VLMatrizTrans())
         PMChequea sqlconn&
    End If
    For i = 0 To 9
        If i <> 5 Then txtCampo(i).Height = 240
    Next

    VLTabla$ = "cc_campo_contable"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
        PMMapeaGrid sqlconn&, grdConta, False
        PMChequea sqlconn&
        grdConta.Col = 2
        For i% = 0 To grdConta.Rows - 2
            grdConta.Row = i% + 1
            CmbContab.AddItem grdConta.Text, i
        Next i
    End If
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRegistros_Click()
    grdRegistros.Col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
        grdRegistros.SelStartRow = 1
        grdRegistros.SelEndRow = 1
    Else
        grdRegistros.SelStartRow = grdRegistros.Row
        grdRegistros.SelEndRow = grdRegistros.Row
        
    End If
End Sub

Private Sub grdregistros_DblClick()
    Dim i As Integer
    Dim causa_sus As Integer
    Dim causa As String
    Dim VTCampo As Integer
    txtCampo(7).Enabled = False

    ' Verificar que existan transacciones para procesar
    If grdRegistros.Rows <= 2 Then
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        If Trim$(grdRegistros.Text) = "" Then
            MsgBox "No existen transacciones para procesar", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    'Escoge los datos del registro a procesar

    'Codigo de transaccion
    grdRegistros.Col = 1
    txtCampo(0).Text = Trim$(grdRegistros.Text)
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "494"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
     PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, (txtCampo(0).Text)
     PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
         PMMapeaObjeto sqlconn&, lblDescripcion(0)
         PMChequea sqlconn&
    End If

    VLTabla$ = ""
    txtCampo(1).Enabled = False
    For i = 1 To UBound(VLMatrizTrans, 2)
        If txtCampo(0).Text = VLMatrizTrans(0, i) Then
            VLTabla$ = VLMatrizTrans(1, i)
            txtCampo(1).Enabled = True
            Exit For
        End If
    Next i

    ' Descripcion de la transaccion a contabilizar
    grdRegistros.Col = 2
    txtCampo(3).Text = grdRegistros.Text
    

    ' Signo de Contabilizacion
    grdRegistros.Col = 3
    txtCampo(6).Text = Trim$(grdRegistros.Text)
    If txtCampo(6).Text = "C" Then
        lblDescripcion(4).Caption = "CREDITO"
    Else
        lblDescripcion(4).Caption = "DEBITO"
    End If

    ' Causa origen de la transaccion
    grdRegistros.Col = 4
    If Trim$(grdRegistros.Text) <> "0" Then
        txtCampo(1).Text = Trim$(grdRegistros.Text)
        If VLTabla$ <> "" Then
            If Not IsNumeric(Trim$(grdRegistros.Text)) Then
                txtCampo(1).Text = Trim$(grdRegistros.Text)
                PMCatalogo "V", VLTabla$, txtCampo(1), lblDescripcion(1)
            Else
                If txtCampo(0).Text = "48" Or txtCampo(0).Text = "50" Or txtCampo(0).Text = "264" Or txtCampo(0).Text = "253" Then
                    causa_sus = CInt(txtCampo(1).Text)
                    causa = txtCampo(1).Text
                    If causa_sus > 500 Then
                        causa_sus = causa_sus - 500
                    End If
                Else
                    causa = txtCampo(1).Text
                    causa_sus = txtCampo(1).Text
                End If
                txtCampo(1).Text = CStr(causa_sus)
                PMCatalogo "V", VLTabla$, txtCampo(1), lblDescripcion(1)
                txtCampo(1).Text = causa
                If CInt(txtCampo(1).Text) > 500 Then
                    lblDescripcion(1).Caption = "VALOR EN SUSPENSO POR " + lblDescripcion(1).Caption
                End If
            End If
        End If
    Else
        txtCampo(1).Text = Trim$(grdRegistros.Text)
        lblDescripcion(1).Caption = ""
    End If

    ' Causa destino de la transaccion
    grdRegistros.Col = 5
    txtCampo(8).Text = grdRegistros.Text

    ' Indicador de la transaccion
    grdRegistros.Col = 6
    If Trim$(grdRegistros.Text) <> "" Then
        txtCampo(2).Text = Trim$(grdRegistros.Text)
        PMCatalogo "V", "cc_tipo_indicador", txtCampo(2), lblDescripcion(2)
    Else
        txtCampo(2) = ""
        lblDescripcion(2) = ""
    End If
    
    ' Campo acontabilizar
    grdRegistros.Col = 7
    CmbContab.Text = Trim$(grdRegistros.Text)

    ' Estado de la transaccion
    grdRegistros.Col = 8
    txtCampo(9).Text = Trim$(grdRegistros.Text)
    If txtCampo(9).Text = "V" Then
        lblDescripcion(5).Caption = "VIGENTE"
    Else
        lblDescripcion(5).Caption = "CANCELADO"
    End If

    ' Perfil contable
    grdRegistros.Col = 9
    txtCampo(4).Text = grdRegistros.Text

    ' Guardar el secuenciial para la actualizacion
    grdRegistros.Col = 12
    VLSecuencial$ = grdRegistros.Text
    
    ' producto Bancario
    grdRegistros.Col = 13
    txtCampo(10).Text = grdRegistros.Text
    
    ' clase
    grdRegistros.Col = 14
    If Trim$(grdRegistros.Text) <> "" Then
        txtCampo(11).Text = Trim$(grdRegistros.Text)
        PMCatalogo "V", "cc_clase_clte", txtCampo(11), lblDescripcion(7)
    End If
    'Contabiliza
    grdRegistros.Col = 15
    If Trim$(grdRegistros.Text) <> "" Then
        txtCampo(12).Text = Trim$(grdRegistros.Text)
        PMCatalogo "V", "re_campo_totaliza", txtCampo(12), lblDescripcion(8)
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
    PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, (txtCampo(10).Text)
    If txtCampo(7).Text = 10 Then
        VTCampo = 3
        PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, VTCampo
    Else
        PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, txtCampo(7).Text
    End If
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, "Ok.. Consulta de Producto Bancaria") Then
         PMMapeaObjeto sqlconn&, lblDescripcion(6)
         PMChequea sqlconn&
    End If

    ' Actualizar
    cmdBoton(3).Enabled = True
    ' Ingresar
    cmdBoton(2).Enabled = False
    ' Eliminar
    cmdBoton(6).Enabled = True

End Sub

Private Sub PLBuscar()
Dim VTRegistros As Integer
Dim VTSecuencial As String
Dim VTFlag As Boolean
Dim VTCodigoTrn As String
Dim VTBusqueda As String
Dim Msg As String
Dim i As Integer
Dim j As Integer
Dim a As Integer
Dim num As Integer
Dim M As Integer
Dim Var As Integer
    ' La busqueda se realiza por producto

    If Trim$(txtCampo(7).Text) = "" Then
        MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(7).SetFocus
        Exit Sub
    End If

    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "Código de transacción mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    ' Traer las definciones de perfiles contables para un
    ' producto determinado

    VTRegistros = 20
    VTSecuencial = "0"
    VTFlag = False

    VTCodigoTrn = Trim$(txtCampo(0).Text)
    If VTCodigoTrn = "" Then
        VTBusqueda = "P"
        VTCodigoTrn$ = "0"
    Else
        VTBusqueda$ = "T"
    End If

    If txtCampo(1).Text = "" Then
        VLCausa = "0"
    Else
        VLCausa$ = txtCampo(1).Text
        VTBusqueda$ = "C"
    End If

    While VTRegistros% = 20
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "494"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, VTBusqueda$
         PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, VLCausa$
         PMPasoValores sqlconn&, "@i_orden", 0, SQLINT4, VTSecuencial$
         PMPasoValores sqlconn&, "@i_prod", 0, SQLINT1, (txtCampo(7).Text)
         PMPasoValores sqlconn&, "@i_codtrn", 0, SQLINT2, VTCodigoTrn$
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", True, "OK consulta de Transacciones a Contabilizar") Then
             PMMapeaGrid sqlconn&, grdRegistros, VTFlag
             PMChequea sqlconn&
            VTFlag = True
            VTRegistros% = Val(grdRegistros.Tag)
            'GYA Activa Boton Imprimir.
            If VTRegistros% > 0 Then
               cmdBoton(4).Enabled = True
            End If
            
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 12
            VTSecuencial$ = grdRegistros.Text
            grdRegistros.Col = 1
            VTCodigoTrn$ = grdRegistros.Text
        Else
            VTRegistros% = 0
        End If
    Wend
    grdRegistros.ColWidth(2) = 4600
    grdRegistros.ColWidth(4) = 1000
    grdRegistros.ColWidth(5) = 1
    grdRegistros.ColWidth(6) = 900
    grdRegistros.ColWidth(7) = 1200
    grdRegistros.ColWidth(8) = 650
    grdRegistros.ColWidth(9) = 700
    grdRegistros.ColWidth(10) = 800
    grdRegistros.ColWidth(11) = 1
    grdRegistros.ColWidth(12) = 700
    grdRegistros.ColWidth(13) = 700
    If grdRegistros.Rows > 2 And VLBuscar$ = "S" Then
        Msg = "¿Desea que los Datos estén ordenados - Puede tardar un poco?"
        If MsgBox(Msg, 33, Me.Caption) = 1 Then
            Screen.MousePointer = 11
            i = grdRegistros.Rows - 1
            grdRegistros.Col = 4
            VLBorra = False
            VLPosGrid = 1
            While i% >= 1
                j = i - 1
                grdRegistros.Row = i%
                a = Len(grdRegistros.Text)
                num = 0
                For M = 1 To a
                    grdRegistros.Col = 1
                    If grdRegistros.Text = 2679 Or grdRegistros.Text = 2680 Or grdRegistros.Text = 2681 Or grdRegistros.Text = 2682 Or _
                       grdRegistros.Text = 2689 Or grdRegistros.Text = 2690 Or grdRegistros.Text = 2691 Or grdRegistros.Text = 2692 Or _
                       grdRegistros.Text = 250 Then
                            grdRegistros.Col = 4
                            Var = Asc(Mid$(grdRegistros.Text, M, 1))
                            num% = num% + Var%
                    Else
                       grdRegistros.Col = 4
                       num% = CInt(grdRegistros.Text)
                    End If
                Next M
                
                VLValorMin% = num
                VLPos = i
                While j% >= 1
                    grdRegistros.Row = j%
                    a% = Len(grdRegistros.Text)
                    num% = 0
                    For M = 1 To a%
                        grdRegistros.Col = 1
                        If grdRegistros.Text = 2679 Or grdRegistros.Text = 2680 Or grdRegistros.Text = 2681 Or grdRegistros.Text = 2682 Or _
                            grdRegistros.Text = 2689 Or grdRegistros.Text = 2690 Or grdRegistros.Text = 2691 Or grdRegistros.Text = 2692 Or _
                            grdRegistros.Text = 250 Then
                            grdRegistros.Col = 4
                            Var% = Asc(Mid$(grdRegistros.Text, M, 1))
                            num% = num% + Var%
                        Else
                            grdRegistros.Col = 4
                            num% = CInt(grdRegistros.Text)
                        End If
                    Next M
                    VLValorInter = num
                    If VLValorInter% < VLValorMin% Then
                        VLValorMin% = num%
                        VLPos% = j%
                    End If
                    j% = j% - 1
                Wend
                grdRegistros.SelStartCol = 1
                grdRegistros.SelEndCol = grdRegistros.Cols - 1
                grdRegistros.SelStartRow = VLPos%
                grdRegistros.SelEndRow = VLPos%
                VLClip = grdRegistros.Clip
                grdRegistros.RemoveItem VLPos%
                grdRegistros.AddItem Str$(VLPosGrid%) & Chr(9) & VLClip$
                i% = i% - 1
                VLPosGrid% = VLPosGrid% + 1
            Wend
            MsgBox "Datos Ordenados Satisfactoriamente", 64, Me.Caption
            Screen.MousePointer = 0
        End If
    End If
End Sub
Private Sub PLIngresar()
Dim VTCausaOrg As String
Dim VTIndicador As String
    ' Valida mandatoriedades
    
    If Trim$(txtCampo(7).Text) = "" Then
        MsgBox "El código de producto es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(7).Enabled = True Then txtCampo(7).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(6).Text) = "" Then
        MsgBox "El signo de la transacción es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(6).Enabled = True Then txtCampo(6).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "El código de transacción es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled = True Then txtCampo(0).SetFocus
        Exit Sub
    End If

    If Trim$(txtCampo(3).Text) = "" Then
        MsgBox "El campo Descripción es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(3).Enabled = True Then txtCampo(3).SetFocus
        Exit Sub
    End If

    If Trim$(txtCampo(4).Text) = "" Then
        MsgBox "El código del perfil contable es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(4).Enabled = True Then txtCampo(4).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(9).Text) = "" Then
        MsgBox "El campo Estado es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(9).Enabled = True Then txtCampo(9).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(10).Text) = "" Then
        MsgBox "El campo producto bancario es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(10).Enabled = True Then txtCampo(10).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(11).Text) = "" Then
        MsgBox "El campo Clase es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(11).Enabled = True Then txtCampo(11).SetFocus
        Exit Sub
    End If
        
    If Trim$(txtCampo(12).Text) = "" Then
        MsgBox "El campo Totaliza es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(12).Enabled = True Then txtCampo(12).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(1).Text) = "" Then
        VTCausaOrg = "0"
    Else
        VTCausaOrg = txtCampo(1).Text
    End If

    If Trim$(txtCampo(2).Text) = "" Then
        VTIndicador = "0"
    Else
        VTIndicador = txtCampo(2).Text
    End If

    If (txtCampo(0).Text = "48" Or txtCampo(0).Text = "50" Or txtCampo(0).Text = "253" Or txtCampo(0).Text = "255" Or txtCampo(0).Text = "262" Or txtCampo(0).Text = "264" _
        Or txtCampo(0).Text = "2679" Or txtCampo(0).Text = "2680" Or txtCampo(0).Text = "2681" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2689" _
        Or txtCampo(0).Text = "2690" Or txtCampo(0).Text = "2691" Or txtCampo(0).Text = "2692" Or txtCampo(0).Text = "2752" Or txtCampo(0).Text = "329" Or txtCampo(0).Text = "676" Or txtCampo(0).Text = "259" _
        Or txtCampo(0).Text = "2505" Or txtCampo(0).Text = "2766" Or txtCampo(0).Text = "2770" Or txtCampo(0).Text = "2772" Or txtCampo(0).Text = "250" Or txtCampo(0).Text = "2908") And VTCausaOrg$ = "0" Then
        MsgBox "La Causa no puede ser ""0"" para la Transacción " + txtCampo(0).Text, 0 + 16, "Mensaje de Error"
        If txtCampo(1).Enabled = True Then txtCampo(1).SetFocus
        Exit Sub
    End If
    
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "493"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
     PMPasoValores sqlconn&, "@i_prod", 0, SQLINT1, (txtCampo(7).Text)
     PMPasoValores sqlconn&, "@i_credeb", 0, SQLCHAR, (txtCampo(6).Text)
     PMPasoValores sqlconn&, "@i_tran", 0, SQLINT2, (txtCampo(0).Text)
     PMPasoValores sqlconn&, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$
     PMPasoValores sqlconn&, "@i_indicador", 0, SQLINT1, VTIndicador$
     PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (txtCampo(3).Text)
     PMPasoValores sqlconn&, "@i_perfil", 0, SQLVARCHAR, (txtCampo(4).Text)
     PMPasoValores sqlconn&, "@i_contabiliza", 0, SQLVARCHAR, (CmbContab.Text)
     PMPasoValores sqlconn&, "@i_estado", 0, SQLVARCHAR, (txtCampo(9).Text)
     PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT1, (txtCampo(10).Text)
     PMPasoValores sqlconn&, "@i_clase", 0, SQLVARCHAR, (txtCampo(11).Text)
     PMPasoValores sqlconn&, "@i_totaliza", 0, SQLVARCHAR, (txtCampo(12).Text)
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then
        txtCampo(0).SetFocus
        MsgBox "Ingreso satisfactorio del perfil (" + txtCampo(4).Text + ")", vbInformation, "Ingreso de Perfil"
     End If
     PMChequea sqlconn&
     PLLimpiar
End Sub

Private Sub PLLimpiar()
Dim i As Integer
    ' Limpiar en niveles

    If (Trim$(txtCampo(6).Text) <> "") And (Trim$(txtCampo(4).Text) <> "") Then
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(5).Caption = ""
        lblDescripcion(6).Caption = ""
        lblDescripcion(7).Caption = ""
        lblDescripcion(8).Caption = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        txtCampo(4).Text = ""
        txtCampo(8).Text = ""
        txtCampo(9).Text = ""
        txtCampo(10).Text = ""
        txtCampo(11).Text = ""
        txtCampo(12).Text = ""
    ElseIf Trim$(txtCampo(0).Text) <> "" Then
        lblDescripcion(0).Caption = ""
        txtCampo(0).Text = ""
        lblDescripcion(1).Caption = ""
        txtCampo(1).Text = ""
        lblDescripcion(4).Caption = ""
        txtCampo(6).Text = ""
        PMLimpiaGrid grdRegistros
    Else
        For i = 0 To 8
            lblDescripcion(i).Caption = ""
        Next i
        
        For i = 0 To 12
            If i <> 5 Then txtCampo(i).Text = ""
        Next i

        PMLimpiaGrid grdRegistros
    End If
    
    ' Actualizar
    cmdBoton(3).Enabled = False
    ' Eliminar
    cmdBoton(6).Enabled = False
    ' Ingresar
    cmdBoton(2).Enabled = True
    txtCampo(7).Enabled = True
    
    CmbContab.ListIndex = 0
    
End Sub

Private Sub PLModificar()
Dim VTCausaOrg As String
Dim VTCausaDst As String
Dim VTIndicador As String
    If VLSecuencial$ <> "" Then
    
        ' Valida mandatoriedades
        
        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "El código de producto es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(7).Enabled = True Then txtCampo(7).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(6).Text) = "" Then
            MsgBox "El signo de la transacción es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(6).Enabled = True Then txtCampo(6).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de transacción es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(0).Enabled = True Then txtCampo(0).SetFocus
            Exit Sub
        End If
    
        If Trim$(txtCampo(3).Text) = "" Then
            MsgBox "El campo Descripción es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(3).Enabled = True Then txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(4).Text) = "" Then
            MsgBox "El código del perfil contable es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(4).Enabled = True Then txtCampo(4).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(9).Text) = "" Then
            MsgBox "El campo Estado es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(9).Enabled = True Then txtCampo(9).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(10).Text) = "" Then
            MsgBox "El campo producto bancario es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(10).Enabled = True Then txtCampo(10).SetFocus
            Exit Sub
        End If
        If Trim$(txtCampo(11).Text) = "" Then
            MsgBox "El campo Clase es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(11).Enabled = True Then txtCampo(11).SetFocus
            Exit Sub
        End If
            
        If Trim$(txtCampo(12).Text) = "" Then
            MsgBox "El campo Totaliza es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(12).Enabled = True Then txtCampo(12).SetFocus
            Exit Sub
        End If
    
        If Trim$(txtCampo(1).Text) = "" Then
            VTCausaOrg = "0"
        Else
            VTCausaOrg = txtCampo(1).Text
        End If
    
        If Trim$(txtCampo(8).Text) = "" Then
            VTCausaDst = "0"
        Else
            VTCausaDst = txtCampo(8).Text
        End If
        
        If Trim$(txtCampo(2).Text) = "" Then
            VTIndicador = "0"
        Else
            VTIndicador = txtCampo(2).Text
        End If
    
        If (txtCampo(0).Text = "48" Or txtCampo(0).Text = "50" Or txtCampo(0).Text = "253" Or txtCampo(0).Text = "255" Or txtCampo(0).Text = "262" Or txtCampo(0).Text = "264" _
            Or txtCampo(0).Text = "2679" Or txtCampo(0).Text = "2680" Or txtCampo(0).Text = "2681" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2682" Or txtCampo(0).Text = "2689" _
            Or txtCampo(0).Text = "2690" Or txtCampo(0).Text = "2691" Or txtCampo(0).Text = "2692" Or txtCampo(0).Text = "2752" Or txtCampo(0).Text = "329" Or txtCampo(0).Text = "259" _
            Or txtCampo(0).Text = "2669" Or txtCampo(0).Text = "2753" Or txtCampo(0).Text = "2756" Or txtCampo(0).Text = "2758" Or txtCampo(0).Text = "2699" _
            Or txtCampo(0).Text = "2505" Or txtCampo(0).Text = "2766" Or txtCampo(0).Text = "2770" Or txtCampo(0).Text = "2772") And VTCausaOrg$ = "0" Then
            MsgBox "La Causa no puede ser ""0"" para la Transacción " + txtCampo(0).Text, 0 + 16, "Mensaje de Error"
            If txtCampo(1).Enabled = True Then txtCampo(1).SetFocus
            Exit Sub
        End If

        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "493"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
        PMPasoValores sqlconn&, "@i_prod", 0, SQLINT1, (txtCampo(7).Text)
        PMPasoValores sqlconn&, "@i_credeb", 0, SQLCHAR, (txtCampo(6).Text)
        PMPasoValores sqlconn&, "@i_tran", 0, SQLINT2, (txtCampo(0).Text)
        PMPasoValores sqlconn&, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$
        PMPasoValores sqlconn&, "@i_causa_dst", 0, SQLVARCHAR, VTCausaDst$
        PMPasoValores sqlconn&, "@i_indicador", 0, SQLINT1, VTIndicador$
        PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (txtCampo(3).Text)
        PMPasoValores sqlconn&, "@i_perfil", 0, SQLVARCHAR, (txtCampo(4).Text)
        PMPasoValores sqlconn&, "@i_contabiliza", 0, SQLVARCHAR, (CmbContab.Text)
        PMPasoValores sqlconn&, "@i_estado", 0, SQLVARCHAR, (txtCampo(9).Text)
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, VLSecuencial$
        PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT1, (txtCampo(10).Text)
        PMPasoValores sqlconn&, "@i_clase", 0, SQLCHAR, (txtCampo(11).Text)
        PMPasoValores sqlconn&, "@i_totaliza", 0, SQLCHAR, (txtCampo(12).Text)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then
            PMChequea sqlconn&
            txtCampo(0).SetFocus
        End If
        PLBuscar
    Else
        MsgBox "Transacción a modificarse no seleccionada", 0 + 16, "Mensaje de Error"
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de la transacción por producto"
    Case 1
        cmdBoton(2).Enabled = True
        FPrincipal!pnlHelpLine.Caption = " Causa asociada a la transacción [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Indicador de la transacción [F5 Ayuda]"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Descripción Contable de Transacción"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Código de Perfil Contable "
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Nombre del campo a contabilizar"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Crédito [C] o Débito [D] "
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Producto (3-CTE, 4-AHO, 10-REM)"
    Case 8
        FPrincipal!pnlHelpLine.Caption = " Causa destino por transacción"
    Case 9
        FPrincipal!pnlHelpLine.Caption = " Estado de la transacción a contabilizar [V/C]"
    Case 10
        FPrincipal!pnlHelpLine.Caption = " Producto Bancario"
    Case 11
        FPrincipal!pnlHelpLine.Caption = " Clase de cuenta"
    Case 12
        FPrincipal!pnlHelpLine.Caption = " Totaliza"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
    VLPaso% = True
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Dim VTCampo As Integer
    If Keycode% <> VGTeclaAyuda% Then
        Exit Sub
    End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    VGProductoConta = Trim$(txtCampo(7).Text)
    Select Case Index%
        Case 0
            'Transacciones por producto
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(7).Text) = "" Then
                MsgBox "CODIGO DE PRODUCTO ES OBLIGATORIO"
                txtCampo(7).SetFocus
                Exit Sub
            End If
            VLPaso% = True
            VGOperacion$ = "sp_pro_transaccion"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15020"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "9"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(7)
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "R"
            PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
            PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT4, "0"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_pro_transaccion", True, " OK... Consulta de Productos COBIS") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(0).Text) = "" Then
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                End If
            End If
        Case 1
            'Causas
            If VLTabla$ = "" Then
                Exit Sub
            End If
            VGOperacion$ = ""
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la causa " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(1).Text) = "" Then
                    lblDescripcion(1).Caption = ""
                    txtCampo(1).SetFocus
                End If
            End If
        Case 2  'Indicadores
            VGOperacion$ = ""
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de indicadores " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(2).Text = VGACatalogo.Codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(2).Text) = "" Then
                    lblDescripcion(2).Caption = ""
                    txtCampo(2).SetFocus
                End If
            End If
        Case 4
            'Perfiles por producto
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(7).Text) = "" Then
                MsgBox "CODIGO DE PRODUCTO ES OBLIGATORIO"
                txtCampo(7).SetFocus
                Exit Sub
            End If
            VLPaso% = True
            VGOperacion$ = "sp_perfil"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6907"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "0"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(7)
            PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGFilial
            PMPasoValores sqlconn&, "@i_perfil", 0, SQLVARCHAR, "%"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_perfil", True, " OK... Consulta de Productos COBIS") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(4).Text = VGACatalogo.Descripcion
                If Trim$(txtCampo(0).Text) = "" Then
                    txtCampo(4).SetFocus
                End If
            End If
        Case 7
            'Producto a Contabilizar
            VLPaso% = True
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "475"
            PMPasoValores sqlconn&, "@i_ope", 0, SQLCHAR, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " OK... Consulta de Productos COBIS") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(7).Text = VGACatalogo.Codigo$
                lblDescripcion(3).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(7).Text) = "" Then
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    lblDescripcion(3).Caption = ""
                    txtCampo(7).SetFocus
                End If
            End If
        Case 9
            'Estado
            VGOperacion$ = ""
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_estado_ser"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la causa " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(9).Text = VGACatalogo.Codigo$
                lblDescripcion(5).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(9).Text) = "" Then
                    lblDescripcion(5).Caption = ""
                    txtCampo(9).SetFocus
                End If
            End If
            
        Case 10
            If txtCampo(0).Text = 2679 Or txtCampo(0).Text = 2680 Or txtCampo(0).Text = 2681 Or _
               txtCampo(0).Text = 2682 Or txtCampo(0).Text = 2689 Or txtCampo(0).Text = 2690 Or _
               txtCampo(0).Text = 2691 Or txtCampo(0).Text = 2692 Then
               
               MsgBox "Los datos que puede ingresar para la transacción son: 1 G.CONTRIBUYENTES , 2 JURIDICAS, 3 NATURALES"
               
             Else
                VGOperacion$ = ""
                If txtCampo(7).Text <> "" Then
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
                    If txtCampo(7).Text = 10 Then
                        VTCampo = 3
                        PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, VTCampo
                    Else
                        PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, txtCampo(7).Text
                    End If
                    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, " Ok... Consulta de Productos Bancarios") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMChequea sqlconn&
                        VLPaso% = True
                        FCatalogo.Show 1
                        txtCampo(10).Text = VGACatalogo.Codigo$
                        lblDescripcion(6).Caption = VGACatalogo.Descripcion$
                    End If
                Else
                    MsgBox "Código de Producto es mandatorio", 0 + 16, "Mensaje del Servidor"
                End If
             End If
        Case 11
            VGOperacion$ = ""
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_clase_clte"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de indicadores " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(11).Text = VGACatalogo.Codigo$
                lblDescripcion(7).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(11).Text) = "" Then
                    lblDescripcion(7).Caption = ""
                    txtCampo(11).SetFocus
                End If
                txtCampo(12).SetFocus
            End If
        Case 12
            VGOperacion$ = ""
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_campo_totaliza"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de indicadores " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(12).Text = VGACatalogo.Codigo$
                lblDescripcion(8).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(12).Text) = "" Then
                    lblDescripcion(8).Caption = ""
                End If
            End If
    
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
        Case 0, 1, 2, 7, 8, 10
           KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
        Case 4
            KeyAscii% = FMVAlidaTipoDato("AN", KeyAscii%) ' KeyAscii% = 0
        Case 3
           If (KeyAscii > 47 And KeyAscii < 58) Or _
              (KeyAscii > 64 And KeyAscii < 91) Or _
              (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
           
               KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
           Else
               KeyAscii = 0
           End If
        Case 5
            KeyAscii% = Asc(LCase$(Chr$(KeyAscii%)))
        Case 6
            KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
        Case 9, 11, 12
            KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTTranVal As Integer
    Dim i As Integer
    Dim causa As String
    Dim causa_sus As Integer
    Dim VTCampo As Integer
    Select Case Index%
    Case 0
        'Transacciones
        
        If Trim$(txtCampo(0).Text) = "" Then
            lblDescripcion(0).Caption = ""
            Exit Sub
        End If
        
        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(7).SetFocus
            Exit Sub
        End If

        ' Validar los rangos de transacciones de acuerdo al producto
        VTTranVal = Val(txtCampo(0).Text)
        Select Case Trim$(txtCampo(7).Text)
        Case "3"

            If VTTranVal% > 2999 Or (VTTranVal% < 600 And VTTranVal% > 99) Or (VTTranVal% < 2500 And VTTranVal% > 700) Then
               If (VTTranVal% <> 401 And VTTranVal% <> 402 And VTTranVal% <> 403 And VTTranVal% <> 404 And VTTranVal% <> 405 And VTTranVal% <> 406 And VTTranVal% <> 407 And VTTranVal% <> 408 And VTTranVal% <> 409 And VTTranVal% <> 410 And VTTranVal% <> 489) Then
                    MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                    Exit Sub
                End If
            End If
        Case "4"

            If VTTranVal% <= 200 Or VTTranVal% >= 399 Or VTTranVal% = 401 Then
                If (VTTranVal% <> 401 And VTTranVal% <> 402 And VTTranVal% <> 403 And VTTranVal% <> 404 And VTTranVal% <> 405 And VTTranVal% <> 406 And VTTranVal% <> 407 And VTTranVal% <> 408 And VTTranVal% <> 409 And VTTranVal% <> 410 And VTTranVal% <> 489) Then
                    MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                    Exit Sub
                End If
            End If
        Case "10"
            If (VTTranVal% >= 500 Or VTTranVal% < 400) Or VTTranVal% = 401 Then
                If (VTTranVal% >= 700 Or VTTranVal% < 600) Then
                    MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                    Exit Sub
                End If
            End If
        End Select
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "494"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
        Else
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(0).SetFocus
        End If

        VLTabla = ""
        txtCampo(1).Enabled = False
        For i = 1 To UBound(VLMatrizTrans, 2)
            If txtCampo(0).Text = VLMatrizTrans(0, i) Then
                VLTabla = VLMatrizTrans(1, i)
                txtCampo(1).Enabled = True
                Exit For
            End If
        Next i

    Case 1

        'Causas

        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(1).Text) = "" Then
            lblDescripcion(1).Caption = ""
            Exit Sub
        End If
        causa = txtCampo(1).Text
        
        If VLTabla$ = "" Then
            MsgBox "Código de transacción mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
        
        If txtCampo(0).Text <> "" And IsNumeric(txtCampo(1).Text) Then
            VLTransac = CInt(txtCampo(0).Text)
        End If
        
        If (VLTransac% = 50 Or VLTransac% = 264) Then
            If txtCampo(1).Text <> "" And IsNumeric(txtCampo(1).Text) Then
                causa_sus = CInt(txtCampo(1).Text)
                causa = txtCampo(1).Text
                VLTransac% = txtCampo(0).Text
                If causa_sus > 500 And (VLTransac% = 50 Or VLTransac% = 264) Then
                        causa_sus = causa_sus - 500
                End If
                causa$ = CStr(causa_sus)
            End If
        End If
                
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, causa$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la causa " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(1)
             PMChequea sqlconn&
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(1).SetFocus
        End If

    Case 2
        'Indicadores
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(2).Text) = "" Then
            lblDescripcion(2).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(2).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Indicador " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(2)
             PMChequea sqlconn&
         Else
            txtCampo(2).Text = ""
            lblDescripcion(2).Caption = ""
            txtCampo(2).SetFocus
         End If
    Case 4
        If VLPaso% = True Then
            Exit Sub
        End If
        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(7).SetFocus
            Exit Sub
        End If
    
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6906"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "0"
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(7)
        PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGFilial
        PMPasoValores sqlconn&, "@i_perfil", 0, SQLVARCHAR, txtCampo(4)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_perfil", True, " OK... Consulta de Productos COBIS") Then
            PMChequea sqlconn&
            txtCampo(4) = txtCampo(4)
        Else
            txtCampo(4).Text = ""
            If txtCampo(4).Enabled Then txtCampo(4).SetFocus
        End If
    Case 6

        ' Signo de la transaccion

        If Trim$(txtCampo(6).Text) = "" Then
            lblDescripcion(4).Caption = ""
            Exit Sub
        End If
        
        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(6).Text = ""
            lblDescripcion(4).Caption = ""
            txtCampo(7).SetFocus
            Exit Sub
        End If

        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "Código de transacción mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(6).Text = ""
            lblDescripcion(4).Caption = ""
            txtCampo(0).SetFocus
            Exit Sub
        End If

        If Trim$(txtCampo(6).Text) = "D" Then
            lblDescripcion(4).Caption = "DEBITO"
        ElseIf Trim$(txtCampo(6).Text) = "C" Then
            lblDescripcion(4).Caption = "CREDITO"
        Else
            MsgBox "Signo de Transacción Erróneo", 0 + 16, "Mensaje de Error"
            txtCampo(6).Text = ""
            lblDescripcion(4).Caption = ""
            txtCampo(6).SetFocus
            Exit Sub
        End If
        
    Case 7
        'Productos COBIS
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(7).Text) = "" Then
            lblDescripcion(3).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "475"
         PMPasoValores sqlconn&, "@i_ope", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, (txtCampo(7).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " Consulta de Producto " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(3)
             PMChequea sqlconn&
        Else
            txtCampo(7).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(7).SetFocus
        End If

        If txtCampo(7).Text = "3" Then
        End If

    Case 9

        ' Signo de la transaccion

        If Trim$(txtCampo(9).Text) = "" Then
            lblDescripcion(5).Caption = ""
            Exit Sub
        End If
        
        If Trim$(txtCampo(9).Text) = "V" Then
            lblDescripcion(5).Caption = "VIGENTE"
        ElseIf Trim$(txtCampo(9).Text) = "C" Then
            lblDescripcion(5).Caption = "CANCELADA"
        Else
            MsgBox "Estado de Transacción Erróneo", 0 + 16, "Mensaje de Error"
            txtCampo(9).Text = ""
            lblDescripcion(5).Caption = ""
            txtCampo(9).SetFocus
            Exit Sub
        End If
        
    Case 10
        
        If VLPaso% = False Then
            If txtCampo(10).Text <> "" Then
                If txtCampo(0).Text = 2679 Or txtCampo(0).Text = 2680 Or txtCampo(0).Text = 2681 Or _
                   txtCampo(0).Text = 2682 Or txtCampo(0).Text = 2689 Or txtCampo(0).Text = 2690 Or _
                   txtCampo(0).Text = 2691 Or txtCampo(0).Text = 2692 Then
                   
                   If txtCampo(10).Text = "1" Then
                       lblDescripcion(6) = "G.CONTRIBUYENTES"
                   End If
                   If txtCampo(10).Text = "2" Then
                       lblDescripcion(6) = "JURIDICAS"
                   End If
                   If txtCampo(10).Text = "3" Then
                       lblDescripcion(6) = "NATURALES"
                   End If
                   
                   
                 Else
    
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                    PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, (txtCampo(10).Text)
                    If txtCampo(7).Text = "10" Then
                        VTCampo = 3
                    Else
                        VTCampo = txtCampo(7).Text
                    End If
                    PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, VTCampo%
                    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
    
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, "Ok.. Consulta de Producto Bancaria") Then
                        PMMapeaObjeto sqlconn&, lblDescripcion(6)
                        PMChequea sqlconn&
                        VLPaso% = True
                    Else
                        txtCampo(10).Text = ""
                        lblDescripcion(6).Caption = ""
                        txtCampo(10).SetFocus
                    End If
                End If
            Else
                lblDescripcion(6).Caption = ""
            End If
        End If
    
    Case 11
        'Clase
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(11).Text) = "" Then
            lblDescripcion(7).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_clase_clte"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(11).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Indicador " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(7)
             PMChequea sqlconn&
         Else
            txtCampo(11).Text = ""
            lblDescripcion(7).Caption = ""
            txtCampo(11).SetFocus
         End If
    Case 12
        'Clase
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(12).Text) = "" Then
            lblDescripcion(8).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_campo_totaliza"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(12).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Indicador " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(8)
             PMChequea sqlconn&
         Else
            txtCampo(12).Text = ""
            lblDescripcion(8).Caption = ""
            txtCampo(12).SetFocus
         End If

    End Select
End Sub
Private Sub PLImprimir()
Dim i As Integer
Dim Y As Integer
Dim j As Integer
    If MsgBox("Esta seguro de imprimir los registros " + Trim$("Transacciones a Contabilizar"), 1 + 32 + 0, "Mensaje del Sistema") = 1 Then
        Printer.Orientation = 2
        Printer.FontBold = True
        Printer.CurrentX = 3000
        Printer.CurrentY = 500
        Printer.FontSize = 16
        Printer.Print "MANTENIMIENTO DE TRANSACCIONES A CONTABILIZAR"
        Printer.Print ""
        Printer.CurrentX = 350
        Printer.CurrentY = 1100
        Printer.FontSize = 8
        Printer.Print "Num"
        Printer.CurrentX = 350
        Printer.CurrentY = 1400
        Printer.Print "Trans."
        Printer.CurrentX = 1200
        Printer.CurrentY = 1100
        Printer.Print "Descripcion"
        Printer.CurrentX = 1200
        Printer.CurrentY = 1400
        Printer.Print "Transaccion"
        Printer.CurrentX = 5800
        Printer.CurrentY = 1100
        Printer.Print "Causa"
        Printer.CurrentX = 5800
        Printer.CurrentY = 1400
        Printer.Print "Origen"
        Printer.CurrentX = 6700
        Printer.CurrentY = 1100
        Printer.Print "Numero"
        Printer.CurrentX = 6700
        Printer.CurrentY = 1400
        Printer.Print "Indicador"
        Printer.CurrentX = 8000
        Printer.CurrentY = 1100
        Printer.Print "Campo a "
        Printer.CurrentX = 8000
        Printer.CurrentY = 1400
        Printer.Print "Contabilizar"
        Printer.CurrentX = 9800
        Printer.CurrentY = 1100
        Printer.Print "Estado"
        Printer.CurrentX = 9800
        Printer.CurrentY = 1400
        Printer.Print "Trans."
        Printer.CurrentX = 10800
        Printer.CurrentY = 1100
        Printer.Print "Perfil"
        Printer.CurrentX = 10800
        Printer.CurrentY = 1400
        Printer.Print "Contable"
        Printer.CurrentX = 11800
        Printer.CurrentY = 1100
        Printer.Print "Producto"
        Printer.CurrentX = 11800
        Printer.CurrentY = 1400
        Printer.Print "Bancario"
        Printer.CurrentX = 12800
        Printer.CurrentY = 1100
        Printer.Print "Clase"
        Printer.CurrentX = 12800
        Printer.CurrentY = 1400
        Printer.Print "Cliente"
        Printer.CurrentX = 13800
        Printer.CurrentY = 1100
        Printer.Print "Campo"
        Printer.CurrentX = 13800
        Printer.CurrentY = 1400
        Printer.Print "Totaliza"
        Printer.CurrentX = 350
        Printer.CurrentY = 1650
        Printer.FontSize = 17
        Printer.Print String$(130, "-")
        Printer.FontBold = False
        Printer.FontSize = 6
        Y = Printer.CurrentY
        For j% = 1 To (grdRegistros.Rows - 1)
            Y = Printer.CurrentY + 300
            grdRegistros.Row = j%
            grdRegistros.Col = 1
            For i = 1 To 15
               If i <> 3 And i <> 10 And i <> 11 And i <> 5 And i <> 12 Then
                 Select Case i
                Case 1
                    Printer.CurrentX = 350
                    Printer.CurrentY = Y
                
                Case 2
                    Printer.CurrentX = 1200
                    Printer.CurrentY = Y
                  
                Case 4
                    Printer.CurrentX = 5800
                    Printer.CurrentY = Y
                Case 6
                    Printer.CurrentX = 6700
                    Printer.CurrentY = Y
                Case 7
                    Printer.CurrentX = 8000
                    Printer.CurrentY = Y
                Case 8
                    Printer.CurrentX = 9800
                    Printer.CurrentY = Y
                Case 9
                    Printer.CurrentX = 10800
                    Printer.CurrentY = Y
                Case 13
                    Printer.CurrentX = 11800
                    Printer.CurrentY = Y
                Case 14
                    Printer.CurrentX = 12800
                    Printer.CurrentY = Y
                Case 15
                    Printer.CurrentX = 13800
                    Printer.CurrentY = Y
                End Select
                
                grdRegistros.Col = i%
                If i% = 5 Then
                    Printer.Print Left$(grdRegistros.Text, 22);
                Else
                    Printer.Print grdRegistros.Text;
                End If
               End If
            Next i%
         Next j%
     
        Printer.FontSize = 17
        Printer.FontBold = True
        Printer.CurrentX = 350
        Printer.CurrentY = Y + 500
        Printer.Print String$(130, "-")
        Printer.EndDoc
        Screen.MousePointer = 0
       End If
       
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index%
        Case 0, 7, 10
            Clipboard.Clear
            Clipboard.SetText ""
    End Select
End Sub


