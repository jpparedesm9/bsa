VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran201 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Apertura de Cuentas de Ahorros"
   ClientHeight    =   6450
   ClientLeft      =   3330
   ClientTop       =   1635
   ClientWidth     =   9330
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
   HelpContextID   =   1012
   LinkTopic       =   "Form6"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6450
   ScaleWidth      =   9330
   Tag             =   "3010"
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
      TabIndex        =   23
      Top             =   4740
      Width           =   435
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   15
      Left            =   1860
      MaxLength       =   15
      TabIndex        =   80
      Top             =   4320
      Visible         =   0   'False
      Width           =   2715
   End
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
      Height          =   285
      Index           =   14
      Left            =   2130
      MaxLength       =   12
      TabIndex        =   0
      Top             =   20
      Width           =   2310
   End
   Begin VB.CheckBox chkFuncionario 
      BackColor       =   &H00C0C0C0&
      Caption         =   "*Cuenta de funcionario"
      Enabled         =   0   'False
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
      Height          =   255
      Left            =   6000
      TabIndex        =   77
      Top             =   4200
      WhatsThisHelpID =   5361
      Width           =   2265
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   18
      Left            =   1860
      MaxLength       =   1
      TabIndex        =   12
      Top             =   4020
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   19
      Left            =   6000
      MaxLength       =   1
      TabIndex        =   17
      Top             =   3120
      Width           =   675
   End
   Begin VB.ComboBox cmbenvioec 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   7485
      Style           =   2  'Dropdown List
      TabIndex        =   40
      Top             =   4680
      Width           =   760
   End
   Begin VB.OptionButton optdir 
      BackColor       =   &H00C0C0C0&
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
      Left            =   0
      TabIndex        =   27
      Top             =   4920
      WhatsThisHelpID =   5349
      Width           =   1800
   End
   Begin VB.OptionButton optdir 
      BackColor       =   &H00C0C0C0&
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
      Height          =   435
      Index           =   0
      Left            =   0
      TabIndex        =   22
      Top             =   4800
      Value           =   -1  'True
      WhatsThisHelpID =   5348
      Width           =   1680
   End
   Begin VB.TextBox txtCampo 
      Height          =   700
      Index           =   12
      Left            =   6000
      MaxLength       =   40
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   18
      Top             =   3420
      Visible         =   0   'False
      Width           =   2355
   End
   Begin Crystal.CrystalReport rptReporte 
      Left            =   8760
      Top             =   0
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
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   11
      Left            =   210
      MaxLength       =   8
      TabIndex        =   13
      Top             =   5580
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   9
      Left            =   1860
      MaxLength       =   2
      TabIndex        =   8
      Top             =   2820
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   8
      Left            =   1860
      MaxLength       =   2
      TabIndex        =   7
      Top             =   2520
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   10
      Left            =   1860
      MaxLength       =   2
      TabIndex        =   11
      Top             =   3720
      Width           =   675
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   30
      Top             =   5460
      WhatsThisHelpID =   2008
      Width           =   885
      _Version        =   65536
      _ExtentX        =   1570
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
      Index           =   3
      Left            =   8415
      TabIndex        =   29
      Top             =   4695
      WhatsThisHelpID =   2003
      Width           =   885
      _Version        =   65536
      _ExtentX        =   1570
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
      Index           =   2
      Left            =   8400
      TabIndex        =   28
      Top             =   3930
      WhatsThisHelpID =   2007
      Width           =   885
      _Version        =   65536
      _ExtentX        =   1566
      _ExtentY        =   1333
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
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   5
      Left            =   1860
      MaxLength       =   2
      TabIndex        =   10
      Top             =   3420
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   4
      Left            =   1860
      MaxLength       =   5
      TabIndex        =   9
      Top             =   3120
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Enabled         =   0   'False
      Height          =   285
      Index           =   2
      Left            =   1860
      MaxLength       =   64
      TabIndex        =   6
      Top             =   2220
      Width           =   6490
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   1
      Left            =   6650
      MaxLength       =   2
      TabIndex        =   2
      Top             =   855
      Width           =   375
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   0
      Left            =   0
      MaxLength       =   8
      TabIndex        =   1
      Top             =   855
      Width           =   975
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   380
      Index           =   0
      Left            =   8415
      TabIndex        =   3
      Top             =   15
      WhatsThisHelpID =   2069
      Width           =   890
      _Version        =   65536
      _ExtentX        =   1570
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   380
      Index           =   1
      Left            =   8415
      TabIndex        =   4
      Top             =   405
      WhatsThisHelpID =   2058
      Width           =   890
      _Version        =   65536
      _ExtentX        =   1570
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
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   750
      Left            =   0
      TabIndex        =   5
      Top             =   1385
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   1323
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
      Cols            =   7
      FixedCols       =   0
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   6
      Left            =   6000
      MaxLength       =   2
      TabIndex        =   15
      Top             =   2520
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   7
      Left            =   6000
      MaxLength       =   3
      TabIndex        =   16
      Top             =   2820
      Width           =   675
   End
   Begin MSMask.MaskEdBox Mskvalor 
      Height          =   285
      Left            =   540
      TabIndex        =   26
      Top             =   5580
      Visible         =   0   'False
      Width           =   225
      _ExtentX        =   397
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   13
      Left            =   1710
      MaxLength       =   4
      TabIndex        =   25
      Top             =   5280
      Visible         =   0   'False
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   3
      Left            =   1710
      MaxLength       =   4
      TabIndex        =   24
      Top             =   5280
      Width           =   690
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   380
      Index           =   6
      Left            =   8415
      TabIndex        =   83
      Top             =   800
      Visible         =   0   'False
      WhatsThisHelpID =   2070
      Width           =   890
      _Version        =   65536
      _ExtentX        =   1570
      _ExtentY        =   670
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   9
      Left            =   8415
      TabIndex        =   72
      Tag             =   "6335"
      Top             =   3150
      Visible         =   0   'False
      WhatsThisHelpID =   2016
      Width           =   885
      _Version        =   65536
      _ExtentX        =   1566
      _ExtentY        =   1333
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
   Begin VB.Frame frmDirecciones 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   600
      Left            =   8520
      TabIndex        =   33
      Top             =   5310
      Visible         =   0   'False
      Width           =   150
      Begin Threed.SSOption optDireccion 
         Height          =   195
         Index           =   1
         Left            =   30
         TabIndex        =   31
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
         Index           =   2
         Left            =   30
         TabIndex        =   19
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
         Index           =   3
         Left            =   30
         TabIndex        =   32
         TabStop         =   0   'False
         Top             =   360
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
      Begin Threed.SSOption optDireccion 
         Height          =   195
         Index           =   0
         Left            =   30
         TabIndex        =   14
         Top             =   120
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
         Enabled         =   0   'False
      End
   End
   Begin VB.Frame Frame1dv 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   600
      Left            =   8670
      TabIndex        =   66
      Top             =   5310
      Visible         =   0   'False
      Width           =   120
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   1
         Left            =   30
         TabIndex        =   20
         TabStop         =   0   'False
         Top             =   130
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
         Index           =   2
         Left            =   30
         TabIndex        =   67
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
         Index           =   0
         Left            =   30
         TabIndex        =   68
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
         Enabled         =   0   'False
      End
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   3
         Left            =   30
         TabIndex        =   21
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
      Height          =   756
      Index           =   5
      Left            =   8412
      TabIndex        =   79
      Top             =   1404
      Visible         =   0   'False
      WhatsThisHelpID =   2000
      Width           =   888
      _Version        =   65536
      _ExtentX        =   1570
      _ExtentY        =   1323
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   7
      Left            =   8415
      TabIndex        =   84
      Top             =   2040
      WhatsThisHelpID =   2511
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*C&anales"
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
   Begin VB.Label lbldesalianza 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   407
      Left            =   2445
      TabIndex        =   86
      Top             =   5970
      Width           =   5925
   End
   Begin VB.Label Lblalianza 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Enabled         =   0   'False
      Height          =   285
      Left            =   1710
      TabIndex        =   85
      Top             =   5970
      Width           =   675
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Alianza:"
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
      Height          =   270
      Left            =   0
      TabIndex        =   87
      Top             =   6000
      Width           =   735
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
      TabIndex        =   82
      Top             =   4740
      Width           =   3405
   End
   Begin VB.Label lblEtiqueta 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Fideicomiso:"
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
      Index           =   20
      Left            =   0
      TabIndex        =   81
      Top             =   4350
      Visible         =   0   'False
      WhatsThisHelpID =   5233
      Width           =   1065
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Solicitud:"
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
      Index           =   16
      Left            =   30
      TabIndex        =   78
      Top             =   60
      WhatsThisHelpID =   5250
      Width           =   1335
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   20
      Left            =   2550
      TabIndex        =   76
      Top             =   4020
      Width           =   2325
   End
   Begin VB.Label lblEtiqueta 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Titularidad:"
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
      Index           =   25
      Left            =   0
      TabIndex        =   75
      Top             =   4050
      WhatsThisHelpID =   5151
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cl. Cliente:"
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
      Index           =   18
      Left            =   5040
      TabIndex        =   74
      Top             =   3150
      WhatsThisHelpID =   5263
      Width           =   915
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   500
      Index           =   14
      Left            =   6690
      TabIndex        =   73
      Top             =   3120
      Width           =   1665
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
      Left            =   5970
      TabIndex        =   71
      Top             =   4740
      WhatsThisHelpID =   5264
      Width           =   1380
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Código de dirección:"
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
      Index           =   19
      Left            =   0
      TabIndex        =   69
      Top             =   5280
      Visible         =   0   'False
      WhatsThisHelpID =   5260
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nom.Libreta Cotitular:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   17
      Left            =   840
      TabIndex        =   65
      Top             =   1560
      Visible         =   0   'False
      Width           =   1860
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Origen cuenta:"
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
      Index           =   14
      Left            =   30
      TabIndex        =   63
      Top             =   2820
      WhatsThisHelpID =   5256
      Width           =   1170
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   12
      Left            =   2550
      TabIndex        =   62
      Top             =   2820
      Width           =   2325
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Rol:"
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
      Left            =   6705
      TabIndex        =   61
      Top             =   645
      WhatsThisHelpID =   5253
      Width           =   390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cliente:"
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
      Left            =   30
      TabIndex        =   60
      Top             =   645
      WhatsThisHelpID =   5252
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de Propietarios:"
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
      Left            =   30
      TabIndex        =   59
      Top             =   1125
      WhatsThisHelpID =   5055
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   11
      Left            =   2550
      TabIndex        =   58
      Top             =   2520
      Width           =   2325
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Bancario:"
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
      Left            =   30
      TabIndex        =   57
      Top             =   2520
      WhatsThisHelpID =   5176
      Width           =   1575
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
      Index           =   2
      Left            =   30
      TabIndex        =   43
      Top             =   4605
      WhatsThisHelpID =   5259
      Width           =   855
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Código de dirección:"
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
      Left            =   60
      TabIndex        =   56
      Top             =   5280
      Width           =   1590
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   13
      Left            =   2550
      TabIndex        =   34
      Top             =   3720
      Width           =   2325
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   6210
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Cuenta Ahorros:"
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
      Left            =   30
      TabIndex        =   36
      Top             =   315
      WhatsThisHelpID =   5254
      Width           =   1875
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Verdana"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   2130
      TabIndex        =   37
      Top             =   315
      Width           =   2310
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   2
      Left            =   990
      TabIndex        =   38
      Top             =   855
      UseMnemonic     =   0   'False
      Width           =   1440
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   4
      Left            =   2730
      TabIndex        =   39
      Top             =   855
      UseMnemonic     =   0   'False
      Width           =   3915
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   5
      Left            =   7040
      TabIndex        =   41
      Top             =   855
      Width           =   1290
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8385
      Y1              =   630
      Y2              =   630
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nom. de la Cuenta:"
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
      TabIndex        =   42
      Top             =   2220
      WhatsThisHelpID =   5017
      Width           =   1515
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficial de cuenta:"
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
      Left            =   30
      TabIndex        =   44
      Top             =   3120
      WhatsThisHelpID =   5014
      Width           =   1395
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo de promedio:"
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
      Left            =   30
      TabIndex        =   45
      Top             =   3420
      WhatsThisHelpID =   5257
      Width           =   1455
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Categoría:"
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
      Left            =   5040
      TabIndex        =   46
      Top             =   2820
      WhatsThisHelpID =   5262
      Width           =   885
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ciclo:"
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
      Left            =   5040
      TabIndex        =   47
      Top             =   2520
      WhatsThisHelpID =   5261
      Width           =   525
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   7
      Left            =   2550
      TabIndex        =   48
      Top             =   3120
      Width           =   2325
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   8
      Left            =   2550
      TabIndex        =   49
      Top             =   3420
      Width           =   2325
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   9
      Left            =   6690
      TabIndex        =   50
      Top             =   2520
      Width           =   1665
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8355
      Y1              =   2170
      Y2              =   2170
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   3
      Left            =   2430
      TabIndex        =   51
      Top             =   855
      UseMnemonic     =   0   'False
      Width           =   300
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo capitalización:"
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
      Left            =   30
      TabIndex        =   52
      Top             =   3735
      WhatsThisHelpID =   5258
      Width           =   1560
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha de corte estado cuenta:"
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
      Left            =   4470
      TabIndex        =   53
      Top             =   315
      WhatsThisHelpID =   5255
      Width           =   2385
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   1
      Left            =   7155
      TabIndex        =   54
      Top             =   315
      Width           =   1200
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   10
      Left            =   6690
      TabIndex        =   55
      Top             =   2820
      Width           =   1665
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   555
      Index           =   15
      Left            =   2445
      TabIndex        =   70
      Top             =   5280
      Visible         =   0   'False
      Width           =   5925
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   555
      Index           =   6
      Left            =   2430
      TabIndex        =   35
      Top             =   5280
      Width           =   5925
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Patente:"
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
      Index           =   15
      Left            =   5040
      TabIndex        =   64
      Top             =   3420
      Visible         =   0   'False
      WhatsThisHelpID =   5152
      Width           =   720
   End
End
Attribute VB_Name = "FTran201"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRAN201.frm
' NOMBRE LOGICO:    FTran201
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
' Esta forma permite apertura una cuenta de Ahorros
' personalizada.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Personalización AgroMercantil
'*************************************************************

Dim VLNumero As Integer
Dim VLContador As Integer
Dim VLTitular As Integer
Dim VLPaso As Integer
Dim VLImprimio As Integer
Dim VLTipoEnte As String
Dim VLEnte As Integer
Dim VLCedula1 As String
Dim VLCotitular As String
Dim VLNombre As String
Dim VLOficina As Integer
Dim VLTraslado_dtn As Integer
Dim VLCodTitular As Long
Dim VLBeneficiarios As Boolean
Dim VLTipoEnteTitular As String
Dim VLyaingreso As Integer
Dim VLCuenta0 As String
Dim VLTutor As Boolean

Dim VTMatrizprop() As String
Dim VLReferenah As String
Dim VLContadorprop As Integer
Dim VLTipoDireccion(2, 2) As String
Dim VLProdProgresivo As String

Dim Roles() As String
Dim XT%
'Dim VLMarca As String
'Req. 371 Tarjeta Debito
Dim VLNumDoc As String
Dim VLTitularidad As String
Dim VLEstado As String
Dim VLOficinaO As Integer
Dim VLTipoTran As String
Dim VLProdBancBloq As String
Dim VLFormatoFecha As String
Dim VTRefercliente As String
Dim VTCliente As String
Dim VLReferencia As String
Dim VLMensajeBlq As String


Private Sub PLReporteApertura()
'*************************************************************
' PROPOSITO: Imprime el Contrato de Apertura de Cuentas
'            de Ahorros.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 14-Jul-05      L. Bernuil      Ajustes al contrato de Apertura
'*************************************************************
    On Error GoTo Error1
    Dim BaseDatos As Database
    Dim Tabla1 As Recordset
    Dim tabla2 As Recordset
    Dim tabla4 As Recordset
    Dim tabla5 As Recordset
'FIXIT: Declare JTA 'VTArray' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
    Dim VTArray() As String 'LBM
   
    Dim i As Integer
    Dim j As Integer
    Dim archivo As String
    archivo = VGPath$ + "\APERTURA.MDB"
    Set BaseDatos = DBEngine.OpenDatabase(archivo)
    Set Tabla1 = BaseDatos.OpenRecordset("cuenta")
    Set tabla2 = BaseDatos.OpenRecordset("propietarios")
    Set tabla4 = BaseDatos.OpenRecordset("referencias")
    Set tabla5 = BaseDatos.OpenRecordset("datosadic")
    
    BaseDatos.Execute "delete from cuenta"
    BaseDatos.Execute "delete from propietarios"
    BaseDatos.Execute "delete from referencias"
    BaseDatos.Execute "delete from datosadic"
    
    'Se insertan los datos generales de la cuenta
    Tabla1.AddNew
   
    Tabla1("oficina") = VGOficina
    Tabla1("fecha") = Date$
    Tabla1("deposito") = Format$(MskValor.Text, "#,##0.00")
    Tabla1("numero") = Format$(lblDescripcion(0).Caption, VGMascaraCtaCte$)
    Tabla1("moneda") = Left$(FPrincipal!cmbMoneda.Text, 30)
    Tabla1("nombre") = Left$(txtCampo(2).Text, 64) 'Left$(txtCampo(2).Text, 30)
    Tabla1("producto") = Left$(lblDescripcion(11).Caption, 30)
    Tabla1("origen") = Left$(lblDescripcion(12).Caption, 30)
    Tabla1("oficial") = Left$(lblDescripcion(7).Caption, 30)
    Tabla1("promedio") = Left$(lblDescripcion(8).Caption, 30)
    Tabla1("categoria") = Left$(lblDescripcion(10).Caption, 30)
    Tabla1("ciclo") = Left$(lblDescripcion(9).Caption, 30)
    Tabla1("fecha_corte") = Left$(lblDescripcion(1).Caption, 30)
       
     If cmbenvioec.Text = "S" Then
        If VLTipoDireccion(0, 0) = "D" Then
            Tabla1("direccion") = Left$(lblDescripcion(15).Caption, 30)
        Else
            Tabla1("agencia_ec") = Left$(lblDescripcion(6).Caption, 30)
        End If
     End If
    
    Tabla1("tipo") = "Ahorro"
    Tabla1("firma") = Left$(lblDescripcion(20).Caption, 30) '"" ''Poner la descripción del campo de titularidad.
    If VGCodPais$ = "PA" Then Tabla1("patente") = txtCampo(12).Text '"" ''Poner la descripción del campo de patente.
    If VGCodPais$ = "PA" Then Tabla1("fideicomiso") = txtCampo(15).Text
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
            
    'cuando ya los datos estan ordenados en la matriz, procedemos a pasarlos al grid nuevamente
    'pero ya ordenados
    For i = 1 To grdPropietarios.Rows - 1
        For j% = 1 To grdPropietarios.Cols - 1
            grdPropietarios.Row = i
            grdPropietarios.col = j%
            grdPropietarios.Text = VTMatrizprop(j% - 1, i - 1)
        Next j%
    Next i
    
    grdPropietarios.Row = 1
    grdPropietarios.col = 1
    Dim VTclientepro As String
    VTclientepro = grdPropietarios.Text
    Tabla1("solicitu") = VTclientepro
    Tabla1("secuencial") = 1
    
    'Pasar los datos a los campos de zona, codigo postal, y ciudad
    If VLTipoDireccion(0, 0) = "C" And txtCampo(3).Text <> "" Then
        VTArray = Split(Trim$(lblDescripcion(6).Caption), "|")
            
        If LBound(VTArray) >= 0 Then
            For i = LBound(VTArray) To UBound(VTArray)
            
                Select Case i
                    Case 0
                        Tabla1("di_codpostal") = Trim$(CStr(VTArray(0)))
                    Case 1
                        Tabla1("di_ciudad") = Trim$(CStr(VTArray(2)))
                    Case 2
                        Tabla1("di_zona") = Trim$(CStr(VTArray(1)))
                    Case 3
                        Tabla1("di_pais") = Trim$(CStr(VTArray(3)))
                End Select
            Next i
        End If
    End If
                    
    Dim VLSecuencial As Integer
    VLSecuencial = 1
    Dim k As Integer
    Dim VTTitular As String
    Dim VLCondicion As String
    For k = 1 To grdPropietarios.Rows - 1
    
        grdPropietarios.col = 1
        grdPropietarios.Row = k
        VLCodTitular = grdPropietarios.Text
        grdPropietarios.col = 5
        VTTitular = grdPropietarios.Text
        grdPropietarios.col = 6
        VLCondicion = grdPropietarios.Text
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, CStr(VLCodTitular)
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2543"
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
        
        Dim VTR1 As Integer
        Dim VTR3 As Integer
        Dim VTR4 As Integer
        Dim VTR5 As Integer
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente_cc", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
            ReDim VTDatosCli(40) As String
            VTR1 = FMMapeaArreglo(sqlconn&, VTDatosCli())
            ReDim VTRefCom(10, 100) As String 'LBM
            VTR3 = FMMapeaMatriz(sqlconn&, VTRefCom())
            ReDim VTRefBan(4) As String
            VTR4 = FMMapeaArreglo(sqlconn&, VTRefBan())
            ReDim VTRefPerso(10, 100) As String 'LBM
            VTR5 = FMMapeaMatriz(sqlconn&, VTRefPerso())
            
            PMChequea sqlconn&
       
            tabla2.AddNew
            tabla2("cliente") = VLCodTitular 'LBM
            tabla2("secuencial") = VLSecuencial%
            tabla2("numero") = lblDescripcion(0).Caption
            tabla2("firma") = Left$(lblDescripcion(20).Caption, 30) '"" ''Poner la descripción del campo de titularidad.
            tabla2("condicion") = VLCondicion$
            tabla2("titular") = VTTitular$
            VLSecuencial% = VLSecuencial% + 1
            
            If VTDatosCli(7) = "P" Then
                tabla2("cedula") = Left$(VTDatosCli(1), 30)
                
                tabla2("nombre") = Trim$(VTDatosCli(37)) 'Trim$(Left$(VTDatosCli(2), 30)) + " " + Trim$(Left$(VTDatosCli(3), 30)) + " " + Trim$(Left$(VTDatosCli(4), 30)) + " " + Trim$(Left$(VTDatosCli(5), 30))
                
                If VTDatosCli(2) = "" Then
                    tabla2("primer_nombre") = " "  '60)
                Else
                    tabla2("primer_nombre") = Left$(VTDatosCli(2), 30)  '60)
                End If
                
                If VTDatosCli(3) = "" Then
                    tabla2("segundo_nombre") = " "
                Else
                    tabla2("segundo_nombre") = Left$(VTDatosCli(3), 30)
                End If
                
                If VTDatosCli(4) = "" Then
                    tabla2("primer_apellido") = " "
                Else
                    tabla2("primer_apellido") = Left$(VTDatosCli(4), 30)
                End If
                
                If VTDatosCli(5) = "" Then
                    tabla2("segundo_apellido") = " "
                Else
                    tabla2("segundo_apellido") = Left$(VTDatosCli(5), 30)
                End If
                
                tabla2("apellido_casada") = Left$(VTDatosCli(6), 30)
                tabla2("tipo_cliente") = Left$(VTDatosCli(7), 30)
                tabla2("pais") = Left$(VTDatosCli(9), 30)
                tabla2("sexo") = Left$(VTDatosCli(10), 30)
                tabla2("estado_civil") = Left$(VTDatosCli(11), 30)
                tabla2("nit") = Left$(VTDatosCli(12), 30)
                
                If VTDatosCli(13) <> "" Then
                    tabla2("fecha_nacimiento") = Left$(VTDatosCli(13), 30)
                End If
                
                tabla2("num_hijos") = Val(VTDatosCli(14))
                tabla2("num_cargas") = Val(VTDatosCli(15))
                tabla2("desc_ciudad_nac") = Left$(VTDatosCli(16), 30)
                tabla2("desc_lugar_doc") = Left$(VTDatosCli(17), 30)
                tabla2("desc_dep_doc") = Left$(VTDatosCli(18), 30)
                tabla2("desc_profesion") = Left$(VTDatosCli(19), 30)
                tabla2("emp_cargo") = VTDatosCli(20)
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
                tabla2("empresa") = Left(VTDatosCli(21), 64)
                tabla2("razon_social") = Left$(VTDatosCli(22), 30)
                tabla2("emp_telefono") = Left$(VTDatosCli(23), 30)
                tabla2("desc_dep_nac") = VTDatosCli(24)
                tabla2("desc_pais_nac") = VTDatosCli(25)
                
                If VTDatosCli(26) <> "" And VTDatosCli(27) <> "" Then
                    tabla2("emp_tiempo") = DateDiff("yyyy", VTDatosCli(26), VTDatosCli(27))
                ElseIf VTDatosCli(26) <> "" And VTDatosCli(27) = "" Then
                    tabla2("emp_tiempo") = DateDiff("yyyy", VTDatosCli(26), Now())
                End If
                
                tabla2("rl_fecha_ing") = Format(VTDatosCli(26), "dd/mm/yyyy")
                tabla2("nacionalidad") = VTDatosCli(28)
                tabla2("tipo_vivienda") = VTDatosCli(29)
                tabla2("tipo_ced") = VTDatosCli(30)
                tabla2("emp_ingresos") = VTDatosCli(31)
                tabla2("emp_act_economica") = VTDatosCli(32)
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                tabla2("emp_desc_actividad") = Mid(VTDatosCli(33), 1, 50) 'LBM
                tabla2("emp_direccion") = VTDatosCli(34)
                tabla2("email") = VTDatosCli(35)
                tabla2("digito") = VTDatosCli(36)
                Dim reporte As String
                reporte = VGPath$ + "\APCTACTE1.RPT"
            Else
            
                tabla2("pais") = Left$(VTDatosCli(5), 30) 'LBM
                
                tabla2("razon_social") = VTDatosCli(3)
                tabla2("nombre") = VTDatosCli(1)
                tabla2("emp_act_economica") = VTDatosCli(2)
                tabla2("rep_legal") = VTDatosCli(4)
                tabla2("rl_telefono") = VTDatosCli(8)
                tabla2("rl_fax") = VTDatosCli(9)
                tabla2("rl_email") = VTDatosCli(11)
                tabla2("emp_cargo") = VTDatosCli(10)
                tabla2("rl_fecha_ing") = VTDatosCli(12)
                tabla2("cedula") = VTDatosCli(21) 'VTDatosCli(13) '***PCOELLO GRABAR EL NIT
                tabla2("tipo_ced") = VTDatosCli(22) '***PCOELLO GRABAR EL TIPO DE CEDULA
                tabla2("digito") = VTDatosCli(23) '***PCOELLO GRABAR EL DIGITO
                tabla2("num_patenteC") = VTDatosCli(14)
                tabla2("num_RegM") = VTDatosCli(15)
                tabla2("num_folioRegM") = VTDatosCli(16)
                tabla2("num_libroRegM") = VTDatosCli(17)
                
                Dim tiempoemp As Integer
                If VTDatosCli(18) <> "" Then
                    tiempoemp = Len(VTDatosCli(18))
                    If tiempoemp > 2 Then
                        VTDatosCli(18) = Mid$(VTDatosCli(18), 1, 2)
                        tabla2("emp_tiempo") = VTDatosCli(18)
                    End If
                End If
                
                tabla2("fecha_constitucion") = VTDatosCli(19)
                tabla2("objeto_social") = VTDatosCli(20)
                tabla2("nit") = VTDatosCli(21)
                reporte$ = VGPath$ + "\APCTACTE1.RPT"
            End If
              
            tabla2("refcom1") = Left$(VTRefCom(0, 1), 64)
            tabla2("di_refcom1") = Left$(VTRefCom(1, 1), 64)
            tabla2("tel_refcom1") = Left$(VTRefCom(2, 1), 16)
            tabla2("refcom2") = Left$(VTRefCom(0, 2), 64)
            tabla2("di_refcom2") = Left$(VTRefCom(1, 2), 64)
            tabla2("tel_refcom2") = Left$(VTRefCom(2, 2), 16)
            tabla2("refcom3") = Left$(VTRefCom(0, 3), 64)
            tabla2("di_refcom3") = Left$(VTRefCom(1, 3), 64)
            tabla2("tel_refcom3") = Left$(VTRefCom(2, 3), 16)
            tabla2("refban1") = Left$(VTRefBan(1), 64)
            tabla2("refban2") = Left$(VTRefBan(2), 64)
            tabla2("refban3") = Left$(VTRefBan(3), 64)
        
            Dim VTSec As Integer
            Dim n As Integer
            VTSec = 1
            For n = 1 To VTR3%
                If Left$(VTRefCom(0, n%), 50) <> "" Then
                    tabla4.AddNew
                    tabla4("numero") = lblDescripcion(0).Caption
                    tabla4("entidad") = Left$(VTRefCom(0, n), 50)
                    tabla4("anios") = VTRefCom(1, n%)
                    tabla4("contacto") = Left$(VTRefCom(2, n), 50)
                    tabla4("tipo_cta") = Left$(VTRefCom(3, n), 30)
                    tabla4("telefono") = Left$(VTRefCom(4, n), 38) 'gagm1050 03abr2007 tel ref
                    tabla4("secuencial") = VTSec
                    tabla4("sec_beneficiario") = tabla2("secuencial")
                    VTSec% = VTSec% + 1
                    tabla4("filial") = Val(VGLOGO$)
                    tabla4.Update
                End If
            Next n
            
            For n = 1 To VTR5%
                    tabla4.AddNew
                    tabla4("numero") = lblDescripcion(0).Caption
                    tabla4("entidad") = Left$(VTRefPerso(0, n%), 50)
                    tabla4("anios") = VTRefPerso(1, n%)
                    tabla4("contacto") = Left$(VTRefPerso(2, n%), 50)
                    tabla4("tipo_cta") = Left$(VTRefPerso(3, n%), 30)
                    tabla4("telefono") = Left$(VTRefPerso(4, n%), 38) 'gagm1050 03abr2007 tel ref
                    tabla4("secuencial") = VTSec%
                    tabla4("sec_beneficiario") = tabla2("secuencial")
                    VTSec% = VTSec% + 1
                    tabla4("filial") = Val(VGLOGO$)
                    tabla4.Update
            Next n%
            
        Else
            Tabla1.Close
            tabla2.Close
            tabla4.Close
            BaseDatos.Close
            PMChequea sqlconn&
            Exit Sub
        End If
        
        Dim Index As Integer
        Dim VTTelef As String
        Dim VTCelular As String
        Dim VTFax As String
        Dim VTTelex As String
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, CStr(VLCodTitular)
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index) & "]") Then
            ReDim VTDireccionCli(25, 10) As String
            VTR1% = FMMapeaMatriz(sqlconn&, VTDireccionCli())
            PMChequea sqlconn&
            
            For i = 1 To VTR1%
                If VTDireccionCli(11, i) = "S" Then 'LBM
                    tabla2("direccion_ente") = Left$(Trim$(Trim$(VTDireccionCli(15, i)) + " " + Trim$(VTDireccionCli(16, i)) + " " + Trim$(VTDireccionCli(17, i)) + " " + Trim$(VTDireccionCli(18, i))), 255)
                    tabla2("di_ciudad") = Left$(VTDireccionCli(5, i), 30)
                    'tabla2("di_zona") = Left$(VTDireccionCli(7, i), 30)
                    tabla2("di_provincia") = Left$(VTDireccionCli(3, i), 30)
                    tabla2("di_codpostal") = Left$(VTDireccionCli(8, i), 30)
                    'tabla2("di_pais") = Left$(VTDireccionCli(15, i), 30)
                    
                    VTTelef$ = ""
                    VTCelular$ = ""
                    VTFax$ = ""
                    VTTelex$ = ""
                    
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, CStr(VLCodTitular)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1345"
                    PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT4, VTDireccionCli(0, i)
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index%) & "]") Then
                        ReDim VTTelefonoCli(4, 10) As String
                        Dim VTR2 As Integer
                        VTR2 = FMMapeaMatriz(sqlconn&, VTTelefonoCli())
                        PMChequea sqlconn&
                        For j = 1 To VTR2
                            If VTTelefonoCli(2, j) = "RE" Then ''Fijo 'LBM
                                VTTelef$ = VTTelefonoCli(1, j%)
                            End If
                            
                            If VTTelefonoCli(2, j) = "CE" Then ''Celular 'LBM
                                VTCelular$ = VTTelefonoCli(1, j%)
                            End If
                            
                            If VTTelefonoCli(2, j) = "FA" Then ''Fax 'LBM
                                VTFax$ = VTTelefonoCli(1, j%)
                            End If
                            
                            If VTTelefonoCli(2, j) = "OT" Then ''Otros
                                VTTelex$ = VTTelefonoCli(1, j%)
                            End If
                        Next j%
                    End If
                    
                    tabla2("telefono") = VTTelef$
                    tabla2("num_fax") = VTFax$
                    tabla2("celular") = VTCelular$
                    tabla2("telex") = VTTelex$
                End If
                                
                VTTelef$ = ""
                VTFax$ = ""
                
                If VLTipoDireccion(0, 0) = "C" And Val(VTDireccionCli(0, i)) = Val(txtCampo(3).Text) And txtCampo(3).Text <> "" Then 'LBM
                    'tabla1("direccion") = VTDireccionCli(1, i)
                    'tabla1("di_zona") = Left(VTDireccionCli(7, i), 30)
                    'tabla1("di_ciudad") = Left(VTDireccionCli(5, i), 30)
                    'tabla1("di_codpostal") = Left(VTDireccionCli(8, i), 30)
                    'tabla1("di_provincia") = VTDireccionCli(3, i)
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, CStr(VLCodTitular)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1345"
                    PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT4, txtCampo(3).Text
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(3) & "]") Then
                        ReDim VTTelefonoCli(4, 10) As String
                        VTR2% = FMMapeaMatriz(sqlconn&, VTTelefonoCli())
                        PMChequea sqlconn&
                        
                        For j = 1 To VTR2
                            If VTTelefonoCli(2, j) = "RE" Then 'LBM
                                VTTelef$ = VTTelefonoCli(1, j)
                            Else
                                VTFax$ = VTTelefonoCli(1, j)
                            End If
                        Next j
                    End If
                    
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
                    Tabla1("di_telefono") = Left(VTTelef$, 16)
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
                    Tabla1("di_fax") = Left(VTFax$, 16)
                End If
         
                If VTDireccionCli(9, i) = "E-MAIL" Then
                    tabla2("email") = VTDireccionCli(1, i)
                End If
                
            Next i
        End If
        tabla2("filial") = Val(VGLOGO$)
        tabla2.Update
    Next k%
   
    If VGCodPais$ = "PA" Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "348"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, VLCuenta0
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        ReDim VTArreglo(30) As String
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_datos_adic_aho", True, " Ok... Consulta de información de la cuenta " & "[" & lblDescripcion(0).Caption & "]") Then
            VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
            PMChequea sqlconn&
            If VTR1% > 0 Then
                tabla5.AddNew
                tabla5("numero") = lblDescripcion(0).Caption
                tabla5("dep_inicial") = VTArreglo(2)
                tabla5("forma_dep_inicial") = VTArreglo(3)
                tabla5("proposito_cuenta") = VTArreglo(4)
                tabla5("origen_fondos") = VTArreglo(5)
                tabla5("prod_cobis1") = VTArreglo(6)
                tabla5("prod_cobis2") = VTArreglo(7)
                tabla5("monto_ext") = VTArreglo(8)
                tabla5("trx_ext") = Val(VTArreglo(9))
                tabla5("frecuencia_ext") = VTArreglo(10)
                tabla5("monto_efec") = VTArreglo(11)
                tabla5("trx_efec") = Val(VTArreglo(12))
                tabla5("frecuencia_efec") = VTArreglo(13)
                tabla5("monto_refec") = VTArreglo(14)
                tabla5("trx_refec") = Val(VTArreglo(15))
                tabla5("frecuencia_refec") = VTArreglo(16)
                tabla5("monto_giro") = VTArreglo(17)
                tabla5("trx_giro") = Val((VTArreglo(18)))
                tabla5("frecuencia_giro") = VTArreglo(19)
                tabla5("monto_gerencia") = VTArreglo(20)
                tabla5("trx_gerencia") = Val(VTArreglo(21))
                tabla5("frecuencia_gerencia") = VTArreglo(22)
                tabla5("monto_transfer") = VTArreglo(23)
                tabla5("trx_transfer") = Val(VTArreglo(24))
                tabla5("frecuencia_transfer") = VTArreglo(25)
                tabla5("monto_recib") = VTArreglo(26)
                tabla5("trx_recib") = Val(VTArreglo(27))
                tabla5("frecuencia_recib") = VTArreglo(28)
                tabla5("filial") = Val(VGLOGO$)
                tabla5.Update
            End If
        End If
    End If 'DATOS ADICIONALES
   
    Tabla1("filial") = Val(VGLOGO$)
    Tabla1.Update
    Tabla1.Close
    tabla2.Close
    tabla4.Close
    tabla5.Close
    BaseDatos.Close
    Dim respuesta As Integer
    respuesta = MsgBox("Desea imprimir el contrato", vbYesNo + vbQuestion)
    
    If respuesta = 7 Then
       Exit Sub
    End If
    rptReporte.ReportFileName = reporte$
    rptReporte.CopiesToPrinter = 1
    rptReporte.DataFiles(0) = archivo$
    rptReporte.Destination = crptToWindow
    rptReporte.Formulas(0) = "usuario=""" & VGLogin & " - " & VGFecha$ & " """
    rptReporte.Formulas(1) = "fecha=""" & VGFecha$ & """"
    rptReporte.Action = 1
    
    Exit Sub
Error1:
    MsgBox "Informe al área de Desarrollo. Error en la Impresión: " + error$
    Exit Sub
              
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
Dim XT As Integer
Dim YT As Integer

    If ParPrincipal = 1 Then
        XT = XT + 1
        Roles(XT, 1) = ParTipoPropietario
    End If
    Dim i As Integer
    Dim j As Integer
    For i = 1 To grdPropietarios.Rows - 1
        grdPropietarios.col = 5
        grdPropietarios.Row = i
        
        bandera = 0
        For YT = 1 To XT%
         If grdPropietarios.Text = Roles(YT, 1) Then
          bandera = 1
         End If
        Next YT
        
        If grdPropietarios.Text = ParTipoPropietario Or (ParTipoPropietario = "OTROS" And bandera <> 1) Then
        
            VLContadorprop = VLContadorprop + 1
        
            ReDim Preserve VTMatrizprop(grdPropietarios.Cols - 1, VLContadorprop)
            For j = 1 To grdPropietarios.Cols - 1
                grdPropietarios.col = j
                grdPropietarios.Row = i
                VTMatrizprop(j - 1, VLContadorprop) = grdPropietarios.Text
            Next j
        End If
    Next i
End Sub
Private Sub cmbenvioec_Click()
  optdir(0).Enabled = IIf(cmbenvioec.Text = "N", False, True)
  If cmbenvioec.Text = "N" Then
    optdir(1).Value = True
  Else
    optdir(0).Value = True
  End If
End Sub

Private Sub cmbenvioec_GotFocus()
  FPrincipal!pnlHelpLine.Caption = " Opción de Envío de Estado de Cuenta (S/N)"
End Sub
Private Sub cmdBoton_Click(Index As Integer)
    Dim VLProdbanc As String
    Dim VTR1 As Integer
    Dim VTR As Integer
    Dim i As Integer
    Dim VLTipoDoc As String
    Select Case Index
        Case 0
            PLAniadir
            txtCampo(0).SetFocus
            VLEnte% = True
        Case 1
            PLEliminar
        Case 2
            PLTransmitir
        Case 3
            If VGCodPais = "PA" Then
            If VGPerfilCta <> "S" And VGPerfilCta <> "" Then
                MsgBox "Debe ingresar los datos del perfil de la cuenta antes de limpiar la pantalla", vbCritical, "Mensaje del Sistema"
                Exit Sub
            End If
            End If
            PLLimpiar
        Case 4
            If VGCodPais = "PA" Then
            If VGPerfilCta <> "S" And VGPerfilCta <> "" Then
                MsgBox "Debe ingresar los datos del perfil de la cuenta antes salir de la pantalla", vbCritical, "Mensaje del Sistema"
                Exit Sub
            End If
            End If
            PLSalir
        Case 5
            PLBuscar
    '    Case 5
    '        PLReporteApertura
        Case 9
            If VGCodPais = "PA" Then
            If VGPerfilCta <> "S" And VGPerfilCta <> "" Then
                MsgBox "Debe ingresar los datos del perfil de la cuenta antes imprimir el contrato de apertura", vbCritical, "Mensaje del Sistema"
                Exit Sub
            End If
            End If
            PLReporteApertura
        Case 6
            VGProducto = "AHO"
            Fdatadi.Show
            Fdatadi!mskCuenta.Mask = VGMascaraCtaAho
            'Fdatadi!mskCuenta.Text = Format$(lblDescripcion(0), VGMascaraCtaAho$)
            Fdatadi!mskCuenta.Text = lblDescripcion(0)
            
        Case 7
            'REQ363
            VGCuenta = VLCuenta0
                        'Req. 371 Verificar si en el catalogo el prod bancario bloq existe
            VLProdbanc = txtCampo(8).Text
        
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "747"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "V"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, VLProdbanc
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Consultando") Then
                PMMapeaVariable sqlconn&, VLProdBancBloq
                PMChequea sqlconn&
            Else
                VLProdBancBloq = ""
            End If
        
            If VLProdBancBloq <> "" Then
                MsgBox "Producto Bancario bloqueado, no puede relacionarse con canales", 0 + 48, "Advertencia"
                Exit Sub
            End If
            
            'Paso de parametros de búsqueda
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "206"
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR&, VGCuenta
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                ReDim VTArreglo(20) As String
                VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                VLNombre = VTArreglo(1)
                VLOficina = VTArreglo(2)
                VLTraslado_dtn = VTArreglo(3)
                VLTitularidad = VTArreglo(4)
                VLOficinaO = VTArreglo(5)
                VLEstado = VTArreglo(6)
                PMChequea sqlconn&
                If VLTitularidad = "CONJUNTA" Then
                    MsgBox "Cuenta con Titularidad Conjunta. No puede relacionarse a un canal ", 0 + 16, "Mensaje de Error"
                    Exit Sub
                Else
                    'Req. 371 Tarjeta Debito
                    VTR = grdPropietarios.Rows - 1
                    For i = 1 To VTR
                        grdPropietarios.col = 2
                        grdPropietarios.Row = i
                        VLNumDoc = grdPropietarios.Text
                        grdPropietarios.col = 3
                        VLTipoDoc = grdPropietarios.Text
                        If VLTipoDoc = "C" Then
                            MsgBox "Cuenta de Persona Jurídica. No puede relacionarse a un canal", 0 + 16, "Mensaje de Error"
                            Exit Sub
                        End If
                        VLTipoTran = "1610"
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1020"
                        PMPasoValores sqlconn&, "@i_frontend", 0, SQLCHAR&, "S"
                        PMPasoValores sqlconn&, "@i_cedruc", 0, SQLVARCHAR&, VLNumDoc
                        PMPasoValores sqlconn&, "@o_tipoced", 0, SQLVARCHAR&, VGTipoDoc
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_datos_cliente", True, "") Then
                            PMMapeaVariable sqlconn&, VGTipoDoc
                            PMChequea sqlconn&
                        End If
                        FMRegistraHuellaAValidar VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran
                    Next i
                    If VGValidaHuella = True Then
                        'Req. 371 Tarjeta Debito
                        VLTipoTran = "1610"
                        FMVerificaHuella VGCuenta, VLTipoTran
                            If VGRegistraHuellaAValidar = True Then
                            FRelCtaCanal.Show
                        Else
                            Exit Sub
                        End If
                    End If
                End If
            End If
    End Select
End Sub

Private Sub Form_Load()
    Dim n As Integer
    Dim C As Integer
    
    FTran201.Left = 0
    FTran201.Top = 0
    FTran201.Width = 9420
    FTran201.Height = 6960
    
    If VGAperCifrada = True Then
      Me.Tag = 3031
    Else
      Me.Tag = 3030
    End If
    
    VGOrigen = "0"
    VGCancelar = "N"
    PMLoadResStrings Me
    PMLoadResIcons Me
    grdPropietarios.ColWidth(0) = 1
    grdPropietarios.ColWidth(1) = 800
    grdPropietarios.ColWidth(2) = 1300
    grdPropietarios.ColWidth(3) = 300
    grdPropietarios.ColWidth(4) = 3915
    grdPropietarios.ColWidth(5) = 375
    grdPropietarios.ColWidth(6) = 1230
    
    grdPropietarios.Row = 0
    grdPropietarios.col = 1
    grdPropietarios.Text = "CODIGO"
    grdPropietarios.col = 2
    grdPropietarios.Text = "IDENTIFICACION"
    grdPropietarios.col = 3
    grdPropietarios.Text = "TP."
    grdPropietarios.col = 4
    grdPropietarios.Text = "NOMBRE"
    grdPropietarios.col = 5
    grdPropietarios.Text = "TIT."
    grdPropietarios.col = 6
    grdPropietarios.Text = "DESCRIPCION"
    'PMCatalogo "D", "ah_tpromedio", txtCampo(5), lblDescripcion(8)
    'txtCampo(5).Enabled = False
    PMCatalogo "D", "cl_rol", txtCampo(1), lblDescripcion(5)
    'txtCampo(5).Enabled = False
    'PMCatalogo "D", "ah_ciclo", txtCampo(6), lblDescripcion(9)
    txtCampo(6).Enabled = True
    'PMCatalogo "D", "ah_capitalizacion", txtCampo(10), lblDescripcion(13)
    'txtCampo(10).Enabled = False
    VLNumero% = 0
    VLTitular% = 0
    MskValor.Format = VGDecimales$
    MskValor.Text = Format$(0, VGDecimales$)
    MskValor.MaxLength = 14
    VLImprimio% = True
    VLEnte% = True
    VLCedula1$ = ""
    VLCotitular$ = "0"
    VLyaingreso = 0
    'txtpromotor.Connection = VGMap
    'Set txtpromotor.AsociatedLabel = lblDescripcion(14)
    'txtpromotor.TableName = "cl_promotor"
    
    cmbenvioec.Clear
    cmbenvioec.AddItem "S"
    cmbenvioec.AddItem "N"
    cmbenvioec.ListIndex = 1
    
    VGPerfilCta = ""
    
    'HA20060826
    For n = 0 To UBound(VLTipoDireccion, 1) - 1
      For C = 0 To UBound(VLTipoDireccion, 2) - 1
        VLTipoDireccion(n, C) = ""
      Next C
    Next n
    
    optdir(1).Value = True
    optdir_Click (1)

    txtCampo(21) = ""
    lblDescripcion(22) = ""
    
    If VGCodPais$ = "PA" Then
        ' Patente
        lbletiqueta(15).Visible = True
        txtCampo(12).Visible = True
        ' Fideicomiso
        lbletiqueta(20).Visible = True
        txtCampo(15).Visible = True
        ' Perfil de Cuenta
        cmdBoton(6).Visible = True
    End If
    PLParametro
End Sub
Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
'FIXIT: Declare JTA 'Msg' with an early-bound data type                                        FixIT90210ae-R1672-R1B8ZE
    Dim Msg As String ' Declare variable.

    If Not VLImprimio% Then
        ' Set the message text.
        Msg = "¿Realmente desea Cerrar la Ventana Activa?"
        ' If user clicks the 'No' button, stop QueryUnload.
        If MsgBox(Msg, 36, Me.Caption) = 7 Then Cancel = True
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
    
    VGPerfilCta = ""
End Sub

Private Sub grdPropietarios_Click()
    grdPropietarios.col = 0
    grdPropietarios.SelStartCol = 1
    grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
    If grdPropietarios.Row = 0 Then
        grdPropietarios.SelStartRow = 1
        grdPropietarios.SelEndRow = 1
    Else
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
    End If
    
  'HA20060810
  If optdir(1).Value = False Then
    If VLTipoDireccion(0, 0) = "D" Then
        txtCampo(3).Text = ""
        lblDescripcion(6).Caption = ""
    End If
  Else
    If VLTipoDireccion(1, 0) = "D" Then
        txtCampo(13).Text = ""
        lblDescripcion(15).Caption = ""
    End If
  End If
End Sub

Private Sub grdPropietarios_DblClick()
 'Para Perzonalizacion del Banco del Caribe Nombres Titular y Cotitular de la Cuenta
 Dim i As Integer
  If VLEnte% = True Then
      grdPropietarios.col = 2
      VLTipoEnte$ = grdPropietarios.Text
      For i = 1 To (grdPropietarios.Rows - 1)
       grdPropietarios.Row = i
       If (grdPropietarios.Text) = "C" Then
           VLTipoEnte$ = grdPropietarios.Text
           grdPropietarios.col = 4
           If (Trim$(grdPropietarios.Text) = "T") Then
               Exit For
           End If
       End If
     Next i
     VLEnte% = False
  End If
End Sub
Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub
Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del depósito inicial"
    MskValor.SelStart = 0
    MskValor.SelLength = Len(MskValor.Text)
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

Private Sub optdir_Click(Index As Integer)
' Selecciona entre direccion de estado de cuenta y direccion de cheques devueltos
  If Index = 0 Then 'Estado de cuenta
    txtCampo(3).Visible = True
    txtCampo(13).Visible = Not txtCampo(3).Visible
    lblDescripcion(6).Visible = True
    lblDescripcion(15).Visible = Not lblDescripcion(6).Visible
    lbletiqueta(12).Visible = True
    lbletiqueta(19).Visible = Not lbletiqueta(12).Visible
    txtCampo(21).Text = VLTipoDireccion(Index, 0)
    lblDescripcion(22).Caption = VLTipoDireccion(Index, 1)
  Else              'Cheques devueltos
    txtCampo(13).Visible = True
    txtCampo(3).Visible = Not txtCampo(13).Visible
    lblDescripcion(15).Visible = True
    lblDescripcion(6).Visible = Not lblDescripcion(15).Visible
    lbletiqueta(19).Visible = True
    lbletiqueta(12).Visible = Not lbletiqueta(19).Visible
    txtCampo(21).Text = VLTipoDireccion(Index, 0)
    lblDescripcion(22).Caption = VLTipoDireccion(Index, 1)
  End If
End Sub
Private Sub optdir_GotFocus(Index As Integer)
  optdir(Index).Value = True
End Sub
Private Sub PLAniadir()
'*************************************************************
' PROPOSITO: Rutina que permite añadir un propietario al grid
'            propietarios de la cuenta, controlando que exista
'            un solo propietario con el rol de Alternante.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VTCadena As String
Dim VTSeguir As Integer
Dim VTR1 As Integer
Dim vti As Integer
Dim i As Integer
vti = 1

    VTSeguir = 1
    'VLyaingreso% = 0
    
    ' Se añade la validacion de que existan hasta 20 propietarios por el sp_validar_titularidad
    ' creado para la version global bank
    If grdPropietarios.Rows - 1 >= 20 Then
        MsgBox "Solo puede ingresar hasta 20 Propietarios", vbInformation
        Exit Sub
    End If
    If txtCampo(0).Text <> "" Then
        If lblDescripcion(3).Caption = "C" And lblDescripcion(2).Caption = "" Then
            lblDescripcion(2).Caption = "Sin Identificación"
        End If
        
        If lblDescripcion(2).Caption <> "" Then
            If lblDescripcion(4).Caption <> "" Then
                If lblDescripcion(3).Caption <> "" Then
                    If txtCampo(1).Text <> "" Then
                        If txtCampo(1).Text <> "T" And VLyaingreso = 0 Then
                            MsgBox "Debe Ingresar Primero el Titular de la Cuenta", vbInformation
                            Exit Sub
                        End If
                        If txtCampo(1).Text = "U" Then
                            MsgBox "No es Posible Asignar un Tutor desde esta Pantalla. Remitase al modulo de Clientes", vbInformation
                            txtCampo(1).SetFocus
                            Exit Sub
                        End If
                            ' Se Valida la Existencia de tutores
                            VLTutor = False
                            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "350"
                            PMPasoValores sqlconn&, "@i_retorna", 0, SQLINT1, "1"
                            VTCadena = ""
                            VTCadena = VTCadena + (txtCampo(0).Text) + "@"           'codigo
                            VTCadena = VTCadena + (txtCampo(1).Text) + "@"           'rol
                            VTCadena = VTCadena + (lblDescripcion(4).Caption) + "@"  'nombre
                            PMPasoValores sqlconn&, "@i_param" + CStr(vti%), 0, SQLCHAR&, VTCadena
                            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_valida_menor", True, " Ok... Valida Titularidad") Then
                               ReDim VTValores(15) As String
                               VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
                               PMChequea sqlconn&
                               If VTR1 > 0 Then
                                    ' Se carga valor de catalogo de tutor
                                    VLTutor = True
                                    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
                                    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_rol"
                                    PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, "U"    'Cod. tutor
                                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
                                       ReDim VTArreglo(10) As String
                                       VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                                       PMChequea sqlconn&
                                    End If
                               End If
                            Else
                               PMChequea sqlconn&
                               txtCampo(0).Text = ""
                               txtCampo(0).SetFocus
                               lblDescripcion(2).Caption = ""
                               lblDescripcion(3).Caption = ""
                               lblDescripcion(4).Caption = ""
                               txtCampo(1).Text = ""
                               lblDescripcion(5).Caption = ""
                               Exit Sub
                            End If
                        If VLNumero% > 0 Then
                           VTSeguir% = PLChequeoIngreso()
                        End If
                        If VTSeguir% = 1 Then
                            If (txtCampo(1).Text = "T") And (grdPropietarios.Tag <> "T") Then
                                VLTitular% = VLNumero% + 1
                                grdPropietarios.Tag = "T"
                                If VLNumero% = 0 Then
                                    grdPropietarios.Row = 1
                                    grdPropietarios.col = 1
                                    grdPropietarios.Text = txtCampo(0).Text
                                    grdPropietarios.col = 2
                                    grdPropietarios.Text = lblDescripcion(2).Caption
                                    grdPropietarios.col = 3
                                    grdPropietarios.Text = lblDescripcion(3).Caption
                                    grdPropietarios.col = 4
                                    grdPropietarios.Text = lblDescripcion(4).Caption
                                    grdPropietarios.col = 5
                                    grdPropietarios.Text = txtCampo(1).Text
                                    If txtCampo(1).Text = "T" Then
                                        VLCodTitular = Val(txtCampo(0).Text)
                                        VLTipoEnteTitular$ = lblDescripcion(3).Caption
                                    End If
                                    grdPropietarios.col = 6
                                    grdPropietarios.Text = lblDescripcion(5).Caption
                                Else
                                '1
                                    grdPropietarios.AddItem "" & Chr$(9) & txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero% + 1
                                End If
                                ' Se Add. el tutor al cliente si existe
                                If VTR1% > 0 Then
                                   grdPropietarios.AddItem "" & Chr$(9) & VTValores(1) & Chr$(9) & VTValores(2) & Chr$(9) & VTValores(3) & Chr$(9) & VTValores(4) & Chr$(9) & "U" & Chr$(9) & VTArreglo(1), VLNumero% + 2
                                   VLNumero% = VLNumero% + 1
                                   'VLContador% = VLContador% + 1
                                   txtCampo(0).SetFocus
                                End If
                                grdPropietarios.col = 5
                                If Trim$(txtCampo(1).Text) = "T" Then
                                    VLyaingreso = 1   'lgr
                                    txtCampo(2).Text = lblDescripcion(4).Caption
                                    txtCampo(2).Enabled = False
                                End If
                                VLNumero% = VLNumero% + 1
                                txtCampo(0).Text = ""
                                txtCampo(1).Text = ""
                                lblDescripcion(2).Caption = ""
                                lblDescripcion(3).Caption = ""
                                lblDescripcion(4).Caption = ""
                                lblDescripcion(5).Caption = ""
                                'PMCatalogo "D", "cl_rol", txtCampo(1), lblDescripcion(5)
                            ElseIf (txtCampo(1).Text <> "T") Then
                                If VLNumero% = 0 Then
                                    grdPropietarios.Row = 1
                                    grdPropietarios.col = 1
                                    grdPropietarios.Text = txtCampo(0).Text
                                    grdPropietarios.col = 2
                                    grdPropietarios.Text = lblDescripcion(2).Caption
                                    grdPropietarios.col = 3
                                    grdPropietarios.Text = lblDescripcion(3).Caption
                                    grdPropietarios.col = 4
                                    grdPropietarios.Text = lblDescripcion(4).Caption
                                    grdPropietarios.col = 5
                                    grdPropietarios.Text = txtCampo(1).Text
                                    grdPropietarios.col = 6
                                    grdPropietarios.Text = lblDescripcion(5).Caption
                                Else
                                    If VLTipoEnteTitular$ = "C" Then ' titular es compania
                                        If txtCampo(1).Text = "C" Then ' se quiere ingresar un cotitular
                                            MsgBox "El Titular es Persona Juridica por tanto no puede tener cotitulares", 0 + 16, "Mensaje de Error"
                                            VLNumero% = VLNumero% - 1
                                        Else
                                            If txtCampo(1).Text = "F" And lblDescripcion(3).Caption = "C" Then ' se quiere firma autorizada
                                                MsgBox "Persona Juridica solo puede ser titular", 0 + 16, "Mensaje de Error"
                                                VLNumero% = VLNumero% - 1
                                            Else
                                            '2
                                                grdPropietarios.AddItem "" & Chr$(9) & txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero% + 1
                                            End If
                                        End If
                                    Else
                                        ' titular es persona
                                        ' no puede haber compania como cotitular o firma
                                        If lblDescripcion(3).Caption = "C" Then
                                            MsgBox "Persona Juridica solo puede ser titular", 0 + 16, "Mensaje de Error"
                                            VLNumero% = VLNumero% - 1
                                        Else
                                        '3
                                            grdPropietarios.AddItem "" & Chr$(9) & txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero% + 1
                                        End If
                                    End If
                                End If
                                VLNumero% = VLNumero% + 1
                                txtCampo(0).Text = ""
                                txtCampo(1).Text = ""
                                lblDescripcion(2).Caption = ""
                                lblDescripcion(3).Caption = ""
                                lblDescripcion(4).Caption = ""
                                lblDescripcion(4).Caption = ""
                                'PMCatalogo "D", "cl_rol", txtCampo(1), lblDescripcion(5)
                            Else
                                MsgBox "La cuenta de ahorros solo puede tener un titular", 0 + 16, "Mensaje de Error"
                            End If
                            PLAjustaGrid grdPropietarios, Me
                          Else
                            MsgBox "Cliente ya Registrado", 0 + 16, "Mensaje de Error"
                            txtCampo(0).Text = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(2).Caption = ""
                            lblDescripcion(3).Caption = ""
                            lblDescripcion(4).Caption = ""
                            lblDescripcion(5).Caption = ""
                            txtCampo(0).SetFocus
                          End If
                    Else
                        MsgBox "El código del rol del cliente es mandatorio", 0 + 16, "Mensaje de Error"
                        txtCampo(1).SetFocus
                    End If
                Else
                    MsgBox "El tipo de cliente es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If
            Else
                MsgBox "El nombre del cliente es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
            End If
        Else
            MsgBox "La Identificación es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
        End If
    Else
        MsgBox "El código del cliente es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
    End If
  'Para Personalizacion Banco Caribe
  If txtCampo(1).Text = "T" Then
    If VLEnte% = True Then
      grdPropietarios.col = 3
      VLTipoEnte$ = grdPropietarios.Text
      For i = 1 To (grdPropietarios.Rows - 1)
       grdPropietarios.Row = i
       If (grdPropietarios.Text) = "C" Then
           VLTipoEnte$ = grdPropietarios.Text
           grdPropietarios.col = 5
           If (Trim$(grdPropietarios.Text) = "T") Then
               Exit For
           End If
       End If
      Next i
    VLEnte% = False
   End If
  End If
End Sub

Private Function PLChequeoIngreso() As Integer
'*************************************************************
' PROPOSITO: Rutina que permite verificar si el cliente que
'            se pretende ingresar al grid de propietarios
'            existe.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim i As Integer
Dim VTRegistrado As Integer
    For i = 1 To grdPropietarios.Rows - 1
       grdPropietarios.col = 1
       grdPropietarios.Row = i
       If Trim$(grdPropietarios.Text) = Trim$(txtCampo(0).Text) Then
          VTRegistrado = 0
          Exit For
         Else
            VTRegistrado = 1
       End If
    Next i
    PLChequeoIngreso = VTRegistrado

End Function

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Rutina que permite eliminar un propietario
'            del grid de propietarios de la cuenta.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VTFlag As Boolean
Dim VTPosTmp As Integer
Dim VTCliCasi As String
Dim i As Integer
VTFlag = False

    grdPropietarios.col = 5
    
    If grdPropietarios.Text = "U" Then
        MsgBox "No es Posible Eliminar un Tutor desde esta Pantalla. Remitase al modulo de Clientes", vbInformation
        Exit Sub
    End If
    
    If grdPropietarios.Text = "T" Then
        VLTitular% = 0
        grdPropietarios.Tag = ""
        txtCampo(2).Text = ""
        txtCampo(8).Text = ""
        lblDescripcion(11).Caption = ""
        txtCampo(7).Text = ""
        lblDescripcion(10).Caption = ""
        VLyaingreso = 0  'lgr
        VTFlag = True
    End If

    grdPropietarios.col = 1
    VTCliCasi = grdPropietarios.Text
    If VTCliCasi = txtCampo(3).Tag Then
        txtCampo(3).Text = ""
        lblDescripcion(6).Caption = ""
        txtCampo(3).Tag = ""
    End If
    If VTCliCasi$ = txtCampo(13).Tag Then
        txtCampo(13).Text = ""
        lblDescripcion(15).Caption = ""
        txtCampo(13).Tag = ""
    End If
    
    If grdPropietarios.Rows = 2 Then
        VLNumero% = 0
        grdPropietarios.Row = 1
        For i = 0 To 6
            grdPropietarios.col = i
            grdPropietarios.Text = ""
        Next i
    Else
        VLNumero% = VLNumero% - 1
        grdPropietarios.RemoveItem grdPropietarios.Row
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
        'Si se Elimina el titular se elimina el tutor si existe
        If VTFlag Then
           If grdPropietarios.Rows = 2 Then
                VLNumero% = 0
                'VLContador% = 0
                grdPropietarios.Row = 1
                grdPropietarios.col = 5
                If grdPropietarios.Text = "U" Then
                    For i = 0 To 6
                        grdPropietarios.col = i
                        grdPropietarios.Text = ""
                    Next i
                End If
           Else
                grdPropietarios.Row = 1
                grdPropietarios.col = 5
                 For i = 1 To (grdPropietarios.Rows - 1)
                    grdPropietarios.Row = i
                    If grdPropietarios.Text = "U" Then
                       VTPosTmp = i
                       Exit For
                    End If
                 Next i
                   If VTPosTmp > 0 Then
                        VLNumero = VLNumero - 1
                        VLContador = VLContador - 1
                        grdPropietarios.SelStartRow = VTPosTmp
                        grdPropietarios.SelEndRow = VTPosTmp
                        grdPropietarios.RemoveItem VTPosTmp
                   End If
           End If
        End If
        txtCampo(0).SetFocus
   End If

'Limpia campos de tipo de cliente
    txtCampo(19).Text = ""
    lblDescripcion(14).Caption = ""
End Sub

'Private Sub PLImprimir()
''*************************************************************
'' PROPOSITO: Imprime los datos relacionados con la apertura
''            de Cuentas de Ahorros.
'' INPUT    : Ninguna.
'' OUTPUT   : Ninguna.
''*************************************************************
''                       MODIFICACIONES
'' FECHA          AUTOR           RAZON
'' 10-Ene-02      C. Milán        Emisión Inicial
''*************************************************************
'    On Error GoTo Error1
'    Dim baseDatos As Database
'    Dim tabla1 As Recordset
'    Dim tabla2 As Recordset
'
'    archivo$ = VGPath$ + "\APERTURA.MDB"
'    Set baseDatos = DBEngine.OpenDatabase(archivo$)
'    Set tabla1 = baseDatos.OpenRecordset("cuenta")
'    Set tabla2 = baseDatos.OpenRecordset("propietarios")
'    baseDatos.Execute "delete from cuenta"
'    baseDatos.Execute "delete from propietarios"
'    tabla1.AddNew
'    tabla1("oficina") = VGOficina
'    tabla1("fecha") = Date$
'    tabla1("deposito") = Format$(Mskvalor.Text, "#,##0.00")
'    tabla1("numero") = Format$(lblDescripcion(0).Caption, VGMascaraCtaAho$)
'    tabla1("moneda") = Left$(FPrincipal!cmbMoneda.Text, 30)
'    tabla1("chequera") = Left$(txtCampo(2).Text, 30)
'    tabla1("producto") = Left$(lblDescripcion(11).Caption, 30)
'    tabla1("origen") = Left$(lblDescripcion(12).Caption, 30)
'    'If optDireccion(0).Value = True Then
'    '   tabla1("direccion") = "DIRECCION DEL CLIENTE"
'    'End If
'    'If optDireccion(1).Value = True Then
'    '   tabla1("direccion") = "CASILLA POSTAL DEL CLIENTE"
'    'End If
'    'If optDireccion(2).Value = True Then
'    '   tabla1("direccion") = "RETENER EN AGENCIA DEL BANCO"
'    'End If
'    'If optDireccion(3).Value = True Then
'    '   tabla1("direccion").Value = "RETENER EN CASILLERO DEL BANCO"
'    'End If
'    tabla1("oficial") = Left$(lblDescripcion(7).Caption, 30)
'    tabla1("promedio") = Left$(lblDescripcion(8).Caption, 30)
'    tabla1("categoria") = Left$(lblDescripcion(10).Caption, 30)
'    tabla1("ciclo") = Left$(lblDescripcion(9).Caption, 30)
'    tabla1("fecha_corte") = Left$(lblDescripcion(1).Caption, 30)
'    'tabla1("solicitu") = Left$(txtCampo(10).Text, 30)
'    tabla1("tipo_capital") = Left$(lblDescripcion(13).Caption, 30)
'    tabla1("num_libreta") = Left$(txtCampo(11).Text, 30)
'    tabla1("secuencial") = 1
'    tabla1.Update
'    For i = 1 To (grdPropietarios.Rows - 1)
'        grdPropietarios.row = i
'        tabla2.AddNew
'        grdPropietarios.Col = 1
'        tabla2("cedula") = Left$(grdPropietarios.Text, 30)
'        grdPropietarios.Col = 3
'        tabla2("nombre") = Left$(grdPropietarios.Text, 30)
'        grdPropietarios.Col = 5
'        tabla2("descripcion") = Left$(grdPropietarios.Text, 30)
'        tabla2("secuencial") = i
'        tabla2.Update
'    Next i
'    tabla2.Close
'
'    'Activamos el reporte
'    reporte$ = VGPath$ + "\APCTAHOR.RPT"
'    rptReporte.ReportFileName = reporte$
'    For i = 1 To 2
'        tabla1.MoveFirst
'        tabla1.Edit
'        If i = 1 Then
'            tabla1("tipo") = "ORIGINAL"
'        Else
'            tabla1("tipo") = "COPIA"
'            rptReporte.CopiesToPrinter = 2
'        End If
'        tabla1.Update
'        rptReporte.DataFiles(0) = archivo$
'        rptReporte.Destination = 1
'        rptReporte.Action = 1
'    Next i
'    tabla1.Close
'    baseDatos.Close
'
'    MsgBox "Ingrese el + Mid ({cuenta.fecha}, 7, 4)papel para imprimir el contrato"
'
'    'Impresión del contrato
'     PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2, "2618"
'     PMPasoValores SqlConn&, "@i_filial", 0, SQLINT1, VGFilial
'     PMPasoValores SqlConn&, "@i_oficina", 0, SQLINT2, VGOficina
'     If FMTransmitirRPC(SqlConn&, ServerName$, "cob_cuentas", "sp_consulta_contrato", False, "") Then
'        ReDim Valores(2) As String
'        VTR% = FMMapeaArreglo(SqlConn&, Valores())
'        PMMapeaVariable SqlConn&, ciudad$
'        PMChequea SqlConn&
'    End If
'    nom_banco$ = Valores(1)
'    cargo$ = Valores(2)
'
'    archivo$ = VGPath$ + "\CONTRATO.MDB"
'    Set baseDatos = DBEngine.OpenDatabase(archivo$)
'    Set tabla1 = baseDatos.OpenRecordset("partes")
'    baseDatos.Execute "delete from partes"
'    tabla1.AddNew
'    tabla1("nom_banco") = Left$(nom_banco$, 30)
'    tabla1("cargo") = Left$(cargo$, 30)
'    For i = 1 To (grdPropietarios.Rows - 1)
'        grdPropietarios.row = i
'        grdPropietarios.Col = 4
'        If grdPropietarios.Text = "T" Then
'            Exit For
'        End If
'    Next i
'    grdPropietarios.Col = 3
'    tabla1("nom_cliente") = Left$(grdPropietarios.Text, 30)
'    tabla1("ciudad") = Left$(ciudad$, 30)
'    tabla1("fechac") = Date$
'    tabla1("num_contrato") = Left$(lblDescripcion(0).Caption, 30)
'    tabla1.Update
'    tabla1.Close
'    baseDatos.Close
'
'    'Activamos el reporte
'    reporte$ = VGPath$ + "\CONTAHOR.RPT"
'    rptReporte.ReportFileName = reporte$
'    rptReporte.CopiesToPrinter = 1
'    rptReporte.DataFiles(0) = archivo$
'    rptReporte.Destination = 1
'    rptReporte.Action = 1
'    Exit Sub
'Error1:
'    MsgBox "Informe al área de Desarrollo. Error en la Impresión: " + error$
'    Exit Sub
'End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia los valores de los objetos y del grid
'            de la Apertura de Cuentas de Ahorros.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim i As Integer
    For i = 0 To 4
        txtCampo(i).Text = ""
    Next i
    txtCampo(6).Text = ""
    txtCampo(5).Text = ""   'lgr
    txtCampo(7).Text = ""
    txtCampo(8).Text = ""
    txtCampo(9).Text = ""
    txtCampo(10).Text = ""
    'txtCampo(11).Text = ""
    If VGCodPais$ = "PA" Then txtCampo(12).Text = ""
    txtCampo(13).Text = ""
    txtCampo(14).Text = ""
    If VGCodPais$ = "PA" Then txtCampo(15).Text = ""
    txtCampo(18).Text = ""   ' AVI 8-Jun-2005 G.Bank
    lblDescripcion(20).Caption = ""   ' AVI 8-Jun-2005 G.Bank
    MskValor.Text = "0"
    txtCampo(3).Tag = ""
    lblDescripcion(15).Caption = ""
    For i = 0 To 15
      'If i <> 6 And i <> 14 Then
        lblDescripcion(i).Caption = ""
      'End If
    Next i
    grdPropietarios.Rows = 2
    grdPropietarios.Row = 1
    For i = 0 To 6
        grdPropietarios.col = i
        grdPropietarios.Text = ""
    Next i
    grdPropietarios.Tag = ""
    VLNumero% = 0
    VLTitular% = 0
    VLCotitular$ = "0"
    PMCatalogo "D", "ah_tpromedio", txtCampo(5), lblDescripcion(8)
    cmdBoton(0).Enabled = True
    cmdBoton(1).Enabled = True
    cmdBoton(2).Enabled = True
    cmdBoton(5).Enabled = True
    cmdBoton(9).Visible = False
    cmdBoton(9).Enabled = False
    If VGCodPais$ = "PA" Then cmdBoton(6).Enabled = False
    txtCampo(0).Enabled = True
    txtCampo(1).Enabled = True
    txtCampo(14).Enabled = True
    txtCampo(8).Enabled = True

    chkFuncionario.Value = vbUnchecked
    
    txtCampo(19).Text = ""
    lblDescripcion(14).Caption = ""

    'lblEtiqueta(2).Visible = False
    'lblEtiqueta(12).Visible = False
    'frmDirecciones.Visible = False
   ' txtCampo(3).Visible = False
   ' lblDescripcion(6).Visible = False

    txtCampo(3).Text = ""
    txtCampo(0).SetFocus
    VLEnte% = True
    'txtpromotor.Text = ""
    VLyaingreso = 0
    
    cmbenvioec.ListIndex = 1
'    optdir(0).Enabled = True
'    optdir(0).Value = True

    VGPerfilCta = ""
    
    'HA20060826
    optdir(1).Value = True
    optdir_Click (1)
    
    txtCampo(21) = ""
    lblDescripcion(22) = ""
    
    Dim n As Integer
    Dim C As Integer
    For n = 0 To UBound(VLTipoDireccion, 1) - 1
      For C = 0 To UBound(VLTipoDireccion, 2) - 1
        VLTipoDireccion(n, C) = ""
      Next C
    Next n
    
    txtCampo(0).Enabled = True
    txtCampo(1).Enabled = True
    Lblalianza.Caption = ""
    lbldesalianza.Caption = ""
End Sub

Private Sub PLSalir()
'*************************************************************
' PROPOSITO: Sale de la forma de Apertura de Cuentas
'            de Ahorros.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Unload FTran201
End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Efectúa la llamada al stored procedure de
'            apertura de Cuentas de Ahorros para el
'            almacenamiento de los valores respectivos, bajo
'            ciertas condiciones.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VTOficina As String
    Dim VTTrn As String
    Dim VTR1 As Integer
    Dim VLFirmante As Integer
    Dim VTPatente As String
    Dim VTFuncionario As Integer
    Dim i As Integer
    Dim j As Integer
    Dim VLProdbanc As String
    Dim VLRespuesta As Integer
    Dim VTR As Integer
    Dim VLTipoDoc As String
    
    VLFirmante = 0
    
    For i = 1 To grdPropietarios.Rows - 1
        grdPropietarios.col = 5
        grdPropietarios.Row = i
        If (grdPropietarios.Text = "F") Or (grdPropietarios.Text = "U") Then
            VLFirmante = VLFirmante + 1
            VLTutor = True
        End If
    Next i
    ' La cuenta debe tener un tiltular
    If VLTitular% <= 0 Then
        MsgBox "La cuenta de ahorros debe tener al menos un titular", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If
    
    If txtCampo(18).Text = "I" Then
        If VLTutor = True Then
            If grdPropietarios.Rows > 3 Then
               MsgBox "Cuenta individual, solo puede tener un propietario", 0 + 16, "Mensaje de Error"
               txtCampo(18).SetFocus
               Exit Sub
            End If
        Else
            If grdPropietarios.Rows > 2 Then
               MsgBox "Cuenta individual, solo puede tener un propietario", 0 + 16, "Mensaje de Error"
               txtCampo(18).SetFocus
               Exit Sub
            End If
        End If
    Else
        If VLTutor = True Then
            If (grdPropietarios.Rows - VLFirmante) <= 2 Then
               MsgBox "Cuenta Multiple, debe tener mas de un propietario", 0 + 16, "Mensaje de Error"
               txtCampo(18).SetFocus
               Exit Sub
            End If
        Else
            If grdPropietarios.Rows <= 2 Then
               MsgBox "Cuenta Multiple, debe tener mas de un propietario", 0 + 16, "Mensaje de Error"
               txtCampo(18).SetFocus
               Exit Sub
            End If
        End If
    End If

    ' Nombre de la cuenta de ahrros
    If txtCampo(2).Text = "" Then
        MsgBox "El nombre de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(2).SetFocus
        Exit Sub
    End If

    ' Producto Bancario
    If txtCampo(8).Text = "" Then
        MsgBox "El código de Producto Bancario mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(8).SetFocus
        Exit Sub
    End If
    
    ' Producto Bancario de cuenta mercantil inválido
    'If Trim$(txtCampo(8).Text) = "2" Then
    '    MsgBox "No es posible aperturar Cuentas de Ahorros Mercantiles", 0 + 16, "Mensaje de Error"
    '    txtCampo(8).Text = ""
    '    lblDescripcion(11).Caption = ""
    '    txtCampo(8).SetFocus
    '    Exit Sub
    'End If


    ' Origen de la Cuenta
    If txtCampo(9).Text = "" Then
        MsgBox "El código de origen de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(9).SetFocus
        Exit Sub
    End If

    ' Patente de la cuenta
    If VGCodPais = "PA" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
       If Trim(txtCampo(12).Text) <> "" Then
          VTPatente = txtCampo(12).Text
       End If
    Else
        VTPatente = " "
    End If

    ' Direccion de cheques devueltos
    If txtCampo(13).Text = "" Then
        MsgBox "La dirección de los cheques devueltos es mandatorio", 0 + 16, "Mensaje de Error"
        Exit Sub
'        For i = 0 To 3
'            If optDireccion(i).Value = True Then
'                 optDirecciondv(i).Value = True
'            End If
'        Next i
'        txtCampo(13).Text = txtCampo(3).Text
'        txtCampo(13).Tag = txtCampo(3).Tag
'        lblDescripcion(15).Caption = lblDescripcion(6).Caption
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
    
         'Direccion del estado de cuenta
    If txtCampo(3).Text = "" Then
     '      MsgBox "La dirección del estado de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
'           For i = 0 To 3
'            If optDirecciondv(i).Value = True Then
'                 optDireccion(i).Value = True
'            End If
'        Next i
        txtCampo(3).Text = txtCampo(13).Text
        txtCampo(3).Tag = txtCampo(13).Tag
        lblDescripcion(6).Caption = lblDescripcion(15).Caption
    End If
    
    If lblDescripcion(6).Caption = "" And cmbenvioec.Text = "S" Then
        MsgBox "La Dirección de Estado de Cuenta es Mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(21).SetFocus
        Exit Sub
    End If
    
    If lblDescripcion(15).Caption = "" Then
        MsgBox "La Dirección de Cheques Devueltos es Mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(21).SetFocus
        Exit Sub
    End If
    
    ' Oficial de credito
    If txtCampo(4).Text = "" Then
        MsgBox "El código del oficial es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(4).SetFocus
        Exit Sub
    End If
    
    ' Tipo de Promedio
    If txtCampo(5).Text = "" Then
        MsgBox "El código del tipo de promedio es mandatorio", 0 + 16, "Mensaje de Error"
        'txtCampo(5).SetFocus
        Exit Sub
    End If
    
    ' Ciclo de la Cuenta
    If txtCampo(6).Text = "" Then
        MsgBox "El código del ciclo de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
       ' txtCampo(6).SetFocus
        Exit Sub
    End If

    ' Tipo de Capitalizacion
    If txtCampo(10).Text = "" Then
        MsgBox "El código del tipo de capitalización es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(10).Enabled = True Then
        txtCampo(10).SetFocus
        End If
        Exit Sub
    End If

'    txtCampo(11).Text = "0"
'    ' Número de Libreta
'    If txtCampo(11).Text = "" Then
'        MsgBox "El Número de Libreta es mandatorio", 0 + 16, "Mensaje de Error"
'        'txtCampo(11).SetFocus
'        Exit Sub
'    End If

    
    ' Categoria de la cuenta
    If txtCampo(7).Text = "" Then
        MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(7).SetFocus
        Exit Sub
    End If
    ' clasificacion del cliente
    If txtCampo(19).Text = "" Then
        MsgBox "El Código de la Clasificación del Cliente es Mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).SetFocus
        Exit Sub
    End If

    'Verificar que todos los titulares y cotitulares solo tengan una cuenta
    'super cash o super plus
    If Not FLVerificarTitularidad Then
        Exit Sub
    End If

    'Verificar el manejo de menores de edad
    If Not FLVerificarMenor Then
        Exit Sub
    End If

    'Verificar el manejo de menores de edad
    If Not FLVerificarExtranjero Then
        Exit Sub
    End If


    PLArmadoNomCta

    '  Codigo del promotor de la cuenta
    'If txtpromotor.Text <> "" Then
     '   PMPasoValores SqlConn&, "@i_promotor", 0, SQLINT2, txtpromotor.Text
    'Else
        'PMPasoValores SqlConn&, "@i_promotor", 0, SQLINT2, " "
    'End If

    If VGAperCifrada = True Then
      VTTrn = "320"
    Else
      VTTrn = "201"
    End If

    grdPropietarios.Row = VLTitular%
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTrn
    grdPropietarios.col = 1
     PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
     PMPasoValores sqlconn&, "@i_cli1", 0, SQLINT4, VLCotitular$
    grdPropietarios.col = 2

     PMPasoValores sqlconn&, "@i_cedruc", 0, SQLVARCHAR, (grdPropietarios.Text)
     PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, (txtCampo(2).Text)
    ' Personalizacion Banco Caribe Nombres Titular y Cotitular de la Cuenta
'    If txtCampo(12).Text <> "" Then
'        txtCampo(12).Text = " "
'        PMPasoValores sqlconn&, "@i_nombre1", 0, SQLVARCHAR, (txtCampo(12).Text)
'    Else
'      txtCampo(12).Text = " "
'       PMPasoValores sqlconn&, "@i_nombre1", 0, SQLVARCHAR, (txtCampo(12).Text)
'    End If
    PMPasoValores sqlconn&, "@i_nombre1", 0, SQLVARCHAR, " "
    
    If VLCedula1 <> "" Then
       VLCedula1 = " "
        PMPasoValores sqlconn&, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1$
    Else
      VLCedula1 = " "
       PMPasoValores sqlconn&, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1$
    End If
    ' Determinacion del tipo de direccion
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
    ElseIf VLTipoDireccion(0, 0) = "R" Then
        If Trim$(txtCampo(3).Text) = "" Then 'BANCO DEL CARIBE: 8 de marzo de 1999
          VTOficina$ = VGOficina$
        Else
          VTOficina$ = Trim$(txtCampo(3).Text)
        End If
        PMPasoValores sqlconn&, "@i_agencia", 0, SQLINT2, VTOficina$
        PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "R"
    End If
    ' Direccion cheques devueltos
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
    ElseIf VLTipoDireccion(1, 0) = "R" Then
        If Trim$(txtCampo(13).Text) = "" Then 'BANCO DEL CARIBE: 8 de marzo de 1999
          VTOficina$ = VGOficina$
        Else
          VTOficina$ = Trim$(txtCampo(13).Text)
        End If
        PMPasoValores sqlconn&, "@i_agencia_dv", 0, SQLINT2, VTOficina$
        PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "R"
    End If

     PMPasoValores sqlconn&, "@i_ofl", 0, SQLINT2, (txtCampo(4).Text)
     PMPasoValores sqlconn&, "@i_tprom", 0, SQLCHAR, (txtCampo(5).Text)
     PMPasoValores sqlconn&, "@i_categ", 0, SQLCHAR, (txtCampo(7).Text)
     PMPasoValores sqlconn&, "@i_tint", 0, SQLCHAR, (txtCampo(7).Text)
     PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, (txtCampo(6).Text)
     PMPasoValores sqlconn&, "@i_capit", 0, SQLCHAR, (txtCampo(10).Text)
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
     PMPasoValores sqlconn&, "@i_tdef", 0, SQLCHAR, "D"
     PMPasoValores sqlconn&, "@i_def", 0, SQLINT4, "0"
     PMPasoValores sqlconn&, "@i_rolente", 0, SQLCHAR, "1"
     PMPasoValores sqlconn&, "@i_rolcli", 0, SQLCHAR, "T"
     PMPasoValores sqlconn&, "@i_prodbanc", 0, SQLINT2, (txtCampo(8).Text)
     PMPasoValores sqlconn&, "@i_tipo_cta", 0, SQLINT2, (txtCampo(8).Text)
     PMPasoValores sqlconn&, "@i_origen", 0, SQLVARCHAR, (txtCampo(9).Text)
     PMPasoValores sqlconn&, "@i_numlib", 0, SQLINT4, "0" '(txtCampo(11).Text)
     
     PMPasoValores sqlconn&, "@i_tipocta_super", 0, SQLCHAR, (txtCampo(19).Text)
     
    'Si no se ingresa numero de solicitud
     If txtCampo(14).Text <> "" Then
        PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, (txtCampo(14).Text)
     Else
        grdPropietarios.Row = VLTitular%
        grdPropietarios.col = 1
        PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, grdPropietarios.Text
     End If

     'If txtCampo(7).Text = "E" Then
     '   PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, (txtCampo(14).Text)
     'Else
     '   grdPropietarios.Row = VLTitular%
     '   grdPropietarios.Col = 1
     '   PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, grdPropietarios.Text
     'End If

     
    If MskValor.Text = "" Then
        MskValor.Format = VGDecimales$
        MskValor.Text = Format$(0, VGDecimales$)
    End If
    PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, (MskValor.Text)
    PMPasoValores sqlconn&, "@o_funcio", 1, SQLINT1, "0"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    
    If VGCodPais$ = "PA" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
       If Trim(txtCampo(15).Text) <> "" Then
          PMPasoValores sqlconn&, "@i_fideicomiso", 0, SQLCHAR, (txtCampo(15).Text)
       End If
    End If
    If VGContractual$ = "S" Then
       If VGPlazo = "" Or VGDeposito = "" Then
          MsgBox "El Producto Contractual debe tener Plazo Y Deposito minimo", 0 + 16, "Mensaje de Error"
          txtCampo(7).SetFocus
       Else
          PMPasoValores sqlconn&, "@i_contractual", 0, SQLCHAR, VGContractual$
          PMPasoValores sqlconn&, "@i_plazo", 0, SQLINT2, VGPlazo
          PMPasoValores sqlconn&, "@i_deposito", 0, SQLMONEY, VGDeposito
          PMPasoValores sqlconn&, "@i_puntos", 0, SQLFLT8&, Format$(VGPuntos, "0##.000000")
          PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, VGProdFinal
          PMPasoValores sqlconn&, "@i_monto_final", 0, SQLMONEY, VGMontoFinal
          PMPasoValores sqlconn&, "@i_periodicidad", 0, SQLCHAR, VGPeriodicidad
          PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VGEstado$  'El estado se levanta cuando se cumplan las condiciones
       End If
    End If
    PMPasoValores sqlconn&, "@i_estado_cuenta", 0, SQLCHAR, (cmbenvioec.Text)
    PMPasoValores sqlconn&, "@i_titularidad", 0, SQLCHAR, (txtCampo(18).Text)    ' AVI 7-Jun-2005 G.Bank
    PMPasoValores sqlconn&, "@i_patente", 0, SQLVARCHAR, (VTPatente$)
    PMPasoValores sqlconn&, "@i_tipo_cta", 0, SQLINT2, (txtCampo(8).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_apertura_ah", True, " Ok... Apertura de la cuenta de ahorros") Then
    
        VGPerfilCta = "N"
        VGCancelar = "N"
        VGOrigen = "0"
        ReDim VTArreglo(20) As String
        VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        VTFuncionario = Val(FMRetParam(sqlconn&, 1))
        
        'Determinar si la cuenta aperturada es de funcionario
        If VTFuncionario = 1 Then
            chkFuncionario.Value = vbChecked
        End If
        

        For j = 1 To grdPropietarios.Rows - 1
            If j <> VLTitular% Then
                grdPropietarios.Row = j
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTrn
                grdPropietarios.col = 1
                PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                grdPropietarios.col = 2
                PMPasoValores sqlconn&, "@i_cedruc", 0, SQLVARCHAR, (grdPropietarios.Text)
                grdPropietarios.col = 5
                PMPasoValores sqlconn&, "@i_rolcli", 0, SQLCHAR, (grdPropietarios.Text)
                PMPasoValores sqlconn&, "@i_dprod", 0, SQLINT4, VTArreglo(3)
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_cli1", 0, SQLINT4, "0"
                PMPasoValores sqlconn&, "@i_estado_cuenta", 0, SQLCHAR, (cmbenvioec.Text)
                
                PMPasoValores sqlconn&, "@i_tipocta_super", 0, SQLCHAR, (txtCampo(19).Text)
                
                
                'Si no se ingresa numero de solicitud
                'No aplica para la version Colombia
                 'If txtCampo(7).Text = "E" Then
                 '   PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, (txtCampo(14).Text)
                 'Else
                 '   grdPropietarios.Row = VLTitular%
                 '   grdPropietarios.Col = 1
                 '   PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, grdPropietarios.Text
                 'End If
                 
                 PMPasoValores sqlconn&, "@i_patente", 0, SQLVARCHAR, (VTPatente$)
                 PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, VTArreglo(1)
                
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_apertura_ah", True, " Ok... Ingresando los propietarios") Then
                    PMChequea sqlconn&
                End If
            End If
            grdPropietarios.col = 5
            If grdPropietarios.Text = "T" Then
               grdPropietarios.col = 3
               If grdPropietarios.Text = "P" Then
                  VLBeneficiarios = True
               End If
            End If
        Next j%
        lblDescripcion(0).Caption = FMMascara$(VTArreglo(1), VGMascaraCtaAho$)
        VLCuenta0 = VTArreglo(1)
        lblDescripcion(1).Caption = FMConvFecha(VTArreglo(2), CGFormatoBase$, VGFormatoFecha$)
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = False
        'cmdBoton(5).Enabled = True
        If cmdBoton(9).Visible = True Then cmdBoton(9).Enabled = True
        If VGCodPais$ = "PA" Then cmdBoton(6).Enabled = True
        txtCampo(0).Enabled = False
        txtCampo(1).Enabled = False
        VLImprimio% = False

        If txtCampo(8).Text = VLProdProgresivo Then
           MsgBox "Recuerde Marcar esta Cuenta para Servicio de Abono de Remesas Recibidas del Exterior", 0 + 48, "Advertencia"
        End If
        
                'Req. 371 Verificar si en el catalogo el prod bancario bloq existe
                VLProdbanc = txtCampo(8).Text
        
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "747"
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "V"
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, VLProdbanc
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Consultando") Then
                        PMMapeaVariable sqlconn&, VLProdBancBloq
                        PMChequea sqlconn&
                Else
                        VLProdBancBloq = ""
                End If
        
                If VLProdBancBloq <> "" Then
                        MsgBox "Producto Bancario bloqueado y/o excluido no puede relacionarse con canales", 0 + 48, "Advertencia"
                        Exit Sub
                End If
                        
        'REQ363
        If (txtCampo(19).Text) <> 1 Then
            Exit Sub
        ElseIf (txtCampo(18).Text) = "M" Then
            Exit Sub
        Else
            VLRespuesta = MsgBox("Desea relacionar la Cuenta creada a Datos de Canales?", 4, "Confirmacion")
            If VLRespuesta = 7 Then
                cmdBoton(7).Enabled = True
                Exit Sub
            End If
            VGCuenta = VTArreglo(1)
            'Paso de parametros de búsqueda
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "206"
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR&, VGCuenta
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                ReDim VTArreglo(20) As String
                VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                VLNombre = VTArreglo(1)
                VLOficina = VTArreglo(2)
                VLTraslado_dtn = VTArreglo(3)
                VLTitularidad = VTArreglo(4)
                VLOficinaO = VTArreglo(5)
                VLEstado = VTArreglo(6)
                PMChequea sqlconn&
                If VLTitularidad = "CONJUNTA" Then
                    MsgBox "Cuenta con Titularidad Conjunta. No puede relacionarse a un canal ", 0 + 16, "Mensaje de Error"
                    Exit Sub
                Else
                    'Req. 371 Tarjeta Debito
                    VTR% = grdPropietarios.Rows - 1
                    For i = 1 To VTR
                        grdPropietarios.Row = i
                        grdPropietarios.col = 2
                        VLNumDoc = grdPropietarios.Text
                        VLTipoTran = "1610"
                        VGTipoDoc = ""
                        grdPropietarios.col = 3
                        VLTipoDoc = grdPropietarios.Text
                        If VLTipoDoc = "C" Then
                            MsgBox "Cuenta de Persona Jurídica. No puede relacionarse a un canal ", 0 + 16, "Mensaje de Error"
                            Exit Sub
                        End If
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1020"
                        PMPasoValores sqlconn&, "@i_frontend", 0, SQLCHAR&, "S"
                        PMPasoValores sqlconn&, "@i_cedruc", 0, SQLVARCHAR&, VLNumDoc
                        PMPasoValores sqlconn&, "@o_tipoced", 1, SQLVARCHAR&, "0"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_datos_cliente", True, "") Then
                            PMMapeaVariable sqlconn&, VGTipoDoc
                            PMChequea sqlconn&
                        End If
                        FMRegistraHuellaAValidar VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran
                    Next i
                    'Req. 371 Tarjeta Debito
                    If VGValidaHuella = True Then
                        'Req. 371 Tarjeta Debito
                        VLTipoTran = "1610"
                        FMVerificaHuella VGCuenta, VLTipoTran
                            If VGRegistraHuellaAValidar = True Then
                            FRelCtaCanal.Show
                        Else
                            Exit Sub
                        End If
                    End If
                    
                End If
            End If
        End If
    Else
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 18, 19, 12, 21
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
        FPrincipal!pnlHelpLine.Caption = " Nombre de la Cuenta de Ahorros"
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
        FPrincipal!pnlHelpLine.Caption = " Código de tipo de cuenta [F5 Ayuda]"
    Case 10
        FPrincipal!pnlHelpLine.Caption = " Código del tipo de capitalización [F5 Ayuda]"
    Case 11
        FPrincipal!pnlHelpLine.Caption = " Código de la Libreta"
    Case 13
        If VLTipoDireccion(1, 0) = "D" Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de Cheques devueltos [F5 Ayuda]"
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
    Case 18
        FPrincipal!pnlHelpLine.Caption = " Código de Titularidad [F5 Ayuda]"
    Case 19
        FPrincipal!pnlHelpLine.Caption = " Código Clasificación del Cliente [F5 Ayuda]"
    Case 12
        FPrincipal!pnlHelpLine.Caption = " Patente Comercial"
     Case 21
        FPrincipal!pnlHelpLine.Caption = " Catálogo Tipo de Direcciones [F5 Ayuda]"
    End Select
    
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    Dim VTCliente As String
    Dim VTTipoper As String
    Dim n As Integer
    If KeyCode = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 0  'F5 Cliente
            txtCampo(0).Text = ""
            VLPaso% = True
            Dim VTRes As Boolean
            Dim VTCliCif As Boolean
            Set FMain = FPrincipal
            If VGFBusCliente Is Nothing Then
               Set VGFBusCliente = New BuscarClientes
            End If
            Set FMain = FPrincipal
            If VGAperCifrada Then
              VTCliCif = False
            Else
              VTCliCif = True
            End If
            'VGFBusCliente.Cabecera_Busqueda True, VTCliCif, VTCliCif, VGAperCifrada, 1
            'Abrir forma de búsqueda de clientes
            VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
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
                        'REQ. 371 Agregado para extraer el tipo de documento del cliente
                        VGTipoDoc = VGFBusCliente.DatosCliente(6)
                    Else
                        lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(3)
                        lblDescripcion(4).Caption = VGFBusCliente.DatosCliente(2)
                        'REQ. 371 Agregado para extraer el tipo de documento del cliente
                        VGTipoDoc = VGFBusCliente.DatosCliente(4)
                        VLReferenah = VGFBusCliente.DatosCliente(5)
                    End If
                    txtCampo(1).SetFocus
                End If
             End If

        Case 1  'F5 Rol
            VLPaso% = True
            PMCatalogo "A", "cl_rol", txtCampo(1), lblDescripcion(5)
            If txtCampo(1).Text <> "" Then
                cmdBoton(0).SetFocus
            End If
        Case 3  'F5 Código de dirección
            If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
              MsgBox "El Tipo de Dirección de los Estado de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(3).Text = ""
              txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(0, 0) = "D" Then
                If VLNumero% <> 0 Then
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                    grdPropietarios.col = 1
                    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de direcciones") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMChequea sqlconn&
                        FCatalogo.Show 1
                        txtCampo(3).Text = VGACatalogo.Codigo$
                        lblDescripcion(6).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.col = 1
                        txtCampo(3).Tag = grdPropietarios.Text
                        If txtCampo(3).Text <> "" Then
                           VLPaso% = True
                           'txtCampo(11).SetFocus
                        End If
                    Else
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(0, 0) = "C" Then
                If VLNumero% <> 0 Then
                    grdPropietarios.col = 5
                    If grdPropietarios.Text = "F" Then
                        MsgBox "No se puede elegir Casillas postales de Firmantes", vbInformation, "Dirección postal del cliente"
                        txtCampo(3).Text = ""
                        lblDescripcion(6).Caption = ""
                        txtCampo(3).Tag = ""
                        Exit Sub
                    End If
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
                    grdPropietarios.col = 1
                    PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                    ' ojo definir con julio los valores de este stored procedure
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casillas") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
                        PMChequea sqlconn&
                        VLPaso% = True
                        FCatalogo.Show 1
                        txtCampo(3).Text = VGACatalogo.Codigo$
                        lblDescripcion(6).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.col = 1
                        txtCampo(3).Tag = grdPropietarios.Text
                    Else
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
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
                        grdPropietarios.col = 1
                        txtCampo(3).Tag = grdPropietarios.Text
                    Else
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If

            End If
        Case 4 ' F5 Busqueda de oficiales de crédito
            txtCampo(4).Text = ""
            FHelpOficial.Show 1
            If VGBusqueda(0) <> "*" Then
                txtCampo(4).Text = VGBusqueda(0)
                lblDescripcion(7).Caption = VGBusqueda(1)
                If txtCampo(4).Text <> "" Then
                    VLPaso% = True
                    'txtCampo(11).SetFocus
                    'txtpromotor.SetFocus
                End If
              Else
                txtCampo(4).Text = ""
                lblDescripcion(7).Caption = ""
            End If

        Case 5  ' F5 Tipo Promedio
            PMCatalogo "A", "ah_tpromedio", txtCampo(5), lblDescripcion(8)
            If txtCampo(5).Text <> "" Then
               VLPaso% = True
               'txtCampo(6).SetFocus
            End If
        Case 6  ' F5 Ciclo
            txtCampo(6).Text = ""
            PMCatalogo "A", "cc_ciclo", txtCampo(6), lblDescripcion(9)
            If txtCampo(6).Text <> "" Then
               VLPaso% = True
'               If txtCampo(11).Visible = True And txtCampo(11).Enabled = True Then
'                txtCampo(11).SetFocus
'               End If
            End If
        Case 7  'F5 Categoría
            If Trim$(txtCampo(8).Text) = "" Then
                MsgBox "El código de Producto Bancario mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                VLPaso% = True
                If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).SetFocus
                Exit Sub
            End If

            If VLTitular% <= 0 Then
                MsgBox "La cuenta de ahorros debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            Else
                grdPropietarios.Row = VLTitular%
                grdPropietarios.col = 3
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text
            PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(7).Text = VGACatalogo.Codigo$
                lblDescripcion(10).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(7).Text) <> "" Then
                    VLPaso% = True
                    If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).SetFocus
                End If
                VGPlazo = ""
                VGDeposito = ""
                PLBuscar_marca
                If VGCancelar = "S" Then
                   txtCampo(7).Text = ""
                   lblDescripcion(10).Caption = ""
                   txtCampo(7).SetFocus
                End If
            End If

        Case 8  ' F5 Productos Bancarios

            If VLTitular% <= 0 Then
                MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(8).Text = ""
                lblDescripcion(11).Caption = ""
                If txtCampo(8).Enabled Then txtCampo(8).SetFocus
                Exit Sub
            Else
                grdPropietarios.Row = VLTitular%
                grdPropietarios.col = 3
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
            End If

            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4093" '"4088"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text
            PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular$
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_capitalizacion_profinal", True, " Ok... Consulta de Tipos de Capitalización por Producto Final") Then
               PMMapeaObjetoAB sqlconn&, txtCampo(10), lblDescripcion(13)
               PMChequea sqlconn&
               txtCampo(10).Enabled = False
            End If
                    
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4097" '"4087"
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
               txtCampo(6).Enabled = False
            End If
        Case 9  ' F5 Origen cuenta
            txtCampo(9).Text = ""
            PMCatalogo "A", "ah_tipocta", txtCampo(9), lblDescripcion(12)
            ''No se debe permitir escoger el valor "8" del catálogo
''''            If txtCampo(9).Text = "8" Then
''''                txtCampo(9).Text = ""
''''                lblDescripcion(12).Caption = ""
''''            End If
            If txtCampo(9).Text <> "" Then
''               Mskvalor.SetFocus
               VLPaso% = True
            End If
        Case 10 'F5 Tipo capitalización
            PMCatalogo "A", "pe_capitalizacion", txtCampo(10), lblDescripcion(13) 'JAR Requerimiento FO-022
            If txtCampo(10).Text <> "" Then
               VLPaso% = True
               txtCampo(7).SetFocus
            End If
        Case 13  'F5 Código de dirección
            If VLTipoDireccion(1, 0) = "" Then
              MsgBox "El Tipo de Dirección de los Cheques Devueltos es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(13).Text = ""
              txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(1, 0) = "D" Then
                If VLNumero% <> 0 Then
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                    grdPropietarios.col = 1
                    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de direcciones") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMChequea sqlconn&
                        FCatalogo.Show 1
                        txtCampo(13).Text = VGACatalogo.Codigo$
                        lblDescripcion(15).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.col = 1 '0
                        txtCampo(13).Tag = grdPropietarios.Text
                        If txtCampo(13).Text <> "" Then
                           VLPaso% = True
                           'txtCampo(11).SetFocus
                        End If
                    Else
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "C" Then
                If VLNumero% <> 0 Then
                    grdPropietarios.col = 5
                    If grdPropietarios.Text = "F" Then
                        MsgBox "No se puede elegir Casillas postales de Firmantes", vbInformation, "Dirección postal del cliente"
                        txtCampo(13).Text = ""
                        lblDescripcion(15).Caption = ""
                        txtCampo(13).Tag = ""
                        Exit Sub
                    End If
                    PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
                    grdPropietarios.col = 1 '0
                    PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                    ' ojo definir con julio los valores de este stored procedure
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casillas") Then
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, True
                        PMChequea sqlconn&
                        VLPaso% = True
                        FCatalogo.Show 1
                        txtCampo(13).Text = VGACatalogo.Codigo$
                        lblDescripcion(15).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.col = 1 '0
                        txtCampo(13).Tag = grdPropietarios.Text
                    Else
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "R" Then
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
                        txtCampo(13).Text = VGACatalogo.Codigo$
                        lblDescripcion(15).Caption = VGACatalogo.Descripcion$
                        grdPropietarios.col = 1 '0
                        txtCampo(13).Tag = grdPropietarios.Text
                    Else
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If

            End If
            
        Case 18 'Codigo de Titularidad
            PMCatalogo "A", "re_titularidad", txtCampo(18), lblDescripcion(20)
            VLPaso% = True
        Case 19 'Clasificación del Cliente
            
            'Valida la existencia de un titular en el grid
            If grdPropietarios.Rows <= 2 Then
                grdPropietarios.col = 1
                grdPropietarios.Row = 1
                If grdPropietarios.Text = "" Then
                    MsgBox "Debe ingresar un titular en la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                    VLPaso% = True
                    Exit Sub
                End If
            End If
        
            'Guarda el Tipo de cliente del Titular
            grdPropietarios.Row = 1
            grdPropietarios.col = 3
            VTTipoper = grdPropietarios.Text
            grdPropietarios.col = 1
                
            'Llama el catálogo
            PMCatalogo "A", "ah_cla_cliente", txtCampo(19), lblDescripcion(14)
            VLPaso% = True
            If txtCampo(19).Text <> "" Then
                'If txtCampo(13).Visible And txtCampo(13).Enabled Then txtCampo(13).SetFocus
                If txtCampo(12).Visible And txtCampo(12).Enabled Then txtCampo(12).SetFocus
                If txtCampo(19).Text <> "1" And VTTipoper = "P" Then
                    MsgBox "Clasificación Cliente incompatible con Tipo de Persona del Titular", 0 + 16, "Mensaje de Error"
                    txtCampo(19).Text = ""
                    lblDescripcion(14).Caption = ""
                    txtCampo(19).SetFocus
                    Exit Sub
                End If
                If txtCampo(19).Text = "1" And VTTipoper = "C" Then
                    MsgBox "Clasificación Cliente incompatible con Tipo de Persona del Titular", 0 + 16, "Mensaje de Error"
                    txtCampo(19).Text = ""
                    lblDescripcion(14).Caption = ""
                    txtCampo(19).SetFocus
                    Exit Sub
                End If
            End If
        Case 21 'Tipo de Direcciones
            VLPaso% = True
            PMCatalogo "A", "cl_direccion_ec", txtCampo(21), lblDescripcion(22)
            If txtCampo(21) <> "" Then
              PLlblEtiqueta txtCampo(21)
              n = IIf(optdir(0).Value = True, 0, 1)
              VLTipoDireccion(n, 0) = txtCampo(21)
              VLTipoDireccion(n, 1) = lblDescripcion(22)
            End If
        End Select
        VLPaso% = True
    End If
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 3, 6, 4, 8, 9, 11, 13, 19
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    Case 1, 5, 10, 18, 21
        KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
    Case 2
        KeyAscii% = FMVAlidaTipoDato("B", KeyAscii%)
    Case 12, 21
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    Case 14
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 7, 15
        KeyAscii% = FMVAlidaTipoDato("U", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTR1 As Integer
    Dim VLAlianza As String
    Dim VLDesAlianza As String
    Dim VTSubtipo As String
    Dim VLBloqueado As String
    Dim VLMalaref As String
    Dim VLLista As String
    Dim VTTipoper As String
    Dim n As Integer
    Select Case Index%
    Case 0  'F5 Cliente
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q" '"H"
                PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0).Text)
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1181"  '"1225"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    ReDim VTValores(15) As String
                    VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
                    PMMapeaVariable sqlconn&, VLAlianza
                    PMMapeaVariable sqlconn&, VLDesAlianza
                    PMChequea sqlconn&
                    VTSubtipo = VTValores(3)
                    'PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (txtCampo(0).Text)
                    'PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1182"
                    'PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT1&, "1"
                    'PMPasoValores sqlconn&, "@i_subtipo", 0, SQLCHAR, VTSubtipo
                    'If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_se_ente", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    '    ReDim VTValores(15) As String
                    '    VTR1% = FMMapeaArreglo(sqlconn&, VTValores())
                    '    PMChequea sqlconn&
                         VTRefercliente = VTValores(5)
                    'End If
                    'lblDescripcion(2).Caption = VTValores(1)
                    lblDescripcion(3).Caption = VTSubtipo
                    If VTSubtipo = "P" Then
                        lblDescripcion(2).Caption = VTValores(1)
                        VTCliente = VTValores(2)  'VTValores(2) + " " + VTValores(3) + " " + VTValores(4)
                        lblDescripcion(4).Caption = VTCliente
                        VLReferencia = VTValores(5)
                    Else
                        lblDescripcion(2).Caption = VTValores(1)
                        lblDescripcion(4).Caption = VTValores(2)
                        VLReferencia = VTValores(5)
                    End If
                    Lblalianza.Caption = VLAlianza
                    lbldesalianza.Caption = VLDesAlianza
                    If txtCampo(1).Text = "" Then
                        txtCampo(1).SetFocus
                    Else
                        cmdBoton(0).SetFocus
                    End If
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(2).Caption = ""
                    lblDescripcion(4).Caption = ""
                    lblDescripcion(3).Caption = ""
                    Lblalianza.Caption = ""
                    lbldesalianza.Caption = ""
                    txtCampo(0).SetFocus
                End If
            Else
                lblDescripcion(2).Caption = ""
                lblDescripcion(4).Caption = ""
                lblDescripcion(3).Caption = ""
            End If
        End If
        'REQ I002-ENTEBLOQUEADO  -OUS
        If txtCampo(0).Text <> "" Then
            VLMensajeBlq = ""
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "175"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "B"
            PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, txtCampo(0)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_ente_bloqueado", True, "Ok..Consulta Clientes Bloqueados") Then
                 PMMapeaVariable sqlconn&, VLBloqueado
                 PMMapeaVariable sqlconn&, VLMalaref
                 PMMapeaVariable sqlconn&, VLLista
                 PMMapeaVariable sqlconn&, VLMensajeBlq
                 PMChequea sqlconn&
            Else
                PMChequea sqlconn&
                lblDescripcion(2).Caption = ""
                lblDescripcion(3).Caption = ""
                lblDescripcion(4).Caption = ""
                txtCampo(0).Text = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If

    
            If VLBloqueado = "S" And VLMalaref = "N" Then
               MsgBox "Cliente está Bloqueado", 48, "Control de Datos del Clientes"
               lblDescripcion(2).Caption = ""
               lblDescripcion(3).Caption = ""
               lblDescripcion(4).Caption = ""
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               Exit Sub
            End If
    
            If VLMalaref = "S" Then
               MsgBox VLMensajeBlq, 48, "Control de Clientes Reportados"
               lblDescripcion(2).Caption = ""
               lblDescripcion(3).Caption = ""
               lblDescripcion(4).Caption = ""
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               Exit Sub
            End If
            
            If VLMalaref = "N" And VLMensajeBlq <> "" Then
               MsgBox VLMensajeBlq$, 48, "Control de Clientes Reportados"
            End If
        End If
    Case 1  'F5 Rol
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                PMCatalogo "V", "cl_rol", txtCampo(1), lblDescripcion(5)
                VLPaso% = True
            Else
                lblDescripcion(5).Caption = ""
            End If
        End If
    Case 3  'F5 Código de dirección
        If VLPaso% = False Then
            If VLTipoDireccion(0, 0) = "" And cmbenvioec.Text = "S" Then
              MsgBox "El Tipo de Dirección de los Estado de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(3).Text = ""
              txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(0, 0) = "D" Then
                If VLNumero% <> 0 Then
                    If txtCampo(3).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                        grdPropietarios.col = 1
                        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                        PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT2, (txtCampo(3).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1229"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(6)
                            PMChequea sqlconn&
                            grdPropietarios.col = 1
                            txtCampo(3).Tag = grdPropietarios.Text
                        Else
                            txtCampo(3).Text = ""
                            lblDescripcion(6).Caption = ""
                            txtCampo(3).Tag = ""
                            txtCampo(3).SetFocus
                        End If
                    Else
                        lblDescripcion(6).Caption = ""
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Tag = ""
                    txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "C" Then
                If VLNumero% <> 0 Then
                    If txtCampo(3).Text <> "" Then
                        grdPropietarios.col = 5
                        If grdPropietarios.Text = "F" Then
                            MsgBox "No se puede elegir Casillas postales de Firmantes", vbInformation, "Dirección postal del cliente"
                            txtCampo(3).Text = ""
                            lblDescripcion(6).Caption = ""
                            txtCampo(3).Tag = ""
                            Exit Sub
                        End If
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                        grdPropietarios.col = 1 '0
                        PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_casi", 0, SQLINT2, (txtCampo(3).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casilla " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(6)
                            PMChequea sqlconn&
                            grdPropietarios.col = 1
                            txtCampo(3).Tag = grdPropietarios.Text
                        Else
                            txtCampo(3).Text = ""
                            lblDescripcion(6).Caption = ""
                            txtCampo(3).Tag = ""
                            txtCampo(3).SetFocus
                        End If
                    Else
                        lblDescripcion(6).Caption = ""
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Tag = ""
                    txtCampo(0).SetFocus
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
                            grdPropietarios.col = 1
                            txtCampo(3).Tag = grdPropietarios.Text
                        Else
                            txtCampo(3).Text = ""
                            lblDescripcion(6).Caption = ""
                            txtCampo(3).Tag = ""
                            txtCampo(3).SetFocus
                        End If
                    Else
                        lblDescripcion(6).Caption = ""
                        txtCampo(3).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Tag = ""
                    txtCampo(0).SetFocus
                End If
            End If
        End If
        VLPaso% = True
    Case 4  ' F5 Busqueda de oficiales de crédito
        If VLPaso% = False Then
            If txtCampo(4).Text <> "" Then
                If txtCampo(4).Text >= 32000 Then
                    MsgBox "El codigo del Oficial no puede ser mayor a 32000", 0 + 16, "Mensaje de Error"
                    txtCampo(4).SetFocus
                    Exit Sub
                End If
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15153"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_oficial", 0, SQLINT2, (txtCampo(4).Text)
                
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tr_cons_oficiales", True, "Ok.. Consulta de Oficiales de Crédito") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(7)
                    PMChequea sqlconn&
                    VLPaso% = True
                Else
                    txtCampo(4).Text = ""
                    lblDescripcion(7).Caption = ""
                    txtCampo(4).SetFocus
                End If
            Else
                lblDescripcion(7).Caption = ""
            End If
        End If
    Case 5  ' F5 Tipo Promedio
        If VLPaso% = False Then
            If txtCampo(5).Text <> "" Then
                PMCatalogo "V", "ah_tpromedio", txtCampo(5), lblDescripcion(8)
                VLPaso% = True
            Else
                lblDescripcion(8).Caption = ""
            End If
        End If
    Case 6  ' F5 Ciclo
        If VLPaso% = False Then
            If txtCampo(6).Text <> "" Then
                PMCatalogo "V", "cc_ciclo", txtCampo(6), lblDescripcion(9)
                VLPaso% = True
            Else
                lblDescripcion(9).Caption = ""
            End If
        End If
    Case 7  'F5 Categoría
        If VLPaso% = False Then
            If Trim$(txtCampo(7).Text) <> "" Then
                If Trim$(txtCampo(8).Text) = "" Then
                    MsgBox "El código de Producto Bancario mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    If txtCampo(8).Enabled Then txtCampo(8).SetFocus
                    Exit Sub
                End If

                If VLTitular% <= 0 Then
                    MsgBox "La cuenta de ahorros debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    txtCampo(0).SetFocus
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular%
                    grdPropietarios.col = 3
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
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(10)
                    PMChequea sqlconn&
                    VLPaso% = True
                    VGPlazo = ""
                    VGDeposito = ""
                    PLBuscar_marca
                    If VGCancelar = "S" Then
                       VGCancelar = "N"
                       txtCampo(7).Text = ""
                       lblDescripcion(10).Caption = ""
                       txtCampo(7).SetFocus
                    End If
                Else
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    txtCampo(7).SetFocus
                End If
            
            Else
                lblDescripcion(10).Caption = ""
            End If
        End If

    Case 8  ' F5 Productos Bancarios
    
        If VLPaso% = False Then
            If txtCampo(8).Text <> "" Then
                
                If VLTitular% <= 0 Then
                    MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(8).Text = ""
                    lblDescripcion(8).Caption = ""
                    If txtCampo(8).Enabled Then txtCampo(8).SetFocus
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular%
                    grdPropietarios.col = 3
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
                          
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4093" '"4088"
                    PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
                    PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
                    PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(8).Text
                    PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, VLTipoEnteTitular$
                    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
                    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                    PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
                    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_capitalizacion_profinal", True, " Ok... Consulta de Tipos de Capitalización por Producto Final") Then
                       PMMapeaObjetoAB sqlconn&, txtCampo(10), lblDescripcion(13)
                       PMChequea sqlconn&
                       txtCampo(10).Enabled = False
                    End If
                    
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4097" '"4087"
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
                       txtCampo(6).Enabled = False
                    End If
        
                    VLPaso% = True
                    
                Else
                    txtCampo(8).Text = ""
                    lblDescripcion(11).Caption = ""
                    txtCampo(6).Text = ""
                    lblDescripcion(9).Caption = ""
                    txtCampo(10).Text = ""
                    lblDescripcion(13).Caption = ""
                    If txtCampo(8).Enabled Then txtCampo(8).SetFocus
                End If

            Else
                lblDescripcion(11).Caption = ""
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                txtCampo(6).Text = ""
                lblDescripcion(9).Caption = ""
                txtCampo(10).Text = ""
                lblDescripcion(13).Caption = ""
            End If
        End If

    Case 9  ' F5 Origen cuenta
        If VLPaso% = False Then
            If txtCampo(9).Text <> "" Then
                PMCatalogo "V", "ah_tipocta", txtCampo(9), lblDescripcion(12)
            Else
                lblDescripcion(12).Caption = ""
            End If
        End If
    Case 10 'F5 Tipo capitalización
        If VLPaso% = False Then
            If txtCampo(10).Text <> "" Then
                PMCatalogo "V", "pe_capitalizacion", txtCampo(10), lblDescripcion(13) 'JAR Requerimiento FO-022
                VLPaso% = True
            Else
                lblDescripcion(13).Caption = ""
            End If
        End If
    Case 13  'F5 Código de dirección
        If VLPaso% = False Then
            If VLTipoDireccion(1, 0) = "" Then
              MsgBox "El Tipo de Dirección de los Cheques Devueltos es mandatorio", 0 + 16, "Mensaje de Error"
              VLPaso% = True
              txtCampo(13).Text = ""
              txtCampo(21).SetFocus
              Exit Sub
            End If
            If VLTipoDireccion(1, 0) = "D" Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                        grdPropietarios.col = 1
                        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                        PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1229"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(15)
                            PMChequea sqlconn&
                            grdPropietarios.col = 1 '0
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(15).Caption = ""
                            txtCampo(13).Tag = ""
                            txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(15).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    txtCampo(13).Text = ""
                    lblDescripcion(15).Caption = ""
                    txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "C" Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        grdPropietarios.col = 5
                        If grdPropietarios.Text = "F" Then
                            MsgBox "No se puede elegir Casillas postales de Firmantes", vbInformation, "Dirección postal del cliente"
                            txtCampo(13).Text = ""
                            lblDescripcion(15).Caption = ""
                            txtCampo(13).Tag = ""
                            Exit Sub
                        End If
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                        grdPropietarios.col = 1 '0
                        PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_casi", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casilla " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(15)
                            PMChequea sqlconn&
                            grdPropietarios.col = 1 '0
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(15).Caption = ""
                            txtCampo(13).Tag = ""
                            txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(15).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    txtCampo(0).SetFocus
                End If
            ElseIf VLTipoDireccion(1, 0) = "R" Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "H"
                        PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de sucursal") Then 'agencias") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(15)
                            PMChequea sqlconn&
                            grdPropietarios.col = 1 '0
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(15).Caption = ""
                            txtCampo(13).Tag = ""
                            txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(15).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    txtCampo(0).SetFocus
                End If
            End If
        End If
        VLPaso% = True
    
    Case 14  'Busqueda de solicitud
        If txtCampo(14).Text <> "" Then
            PLBuscar
            VLPaso% = True
            grdPropietarios.Row = 1
            grdPropietarios.col = 1
            VLCodTitular = grdPropietarios.Text
            plAlianza
        End If
    Case 18 'Titularidad
        If VLPaso% = False Then
            If txtCampo(18).Text <> "" Then
                PMCatalogo "V", "re_titularidad", txtCampo(18), lblDescripcion(20)
            Else
                lblDescripcion(20).Caption = ""
            End If
        End If
    
    Case 19 'Clasificación del Cliente
        If VLPaso% = False Then
          If grdPropietarios.Rows <= 2 Then
              grdPropietarios.col = 1
              grdPropietarios.Row = 1
              If grdPropietarios.Text = "" Then
                  MsgBox "Debe ingresar un titular en la cuenta", 0 + 16, "Mensaje de Error"
                  txtCampo(19).Text = ""
                  txtCampo(0).SetFocus
                  Exit Sub
              End If
          End If
         
         'Guarda el Tipo de cliente del Titular
         grdPropietarios.Row = 1
         grdPropietarios.col = 3
         VTTipoper = grdPropietarios.Text
         grdPropietarios.col = 1
        End If
        
        If VLPaso% = False Then
            If txtCampo(19).Text <> "" Then
                PMCatalogo "V", "ah_cla_cliente", txtCampo(19), lblDescripcion(14)
                If txtCampo(19).Text <> "1" And VTTipoper = "P" Then
                    MsgBox "Clasificación Cliente incompatible con Tipo de Persona del Titular", 0 + 16, "Mensaje de Error"
                    txtCampo(19).Text = ""
                    lblDescripcion(14).Caption = ""
                    txtCampo(19).SetFocus
                    Exit Sub
                End If
                If txtCampo(19).Text = "1" And VTTipoper = "C" Then
                    MsgBox "Clasificación Cliente incompatible con Tipo de Persona del Titular", 0 + 16, "Mensaje de Error"
                    txtCampo(19).Text = ""
                    lblDescripcion(14).Caption = ""
                    txtCampo(19).SetFocus
                    Exit Sub
                End If
                VLPaso% = True
            Else
                lblDescripcion(14).Caption = ""
            End If
        End If
    Case 21
      If VLPaso% = False Then
        If txtCampo(21).Text <> "" Then
          PMCatalogo "V", "cl_direccion_ec", txtCampo(21), lblDescripcion(22)
          n = IIf(optdir(0).Value = True, 0, 1)
          VLTipoDireccion(n, 0) = txtCampo(21)
          VLTipoDireccion(n, 1) = lblDescripcion(22)
          PLlblEtiqueta txtCampo(21)
        End If
      End If
    End Select
End Sub
'FIXIT: Declare JTA 'FLVerificarTitularidad' with an early-bound data type                     FixIT90210ae-R1672-R1B8ZE
Private Function FLVerificarTitularidad() As Boolean
'*************************************************************
' PROPOSITO: Determinar que todos los propietarios no tengan
'            mas de una cuenta super cash y una super plus
' INPUT    : Ninguno
' OUTPUT   : FLVerificarTitularidad   'true si se puede crear
'                                     la nueva cuenta
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 24-Mar-05      D. Villagomez   Emision iniciañ
'*************************************************************
Dim VTCadena As String
Dim vti As Integer
Dim j As Integer
    vti = 0
    FLVerificarTitularidad = False
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "344"
    PMPasoValores sqlconn&, "@i_prod_banc", 0, SQLINT2, txtCampo(8).Text
    For j = 1 To grdPropietarios.Rows - 1
        grdPropietarios.Row = j
        grdPropietarios.col = 5
        VTCadena = ""
        If grdPropietarios.Text = "T" Or grdPropietarios.Text = "C" Then
            vti = vti + 1
            grdPropietarios.col = 1 'codigo
            VTCadena = VTCadena + (grdPropietarios.Text) + "@"
            grdPropietarios.col = 4 'nombre
            VTCadena = VTCadena + (grdPropietarios.Text) + "@"
            PMPasoValores sqlconn&, "@i_param" + CStr(vti%), 0, SQLCHAR&, VTCadena
        End If
    Next j
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_valida_titularidad", True, " Ok... Valida Titularidad") Then
        'Tomar variables de output con código temporal
        PMChequea sqlconn&
        vti% = FMRetStatus(sqlconn&)
        If vti% <> 0 Then
            Exit Function
        End If
        FLVerificarTitularidad = True
    Else
        PMChequea sqlconn&
        Exit Function
    End If
 End Function


    
'FIXIT: Declare JTA 'FLVerificarMenor' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Private Function FLVerificarMenor() As Boolean
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
    Dim j As Integer
    For j = 1 To grdPropietarios.Rows - 1
        grdPropietarios.Row = j
        grdPropietarios.col = 5
        VTCadena = ""
        vti = vti + 1
        grdPropietarios.col = 1 'codigo
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.col = 5 'rol
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.col = 4 'nombre
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        PMPasoValores sqlconn&, "@i_param" + CStr(vti), 0, SQLCHAR&, VTCadena
    Next j
    
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
Public Sub PLBuscar()
'*************************************************************
' PROPOSITO: Efectúa la llamada al stored procedure de
'            solicitud de apertura de cuenta de ahorros
'            para validar su existencia.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLSolicitud$
Dim VTR1 As Integer
Dim VTR As Integer
Dim VLMon As Integer
Dim i As Integer
Dim j As Integer
Dim VLCed As String
    ' Validaciones de Mandatoriedades
    
    ' Numero de Solicitud
    If txtCampo(14).Text = "" Then
        MsgBox "El número de solicitud es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(10).Enabled Then txtCampo(10).SetFocus
        Exit Sub
    End If
    
    VLSolicitud$ = txtCampo(14).Text

    ' Limpiar la forma, para el seteo de los datos de la solicitud
    PLLimpiar
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "355"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, VLSolicitud$ '(txtCampo(14).Text)

    '*************** FRC-AHO-004********************CMU BPT 08/01/06
    PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, VGOficina$
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "SI"
    '*************** FRC-AHO-004********************

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Consulta Solicitud de la cuenta") Then
        ReDim VTArreglo(20) As String
        VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        VLMon = CInt(VTArreglo(3))
        If VTArreglo(9) = "AP" Then
            cmdBoton(5).Enabled = False
            cmdBoton(2).Enabled = True
            txtCampo(14).Text = VLSolicitud$
            txtCampo(14).Enabled = False
        Else
            If VTArreglo(9) = "PR" Then
                MsgBox "La solicitud ya fue aperturada", 0 + 16, "Mensaje de Error"
            Else
                MsgBox "La solicitud no esta aprobada", 0 + 16, "Mensaje de Error"
            End If
            'cmdBoton(5).Enabled = False
            txtCampo(14).Text = ""
            If txtCampo(14).Visible And txtCampo(14).Enabled Then txtCampo(14).SetFocus
            Exit Sub
        End If
    
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "356"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S1"
        PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, VLSolicitud$ '(txtCampo(14).Text)
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "1"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Consulta Solicitud de la cuenta") Then
            ReDim Valores(8, 40) As String
            VTR = FMMapeaMatriz(sqlconn&, Valores())
            For i = 1 To VTR
                If Valores(1, i) <> "" Then
                    VLCed = Valores(1, i)
                Else
                    VLCed = Valores(2, i)
                End If
                grdPropietarios.AddItem Str$(i) & Chr(9) & Valores(0, i) & Chr(9) & VLCed$ & Chr(9) & Valores(3, i) & Chr(9) & Valores(4, i) & Chr(9) & Valores(5, i) & Chr(9) & Valores(6, i) '& Chr(9) & Valores(7, i)
                If Valores(3, i) = "P" And Valores(5, i) = "T" Then 'Presenta pantalla de beneficiarios
                   VLBeneficiarios = True
                End If
            Next i
            ReDim ValEnte(16) As String
            VTR1% = FMMapeaArreglo(sqlconn&, ValEnte())
            PMChequea sqlconn&
            If VGCodPais$ = "CO" Then
                txtCampo(0).Enabled = False
                txtCampo(1).Enabled = False
            End If
        End If
        If grdPropietarios.Rows > 2 Then
            grdPropietarios.RemoveItem 1
        End If
        PLAjustaGrid grdPropietarios, Me
        grdPropietarios.Row = 0
        grdPropietarios.col = 1
        grdPropietarios.Text = "CODIGO"
        grdPropietarios.col = 2
        'grdPropietarios.Text = "CI o RIF o PAS"
        grdPropietarios.Text = "IDENTIFICACION"
        grdPropietarios.col = 3
        grdPropietarios.Text = "TP."
        grdPropietarios.col = 4
        grdPropietarios.Text = "NOMBRE"
        grdPropietarios.col = 5
        grdPropietarios.Text = "TIT."
        grdPropietarios.col = 6
        grdPropietarios.Text = "DESCRIPCION"

        VLTitular% = 1
        grdPropietarios.Tag = "T"
        For j = 1 To grdPropietarios.Rows - 1
             grdPropietarios.Row = j
             grdPropietarios.col = 5
             If Trim$(grdPropietarios.Text) = "T" Then
                grdPropietarios.col = 4
                txtCampo(2).Text = grdPropietarios.Text
                grdPropietarios.col = 1
                VLCodTitular = grdPropietarios.Text
                VLTitular% = j
                grdPropietarios.col = 3
                VLTipoEnteTitular$ = grdPropietarios.Text
                VLyaingreso = 1  'PCOELLO
             End If
             VLNumero% = VLNumero% + 1
        Next j
        grdPropietarios.Row = 1
        grdPropietarios.Refresh
        grdPropietarios.col = 0
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row

        txtCampo(8).Text = VTArreglo(5)
        txtCampo(8).Enabled = False
        txtCampo_LostFocus (8)
        txtCampo(7).Text = VTArreglo(10)
        txtCampo_LostFocus (7)
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        'plAlianza
    Else
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
        txtCampo(14).Text = ""
        If txtCampo(14).Visible And txtCampo(14).Enabled Then txtCampo(14).SetFocus
    End If

    If VLEnte% = True Then
       grdPropietarios.col = 3
       VLTipoEnte$ = grdPropietarios.Text
       For i = 1 To (grdPropietarios.Rows - 1)
         grdPropietarios.Row = i
         If (grdPropietarios.Text) = "C" Then
             VLTipoEnte$ = grdPropietarios.Text
             grdPropietarios.col = 5
             If (Trim$(grdPropietarios.Text) = "T") Then
                Exit For
             End If
         End If
       Next i
       VLEnte% = False
    End If
    
' txtCampo(11).SetFocus

End Sub
Private Sub plAlianza()
    Dim VTR1 As Integer
    Dim VLAlianza As String
    Dim VLDesAlianza As String
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q" '"H"
     PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, VLCodTitular
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1181"  '"1225"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
       ReDim VTValores(15) As String
       VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
       PMMapeaVariable sqlconn&, VLAlianza
       PMMapeaVariable sqlconn&, VLDesAlianza
       PMChequea sqlconn&
       Lblalianza.Caption = VLAlianza
       lbldesalianza.Caption = VLDesAlianza
     Else
       Lblalianza.Caption = ""
       lbldesalianza.Caption = ""
     End If
End Sub

'FIXIT: Declare JTA 'FLVerificarExtranjero' with an early-bound data type                      FixIT90210ae-R1672-R1B8ZE
Private Function FLVerificarExtranjero() As Boolean
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
Dim j As Integer
    vti = 0
    FLVerificarExtranjero = False
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "350"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLINT2, "1"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
    PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, (txtCampo(14).Text)
    For j = 1 To grdPropietarios.Rows - 1
        grdPropietarios.Row = j
        grdPropietarios.col = 4
        VTCadena = ""
        vti = vti + 1
        grdPropietarios.col = 1 'codigo
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.col = 5 'rol
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.col = 4 'nombre
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        PMPasoValores sqlconn&, "@i_param" + CStr(vti%), 0, SQLCHAR&, VTCadena
    Next j
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_valida_menor", True, " Ok... Valida Titularidad") Then
        'Tomar variables de output con código temporal
        PMChequea sqlconn&
        vti% = FMRetStatus(sqlconn&)
        If vti% <> 0 Then
            Exit Function
        End If
        FLVerificarExtranjero = True
    Else
        PMChequea sqlconn&
        Exit Function
    End If
 End Function
Private Sub PLArmadoNomCta()
On Error GoTo Error_Armado_Cuenta
    Dim VTTemp1 As String
    Dim VTNombreCta As String
    Dim VTString  As String
    Dim VTcontador As Integer
    Dim i As Integer
    Dim j As Integer
    
    VTTemp1 = txtCampo(2).Text
    'VTTemp2$ = txtCampo(11).Text
    
    VTNombreCta = ""
    VTString = ""
    
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
    VTcontador = 0
    
    For j = 0 To UBound(VTMatrizprop, 2)
        For i = 0 To UBound(VTMatrizprop, 1) - 1
        
            If i = 2 Then
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                If UCase(VTMatrizprop(i, j)) = "P" Then 'Procesar si es solamente persona
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                    If UCase(VTMatrizprop(4, j)) = "T" Or UCase(VTMatrizprop(4, j)) = "C" Then
    
                        If (UBound(VTMatrizprop, 2)) > 0 Then
                            VTcontador = VTcontador + 1
    
                            If VTcontador = 1 Then
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                                VTNombreCta$ = UCase(VTMatrizprop(3, j)) 'grdPropietarios.Text '& VTString$
                            Else
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
                                VTNombreCta$ = VTNombreCta$ & VTString$ & UCase(VTMatrizprop(3, j)) 'grdPropietarios.Text
                            End If
                        End If
                    End If
                Else
                    txtCampo(2).Text = VTTemp1$
                    'txtCampo(11).Text = VTTemp2$
                    Exit Sub
                End If
            End If
        
        Next i
    Next j%
           
    If VTcontador% >= 2 Then '(UBound(VTMatrizprop, 2)) > 0 Then
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
    lbletiqueta(12).Caption = "Código de dirección:"
  Case "C"
    lbletiqueta(12).Caption = "Código de casilla:"
  Case "R"
    lbletiqueta(12).Caption = "Código de sucursal:"
  Case "S"
    lbletiqueta(12).Caption = "No. de casillero:"
  End Select
ElseIf optdir(1) Then
  lblDescripcion(15).Visible = True
  txtCampo(13).Text = ""
  lblDescripcion(15).Caption = ""
  Select Case Etiqueta
  Case "D"
    lbletiqueta(19).Caption = "Código de dirección:"
  Case "C"
    lbletiqueta(19).Caption = "Código de casilla:"
  Case "R"
    lbletiqueta(19).Caption = "Código de sucursal:"
  Case "S"
    lbletiqueta(19).Caption = "No. de casillero:"
  End Select
End If
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 4, 5, 6, 7, 8, 9, 10, 13, 18, 19, 14, 21
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
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
Dim VTParamContracual As String
Dim VTR1 As Integer
Dim VLProdfinal As String
Dim VLParametriza As String
Dim VLMarca As String

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHCT"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1 = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    VTParamContracual = VLParametro(6, 1)
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHPR"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(6, 1) = txtCampo(8).Text Then
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
    If VLParametro(3, 1) = txtCampo(7).Text Then
        VTCambiaCategoria = "S"
    Else
        VTCambiaCategoria = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 734
PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, txtCampo(7).Text
PMPasoValores sqlconn&, "@i_prodban", 0, SQLVARCHAR, txtCampo(8).Text
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
PMPasoValores sqlconn&, "@i_tipoente", 0, SQLCHAR, VLTipoEnteTitular$

If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mto_aho_contractual", True, "Ok... Consulta Marca Contractual") Then
   PMMapeaVariable sqlconn&, VGContractual$
   PMMapeaVariable sqlconn&, VLProdfinal
   PMMapeaVariable sqlconn&, VLParametriza
   PMMapeaVariable sqlconn&, VLMarca
   
   If VGContractual$ = "S" Or VGProgresivo$ = "S" Then
      If VLParametriza <> 0 Or (VTCambiaCategoria = "S" And txtCampo(8).Text = VTParamContracual) Then
         VGcategoria = txtCampo(7).Text
         VGprofinal = VLProdfinal
         VGOrigen = "0"
         VGNombreCuenta = txtCampo(2).Text
         Ftran434.Show 1
      Else
        MsgBox "No existe parametrizacion para el Producto Final " + VLProdfinal$ + " y Categoria " + txtCampo(7).Text + " ", 0 + 16, "Mensaje de Error"
        txtCampo(7).Text = ""
        lblDescripcion(10).Caption = ""
        txtCampo(7).SetFocus
      End If
   Else
     VGCancelar = "N"
   End If
   PMChequea sqlconn&
End If
End Sub
Private Sub PLParametro()
Dim VTR1 As Integer
ReDim Matrizl(20, 20) As String
 'Parametro de Cuentas Especiales
 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
 PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAP"
 PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, "Ok.. Consulta de Nivel Máximo de Autorización") Then
    VTR1 = FMMapeaMatriz(sqlconn&, Matrizl())
    PMChequea sqlconn&
 End If
 VLProdProgresivo = Matrizl(4, 1)
End Sub

