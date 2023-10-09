VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran202 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Actualización Crítica de Cuentas de Ahorros"
   ClientHeight    =   6630
   ClientLeft      =   615
   ClientTop       =   2055
   ClientWidth     =   9360
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
   HelpContextID   =   1061
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6630
   ScaleWidth      =   9360
   Tag             =   "3079"
   Begin VB.TextBox txtCampo 
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   250
      Index           =   21
      Left            =   1860
      MaxLength       =   1
      TabIndex        =   20
      Top             =   4860
      Width           =   435
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   3
      Left            =   1860
      MaxLength       =   4
      TabIndex        =   22
      Top             =   5475
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   13
      Left            =   1860
      MaxLength       =   4
      TabIndex        =   21
      Top             =   5490
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   16
      Left            =   1845
      MaxLength       =   15
      TabIndex        =   88
      Top             =   4080
      Visible         =   0   'False
      Width           =   3080
   End
   Begin VB.TextBox txtCampo 
      Height          =   700
      Index           =   15
      Left            =   6000
      MaxLength       =   40
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   16
      Top             =   3220
      Visible         =   0   'False
      Width           =   2355
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   18
      Left            =   1840
      MaxLength       =   1
      TabIndex        =   12
      Tag             =   "369"
      Top             =   3800
      Width           =   735
   End
   Begin MSMask.MaskEdBox Mskvalor 
      Height          =   285
      Left            =   6390
      TabIndex        =   32
      Top             =   1560
      Visible         =   0   'False
      Width           =   1845
      _ExtentX        =   3254
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin TxtinLib.TextValid txtTipoCta 
      Height          =   285
      Left            =   5640
      TabIndex        =   74
      Top             =   1290
      Visible         =   0   'False
      Width           =   735
      _Version        =   65536
      _ExtentX        =   1296
      _ExtentY        =   503
      _StockProps     =   253
      Appearance      =   1
      Range           =   ""
      MaxLength       =   1
      Character       =   0
      Type            =   3
      HelpLine        =   "Tipo de Cuenta [F5 Ayuda]"
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   19
      Left            =   6000
      MaxLength       =   1
      TabIndex        =   15
      Top             =   2900
      Width           =   675
   End
   Begin VB.Frame frmDirecciones 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   600
      Left            =   8490
      TabIndex        =   67
      Top             =   5370
      Visible         =   0   'False
      Width           =   150
      Begin Threed.SSOption optDireccion 
         Height          =   195
         Index           =   2
         Left            =   45
         TabIndex        =   36
         TabStop         =   0   'False
         Top             =   360
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Retener en sucursal del banco"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optDireccion 
         Height          =   195
         Index           =   1
         Left            =   45
         TabIndex        =   25
         TabStop         =   0   'False
         Top             =   120
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Enviar a casilla postal del cliente"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
      Begin Threed.SSOption optDireccion 
         Height          =   195
         Index           =   0
         Left            =   45
         TabIndex        =   35
         Top             =   140
         Visible         =   0   'False
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Enviar a dirección del cliente"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optDireccion 
         Height          =   195
         Index           =   3
         Left            =   45
         TabIndex        =   26
         TabStop         =   0   'False
         Top             =   360
         Visible         =   0   'False
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Retener en casillero del banco"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
      End
   End
   Begin VB.ComboBox cmbsaldocero 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   7560
      Style           =   2  'Dropdown List
      TabIndex        =   23
      Top             =   4350
      Visible         =   0   'False
      Width           =   675
   End
   Begin VB.ComboBox cmbenvioec 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1845
      Style           =   2  'Dropdown List
      TabIndex        =   17
      Top             =   4425
      Width           =   760
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   7
      Left            =   6000
      MaxLength       =   3
      TabIndex        =   14
      Top             =   2600
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   14
      Left            =   6000
      MaxLength       =   2
      TabIndex        =   31
      Top             =   3795
      Visible         =   0   'False
      Width           =   675
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   375
      Left            =   5040
      TabIndex        =   77
      Top             =   3400
      Visible         =   0   'False
      Width           =   3330
      Begin Threed.SSOption optcausa 
         Height          =   195
         Index           =   1
         Left            =   1800
         TabIndex        =   30
         TabStop         =   0   'False
         Top             =   120
         Width           =   1400
         _Version        =   65536
         _ExtentX        =   2469
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Canje de libreta"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optcausa 
         Height          =   195
         Index           =   0
         Left            =   150
         TabIndex        =   29
         Top             =   120
         Width           =   1470
         _Version        =   65536
         _ExtentX        =   2593
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Lev. Anulación"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
   End
   Begin VB.OptionButton optdir 
      Caption         =   "*Cheques Devueltos"
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
      Height          =   195
      Index           =   1
      Left            =   30
      TabIndex        =   19
      Top             =   5190
      WhatsThisHelpID =   5349
      Width           =   1815
   End
   Begin VB.OptionButton optdir 
      Caption         =   "*Estado de Cuenta"
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
      Height          =   195
      Index           =   0
      Left            =   30
      TabIndex        =   18
      Top             =   4905
      Value           =   -1  'True
      WhatsThisHelpID =   5348
      Width           =   1785
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   12
      Left            =   8820
      MaxLength       =   64
      TabIndex        =   71
      Top             =   5640
      Visible         =   0   'False
      Width           =   465
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   11
      Left            =   6930
      MaxLength       =   8
      TabIndex        =   24
      Top             =   1290
      Visible         =   0   'False
      Width           =   1245
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8430
      TabIndex        =   70
      Tag             =   "6335"
      Top             =   3450
      WhatsThisHelpID =   2009
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
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
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   9
      Left            =   1845
      MaxLength       =   2
      TabIndex        =   8
      Top             =   2600
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   8
      Left            =   1845
      MaxLength       =   2
      TabIndex        =   7
      Top             =   2300
      Width           =   735
   End
   Begin Threed.SSCheck chkFuncionario 
      Height          =   195
      Left            =   5040
      TabIndex        =   42
      Top             =   4120
      WhatsThisHelpID =   5361
      Width           =   2175
      _Version        =   65536
      _ExtentX        =   3837
      _ExtentY        =   344
      _StockProps     =   78
      Caption         =   "*Cuenta de funcionario"
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
      Enabled         =   0   'False
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   10
      Left            =   1840
      MaxLength       =   2
      TabIndex        =   11
      Top             =   3500
      Width           =   735
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2265
      TabIndex        =   0
      Top             =   15
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      AutoTab         =   -1  'True
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   6
      Left            =   6000
      MaxLength       =   2
      TabIndex        =   13
      Top             =   2300
      Width           =   675
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   879
      Left            =   0
      TabIndex        =   5
      Top             =   990
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   1550
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
      Cols            =   6
      FixedCols       =   0
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   380
      Index           =   1
      Left            =   8415
      TabIndex        =   4
      Tag             =   "369"
      Top             =   400
      WhatsThisHelpID =   2058
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   670
      _StockProps     =   78
      Caption         =   "*Eliminar"
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
      Height          =   380
      Index           =   0
      Left            =   8415
      TabIndex        =   3
      Tag             =   "369"
      Top             =   15
      WhatsThisHelpID =   2069
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   670
      _StockProps     =   78
      Caption         =   "*Añadir"
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
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   0
      Left            =   15
      MaxLength       =   8
      TabIndex        =   1
      Top             =   540
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   1
      Left            =   6705
      MaxLength       =   2
      TabIndex        =   2
      Top             =   540
      Width           =   375
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   2
      Left            =   1845
      MaxLength       =   64
      TabIndex        =   6
      Top             =   2000
      Width           =   6510
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   4
      Left            =   1845
      MaxLength       =   5
      TabIndex        =   9
      Tag             =   "368"
      Top             =   2900
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   5
      Left            =   1845
      MaxLength       =   2
      TabIndex        =   10
      Top             =   3200
      Width           =   735
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8430
      TabIndex        =   37
      Top             =   4215
      WhatsThisHelpID =   2007
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8430
      TabIndex        =   38
      Top             =   4980
      WhatsThisHelpID =   2003
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
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
      Index           =   4
      Left            =   8430
      TabIndex        =   39
      Top             =   5745
      WhatsThisHelpID =   2008
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
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
   Begin Threed.SSCheck chkApTasa 
      Height          =   195
      Left            =   5040
      TabIndex        =   44
      Top             =   4400
      Visible         =   0   'False
      WhatsThisHelpID =   5382
      Width           =   2160
      _Version        =   65536
      _ExtentX        =   3810
      _ExtentY        =   344
      _StockProps     =   78
      Caption         =   "*Aplica Tasa Corporat."
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
      Enabled         =   0   'False
   End
   Begin Crystal.CrystalReport rptReporte 
      Left            =   7680
      Top             =   360
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      WindowWidth     =   480
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
      PrintFileType   =   2
      WindowControls  =   -1  'True
      PrintFileLinesPerPage=   60
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8430
      TabIndex        =   76
      Tag             =   "6335"
      Top             =   2685
      Visible         =   0   'False
      WhatsThisHelpID =   2016
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Contrato"
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
   Begin VB.Frame Frame1dv 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   600
      Left            =   8640
      TabIndex        =   72
      Top             =   5400
      Visible         =   0   'False
      Width           =   150
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   2
         Left            =   45
         TabIndex        =   34
         TabStop         =   0   'False
         Top             =   360
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Retener en sucursal del banco"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   1
         Left            =   45
         TabIndex        =   27
         TabStop         =   0   'False
         Top             =   90
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Enviar a casilla postal del cliente"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   0
         Left            =   45
         TabIndex        =   33
         Top             =   140
         Visible         =   0   'False
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Enviar a dirección del cliente"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   3
         Left            =   45
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   360
         Visible         =   0   'False
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Retener en casillero del banco"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   375
      Index           =   7
      Left            =   8415
      TabIndex        =   86
      Top             =   790
      Visible         =   0   'False
      WhatsThisHelpID =   2070
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   661
      _StockProps     =   78
      Caption         =   "*Perfil Cta."
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
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Alianza:"
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   150
      TabIndex        =   95
      Top             =   6195
      Width           =   735
   End
   Begin VB.Label Lblalianza 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Left            =   1860
      TabIndex        =   94
      Top             =   6195
      Width           =   690
   End
   Begin VB.Label lbldesalianza 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   407
      Left            =   2625
      TabIndex        =   93
      Top             =   6195
      Width           =   5715
   End
   Begin VB.Label lblDescripcion 
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
      Height          =   255
      Index           =   22
      Left            =   2310
      TabIndex        =   92
      Top             =   4860
      Width           =   3405
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   555
      Index           =   6
      Left            =   2625
      TabIndex        =   91
      Top             =   5475
      Width           =   5130
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   555
      Index           =   14
      Left            =   2610
      TabIndex        =   90
      Top             =   5490
      Visible         =   0   'False
      Width           =   5130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fideicomiso:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   17
      Left            =   75
      TabIndex        =   89
      Top             =   4110
      Visible         =   0   'False
      WhatsThisHelpID =   5233
      Width           =   1140
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Patente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   16
      Left            =   5040
      TabIndex        =   87
      Top             =   3225
      Visible         =   0   'False
      WhatsThisHelpID =   5152
      Width           =   810
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Titularidad:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   15
      Left            =   75
      TabIndex        =   85
      Top             =   3825
      WhatsThisHelpID =   5151
      Width           =   1050
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   20
      Left            =   2595
      TabIndex        =   84
      Top             =   3800
      Width           =   2325
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   500
      Index           =   13
      Left            =   6690
      TabIndex        =   83
      Top             =   2895
      Width           =   1665
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cl. Cliente"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   18
      Left            =   5040
      TabIndex        =   82
      Top             =   2895
      WhatsThisHelpID =   5263
      Width           =   960
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Sldo Cero:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   27
      Left            =   7320
      TabIndex        =   81
      Top             =   4110
      Visible         =   0   'False
      WhatsThisHelpID =   5201
      Width           =   975
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Generar Est.Cta.:"
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
      Index           =   22
      Left            =   75
      TabIndex        =   80
      Top             =   4440
      WhatsThisHelpID =   5264
      Width           =   1380
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   10
      Left            =   6690
      TabIndex        =   58
      Top             =   2600
      Width           =   1665
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Causa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   21
      Left            =   5040
      TabIndex        =   79
      Top             =   3795
      Visible         =   0   'False
      WhatsThisHelpID =   5155
      Width           =   675
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
      ForeColor       =   &H000000FF&
      Height          =   285
      Index           =   16
      Left            =   6690
      TabIndex        =   78
      Top             =   3795
      Visible         =   0   'False
      Width           =   1665
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Código de dirección:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   19
      Left            =   60
      TabIndex        =   73
      Top             =   5460
      Visible         =   0   'False
      WhatsThisHelpID =   5260
      Width           =   1845
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   12
      Left            =   2595
      TabIndex        =   69
      Top             =   2600
      Width           =   2325
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Origen cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   14
      Left            =   75
      TabIndex        =   68
      Top             =   2595
      WhatsThisHelpID =   5256
      Width           =   1350
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Rol:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   6720
      TabIndex        =   59
      Top             =   345
      WhatsThisHelpID =   5253
      Width           =   435
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cliente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   60
      TabIndex        =   60
      Top             =   345
      WhatsThisHelpID =   5252
      Width           =   735
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   60
      TabIndex        =   61
      Top             =   810
      WhatsThisHelpID =   5055
      Width           =   1890
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Bancario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   75
      TabIndex        =   62
      Top             =   2295
      WhatsThisHelpID =   5176
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   11
      Left            =   2595
      TabIndex        =   63
      Top             =   2300
      Width           =   2325
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Código de dirección:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   60
      TabIndex        =   65
      Top             =   5460
      Width           =   1770
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Dirección:"
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
      Index           =   13
      Left            =   75
      TabIndex        =   66
      Top             =   4695
      WhatsThisHelpID =   5259
      Width           =   855
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo capitalización:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   75
      TabIndex        =   64
      Top             =   3525
      WhatsThisHelpID =   5258
      Width           =   1755
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   1
      Left            =   7185
      TabIndex        =   57
      Top             =   15
      Width           =   1170
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha de corte estado cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   4500
      TabIndex        =   56
      Top             =   0
      WhatsThisHelpID =   5255
      Width           =   2715
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   3
      Left            =   2460
      TabIndex        =   55
      Top             =   540
      UseMnemonic     =   0   'False
      Width           =   300
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -45
      X2              =   8355
      Y1              =   1930
      Y2              =   1930
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   9
      Left            =   6690
      TabIndex        =   54
      Top             =   2300
      Width           =   1665
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   8
      Left            =   2595
      TabIndex        =   53
      Top             =   3200
      Width           =   2325
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   7
      Left            =   2595
      TabIndex        =   52
      Top             =   2900
      Width           =   2325
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ciclo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   5040
      TabIndex        =   51
      Top             =   2295
      WhatsThisHelpID =   5261
      Width           =   570
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   5040
      TabIndex        =   50
      Top             =   2595
      WhatsThisHelpID =   5262
      Width           =   990
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo de promedio:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   75
      TabIndex        =   49
      Top             =   3210
      WhatsThisHelpID =   5257
      Width           =   1620
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficial de cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   75
      TabIndex        =   48
      Top             =   2895
      WhatsThisHelpID =   5014
      Width           =   1605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   75
      TabIndex        =   47
      Top             =   2000
      WhatsThisHelpID =   5017
      Width           =   1725
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8385
      Y1              =   330
      Y2              =   315
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   5
      Left            =   7095
      TabIndex        =   46
      Top             =   540
      Width           =   1260
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   4
      Left            =   2775
      TabIndex        =   45
      Top             =   540
      UseMnemonic     =   0   'False
      Width           =   3915
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   2
      Left            =   1005
      TabIndex        =   43
      Top             =   540
      UseMnemonic     =   0   'False
      Width           =   1440
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   41
      Top             =   15
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   6465
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   2595
      TabIndex        =   40
      Top             =   3500
      Width           =   2325
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   15
      Left            =   2595
      TabIndex        =   75
      Top             =   3500
      Visible         =   0   'False
      Width           =   2325
   End
End
Attribute VB_Name = "FTran202"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'*************************************************************
' ARCHIVO:          FTRAN202.frm
' NOMBRE LOGICO:    FTran202
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
' Permite la actualización crítica de valores establecidos
' para una Cuenta de Ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 10-Ago-06      H. Ayarza       Manejo de Direccion x
'                                Catalogo
'*************************************************************
Dim VLNumero As Integer
Dim VLTitular As Integer
Public VLPaso As Integer
Dim VLTipoEnte As String
Dim VLEnte As Integer
Dim VLCedula1 As String
Dim VLCotitular As String
Dim VLTraslado As String
Dim VLTipoEnteTitular As String
Dim VLCodTitular As Long
Dim VLNumLib As String
Dim VTNumLib As Long

Dim VLCuenta0 As String

Dim VTMatrizprop() As String
Dim VLContadorprop As Integer
Dim VLTipoDireccion(2, 2) As String

Dim Roles() As String
Dim XT As Integer


Private Sub cmbenvioec_Click()
  optdir(0).Enabled = IIf(cmbenvioec.Text = "N", False, True)
  If cmbenvioec.Text = "N" Then
    optdir(1).Value = True
  Else
    optdir(0).Value = True
  End If
End Sub
Private Sub cmbsaldocero_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Permitir Saldo Cero a la cuenta"
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    If txtCampo(11).Text = "" Then
        VTNumLib& = 0
    Else
        VTNumLib& = CLng(txtCampo(11).Text)
    End If

    Select Case Index%
    Case 0
        PLAniadir
    Case 1
        PLEliminar
    Case 2
        PLTransmitir
    Case 3
        PLLimpiar
    Case 4
        Unload FTran202
    Case 5
        PLImprimir
    Case 6
        'PLReporteApertura
    Case 7
        VGProducto$ = "AHO"
        Fdatadi.Show
        Fdatadi!mskCuenta.Mask = VGMascaraCtaAho$
        'Fdatadi!mskCuenta.Text = Format$(lblDescripcion(0), VGMascaraCtaAho$)
        Fdatadi!mskCuenta.Text = mskCuenta.Text 'lblDescripcion(0)
    End Select
End Sub

Private Sub plAlianza()
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q" '"H"
     PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, VLCodTitular
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1181"  '"1225"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
       ReDim VTValores(15) As String
       VTR1% = FMMapeaArreglo(sqlconn&, VTValores())
       PMMapeaVariable sqlconn&, VLAlianza$
       PMMapeaVariable sqlconn&, VLDesAlianza$
       PMChequea sqlconn&
       Lblalianza.Caption = VLAlianza$
       lbldesalianza.Caption = VLDesAlianza$
     Else
       Lblalianza.Caption = ""
       lbldesalianza.Caption = ""
     End If
End Sub
Private Sub Form_Load()
    FTran202.Left = 0
    FTran202.Top = 0
    FTran202.Width = 9450
    FTran202.Height = 7140
    PMLoadResStrings Me
    PMLoadResIcons Me
    VLNumero% = 0
    VLTitular% = 0
    'PMCatalogo "D", "cl_rol", txtCampo(1), lblDescripcion(5)
    mskCuenta.Mask = VGMascaraCtaAho$
    mskValor.MaxLength = 14
    cmdBoton(2).Enabled = False
    'cmdBoton(3).Enabled = False
    VLEnte% = True
    VLTope% = 0
    VLCedula1$ = ""
    VLCotitular$ = "0"
    'txtpromotor.Connection = VGMap
    'Set txtpromotor.AsociatedLabel = lblDescripcion(13)
    'txtpromotor.TableName = "cl_promotor"
    
    txtTipoCta.Connection = VGMap
    Set txtTipoCta.AsociatedLabel = lblDescripcion(15)
    txtTipoCta.TableName = "cc_tipocta_super"
    
    optcausa(0).Value = False
    optcausa(1).Value = False
    
    cmbenvioec.Clear
    cmbenvioec.AddItem "S"
    cmbenvioec.AddItem "N"
    cmbenvioec.ListIndex = 1
    
    txtCampo(14).Enabled = False
    
    cmbsaldocero.AddItem "N", 0
    cmbsaldocero.AddItem "S", 1
    cmbsaldocero.ListIndex = 0
    
    'HA20060826
    For n% = 0 To UBound(VLTipoDireccion, 1) - 1
      For C% = 0 To UBound(VLTipoDireccion, 2) - 1
        VLTipoDireccion(n%, C%) = ""
      Next C%
    Next n%
    
    optdir(1).Value = True
    optdir_Click (1)
    
    txtCampo(21) = ""
    lblDescripcion(22) = ""
    Call PMObjetoSeguridad(txtCampo(4))
    Call PMObjetoSeguridad(txtCampo(18))
    Call PMObjetoSeguridad(cmdBoton(0))
    Call PMObjetoSeguridad(cmdBoton(1))
    If VGCodPais$ = "PA" Then
        lblEtiqueta(16).Visible = True
        lblEtiqueta(17).Visible = True
        txtCampo(15).Visible = True
        txtCampo(16).Visible = True
        chkApTasa.Visible = True
        lblEtiqueta(27).Visible = True
        cmbsaldocero.Visible = True
        cmdBoton(7).Visible = True
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
    
''Captura del titular de la cuenta
    grdPropietarios.Col = 5
    VTTitular$ = grdPropietarios.Text
    
''Solo permitirá borrar los valores respectivos
''si se pretende cambiar los datos del titular
''de la cuenta

'HA20060814 uso de catalogo de direcciones
If VTTitular$ = "T" Then
  If optdir(1).Value = False Then
    If VLTipoDireccion(0, 0) = "D" Then
      txtCampo(3).Text = ""
      lblDescripcion(6).Caption = ""
    End If
  Else
    If VLTipoDireccion(1, 0) = "D" Then
      txtCampo(13).Text = ""
      lblDescripcion(14).Caption = ""
    End If
  End If
End If
End Sub
Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub
Private Sub cmbenvioec_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Opción de Envío de Estado de Cuenta (S/N)"
End Sub



Private Sub mskCuenta_Change()
    VLPaso% = False
End Sub
Public Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta de ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
    VLPaso% = False 'True
End Sub
Public Sub mskCuenta_LostFocus()
    Dim VTAplicaTasa As String
    On Error Resume Next
    If VLPaso% = False Then
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "299"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_up_ah", True, " Ok... Consulta de la cuenta de ahorros") Then
                    ReDim Valores(8, 40) As String
                    VTR% = FMMapeaMatriz(sqlconn&, Valores())
                    PMLimpiaGrid grdPropietarios
                    grdPropietarios.Cols = 8
                    For i% = 1 To VTR%
                        If Valores(1, i%) <> "" Then
                            VLCed$ = Valores(1, i%)
                        Else
                            VLCed$ = Valores(2, i%)
                        End If
                        grdPropietarios.AddItem Str$(i%) & Chr(9) & Valores(0, i%) & Chr(9) & VLCed$ & Chr(9) & Valores(3, i%) & Chr(9) & Valores(4, i%) & Chr(9) & Valores(5, i%) & Chr(9) & Valores(6, i%) & Chr(9) & Valores(7, i%)
                    Next i%
                    If grdPropietarios.Rows > 2 Then
                        grdPropietarios.RemoveItem 1
                    End If
                    grdPropietarios.ColWidth(0) = 1
                    grdPropietarios.ColWidth(1) = 960
                    grdPropietarios.ColWidth(2) = 1440
                    grdPropietarios.ColWidth(3) = 300
                    grdPropietarios.ColWidth(4) = 3915
                    grdPropietarios.ColWidth(5) = 375
                    grdPropietarios.ColWidth(6) = 1230
                    grdPropietarios.ColWidth(7) = 1
                    grdPropietarios.Row = 0
                    grdPropietarios.Col = 1
                    grdPropietarios.Text = "CODIGO"
                    grdPropietarios.Col = 2
                    grdPropietarios.Text = "IDENTIFICACION"
                    grdPropietarios.Col = 3
                    grdPropietarios.Text = "TP."
                    grdPropietarios.Col = 4
                    grdPropietarios.Text = "NOMBRE"
                    grdPropietarios.Col = 5
                    grdPropietarios.Text = "TIT."
                    grdPropietarios.Col = 6
                    grdPropietarios.Text = "DESCRIPCION"
                    ReDim VTArreglo(40) As String
                    VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                    PMMapeaObjetoAB sqlconn&, txtCampo(4), lblDescripcion(7)
                    PMMapeaObjetoAB sqlconn&, txtCampo(5), lblDescripcion(8)
                    PMMapeaObjetoAB sqlconn&, txtCampo(6), lblDescripcion(9)
                    PMMapeaObjetoAB sqlconn&, txtCampo(7), lblDescripcion(10)
                    txtCampo(7).Enabled = False
                    PMMapeaObjetoAB sqlconn&, txtCampo(10), lblDescripcion(0)
                    txtCampo(10).Enabled = False
                    PMMapeaObjetoAB sqlconn&, txtCampo(8), lblDescripcion(11)
                    PMMapeaObjetoAB sqlconn&, txtCampo(9), lblDescripcion(12)
                    PMMapeaObjetoAB sqlconn&, txtCampo(18), lblDescripcion(20) 'titularidad

                    PMMapeaObjeto sqlconn&, txtCampo(11)
                    PMMapeaVariable sqlconn&, VLValor$
                    PMMapeaVariable sqlconn&, VLDepIni$
                    PMMapeaVariable sqlconn&, VLCotitular$
                    'PMMapeaObjetoAB SqlConn&, txtpromotor, lblDescripcion(13)
                    PMMapeaVariable sqlconn&, VLTraslado$
                    
             
                    PMMapeaVariable sqlconn&, VTAplicaTasa$
        
                    'PMMapeaObjeto SqlConn&, txtTipoCta
                    PMMapeaVariable sqlconn&, VTEnvioEC$
                    PMMapeaObjeto sqlconn&, txtTipoCta
                    PMMapeaVariable sqlconn&, VTEnvioEC$
                    PMMapeaVariable sqlconn&, VTPermiteSldCero$
                    'PMMapeaVariable sqlconn&, VTalianza$
                    'PMMapeaVariable sqlconn&, VTdesalianza$
                    'PMMapeaVariable SqlConn&, VTPermiteSldCero$
                    PMMapeaObjetoAB sqlconn&, txtCampo(19), lblDescripcion(13)
                    
                    PMMapeaVariable sqlconn&, VTPatente$
                    
                    If txtTipoCta.Enabled Then txtTipoCta.SetFocus
                    'txtpromotor.SetFocus
                    txtCampo(0).SetFocus
                    mskValor.Text = VLValor$
                    PMChequea sqlconn&
                    
                    VLNumLib = txtCampo(11)
                    
                     grdPropietarios.Row = 1
                     grdPropietarios.Col = 1
                     VLCodTitular = grdPropietarios.Text
                     plAlianza
                    'Lblalianza.Caption = VTalianza$
                    
                    'lbldesalianza.Caption = VTdesalianza$
                    
                    If VTEnvioEC$ = "N" Then
                        cmbenvioec.ListIndex = 1
                    Else
                        cmbenvioec.ListIndex = 0
                    End If
                    
                    If VTPermiteSldCero$ = "S" Then
                        cmbsaldocero.ListIndex = 1
                    Else
                        cmbsaldocero.ListIndex = 0
                    End If
                    
                    If VTAplicaTasa$ = "S" Then
                       chkApTasa.Value = True
                    Else
                       chkApTasa.Value = False
                    End If
                    
                    If VLDepIni$ = "0" Then
                        mskValor.Enabled = False
                    Else
                        mskValor.Enabled = True
                    End If
                    cmdBoton(2).Enabled = True
                    cmdBoton(3).Enabled = True
                    lblDescripcion(1).Caption = VTArreglo(8)
                    txtCampo(5).Enabled = False
                    txtCampo(8).Enabled = False
                    VLNumero% = grdPropietarios.Rows - 1
                    grdPropietarios.Row = 1
                    grdPropietarios.Col = 5
                    For i% = 1 To grdPropietarios.Rows - 1
                       grdPropietarios.Row = i%
                       If grdPropietarios.Text = "T" Then
                          VLTitular% = grdPropietarios.Row
                          grdPropietarios.Col = 1
                          VLCodTitular = grdPropietarios.Text
                          grdPropietarios.Col = 3
                          VLTipoEnteTitular$ = grdPropietarios.Text
                          VTNoDatos% = 0
                          Exit For
                       Else
                           VTNoDatos% = 1
                       End If
                    Next i%
                    If VTNoDatos% = 1 Then
                       PLLimpiar
                       Exit Sub
                    End If
                    grdPropietarios.ColWidth(0) = 1
                    grdPropietarios.ColWidth(1) = 960
                    grdPropietarios.ColWidth(2) = 1440
                    grdPropietarios.ColWidth(3) = 300
                    grdPropietarios.ColWidth(4) = 3915
                    grdPropietarios.ColWidth(5) = 375
                    grdPropietarios.ColWidth(6) = 1230
                    txtCampo(2).Text = VTArreglo(1)
                    txtCampo(2).Enabled = False 'True
                    txtCampo(12).Text = VTArreglo(9)
                    VLCedula1$ = VTArreglo(10)

                    optdir(0).Value = True
                    PLlblEtiqueta VTArreglo(2)
                    optdir(1).Value = True
                    PLlblEtiqueta VTArreglo(11)
                    
                    Dim objTxt As TextBox
                    Dim objLbl As Label
                    Set objTxt = txtCampo(21)
                    Set objLbl = lblDescripcion(22)
                                        
                    If VTArreglo(2) <> "" Then
                      VLTipoDireccion(0, 0) = VTArreglo(2)
                      If VTArreglo(2) <> "N" And VTArreglo(2) <> "L" Then
                        objTxt.Text = VTArreglo(2)
                        PMCatalogo "V", "cl_direccion_ec", objTxt, objLbl
                        VLTipoDireccion(0, 1) = objLbl.Caption
                      Else
                        VLTipoDireccion(0, 1) = VTArreglo(4)
                      End If
                    End If
                      
                    If VTArreglo(11) <> "" Then
                      VLTipoDireccion(1, 0) = VTArreglo(11)
                      objTxt.Text = VTArreglo(11)
                      PMCatalogo "V", "cl_direccion_ec", objTxt, objLbl
                      VLTipoDireccion(1, 1) = objLbl.Caption
                    End If

                    Set objTxt = Nothing
                    Set objLbl = Nothing

                    Select Case VTArreglo(2)
                    Case "D"
                        txtCampo(3).Text = VTArreglo(3)
                        lblDescripcion(6).Caption = VTArreglo(4)
                        txtCampo(3).Tag = VTArreglo(5)
                    Case "C"
                        txtCampo(3).Text = VTArreglo(3)
                        lblDescripcion(6).Caption = VTArreglo(4)
                        txtCampo(3).Tag = VTArreglo(5)
                    Case "R"
                        txtCampo(3).Text = VTArreglo(6)
                        lblDescripcion(6).Caption = VTArreglo(4)
                        txtCampo(3).Tag = VTArreglo(5)
                    Case "S"
                        txtCampo(3).Text = Mid$(VTArreglo(4), 13, Len(VTArreglo(4)))
                        txtCampo(3).Tag = VTArreglo(5)
                    Case Else 'NO CATALOGADO
                        txtCampo(3).Text = VTArreglo(3)
                        lblDescripcion(6).Caption = VTArreglo(4)
                        txtCampo(3).Tag = VTArreglo(5)
                    End Select
                    
                    ' Cheques devueltos
                    Select Case VTArreglo(11)
                    Case "D"
                        txtCampo(13).Text = VTArreglo(12)
                        lblDescripcion(14).Caption = VTArreglo(13)
                        txtCampo(13).Tag = VTArreglo(14)
                    Case "C"
                        txtCampo(13).Text = VTArreglo(12)
                        lblDescripcion(14).Caption = VTArreglo(13)
                        txtCampo(13).Tag = VTArreglo(14)
                    Case "R"
                        txtCampo(13).Text = VTArreglo(15)
                        lblDescripcion(14).Caption = VTArreglo(13)
                        txtCampo(13).Tag = VTArreglo(14)
                    Case "S"
                        txtCampo(13).Text = Mid$(VTArreglo(13), 13, Len(VTArreglo(13)))
                        txtCampo(13).Tag = VTArreglo(14)
                    End Select
                    
                    If VTArreglo(2) <> "" And VTEnvioEC$ = "S" Then
                      Call optdir_GotFocus(0)
                      Call optdir_Click(0)
                    ElseIf VTArreglo(11) <> "" Then
                      Call optdir_GotFocus(1)
                      Call optdir_Click(1)
                    Else
                      optdir(0).Value = False
                      optdir(1).Value = False
                    End If
                    
                    'Determinar si una cuenta es de funcionario
                    If VTArreglo(7) = "S" Then
                        chkFuncionario.Value = True
                    Else
                        chkFuncionario.Value = False
                    End If
                    
                    If txtCampo(4).Text = "" Then
                        MsgBox "OFICIAL NO EXISTE. POR FAVOR ACTUALIZAR.", 0 + 16, "Mensaje de Error"
                        lblDescripcion(7).Caption = ""
                    End If
                    
                    txtTipoCta.Enabled = False 'lgr
                    
                    cmdBoton(7).Enabled = True 'LBM
                    
                    'Solo permite cambiar la clase de cliente si la cuenta es de tipo
                    'Comercial
                    If VTArreglo(16) = "P" Then
                        txtCampo(19).Enabled = False
                    End If
                    If VGCodPais$ = "PA" Then
                        txtCampo(15).Text = VTPatente$
                        txtCampo(16).Text = VTArreglo(17)
                    Else
                        VTPatente$ = " "
                    End If
                Else
                    PLLimpiar
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                PLLimpiar
                Exit Sub
            End If
        Else
            txtCampo(7).Text = ""
            lblDescripcion(10).Caption = ""
        End If
        'cmdBoton(0).Enabled = True    'Añadir
        'cmdBoton(1).Enabled = True    'Limpiar
      'Para Perzonalizacion del Banco del Caribe Nombres Titular y Cotitular de la Cuenta
       If VLEnte% = True Then
         grdPropietarios.Col = 3
         VLTipoEnte$ = grdPropietarios.Text
         For i% = 1 To (grdPropietarios.Rows - 1)
           grdPropietarios.Row = i%
           If (grdPropietarios.Text) = "C" Then
               VLTipoEnte$ = grdPropietarios.Text
               grdPropietarios.Col = 5
               If (Trim$(grdPropietarios.Text) = "T") Then
                  Exit For
               End If
           End If
         Next i%
         VLEnte% = False
         'If VLTipoEnte$ = "I" Then
         '  txtCampo(8).Enabled = False
         'Else
         '  txtCampo(8).Enabled = True
         'End If
       End If
    End If
End Sub
Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Monto Inicial Apertura"
    mskValor.Text = Format$(mskValor.Text)
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
    mskValor.MaxLength = 14
End Sub
Private Sub mskValor_KeyPress(KeyAscii As Integer)
    If VGDecimales$ = "#,##0" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Else
        If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End If
End Sub
Private Sub optcausa_GotFocus(Index As Integer)
    If Index = 0 Then
        txtCampo(14).Text = ""
        lblDescripcion(16).Caption = ""
        txtCampo(14).Enabled = False
    Else
        txtCampo(14).Enabled = True
    End If
End Sub
Private Sub optdir_Click(Index As Integer)
  'Selecciona entre direccion de estado de cuenta y direccion de cheques devueltos
  'Actualizado HA20060810
  If Index = 0 Then 'Estado de cuenta
    txtCampo(3).Visible = True
    txtCampo(13).Visible = Not txtCampo(3).Visible
    lblDescripcion(6).Visible = True
    lblDescripcion(14).Visible = Not lblDescripcion(6).Visible
    lblEtiqueta(12).Visible = True
    lblEtiqueta(19).Visible = Not lblEtiqueta(12).Visible
    txtCampo(21).Text = VLTipoDireccion(Index, 0)
    lblDescripcion(22).Caption = VLTipoDireccion(Index, 1)
  Else              'Cheques devueltos
    txtCampo(13).Visible = True
    txtCampo(3).Visible = Not txtCampo(13).Visible
    lblDescripcion(14).Visible = True
    lblDescripcion(6).Visible = Not lblDescripcion(14).Visible
    lblEtiqueta(19).Visible = True
    lblEtiqueta(12).Visible = Not lblEtiqueta(19).Visible
    txtCampo(21).Text = VLTipoDireccion(Index, 0)
    lblDescripcion(22).Caption = VLTipoDireccion(Index, 1)
  End If
End Sub
Private Sub optdir_GotFocus(Index As Integer)
  optdir(Index).Value = True
End Sub

Private Sub PLAniadir()
'*************************************************************
' PROPOSITO: Permite añadir un propietario al grid
'            propietarios de la cuenta, controlando que exista
'            un solo propietario con el rol de Alternante.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    ' Se añade la validacion de que existan hasta 20 propietarios por el sp_validar_titularidad
    ' creado para la version global bank
    If grdPropietarios.Rows - 1 >= 20 Then
        MsgBox "Solo puede ingresar hasta 20 Propietarios", vbInformation
        Exit Sub
    End If

    ' Codigo de cuenta de ahorros
    If mskCuenta.ClipText = "" Then
        MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        If mskCuenta.Enabled Then mskCuenta.SetFocus
        Exit Sub
    End If

    ' Codigo de cliente
    If txtCampo(0).Text = "" Then
        MsgBox "El código del cliente es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled Then txtCampo(0).SetFocus
        Exit Sub
    End If

    ' Nombre del cliente
    If lblDescripcion(4).Caption = "" Then
        MsgBox "El nombre del cliente es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    ' Tipo de Cliente
    If lblDescripcion(3).Caption = "" Then
        MsgBox "El tipo de cliente es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    ' Codigo del rol cliente
    If txtCampo(1).Text = "" Then
        MsgBox "El código del rol del cliente es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
    End If
                            
    ' La cuenta solo puede tener un titular
    If txtCampo(1).Text = "T" Then
        MsgBox "La cuenta de ahorros solo puede tener un titular", 0 + 16, "Mensaje de Error"
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(3).Caption = ""
        lblDescripcion(4).Caption = ""
        lblDescripcion(5).Caption = ""
        txtCampo(0).SetFocus
        Exit Sub
    End If
    
    ' Validar que no se puedan Add. Tutores desde la pantalla de actualizacion de ctas.
    If txtCampo(1).Text = "U" Then
        MsgBox "No es Posible Asignar un Tutor desde esta Pantalla", vbInformation
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(3).Caption = ""
        lblDescripcion(4).Caption = ""
        lblDescripcion(5).Caption = ""
        txtCampo(0).SetFocus
        Exit Sub
    End If
    
    ' si el titular es juridico no pueden existir cotitulares personas
    VLTiEnteTitular = ""
    VLRol = ""
    For i% = 1 To grdPropietarios.Rows
        grdPropietarios.Row = i%
        grdPropietarios.Col = 5
        If grdPropietarios.Text = "T" Then
            grdPropietarios.Col = 3
            VLTiEnteTitular = grdPropietarios.Text
            grdPropietarios.Col = 5
            VLRol = grdPropietarios.Text
            Exit For
        End If
    Next i%
    If VLTiEnteTitular = "C" Then ' si el titular es compania
        If Trim$(txtCampo(1).Text) = "C" Then ' si quieren ingresar un cotitular
            MsgBox "El Titular es Persona Juridica por tanto no puede tener cotitulares", 0 + 16, "Mensaje de Error"
            If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).SetFocus
            Exit Sub
        End If
        If lblDescripcion(3) = "C" And Trim$(txtCampo(1).Text) = "F" Then
            MsgBox "Persona Juridica solo puede ser titular", 0 + 16, "Mensaje de Error"
            If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).SetFocus
            Exit Sub

        End If
    
    End If

''    If (lblDescripcion(3).Caption = "C") And (txtCampo(1).Text <> "T") Then
''        MsgBox "La empresa siempre debe ser un titular", 0 + 16, "Mensaje de Error"
''        If txtCampo(1).Enabled Then txtCampo(1).SetFocus
''        Exit Sub
''    End If
                                
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "208"
    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
    PMPasoValores sqlconn&, "@o_det_prod", 1, SQLINT4, "1"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_propietarios_ctahorro", False, "") Then
       PMChequea sqlconn&
       VTResult& = CLng(FMRetParam(sqlconn&, 1))
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "296"
       PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
       PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
       PMPasoValores sqlconn&, "@i_dprod", 0, SQLINT4, Str$(VTResult&)
       PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (txtCampo(0).Text)
       PMPasoValores sqlconn&, "@i_rolcli", 0, SQLCHAR, (txtCampo(1).Text)
       PMPasoValores sqlconn&, "@i_cedruc", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
       If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_propietarios_ctahorro", True, " Ok... Ingreso del propietario " & "[" & txtCampo(0).Text & "]") Then
          PMChequea sqlconn&
          grdPropietarios.AddItem Str$(VLNumero% + 1) & Chr$(9) & txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero% + 1
          txtCampo(0).SetFocus
          VLNumero% = VLNumero% + 1
          txtCampo(0).Text = ""
          txtCampo(1).Text = ""
          lblDescripcion(2).Caption = ""
          lblDescripcion(3).Caption = ""
          lblDescripcion(4).Caption = ""
          lblDescripcion(5).Caption = ""
          PMCatalogo "D", "cl_rol", txtCampo(1), lblDescripcion(5)
       Else
          txtCampo(0).SetFocus
          txtCampo(0).Text = ""
          lblDescripcion(2).Caption = ""
          lblDescripcion(3).Caption = ""
          lblDescripcion(4).Caption = ""
          txtCampo(1).Text = ""
          lblDescripcion(5).Caption = ""
       End If
    End If
End Sub

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Rutina que permite eliminar un propietario del grid
'            propietarios de la cuenta, controlando que el cliente
'            a eliminar no sea Titular.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    grdPropietarios.Col = 5
    
    If mskCuenta.ClipText = "" Then
        MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
        Exit Sub
    End If
    
    If grdPropietarios.Text = "T" Then
       MsgBox "No se puede eliminar el titular de la cuenta de ahorros", 0 + 16, "Mensaje de Error"
       If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
       Exit Sub
    End If
    
    If grdPropietarios.Text = "U" And VGCodPais$ = "CO" Then
       MsgBox "No se puede eliminar el tutor de la cuenta de ahorros. Remitase al modulo de clientes", 0 + 16, "Mensaje de Error"
       If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
       Exit Sub
    End If
        
    'Verificar el manejo de menores de edad
    VTFila = grdPropietarios.Row
    If Not FLVerificarMenor(grdPropietarios.Row) Then
       Exit Sub
    End If
            
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "208"
    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
    PMPasoValores sqlconn&, "@o_det_prod", 1, SQLINT4, "1"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_propietarios_ctahorro", False, "") Then
        PMChequea sqlconn&
        VTResult& = Val(FMRetParam(sqlconn&, 1))
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "295"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_dprod", 0, SQLINT4, Str$(VTResult&)
        grdPropietarios.Col = 1
        grdPropietarios.Row = VTFila
        PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_propietarios_ctahorro", True, " Ok... Eliminación del propietario " & "[" & grdPropietarios.Text & "]") Then
            PMChequea sqlconn&
            grdPropietarios.Col = 1
            If grdPropietarios.Text = VLCotitular$ Then
                txtCampo(12).Text = ""
                VLCotitular$ = "0"
                PLTransmitir
            End If
            txtCampo(0).SetFocus
            VLNumero% = VLNumero% - 1
            grdPropietarios.RemoveItem grdPropietarios.Row
            grdPropietarios.SelStartRow = grdPropietarios.Row
            grdPropietarios.SelEndRow = grdPropietarios.Row
        End If
     Else
        txtCampo(0).SetFocus
        txtCampo(0).Text = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(3).Caption = ""
        lblDescripcion(4).Caption = ""
        txtCampo(1).Text = ""
        lblDescripcion(5).Caption = ""
    End If
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Imprime los valores ingresados en la Actualización
'            de la Cuenta de Ahorros.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    If frmDirecciones.Visible = True Then
        If VLTipoDireccion(0, 0) = "D" Then
            VTTipo$ = lblDescripcion(6).Caption
        ElseIf VLTipoDireccion(0, 0) = "C" Then
            VTTipo$ = "Casilla : " & lblDescripcion(6).Caption
        ElseIf VLTipoDireccion(0, 0) = "R" Then
            VTTipo$ = "Sucursal : " & lblDescripcion(6).Caption '"Agencia : " & lblDescripcion(6).Caption
        ElseIf VLTipoDireccion(0, 0) = "S" Then
            VTTipo$ = "Casillero : " & txtCampo(3).Text
        End If
    End If

    If MsgBox("¿Está seguro de imprimir los datos de actualización?", 1 + 32 + 0, "Mensaje del Sistema") = 1 Then
        Screen.MousePointer = 11
        FMCabeceraReporte VGBanco$, Date, "ACTUALIZACIÓN DE DATOS DE CUENTA DE AHORROS", _
                          Time(), Me.Caption, VGFecha$, 1 'Printer.Page
        Printer.Font = "Courier"
        Printer.FontSize = 8
        Printer.Print "      Número de Cuenta :"; Tab(35); mskCuenta.Text
        Printer.Print ""
        Printer.Print "      Nombre de la Cuenta :"; Tab(35); txtCampo(2).Text
        Printer.Print ""
        Printer.Print "      Producto bancario :"; Tab(35); lblDescripcion(11).Caption
        Printer.Print ""
        Printer.Print "      Origen de la cuenta :"; Tab(35); lblDescripcion(12).Caption
        Printer.Print ""
        If frmDirecciones.Visible = True Then
            Printer.Print "      Dirección estado de cuenta :"; Tab(35); VTTipo$ & lblDescripcion(6).Caption
            Printer.Print ""
        End If
        Printer.Print "      Oficial de cuenta :"; Tab(35); lblDescripcion(7).Caption
        Printer.Print ""
        Printer.Print "      Tipo de promedio :"; Tab(35); lblDescripcion(8).Caption
        Printer.Print ""
        Printer.Print "      Ciclo de la cuenta :"; Tab(35); lblDescripcion(9).Caption
        Printer.Print ""
        Printer.Print "      Tipo de capitalización :"; Tab(35); lblDescripcion(0).Caption
        Printer.Print ""
        Printer.Print "      Categoría de la cuenta :"; Tab(35); lblDescripcion(10).Caption
        Printer.Print ""
        Printer.Print "      Titularidad :"; Tab(35); lblDescripcion(20).Caption
        Printer.Print ""
        Printer.Print "      Enviar Estado de Cuenta :"; Tab(35); cmbenvioec.Text
        Printer.Print ""
        If VGCodPais$ = "PA" Then
            Printer.Print "      Patente                        :"; Tab(35); txtCampo(15).Text
            Printer.Print ""
            Printer.Print "      Fideicomiso                    :"; Tab(35); txtCampo(16).Text
            Printer.Print ""
        End If
        Printer.FontBold = True

        Printer.Print String$(125, "_")
                               
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "      _________________                                                  _________________"
        Printer.Print "        PROCESADO POR                                                     VERIFICADO POR "
        Printer.Print ""
        Printer.Print ""
'        If VGCodPais$ <> "CO" Then
'            Printer.Print "---  U L T I M A   L I N E A  ---"
'        End If
        Printer.EndDoc
        Screen.MousePointer = 0
    End If
End Sub
Private Sub PLProcesarPropietarios(ByVal ParTipoPropietario As String, ByVal ParPrincipal As Integer)
'*************************************************************
' PROPOSITO: Realizar el ordenamiento segun el tipo de propietario
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 13-Jul-05      L. Bernuil      Ajustes en el contrato de Apertura
' 15-Abr-08      J. Robalino     Ordenar tipos de rol diferentes a los principales
'*************************************************************
Dim bandera As Integer
Dim i As Integer
Dim j As Integer

Dim YT%

    If ParPrincipal = 1 Then
        XT = XT + 1
        Roles(XT, 1) = ParTipoPropietario
    End If

    For i = 1 To grdPropietarios.Rows - 1
        grdPropietarios.Col = 5
        grdPropietarios.Row = i
        
        bandera = 0
        For YT = 1 To XT
         If grdPropietarios.Text = Roles(YT, 1) Then
          bandera = 1
         End If
        Next YT
        
        If grdPropietarios.Text = ParTipoPropietario Or (ParTipoPropietario = "OTROS" And bandera <> 1) Then
        
            VLContadorprop = VLContadorprop + 1
        
            ReDim Preserve VTMatrizprop(grdPropietarios.Cols - 1, VLContadorprop)
            For j = 1 To grdPropietarios.Cols - 1
                grdPropietarios.Col = j
                grdPropietarios.Row = i
                VTMatrizprop(j - 1, VLContadorprop) = grdPropietarios.Text
            Next j
        End If
    Next i
End Sub
Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos y del
'            grid de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
    For i% = 0 To 13
        txtCampo(i%).Text = ""
    Next i%
    If mskValor.Enabled = False Then
       mskValor.Enabled = True
    End If
    mskValor.Text = ""
    txtCampo(3).Tag = ""
    For i% = 0 To 15
       'If i% <> 13 Then
        lblDescripcion(i%).Caption = ""
       'End If
    Next i%
    txtCampo(18).Text = ""   ' AVI 8-Jun-2005 G.Bank
    lblDescripcion(20).Caption = ""   ' AVI 8-Jun-2005 G.Bank
    'txtpromotor.Text = ""
    txtTipoCta.Text = ""
    grdPropietarios.Rows = 2
    grdPropietarios.Row = 1
    For i% = 0 To grdPropietarios.Cols - 1
        grdPropietarios.Col = i%
        grdPropietarios.Text = ""
    Next i%
    grdPropietarios.Tag = ""
    VLNumero% = 0
    VLTitular% = 0
    txtCampo(7).Enabled = False
    PMCatalogo "D", "cl_rol", txtCampo(1), lblDescripcion(5)
    chkFuncionario.Value = False

    cmdBoton(2).Enabled = True
    cmdBoton(5).Enabled = False
    txtCampo(5).Enabled = True
    txtCampo(10).Enabled = True
    txtCampo(2).Enabled = True
    Call PMObjetoSeguridad(txtCampo(4))
    txtCampo(6).Enabled = True
    txtCampo(9).Enabled = True
    txtCampo(11).Enabled = True
    txtCampo(8).Enabled = True
    Call PMObjetoSeguridad(txtCampo(18)) 'pcoello ahora se maneja por rol
    Call PMObjetoSeguridad(cmdBoton(0))
    Call PMObjetoSeguridad(cmdBoton(1))

    mskCuenta.Enabled = True
    cmdBoton(2).Enabled = False
    VLCotitular$ = "0"
    VLEnte% = True
    
    mskCuenta.SetFocus
    
    optcausa(0).Value = False
    optcausa(1).Value = False
    
    txtCampo(14).Text = ""
    lblDescripcion(16).Caption = ""
    
    cmbenvioec.ListIndex = 1
    txtCampo(14).Enabled = False
    cmbsaldocero.ListIndex = 0
    
    txtCampo(19).Text = ""
    lblDescripcion(13).Caption = ""
    
    cmdBoton(7).Enabled = False 'LBM
    
    txtCampo(19).Enabled = True
    If VGCodPais$ = "PA" Then
        txtCampo(15).Enabled = True
        txtCampo(15).Text = ""
        txtCampo(16).Enabled = True
        txtCampo(16).Text = ""
    End If
        
    'HA20060826
    optdir(1).Value = True
    optdir_Click (1)
    
    txtCampo(21) = ""
    lblDescripcion(22) = ""
    
    For n% = 0 To UBound(VLTipoDireccion, 1) - 1
      For C% = 0 To UBound(VLTipoDireccion, 2) - 1
        VLTipoDireccion(n%, C%) = ""
      Next C%
    Next n%
    Lblalianza.Caption = ""
    lbldesalianza.Caption = ""
End Sub
Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Efectúa la llamada al stored procedure de
'            actualización crítica de cuentas de ahorros.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    ' Numero de Cuenta de Ahorros
    If mskCuenta.ClipText = "" Then
        MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If

    ' La cuenta de ahorros debe tener al menos un titular
    If VLTitular% <= 0 Then
        MsgBox "La cuenta de ahorros debe tener al menos un titular", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    ' Tipo de la cuenta de ahorros
    If txtCampo(9).Text = "" Then
        MsgBox "El tipo de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(9).SetFocus
        Exit Sub
    End If

    ' Nombre de la cuenta de ahorros
    If txtCampo(2).Text = "" Then
        MsgBox "El nombre de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(2).SetFocus
        Exit Sub
    End If

    ' Direccion del estado de cuenta
    If (txtCampo(3).Text = "" Or VLTipoDireccion(0, 0) = "N" Or VLTipoDireccion(0, 0) = "L") And cmbenvioec.Text = "S" Then
        MsgBox "La dirección del estado de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(21).SetFocus
        Exit Sub
    End If

    ' Direccion de cheques devueltos
    If txtCampo(13).Text = "" Then
        txtCampo(13).Text = txtCampo(3).Text
        txtCampo(13).Tag = txtCampo(3).Tag
        lblDescripcion(14).Caption = lblDescripcion(6).Caption
    End If

    If lblDescripcion(6).Caption = "" And cmbenvioec.Text = "S" Then
        MsgBox "La Dirección de Estado de Cuenta es Mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(21).SetFocus
        Exit Sub
    End If
    
    If lblDescripcion(14).Caption = "" Then
        MsgBox "La Dirección de Cheques Devueltos es Mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(21).SetFocus
        Exit Sub
    End If
    ' Oficial de Credito
    If txtCampo(4).Text = "" Then
        MsgBox "El código del oficial es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(4).SetFocus
        Exit Sub
    End If

    ' Tipo de promedio
    If txtCampo(5).Text = "" Then
        MsgBox "El código del tipo de promedio es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(5).SetFocus
        Exit Sub
    End If

    ' Ciclo de la cuenta
    If txtCampo(6).Text = "" Then
        MsgBox "El código del ciclo de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(6).SetFocus
        Exit Sub
    End If

    ' Tipo de capitalizacion
    If txtCampo(10).Text = "" Then
        MsgBox "El código del tipo de capitalización es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(10).SetFocus
        Exit Sub
    End If
                                    
    ' Categoria de la cuenta
    If txtCampo(7).Text = "" Then
        MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(7).Enabled = True Then txtCampo(7).SetFocus
        Exit Sub
    End If
    
    ' Categoria de la cuenta
    If txtCampo(8).Text = "" Then
        MsgBox "El código de la producto bancario es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(8).Enabled = True Then
            txtCampo(8).SetFocus  'Campo deshabilitado
        End If
        Exit Sub
    End If
    
    'Clasificación del cliente
    If txtCampo(19).Text = "" Then
        MsgBox "El Código de Clasificación del Cliente es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).SetFocus
    End If
    
    
    'Verificar el manejo de menores de edad
    If Not FLVerificarMenor(-1) Then
        Exit Sub
    End If
    
    ' Titularidad de la Cuenta
    If txtCampo(18).Text = "" Then    ' AVI 7-Jun-2005 G.Bank
        MsgBox "El código de Titularidad es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(18).Visible And txtCampo(18).Enabled Then txtCampo(18).SetFocus
        Exit Sub
    End If

    If VLNumero% = 1 And txtCampo(18).Text <> "I" Then
        MsgBox "Si la cuenta tiene un solo propietario el codigo de titularidad debe ser Individual", 0 + 16, "Mensaje de Error"
        If txtCampo(18).Visible And txtCampo(18).Enabled Then txtCampo(18).SetFocus
        Exit Sub
    End If
    
    txtCampo(11).Text = VLNumLib
    '  Verifica que se cambiaron datos de la libreta
    If optcausa(0).Value = True Or optcausa(1).Value = True Or (VLNumLib <> txtCampo(11).Text) Then
        'Valida Número de Libreta y Causa
        If txtCampo(11).Text = "" Or VTNumLib& = 0 Then
            MsgBox "Número de libreta mandatorio y distinto de CERO"
            txtCampo(11).SetFocus
            Exit Sub
        ElseIf VLNumLib = txtCampo(11).Text And optcausa(1).Value = True Then
                MsgBox "Cambio del número de libreta es mandatorio en Canje"
                txtCampo(11).SetFocus
                Exit Sub
            ElseIf VLNumLib <> txtCampo(11).Text And optcausa(0).Value = True Then
                    MsgBox "No se debe cambiar el número de libreta en el Levantamiento"
                    txtCampo(11).SetFocus
                    Exit Sub
                ElseIf optcausa(0).Value = False And optcausa(1).Value = False Then
                        MsgBox "Selección de Lev. Anulación o Canje es mandatoria"
                        txtCampo(11).SetFocus
                        Exit Sub
                    ElseIf optcausa(1).Value = True And txtCampo(14).Text = "" Then
                            MsgBox "Causa de Canje es Mandatorio"
                            If txtCampo(14).Enabled = False Then
                                txtCampo(14).Enabled = True
                            End If
                            txtCampo(14).SetFocus
                            Exit Sub
                        ElseIf optcausa(0).Value = True Then
                                VLCausa$ = "A"
                            Else
                                VLCausa$ = "C"
                            End If
    Else
        VLCausa$ = ""
    End If
    

    ' Patente de la cuenta
    VTPatente$ = " "
    If VGCodPais$ = "PA" Then
        If txtCampo(15).Text = "" Then
            VTPatente$ = " "
        Else
            VTPatente$ = txtCampo(15).Text
        End If
    End If
    
    PLArmadoNomCta

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "202"
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
     PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
     PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, (txtCampo(2).Text)
     PMPasoValores sqlconn&, "@i_cli1", 0, SQLINT4, VLCotitular$
     PMPasoValores sqlconn&, "@i_tipocta_super", 0, SQLVARCHAR, (txtTipoCta.Text)
     
    'Para Personalizacion Banco del Caribe
    If txtCampo(12).Text <> "" Then
       txtCampo(12).Text = " "
       VLCedula1$ = " "
        PMPasoValores sqlconn&, "@i_nombre1", 0, SQLVARCHAR, (txtCampo(12).Text)
        PMPasoValores sqlconn&, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1$
    Else
       txtCampo(12).Text = " "
       VLCedula1$ = " "
        PMPasoValores sqlconn&, "@i_nombre1", 0, SQLVARCHAR, (txtCampo(12).Text)
        PMPasoValores sqlconn&, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1$
    End If
    
    If cmbenvioec.Text = "N" Then
        PMPasoValores sqlconn&, "@i_agencia", 0, SQLINT2, "0"
        PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, "0"
        PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, "0"
        PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "N"
    ElseIf VLTipoDireccion(0, 0) = "D" Then
        PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, (txtCampo(3).Text)
        PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, (txtCampo(3).Tag)
        PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "D"
    ElseIf VLTipoDireccion(0, 0) = "C" Then
        PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, (txtCampo(3).Text)
        PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, (txtCampo(3).Tag)
        PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "C"
    ElseIf VLTipoDireccion(0, 0) = "S" Then
        PMPasoValores sqlconn&, "@i_casillero", 0, SQLVARCHAR, (txtCampo(3).Text)
        PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, "0"
        PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, "0"
    ElseIf VLTipoDireccion(0, 0) = "R" Then
        PMPasoValores sqlconn&, "@i_agencia", 0, SQLINT2, (txtCampo(3).Text)
        PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, "0"
        PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, "0"
    End If
    '  Cheques devueltos
    If VLTipoDireccion(1, 0) = "D" Then
        PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, (txtCampo(13).Text)
        PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, (txtCampo(13).Tag)
        PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "D"
    ElseIf VLTipoDireccion(1, 0) = "C" Then
        PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, (txtCampo(13).Text)
        PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, (txtCampo(13).Tag)
        PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "C"
    ElseIf VLTipoDireccion(1, 0) = "S" Then
        PMPasoValores sqlconn&, "@i_casillero_dv", 0, SQLVARCHAR, (txtCampo(13).Text)
        PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, "0"
        PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, "0"
    ElseIf VLTipoDireccion(1, 0) = "R" Then
        PMPasoValores sqlconn&, "@i_agencia_dv", 0, SQLINT2, (txtCampo(13).Text)
        PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, "0"
        PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, "0"
    End If
    If mskValor.Text <> "" Then
        VLDepoIni$ = Str$(CCur(mskValor.Text))
    Else
        VLDepoIni$ = "0"
    End If
    PMPasoValores sqlconn&, "@i_ofl", 0, SQLINT2, (txtCampo(4).Text)
    PMPasoValores sqlconn&, "@i_tprom", 0, SQLCHAR, (txtCampo(5).Text)
    PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, (txtCampo(6).Text)
    PMPasoValores sqlconn&, "@i_categ", 0, SQLCHAR, (txtCampo(7).Text)
    PMPasoValores sqlconn&, "@i_capit", 0, SQLCHAR, (txtCampo(10).Text)
    PMPasoValores sqlconn&, "@i_origen", 0, SQLVARCHAR, (txtCampo(9).Text)
    PMPasoValores sqlconn&, "@i_numlib", 0, SQLINT4, (txtCampo(11).Text)
    PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, VLDepoIni$
    PMPasoValores sqlconn&, "@i_depini", 0, SQLINT1, "0"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    PMPasoValores sqlconn&, "@i_prodbanc", 0, SQLINT2, (txtCampo(8).Text)
    If VGCodPais$ = "PA" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim(txtCampo(16).Text) <> "" Then
        PMPasoValores sqlconn&, "@i_fideicomiso", 0, SQLCHAR, (txtCampo(16).Text)
        End If
    End If
    PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, (VLCausa$)
    PMPasoValores sqlconn&, "@i_estado_cuenta", 0, SQLCHAR, (cmbenvioec.Text)
    PMPasoValores sqlconn&, "@i_tipocta_super", 0, SQLVARCHAR, (txtCampo(19).Text)
    PMPasoValores sqlconn&, "@i_permite_sldcero", 0, SQLCHAR, (cmbsaldocero.Text)
    PMPasoValores sqlconn&, "@i_titularidad", 0, SQLCHAR, (txtCampo(18).Text)    ' AVI 7-Jun-2005 G.Bank
    PMPasoValores sqlconn&, "@i_patente", 0, SQLVARCHAR, (VTPatente$)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_up_ctahorro", True, " Ok... Actualización de la cuenta de ahorros") Then
        PMMapeaObjeto sqlconn&, lblDescripcion(1)
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = False
        cmdBoton(5).Enabled = True
        'cmdBoton(6).Enabled = True
        txtCampo(2).Enabled = False
        txtCampo(4).Enabled = False
        txtCampo(6).Enabled = False
        txtCampo(7).Enabled = False
        txtCampo(8).Enabled = False
        txtCampo(9).Enabled = False
        txtCampo(10).Enabled = False
        txtCampo(11).Enabled = False
        txtCampo(12).Enabled = False
        txtCampo(18).Enabled = False
        'txtpromotor.Enabled = False
        txtCampo(19).Enabled = False
        If VGCodPais$ = "PA" Then txtCampo(15).Enabled = False
        mskCuenta.Enabled = False
    Else
        cmdBoton(3).SetFocus
    End If
    PMChequea sqlconn&
    cmdBoton(0).Enabled = False
    cmdBoton(1).Enabled = False
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
        Case 0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 18, 19, 15, 21
            VLPaso% = False
    End Select
End Sub
Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código del cliente [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código del rol del cliente [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Nombre de la cuenta de ahorros"
    Case 3
        If VLTipoDireccion(0, 0) = "D" Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección del estado de cuenta [F5 Ayuda]"
        ElseIf VLTipoDireccion(0, 0) = "C" Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la casilla postal [F5 Ayuda]"
        ElseIf VLTipoDireccion(0, 0) = "R" Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la sucursal [F5 Ayuda]" '" Código de la dirección de la agencia [F5 Ayuda]"
        ElseIf VLTipoDireccion(0, 0) = "S" Then
            FPrincipal!pnlHelpLine.Caption = " Número del casillero."
        End If
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Código del oficial de la cuenta [F5 Ayuda]"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Código del tipo de promedio [F5 Ayuda]"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Código del ciclo de la cuenta [F5 Ayuda]"
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Código de la categoría de la cuenta [F5 Ayuda]"
    Case 8
        FPrincipal!pnlHelpLine.Caption = " Código de producto bancario [F5 Ayuda]"
    Case 9
        FPrincipal!pnlHelpLine.Caption = " Código de origen de la cuenta [F5 Ayuda]"
    Case 10
        FPrincipal!pnlHelpLine.Caption = " Tipo de capitalización [F5 Ayuda]"
    Case 11
        FPrincipal!pnlHelpLine.Caption = " Identificación de la Libreta"
    Case 13
        If VLTipoDireccion(1, 0) = "D" Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de Cheques Devueltos [F5 Ayuda]"
            txtCampo(13).MaxLength = 2
        ElseIf VLTipoDireccion(1, 0) = "C" Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la casilla postal [F5 Ayuda]"
            txtCampo(13).MaxLength = 2
        ElseIf VLTipoDireccion(1, 0) = "R" Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la sucursal [F5 Ayuda]" '" Código de la dirección de la agencia [F5 Ayuda]"
            txtCampo(13).MaxLength = 4
        ElseIf VLTipoDireccion(1, 0) = "S" Then
            FPrincipal!pnlHelpLine.Caption = " Número del casillero."
        End If
    Case 14
        FPrincipal!pnlHelpLine.Caption = " Causa del Canje de Libreta"
    Case 18
        FPrincipal!pnlHelpLine.Caption = " Código de Titularidad [F5 Ayuda]"
    Case 19
        FPrincipal!pnlHelpLine.Caption = " Código Clasificación del Cliente [F5 Ayuda]"
    Case 15
        FPrincipal!pnlHelpLine.Caption = " Patente Comercial"
     Case 21
        FPrincipal!pnlHelpLine.Caption = " Catálogo Tipo de Direcciones [F5 Ayuda]"
    End Select
    VLPaso% = True
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        Select Case Index%
        Case 0  ' F5 Cliente
            txtCampo(0).Text = ""
            VLPaso% = True
            
            Dim VTRes As Boolean
            Dim VTCliCif As Boolean
            Dim VTCliCf As Boolean
            Set FMain = FPrincipal
            If VGFBusCliente Is Nothing Then
               Set VGFBusCliente = New BuscarClientes
            End If
            Set FMain = FPrincipal
            If VLTipoEnte = "I" Then
              VTCliCif = False
              VTCliCf = True
            Else
              VTCliCif = True
              VTCliCf = False
            End If
            'Si se selecciona un cliente visualizar datos
            VTRes = VGFBusCliente.FMBuscarCliente(FMain, VGMap, sqlconn&, ServerName$, ServerNameLocal$, VLFormatoFecha$, VGRol$)
            'Si se selecciona un cliente visualizar datos
              If VTRes = True Then
                If VGFBusCliente.DatosCliente(1) <> "" Then
                    txtCampo(0).Text = VGFBusCliente.DatosCliente(1)
                    lblDescripcion(3).Caption = VGFBusCliente.DatosCliente(0)
                    If VGFBusCliente.DatosCliente(0) = "P" Then
                        lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(5)
                        VTCliente = VGFBusCliente.DatosCliente(2) + " " + VGFBusCliente.DatosCliente(3) + " " + VGFBusCliente.DatosCliente(4)
                        lblDescripcion(4).Caption = VTCliente
                        VLReferenah = VGFBusCliente.DatosCliente(9)
                    Else
                        lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(3)
                        lblDescripcion(4).Caption = VGFBusCliente.DatosCliente(2)
                        VLReferenah = VGFBusCliente.DatosCliente(5)
                    End If
                    txtCampo(1).SetFocus
                End If
             End If
        
        Case 1  'F5 Rol
            VLPaso% = True
            PMCatalogo "A", "cl_rol", txtCampo(1), lblDescripcion(5)
            If txtCampo(1).Text <> "" Then
                If cmdBoton(0).Enabled Then cmdBoton(0).SetFocus
            End If
        Case 3  'F5 Código de Dirección
            If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
              MsgBox "El Tipo de Dirección de los Estado de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(3).Text = ""
              If txtCampo(21).Enabled Then txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(0, 0) = "D" Then
                If VLNumero% <> 0 Then
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                    grdPropietarios.Col = 1
                    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de direcciones") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMChequea sqlconn&
                        FCatalogo.Show 1
                        txtCampo(3).Text = VGACatalogo.Codigo$
                        lblDescripcion(6).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.Col = 1
                        txtCampo(3).Tag = grdPropietarios.Text
                        VLPaso% = True
                    Else
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(0, 0) = "C" Then
                If VLNumero% <> 0 Then
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
                    grdPropietarios.Col = 1
                    PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casillas") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
                        PMChequea sqlconn&
                        VLPaso% = True
                        FCatalogo.Show 1
                        txtCampo(3).Text = VGACatalogo.Codigo$
                        lblDescripcion(6).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.Col = 1
                        txtCampo(3).Tag = grdPropietarios.Text
                    Else
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(0, 0) = "R" Then
                If VLNumero% <> 0 Then
                    VGOperacion$ = "sp_agencia"
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "O"
                    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de sucursal") Then 'agencias") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMChequea sqlconn&
                        VLPaso% = True
                        FCatalogo.Show 1
                        txtCampo(3).Text = VGACatalogo.Codigo$
                        lblDescripcion(6).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.Col = 1
                        txtCampo(3).Tag = grdPropietarios.Text
                    Else
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            End If
        Case 4  ' F5 Oficiales de crédito
            txtCampo(4).Text = ""
            FHelpOficial.Show 1
            If VGBusqueda(0) <> "*" Then
                txtCampo(4).Text = VGBusqueda(0)
                lblDescripcion(7).Caption = VGBusqueda(1)
                VLPaso% = True
            Else
                txtCampo(4).Text = ""
                lblDescripcion(7).Caption = ""
            End If
            If txtCampo(4).Text <> "" Then
               ' txtCampo(6).SetFocus
                 'txtpromotor.SetFocus
               VLPaso% = True
            End If
       
        Case 5  'F5 Tipo Promedio
            VLPaso% = True
            PMCatalogo "A", "cc_tpromedio", txtCampo(5), lblDescripcion(8)
        Case 6  'F5 Ciclo
            txtCampo(6).Text = 0
            VLPaso% = True
            PMCatalogo "A", "ah_ciclo", txtCampo(6), lblDescripcion(9)
            If txtCampo(6).Text <> "" Then
               If txtCampo(7).Enabled = True Then txtCampo(7).SetFocus
               VLPaso% = True
            End If
        Case 7  'F5 Categoría
            If Trim$(mskCuenta.ClipText) = "" Then
                MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                
                If mskCuenta.Enabled Then
                    If mskCuenta.Enabled Then mskCuenta.SetFocus
                End If
                Exit Sub
            End If

            If VLTitular% <= 0 Then
                MsgBox "La cuenta de ahorros debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                Exit Sub
            Else
                grdPropietarios.Row = VLTitular%
                grdPropietarios.Col = 3
            End If


            If Trim$(txtCampo(8).Text) = "" Then
                MsgBox "El código de Producto Bancario mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                'txtCampo(8).SetFocus  'Campo deshabilitado
                Exit Sub
            End If
            VLPaso% = True
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_cons_cta", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_cuenta", 0, SQLCHAR, mskCuenta.ClipText
            PMPasoValores sqlconn&, "@i_tipo_cta", 0, SQLCHAR, "AHO"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de categorías") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(7).Text = VGACatalogo.Codigo$
                lblDescripcion(10).Caption = VGACatalogo.Descripcion$
            End If
            If txtCampo(7).Text <> "" And txtCampo(11).Enabled Then
                If txtCampo(11).Enabled Then txtCampo(11).SetFocus
                VLPaso% = True
            End If

        Case 8  ' F5 Productos Bancarios       'Campo deshabilitado
                If VLTitular% <= 0 Then
                    MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(8).Text = ""
                    lblDescripcion(11).Caption = ""
                    If txtCampo(8).Enabled = True Then
                        If txtCampo(8).Enabled Then txtCampo(8).SetFocus
                    End If
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular%
                    grdPropietarios.Col = 3
                End If

            txtCampo(8).Text = ""
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
            PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, " Ok... Consulta de Productos Bancarios") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(8).Text = VGACatalogo.Codigo$
                lblDescripcion(11).Caption = VGACatalogo.Descripcion$
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
        
            End If
            If txtCampo(8).Text <> "" Then
               If txtCampo(9).Enabled Then txtCampo(9).SetFocus
               VLPaso% = True
            End If
        
        Case 9  'F5 Origen Cuenta
            txtCampo(9).Text = ""
            PMCatalogo "A", "ah_tipocta", txtCampo(9), lblDescripcion(12)
            VLPaso% = True
            If txtCampo(9).Text <> "" And mskValor.Enabled = True Then
''               Mskvalor.SetFocus
               VLPaso% = True
            End If
        Case 10 'F5 Tipo de Capitalización
            VLPaso% = True
            PMCatalogo "A", "pe_capitalizacion", txtCampo(10), lblDescripcion(0) 'JAR Requerimiento FO-002
        Case 13  '  Cheques devueltos
            If VLTipoDireccion(1, 0) = "" Then
              MsgBox "El Tipo de Dirección de los Cheques Devueltos es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(13).Text = ""
              If txtCampo(21).Enabled Then txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(1, 0) = "D" Then
                If VLNumero% <> 0 Then
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                    grdPropietarios.Col = 1
                    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de direcciones") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMChequea sqlconn&
                        FCatalogo.Show 1
                        txtCampo(13).Text = VGACatalogo.Codigo$
                        lblDescripcion(14).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.Col = 1
                        txtCampo(13).Tag = grdPropietarios.Text
                        VLPaso% = True
                    Else
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "C" Then
                If VLNumero% <> 0 Then
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
                    grdPropietarios.Col = 1
                    PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casillas") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
                        PMChequea sqlconn&
                        VLPaso% = True
                        FCatalogo.Show 1
                        txtCampo(13).Text = VGACatalogo.Codigo$
                        lblDescripcion(14).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.Col = 1
                        txtCampo(13).Tag = grdPropietarios.Text
                    Else
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "R" Then
                If VLNumero% <> 0 Then
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "O"
                    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de sucursal") Then 'agencias") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMChequea sqlconn&
                        VLPaso% = True
                        FCatalogo.Show 1
                        txtCampo(13).Text = VGACatalogo.Codigo$
                        lblDescripcion(14).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.Col = 1
                        txtCampo(13).Tag = grdPropietarios.Text
                    Else
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            End If
        Case 14 'Causa de Canje
            VLPaso% = True
            PMCatalogo "A", "ah_causa_canje", txtCampo(14), lblDescripcion(16)
        
        Case 18 'Codigo de Titularidad
            PMCatalogo "A", "re_titularidad", txtCampo(18), lblDescripcion(20)
            VLPaso% = True

        Case 19 'Clasificación del cliente
        
            PMCatalogo "A", "ah_cla_cliente", txtCampo(19), lblDescripcion(13)
            VLPaso% = True
            If txtCampo(19).Text <> "" Then
                'If txtCampo(14).Visible And txtCampo(14).Enabled Then txtCampo(14).SetFocus
                If VGCodPais$ = "PA" Then If txtCampo(15).Visible And txtCampo(15).Enabled Then txtCampo(15).SetFocus
            End If
        Case 21 'Tipo de Direcciones
            VLPaso% = True
            PMCatalogo "A", "cl_direccion_ec", txtCampo(21), lblDescripcion(22)
            If txtCampo(21) <> "" Then
              n% = IIf(optdir(0).Value = True, 0, 1)
              VLTipoDireccion(n%, 0) = txtCampo(21)
              VLTipoDireccion(n%, 1) = lblDescripcion(22)
              PLlblEtiqueta txtCampo(21)
            End If
        End Select
    End If
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 3, 6, 4, 8, 9, 11, 13, 14, 19
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    Case 1, 5, 9, 10, 18
        KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
    Case 2, 12
        KeyAscii% = FMVAlidaTipoDato("B", KeyAscii%)
    Case 15, 21
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    Case 7, 15, 16
        KeyAscii% = FMVAlidaTipoDato("U", KeyAscii%)
    End Select
End Sub
Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 0  ' F5 Cliente
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q" '"H"
                PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0).Text)
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1181" '"1225"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    ReDim VTValores(15) As String
                    VTR1% = FMMapeaArreglo(sqlconn&, VTValores())
                    PMMapeaVariable sqlconn&, VLAlianza$
                    PMMapeaVariable sqlconn&, VLDesAlianza$
                    PMChequea sqlconn&
                    VTSubtipo = VTValores(3)
                    VTRefercliente = VTValores(5)
                    lblDescripcion(2).Caption = VTValores(1)
                    lblDescripcion(3).Caption = VTSubtipo
                    If VTSubtipo = "P" Then
                        VTCliente = VTValores(2) 'VTValores(2) + " " + VTValores(3) + " " + VTValores(4)
                        lblDescripcion(4).Caption = VTCliente
                        VLReferencia = VTValores(5)
                    Else
                        lblDescripcion(4).Caption = VTValores(2)
                        VLReferencia = VTValores(5)
                    End If
                    Lblalianza.Caption = VLAlianza$
                    lbldesalianza.Caption = VLDesAlianza$
                    If txtCampo(1).Text = "" Then
                        If txtCampo(1).Enabled Then txtCampo(1).SetFocus
                    Else
                        If cmdBoton(0).Enabled Then cmdBoton(0).SetFocus
                    End If
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(2).Caption = ""
                    lblDescripcion(4).Caption = ""
                    lblDescripcion(3).Caption = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            Else
                lblDescripcion(2).Caption = ""
                lblDescripcion(4).Caption = ""
                lblDescripcion(3).Caption = ""
            End If
        End If
        'REQ I002-ENTEBLOQUEADO  -OUS
        If txtCampo(0).Text <> "" Then
            VLMensajeBlq$ = ""
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "175"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "B"
            PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, txtCampo(0)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_ente_bloqueado", True, "Ok..Consulta Clientes Bloqueados") Then
                PMMapeaVariable sqlconn&, VLBloqueado$
                PMMapeaVariable sqlconn&, VLMalaref$
                PMMapeaVariable sqlconn&, VLLista$
                PMMapeaVariable sqlconn&, VLMensajeBlq$
                PMChequea sqlconn&
            Else
               lblDescripcion(2).Caption = ""
               lblDescripcion(3).Caption = ""
               lblDescripcion(4).Caption = ""
               txtCampo(0).Text = ""
               If txtCampo(0).Enabled Then txtCampo(0).SetFocus
            End If
    
            If VLBloqueado$ = "S" And VLMalaref$ = "N" Then
               MsgBox "Cliente está Bloqueado", 48, "Control de Datos del Clientes"
               lblDescripcion(2).Caption = ""
               lblDescripcion(3).Caption = ""
               lblDescripcion(4).Caption = ""
               txtCampo(0).Text = ""
               If txtCampo(0).Enabled Then txtCampo(0).SetFocus
               Exit Sub
            End If
    
            If VLMalaref$ = "S" Then
                MsgBox VLMensajeBlq$, 48, "Control de Clientes Reportados"
                lblDescripcion(2).Caption = ""
                lblDescripcion(3).Caption = ""
                lblDescripcion(4).Caption = ""
                txtCampo(0).Text = ""
                If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                Exit Sub
            End If
            
            If VLMalaref$ = "N" And VLMensajeBlq$ <> "" Then
               MsgBox VLMensajeBlq$, 48, "Control de Clientes Reportados"
            End If
            
        End If
    Case 1  'F5 Rol
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                PMCatalogo "V", "cl_rol", txtCampo(1), lblDescripcion(5)
            Else
                lblDescripcion(5).Caption = ""
            End If
        End If
    Case 3  'F5 Código de Dirección
        If VLPaso% = False Then
            If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
              MsgBox "El Tipo de Dirección de los Estado de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(3).Text = ""
              If txtCampo(21).Enabled Then txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(0, 0) = "D" Then
                If VLNumero% <> 0 Then
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                        PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT2, (txtCampo(3).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1229"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(6)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(3).Tag = grdPropietarios.Text
                        Else
                            txtCampo(3).Text = ""
                            lblDescripcion(6).Caption = ""
                            txtCampo(3).Tag = ""
                            If txtCampo(3).Enabled Then txtCampo(3).SetFocus
                        End If
                    Else
                        lblDescripcion(6).Caption = ""
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Tag = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(0, 0) = "C" Then
                If VLNumero% <> 0 Then
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_casi", 0, SQLINT2, (txtCampo(3).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casilla " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(6)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(3).Tag = grdPropietarios.Text
                        Else
                            txtCampo(3).Text = ""
                            lblDescripcion(6).Caption = ""
                            txtCampo(3).Tag = ""
                            If txtCampo(3).Enabled Then txtCampo(3).SetFocus
                        End If
                    Else
                        lblDescripcion(6).Caption = ""
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Tag = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(0, 0) = "R" Then
                If VLNumero% <> 0 Then
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "H"
                        PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(3).Text)
                        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de sucursal") Then 'agencias") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(6)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(3).Tag = grdPropietarios.Text
                        Else
                            txtCampo(3).Text = ""
                            lblDescripcion(6).Caption = ""
                            txtCampo(3).Tag = ""
                            If txtCampo(3).Enabled Then txtCampo(3).SetFocus
                        End If
                    Else
                        lblDescripcion(6).Caption = ""
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Tag = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            End If
        End If
    Case 4  ' F5 Oficiales de crédito
        If VLPaso% = False Then
            If txtCampo(4).Text <> "" Then
                If txtCampo(4).Text >= 32000 Then
                    MsgBox "El codigo del Oficial no puede ser mayor a 32000", 0 + 16, "Mensaje de Error"
                    If txtCampo(4).Enabled Then txtCampo(4).SetFocus
                    Exit Sub
                End If

                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15153"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_oficial", 0, SQLINT2, (txtCampo(4).Text)
                
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tr_cons_oficiales", True, "Ok.. Consulta de Oficiales de Crédito") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(7)
                    PMChequea sqlconn&
                  
                Else
                    txtCampo(4).Text = ""
                    lblDescripcion(7).Caption = ""
                    If txtCampo(4).Enabled Then txtCampo(4).SetFocus
                End If
            Else
                lblDescripcion(7).Caption = ""
            End If
        End If
    Case 5  'F5 Tipo Promedio
        If VLPaso% = False Then
            If txtCampo(5).Text <> "" Then
                PMCatalogo "V", "cc_tpromedio", txtCampo(5), lblDescripcion(8)
            Else
                lblDescripcion(8).Caption = ""
            End If
        End If
    Case 6  'F5 Ciclo
        If VLPaso% = False Then
            If txtCampo(6).Text <> "" Then
                PMCatalogo "V", "ah_ciclo", txtCampo(6), lblDescripcion(9)
               
            Else
                lblDescripcion(9).Caption = ""
            End If
        End If
    Case 7  'F5 Categoría
        If VLPaso% = False Then
            If txtCampo(7).Text <> "" Then
                If Trim$(mskCuenta.ClipText) = "" Then
                    MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    If mskCuenta.Enabled Then
                        If mskCuenta.Enabled Then mskCuenta.SetFocus
                    End If
                    Exit Sub
                End If

                'PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2, "4101"
                'PMPasoValores SqlConn&, "@i_oper", 0, SQLCHAR, "Q"
                'PMPasoValores SqlConn&, "@i_cons_cta", 0, SQLCHAR, "S"
                'PMPasoValores SqlConn&, "@i_cons_profinal", 0, SQLCHAR, "S"
                'PMPasoValores SqlConn&, "@i_cuenta", 0, SQLCHAR, mskCuenta.ClipText
                'PMPasoValores SqlConn&, "@i_tipo_cta", 0, SQLCHAR, "AHO"
                'PMPasoValores SqlConn&, "@i_categoria", 0, SQLCHAR, txtCampo(7).Text
                If Trim$(txtCampo(8).Text) = "" Then
                    MsgBox "El código de Producto Bancario mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    'txtCampo(8).SetFocus   'Campo deshabilitado
                    Exit Sub
                End If

                If VLTitular% <= 0 Then
                    MsgBox "La cuenta de ahorros debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular%
                    grdPropietarios.Col = 3
                End If

                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
                PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "Q"
                PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text
                PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda$
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(7).Text

                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de categorías") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(10)
                    PMChequea sqlconn&
                Else
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    If txtCampo(7).Enabled Then txtCampo(7).SetFocus
                End If
                VLPaso% = True
            Else
                lblDescripcion(10).Caption = ""
            End If
        End If

    Case 8  ' F5 Productos Bancarios    'Campo deshabilitado
        If VLPaso% = False Then
            If txtCampo(8).Text <> "" Then
    
                If VLTitular% <= 0 Then
                    MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(8).Text = ""
                    lblDescripcion(11).Caption = ""
                    If txtCampo(8).Enabled = True Then
                        txtCampo(8).SetFocus
                    End If
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular%
                    grdPropietarios.Col = 3
                End If
    
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
    
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
                 PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, (txtCampo(8).Text)
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                 PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, "Ok.. Consulta de Producto Bancaria") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(11)
                     PMChequea sqlconn&
                     
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4088"
                     PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
                     PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
                     PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text
                     PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular$
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
                     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_capitalizacion_profinal", True, " Ok... Consulta de Tipos de Capitalización por Producto Final") Then
                       PMMapeaObjetoAB sqlconn&, txtCampo(10), lblDescripcion(0)
                       PMChequea sqlconn&
                     End If
                    
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4087"
                     PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
                     PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
                     PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text
                     PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular$
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
                     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ciclo_profinal", True, " Ok... Consulta de ciclo por Producto Final") Then
                     PMMapeaObjetoAB sqlconn&, txtCampo(6), lblDescripcion(9)
                     PMChequea sqlconn&
                     End If
                     VLPaso% = True
                Else
                    txtCampo(8).Text = ""
                    lblDescripcion(11).Caption = ""
                    If txtCampo(8).Enabled = True Then
                        txtCampo(8).SetFocus
                    End If
                End If
    
            Else
                lblDescripcion(11).Caption = ""
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
            End If
        End If
    
    Case 9  'F5 Origen Cuenta
        If VLPaso% = False Then
            If txtCampo(9).Text <> "" Then
                PMCatalogo "V", "ah_tipocta", txtCampo(9), lblDescripcion(12)
            Else
                lblDescripcion(12).Caption = ""
            End If
        End If
    Case 10 'F5 Tipo de Capitalización
        If VLPaso% = False Then
            If txtCampo(10).Text <> "" Then
                PMCatalogo "V", "pe_capitalizacion", txtCampo(10), lblDescripcion(0) 'JAR Requerimiento FO-022
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If
    Case 13  'F5 Código de Dirección
        If VLPaso% = False Then
            If VLTipoDireccion(1, 0) = "" Then
              MsgBox "El Tipo de Dirección de los Cheques Devueltos es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(13).Text = ""
              If txtCampo(21).Enabled Then txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(1, 0) = "D" Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                        PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1229"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(14)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(14).Caption = ""
                            txtCampo(13).Tag = ""
                            If txtCampo(13).Enabled Then txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(14).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(0, 0) = "C" Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_casi", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casilla " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(14)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(14).Caption = ""
                            txtCampo(13).Tag = ""
                            If txtCampo(13).Enabled Then txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(14).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "R" Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "H"
                        PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de sucursal") Then 'agencias") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(14)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(14).Caption = ""
                            txtCampo(13).Tag = ""
                            If txtCampo(13).Enabled Then txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(14).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    If txtCampo(0).Enabled Then txtCampo(0).SetFocus
                End If
            End If
        End If
        Case 14 'causa de canje
            If VLPaso% = False Then
                If txtCampo(14).Text <> "" Then
                    PMCatalogo "V", "ah_causa_canje", txtCampo(14), lblDescripcion(16)
                Else
                    lblDescripcion(16).Caption = ""
                End If
            End If

    Case 18 'Titularidad
        If VLPaso% = False Then
            If txtCampo(18).Text <> "" Then
                PMCatalogo "V", "re_titularidad", txtCampo(18), lblDescripcion(20)
            Else
                lblDescripcion(20).Caption = ""
            End If
        End If
    
    Case 19 'Clasificación de Cliente
        If VLPaso% = False Then
            If txtCampo(19).Text <> "" Then
                PMCatalogo "V", "ah_cla_cliente", txtCampo(19), lblDescripcion(13)
            Else
                lblDescripcion(13).Caption = ""
            End If
        End If
    Case 21
      If VLPaso% = False Then
        If txtCampo(21).Text <> "" Then
          PMCatalogo "V", "cl_direccion_ec", txtCampo(21), lblDescripcion(22)
          n% = IIf(optdir(0).Value = True, 0, 1)
          VLTipoDireccion(n%, 0) = txtCampo(21)
          VLTipoDireccion(n%, 1) = lblDescripcion(22)
          PLlblEtiqueta txtCampo(21)
        End If
      End If
    End Select
End Sub
'FIXIT: Declare JTA'FLVerificarMenor' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Private Function FLVerificarMenor(parfila As Integer) As Boolean
'*************************************************************
' PROPOSITO: Determinar el manejo de menores de edad en las
'            cuentas
' INPUT    : Ninguno
' OUTPUT   : FLVerificarMenor   'true si se puede crear
'                                     la nueva cuenta
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 24-Mar-05      D. Villagomez   Emision iniciañ
'*************************************************************
Dim VTCadena As String
Dim vti As Integer
    vti = 0
    FLVerificarMenor = False
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "350"
    For j% = 1 To grdPropietarios.Rows - 1

            If parfila <> j% Then
                grdPropietarios.Row = j%
                grdPropietarios.Col = 4
                VTCadena = ""
                vti = vti + 1
                grdPropietarios.Col = 1 'codigo
                VTCadena = VTCadena + (grdPropietarios.Text) + "@"
                grdPropietarios.Col = 5 'rol
                VTCadena = VTCadena + (grdPropietarios.Text) + "@"
                grdPropietarios.Col = 4 'nombre
                VTCadena = VTCadena + (grdPropietarios.Text) + "@"
                PMPasoValores sqlconn&, "@i_param" + CStr(vti%), 0, SQLCHAR&, VTCadena
            End If

    Next j%
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_valida_menor", True, " Ok... Valida Titularidad") Then
        'Tomar variables de output con código temporal
        PMChequea sqlconn&
        vti% = FMRetStatus(sqlconn&)
        If vti% <> 0 Then
            Exit Function
        End If
        FLVerificarMenor = True
    Else
        PMChequea sqlconn&
        Exit Function
    End If
 End Function
Private Sub PLArmadoNomCta()
On Error GoTo Error_Armado_Cuenta
    
    VTTemp1$ = txtCampo(2).Text
    'VTTemp2$ = txtCampo(11).Text
    
    VTNombreCta$ = ""
    VTString$ = ""
    
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
    If UCase(txtCampo(18).Text) <> "M" And UCase(txtCampo(18).Text) <> "S" Then
        txtCampo(2).Text = VTTemp1$
        'txtCampo(11).Text = VTTemp2$
        Exit Sub
    End If
    
    'Hacer ordenamiento por tipo de propietario
    ReDim VTMatrizprop(grdPropietarios.Cols - 1, 0) As String
    VLContadorprop = -1
    
    'Con esta rutina pasamos los valores a una matriz de forma ordenada
    ReDim Roles(50, 1)
    XT% = 0
    PLProcesarPropietarios "T", 1
    PLProcesarPropietarios "C", 1
    PLProcesarPropietarios "F", 1
    PLProcesarPropietarios "OTROS", 0
               
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
    Select Case UCase(txtCampo(18).Text)
        Case "M"
            VTString$ = " (Y) "
        Case "S"
            VTString$ = " (O) "
    End Select
    
    'Procedemos a efectuar el armado del nombre de la cuenta - Formato Panameño
    VTcontador% = 0
    
    For j% = 0 To UBound(VTMatrizprop, 2)
        For i% = 0 To UBound(VTMatrizprop, 1) - 1
        
            If i% = 2 Then
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                If UCase(VTMatrizprop(i%, j%)) = "P" Then 'Procesar si es solamente persona
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                    If UCase(VTMatrizprop(4, j%)) = "T" Or UCase(VTMatrizprop(4, j%)) = "C" Then
                        'DVA 21/04/2006 Actualizacion de nombres cuando se elimina un cliente
                        'If (UBound(VTMatrizprop, 2)) > 0 Then
                            VTcontador% = VTcontador% + 1
    
                            If VTcontador% = 1 Then
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                                VTNombreCta$ = UCase(VTMatrizprop(3, j%)) 'grdPropietarios.Text '& VTString$
                            Else
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                                VTNombreCta$ = VTNombreCta$ & VTString$ & UCase(VTMatrizprop(3, j%)) 'grdPropietarios.Text
                            End If
                        'End If
                    End If
                Else
                    txtCampo(2).Text = VTTemp1$
                    'txtCampo(11).Text = VTTemp2$
                    Exit Sub
                End If
            End If
        
        Next i%
    Next j%
    'DVA 21/04/2006 Actualizacion de nombres cuando se elimina un cliente
    If VTcontador% >= 1 Then '(UBound(VTMatrizprop, 2)) > 0 Then
        txtCampo(2).Text = VTNombreCta$
        'txtCampo(11).Text = VTNombreCta$
    End If
        
    Exit Sub
    
Error_Armado_Cuenta:
txtCampo(2).Text = VTTemp1$
'txtCampo(11).Text = VTTemp2$
Exit Sub
End Sub
Private Sub PLlblEtiqueta(Etiqueta As String)
If optdir(0) Then
  lblDescripcion(6).Visible = True
  txtCampo(3).Text = ""
  lblDescripcion(6).Caption = ""
  Select Case Etiqueta
  Case "D"
    lblEtiqueta(12).Caption = "Código de dirección:"
  Case "C"
    lblEtiqueta(12).Caption = "Código de casilla:"
  Case "R"
    lblEtiqueta(12).Caption = "Código de sucursal:"
  Case "S"
    lblEtiqueta(12).Caption = "No. de casillero:"
  End Select
ElseIf optdir(1) Then
  lblDescripcion(14).Visible = True
  txtCampo(13).Text = ""
  lblDescripcion(14).Caption = ""
  Select Case Etiqueta
  Case "D"
    lblEtiqueta(19).Caption = "Código de dirección:"
  Case "C"
    lblEtiqueta(19).Caption = "Código de casilla:"
  Case "R"
    lblEtiqueta(19).Caption = "Código de sucursal:"
  Case "S"
    lblEtiqueta(19).Caption = "No. de casillero:"
  End Select
End If
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index%
        Case 0, 1
            Clipboard.Clear
            Clipboard.SetText ""
    End Select
End Sub


