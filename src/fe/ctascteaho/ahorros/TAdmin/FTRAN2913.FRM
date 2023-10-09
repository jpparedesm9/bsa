VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form FTran2913 
   Appearance      =   0  'Flat
   BackColor       =   &H80000016&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parametrización Causales Otros Ingresos/Egresos"
   ClientHeight    =   6360
   ClientLeft      =   450
   ClientTop       =   1920
   ClientWidth     =   9480
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
   HelpContextID   =   1096
   Icon            =   "FTRAN2913.frx":0000
   LinkTopic       =   "Form14"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6360
   ScaleWidth      =   9480
   Begin VB.Frame FrmInterfaz 
      Appearance      =   0  'Flat
      BackColor       =   &H80000016&
      Caption         =   " Interfaz Ordenes Pago/Cobro en Caja"
      ForeColor       =   &H00800000&
      Height          =   1000
      Left            =   120
      TabIndex        =   40
      Top             =   2720
      Width           =   8175
      Begin TxtinLib.TextValid txtVigencia 
         Height          =   285
         Left            =   6400
         TabIndex        =   17
         Top             =   470
         Width           =   650
         _Version        =   65536
         _ExtentX        =   1147
         _ExtentY        =   503
         _StockProps     =   253
         Appearance      =   1
         Range           =   ""
         MaxLength       =   3
         Character       =   0
         Type            =   1
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.ComboBox CmbPrograma 
         Height          =   315
         ItemData        =   "FTRAN2913.frx":030A
         Left            =   1185
         List            =   "FTRAN2913.frx":030C
         Style           =   2  'Dropdown List
         TabIndex        =   16
         Top             =   470
         Width           =   3420
      End
      Begin MSGrid.Grid grdInterfaz 
         Height          =   495
         Left            =   7200
         TabIndex        =   42
         Top             =   250
         Visible         =   0   'False
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   873
         _StockProps     =   77
         ForeColor       =   4210752
         BackColor       =   16777215
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Vigencia Orden:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   4920
         TabIndex        =   43
         Top             =   500
         Width           =   1380
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Programa:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   240
         TabIndex        =   41
         Top             =   500
         Width           =   870
      End
   End
   Begin VB.Frame Frame4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000016&
      Caption         =   "Causal Nota Debito"
      ForeColor       =   &H00800000&
      Height          =   1440
      Index           =   2
      Left            =   2040
      TabIndex        =   33
      Top             =   1200
      Width           =   6255
      Begin VB.TextBox txtCaucc 
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
         Height          =   285
         Index           =   1
         Left            =   3600
         MaxLength       =   5
         TabIndex        =   15
         Top             =   1080
         Width           =   525
      End
      Begin VB.TextBox txtCaucc 
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
         Height          =   285
         Index           =   0
         Left            =   840
         MaxLength       =   5
         TabIndex        =   14
         Top             =   1080
         Width           =   525
      End
      Begin VB.TextBox txtCauaho 
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
         Height          =   285
         Index           =   1
         Left            =   3600
         MaxLength       =   5
         TabIndex        =   12
         Top             =   600
         Width           =   525
      End
      Begin VB.TextBox txtCauaho 
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
         Height          =   285
         Index           =   0
         Left            =   840
         MaxLength       =   5
         TabIndex        =   11
         Top             =   600
         Width           =   525
      End
      Begin Threed.SSCheck chk_ndncaho 
         Height          =   240
         Left            =   120
         TabIndex        =   10
         Tag             =   "2747"
         Top             =   600
         Width           =   585
         _Version        =   65536
         _ExtentX        =   1032
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "AH"
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
      End
      Begin Threed.SSCheck chk_ndncc 
         Height          =   240
         Left            =   120
         TabIndex        =   13
         Tag             =   "2747"
         Top             =   1080
         Width           =   555
         _Version        =   65536
         _ExtentX        =   979
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "CC"
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
      End
      Begin VB.Label Lblcaucc 
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
         Height          =   285
         Index           =   1
         Left            =   4200
         TabIndex        =   39
         Top             =   1080
         Width           =   1935
      End
      Begin VB.Label Lblcaucc 
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
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   38
         Top             =   1080
         Width           =   2055
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Causal  Rev"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   3600
         TabIndex        =   37
         Top             =   360
         Width           =   1050
      End
      Begin VB.Label Lblcauho 
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
         Height          =   285
         Index           =   1
         Left            =   4200
         TabIndex        =   36
         Top             =   600
         Width           =   1935
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Causal"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   840
         TabIndex        =   35
         Top             =   360
         Width           =   585
      End
      Begin VB.Label Lblcauho 
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
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   34
         Top             =   600
         Width           =   2055
      End
   End
   Begin VB.Frame Frame4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000016&
      Caption         =   "Costo del Servicio"
      ForeColor       =   &H00800000&
      Height          =   1200
      Index           =   0
      Left            =   6120
      TabIndex        =   31
      Top             =   0
      Width           =   2190
      Begin Threed.SSCheck chkIva 
         Height          =   210
         Left            =   180
         TabIndex        =   4
         Top             =   645
         Width           =   1665
         _Version        =   65536
         _ExtentX        =   2937
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Cobro de IVA"
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
      End
      Begin Threed.SSCheck chkGastoB 
         Height          =   210
         Left            =   180
         TabIndex        =   5
         Top             =   855
         Width           =   1665
         _Version        =   65536
         _ExtentX        =   2937
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Gasto del Banco"
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
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Left            =   150
         TabIndex        =   3
         Top             =   240
         Width           =   1845
         _ExtentX        =   3254
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         MaxLength       =   11
         PromptChar      =   "_"
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   870
      MaxLength       =   5
      TabIndex        =   2
      Top             =   630
      Width           =   645
   End
   Begin VB.Frame Frame2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000016&
      ForeColor       =   &H80000008&
      Height          =   465
      Left            =   870
      TabIndex        =   28
      Top             =   0
      Width           =   4380
      Begin Threed.SSOption optOper 
         Height          =   210
         Index           =   2
         Left            =   240
         TabIndex        =   0
         TabStop         =   0   'False
         Tag             =   "S"
         Top             =   165
         Width           =   1710
         _Version        =   65536
         _ExtentX        =   3016
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Otros Ingresos:"
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
         Alignment       =   1
         Value           =   -1  'True
      End
      Begin Threed.SSOption optOper 
         Height          =   210
         Index           =   3
         Left            =   2430
         TabIndex        =   1
         TabStop         =   0   'False
         Tag             =   "S"
         Top             =   165
         Width           =   1710
         _Version        =   65536
         _ExtentX        =   3016
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Otros Egresos:"
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
         Alignment       =   1
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   0
      Left            =   8520
      TabIndex        =   24
      Top             =   5600
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Picture         =   "FTRAN2913.frx":030E
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   6
      Left            =   8515
      TabIndex        =   18
      Top             =   45
      WhatsThisHelpID =   2000
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1305
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
      Picture         =   "FTRAN2913.frx":032A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   5
      Left            =   8515
      TabIndex        =   19
      Top             =   795
      WhatsThisHelpID =   2001
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1305
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
      Picture         =   "FTRAN2913.frx":0346
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   2
      Left            =   8515
      TabIndex        =   22
      Tag             =   "2516"
      Top             =   3045
      WhatsThisHelpID =   2006
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1305
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
      Picture         =   "FTRAN2913.frx":0362
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   3
      Left            =   8520
      TabIndex        =   20
      Tag             =   "2548"
      Top             =   1545
      WhatsThisHelpID =   2030
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Crear"
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
      Picture         =   "FTRAN2913.frx":037E
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   4
      Left            =   8520
      TabIndex        =   21
      Tag             =   "2549"
      Top             =   2295
      WhatsThisHelpID =   2031
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Actualizar"
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
      Picture         =   "FTRAN2913.frx":039A
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2235
      Left            =   15
      TabIndex        =   25
      Top             =   4100
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14605
      _ExtentY        =   3942
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
      Cols            =   4
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   1
      Left            =   8520
      TabIndex        =   23
      Top             =   4850
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Picture         =   "FTRAN2913.frx":03B6
   End
   Begin VB.Frame Frame4 
      Appearance      =   0  'Flat
      BackColor       =   &H80000016&
      Caption         =   "Medio de Pago"
      ForeColor       =   &H00800000&
      Height          =   1440
      Index           =   1
      Left            =   120
      TabIndex        =   32
      Top             =   1200
      Width           =   1815
      Begin Threed.SSCheck ChkChequeL 
         Height          =   240
         Left            =   165
         TabIndex        =   8
         Tag             =   "2747"
         Top             =   780
         Width           =   1560
         _Version        =   65536
         _ExtentX        =   2752
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "Cheque Local"
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
      End
      Begin Threed.SSCheck ChkEfectivo 
         Height          =   225
         Left            =   165
         TabIndex        =   6
         Top             =   330
         Width           =   1560
         _Version        =   65536
         _ExtentX        =   2752
         _ExtentY        =   397
         _StockProps     =   78
         Caption         =   "Efectivo"
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
      End
      Begin Threed.SSCheck ChkChequeP 
         Height          =   240
         Left            =   165
         TabIndex        =   7
         Tag             =   "2707"
         Top             =   540
         Width           =   1560
         _Version        =   65536
         _ExtentX        =   2752
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "Cheque Propio"
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
      End
      Begin Threed.SSCheck Optndnc 
         Height          =   240
         Left            =   165
         TabIndex        =   9
         Tag             =   "2747"
         Top             =   1020
         Width           =   1560
         _Version        =   65536
         _ExtentX        =   2752
         _ExtentY        =   423
         _StockProps     =   78
         Caption         =   "Nota Debito"
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
      End
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   1560
      TabIndex        =   30
      Top             =   630
      Width           =   4455
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   105
      TabIndex        =   29
      Top             =   180
      Width           =   495
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causales:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   26
      Top             =   3900
      Width           =   840
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8370
      X2              =   0
      Y1              =   3900
      Y2              =   3900
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   27
      Top             =   630
      Width           =   690
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   6400
   End
End
Attribute VB_Name = "FTran2913"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Dim VLPaso As Integer
Dim VLTabla$
Dim VLTOpera$
Dim VLTEfect$
Dim VLTCHL$
Dim VLTCHP$
Dim VLTIva$
Dim VLTGasto$
Dim VLNDNC_AH$
Dim VLNDNC_CC$
Dim VLTCont As Integer
          
Private Sub Limpia_Caundnc()
    chk_ndncaho.Value = False
    chk_ndncc.Value = False
    txtCauaho(0).Text = ""
    txtCauaho(1).Text = ""
    Lblcauho(0).Caption = ""
    Lblcauho(1).Caption = ""
    txtCaucc(0).Text = ""
    txtCaucc(1).Text = ""
    Lblcaucc(0).Caption = ""
    Lblcaucc(1).Caption = ""
End Sub
Private Function Error_causales_ndnc() As Boolean

    If Optndnc.Value = True Then
      If chk_ndncaho.Value = False And chk_ndncc.Value = False Then
         MsgBox "Se debe seleccionar nd/nc de ahorros o corrientes", 0 + 16, "Mensaje de Error"
         
         Error_causales_ndnc = True
         Exit Function
         
      End If
      If chk_ndncaho.Value = True Then
       If txtCauaho(0).Text = "" Or txtCauaho(1).Text = "" Then
          MsgBox "Debe ingresar las causales CREA y REV de nd/nc de ahorros", 0 + 16, "Mensaje de Error"
          Error_causales_ndnc = True
          Exit Function
       End If
      End If
      If chk_ndncc.Value = True Then
        If txtCaucc(0).Text = "" Or txtCaucc(1).Text = "" Then
          MsgBox "Debe ingresar las causales CREA y REV de corrientes", 0 + 16, "Mensaje de Error"
          Error_causales_ndnc = True
          Exit Function
        End If
      End If
  End If
    Error_causales_ndnc = False
End Function
Private Sub Habilita_Caundnc(Indicador As String)
  If Indicador = "S" Then  'habilita
    Frame4(2).Enabled = True
    chk_ndncaho.Enabled = True
    chk_ndncc.Enabled = True
  End If
  
  If Indicador = "N" Then  'deshabilita
    Frame4(2).Enabled = False
    chk_ndncaho.Enabled = False
    chk_ndncc.Enabled = False
  End If
  
End Sub

Private Sub chk_ndncaho_Click(Value As Integer)
   If Value = False Then
      txtCauaho(0).Text = ""
      txtCauaho(1).Text = ""
      Lblcauho(0).Caption = ""
      Lblcauho(1).Caption = ""
   End If
End Sub

Private Sub chk_ndncc_Click(Value As Integer)
  If Value = False Then
    txtCaucc(0).Text = ""
    txtCaucc(1).Text = ""
    Lblcaucc(0).Caption = ""
    Lblcaucc(1).Caption = ""
  End If
End Sub


Private Sub CmbPrograma_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Programa Interfaz"
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
       Case 0 'Salir
          Unload FTran2913
       Case 1 'Limpiar
          PLLimpiar
       Case 2 'Eliminar
          PLEliminar
       Case 3 ' Crear un nuevo parámetro de causal Otros IE
          PLCrear
       Case 4 ' Actualizar un nuevo parámetro de causal Otros IE
          PLActualizar
       Case 5 'Siguientes
          PLSiguientes
       Case 6 'Buscar
          PLBuscar
    End Select
End Sub

Private Sub Form_Load()
    Dim i As Integer
    FTran2913.Left = 15
    FTran2913.Top = 15
    FTran2913.Width = 9570
    FTran2913.Height = 6840
    cmdBoton(5).Enabled = False
    txtCampo(0).Text = ""
    lblDescripcion.Caption = ""
       
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
    
    Habilita_Caundnc ("N")
    
    VLTabla$ = "cc_interfaz_IE"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
        PMMapeaGrid sqlconn&, grdInterfaz, False
        PMChequea sqlconn&
        grdInterfaz.Col = 2
        CmbPrograma.AddItem "", 0
        For i% = 0 To grdInterfaz.Rows - 2
            grdInterfaz.Row = i% + 1
            CmbPrograma.AddItem grdInterfaz.Text, i + 1
            'CmbPrograma.ListIndex = 0
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
    If grdRegistros.Rows <= 2 Then
       grdRegistros.Row = 1
       grdRegistros.Col = 1
       If Trim$(grdRegistros.Text) = "" Then
          MsgBox "No existen causales otros Ingresos/Egresos", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If

    grdRegistros.Col = 1    'causal
    txtCampo(0).Text = grdRegistros.Text
    txtCampo(0).Enabled = False

    grdRegistros.Col = 2   'desc causal
    lblDescripcion.Caption = grdRegistros.Text

    grdRegistros.Col = 3   'cobro iva
    If grdRegistros.Text = "S" Then
       chkIva.Value = True
    Else
       chkIva.Value = False
    End If

    grdRegistros.Col = 4    'costo
    mskValor.Text = grdRegistros.Text
    mskValor.Enabled = False
       
    grdRegistros.Col = 5   'gasto
    If grdRegistros.Text = "S" Then
       chkGastoB.Value = True
    Else
       chkGastoB.Value = False
    End If
    
    grdRegistros.Col = 6   'efectivo
    If grdRegistros.Text = "S" Then
       ChkEfectivo.Value = True
    Else
       ChkEfectivo.Value = False
    End If
   
    grdRegistros.Col = 7  'cheq prop
    If grdRegistros.Text = "S" Then
       ChkChequeP.Value = True
    Else
       ChkChequeP.Value = False
    End If

    grdRegistros.Col = 8   'cheq loc
    If grdRegistros.Text = "S" Then
       ChkChequeL.Value = True
    Else
       ChkChequeL.Value = False
    End If
    
    grdRegistros.Col = 9 'ndnc aho
    If grdRegistros.Text = "S" Then
       chk_ndncaho.Value = True
    Else
      chk_ndncaho.Value = False
    End If
    
    grdRegistros.Col = 10 ' causa aho
    txtCauaho(0).Text = grdRegistros.Text
    txtCauaho_LostFocus (0)
      
    grdRegistros.Col = 11    ' causa  rev aho
    txtCauaho(1).Text = grdRegistros.Text
    txtCauaho_LostFocus (1)
      
      
    grdRegistros.Col = 12 'ndnc cc
    If grdRegistros.Text = "S" Then
       chk_ndncc.Value = True
     Else
       chk_ndncc.Value = False
    End If
    
    grdRegistros.Col = 13 ' causa cc
    txtCaucc(0).Text = grdRegistros.Text
    txtCaucc_LostFocus (0)

    grdRegistros.Col = 14 ' causa  rev cc
    txtCaucc(1).Text = grdRegistros.Text
    txtCaucc_LostFocus (1)

    If chk_ndncaho.Value = True Or chk_ndncc.Value = True Then
        Optndnc.Value = True
    Else
        Optndnc.Value = False
    End If
    
    grdRegistros.Col = 15
    If grdRegistros.Text <> "" Then
        CmbPrograma.Text = Trim$(grdRegistros.Text)
    Else
        CmbPrograma.ListIndex = 0
    End If
    
    grdRegistros.Col = 16
    txtVigencia.Text = Trim$(grdRegistros.Text)
    
    
    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = True
    cmdBoton(2).Enabled = True
End Sub

Private Sub PLActualizar()
    
    PLOperacion
    ' Validacion de mandatoriedades
    If txtCampo(0).Text = "" Then
       MsgBox "La Causal de Ingreso / Egreso es madatoria", 0 + 16, "Mensaje de Error"
       txtCampo(0).SetFocus
       Exit Sub
    End If
    If Val(mskValor.ClipText) < 0 Then
        MsgBox "El costo asociado debe ser mayor o igual a cero", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
    If VLTCont = 0 Then
       MsgBox "Se requiere mínimo un medio de pago", 0 + 16, "Mensaje de Error"
       ChkEfectivo.SetFocus
       Exit Sub
    End If
    'If VLTOpera$ = "I" Then
    '   If Val(mskValor.ClipText) > 0 And VLTCont > 1 Then
    '      MsgBox "El costo asociado sólo permite un medio de pago", 0 + 16, "Mensaje de Error"
    '   Exit Sub
    '   End If
    'End If
    
   If Error_causales_ndnc = True Then
      Exit Sub
   End If
    
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2914"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VLTOpera$
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_cobro_iva", 0, SQLCHAR, VLTIva$
    PMPasoValores sqlconn&, "@i_costo", 0, SQLMONEY, (mskValor.Text)
    PMPasoValores sqlconn&, "@i_gasto_banco", 0, SQLCHAR, VLTGasto$
    PMPasoValores sqlconn&, "@i_efectivo", 0, SQLCHAR, VLTEfect$
    PMPasoValores sqlconn&, "@i_chq_propio", 0, SQLCHAR, VLTCHP$
    PMPasoValores sqlconn&, "@i_chq_local", 0, SQLCHAR, VLTCHL$
    
    PMPasoValores sqlconn&, "@i_ndnc_cte", 0, SQLCHAR, VLNDNC_CC$
    PMPasoValores sqlconn&, "@i_ndnc_aho", 0, SQLCHAR, VLNDNC_AH$
    PMPasoValores sqlconn&, "@i_causa_cte", 0, SQLCHAR, txtCaucc(0).Text
    PMPasoValores sqlconn&, "@i_caurev_cte", 0, SQLCHAR, txtCaucc(1).Text
    PMPasoValores sqlconn&, "@i_causa_aho", 0, SQLCHAR, txtCauaho(0).Text
    PMPasoValores sqlconn&, "@i_caurev_aho", 0, SQLCHAR, txtCauaho(1).Text
    PMPasoValores sqlconn&, "@i_programa", 0, SQLVARCHAR, CmbPrograma.Text
    PMPasoValores sqlconn&, "@i_vigencia", 0, SQLINT2, txtVigencia.Text
    

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_causa_ingegr", True, "Ok... Creación Parametrizac. Causales Otros IE") Then
        PMChequea sqlconn&
        PLBuscar    ' Refrescrar pantalla causales Otros IE
   ' Else
   '     PLLimpiar
    End If
End Sub

Private Sub PLBuscar()
    PLOperacion
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2916"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VLTOpera$
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, (txtCampo(0).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_causa_ingegr", True, "Ok... Consulta de Causales Ingresos-Egresos Varios") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
       If txtCampo(0).Enabled = True Then
          txtCampo(0).SetFocus
       End If
       If grdRegistros.Tag >= 15 Then
          cmdBoton(5).Enabled = True
       Else
          cmdBoton(5).Enabled = False
       End If
    Else
        'PLLimpiar
       PMLimpiaG grdRegistros
       cmdBoton(5).Enabled = False
    End If
End Sub

Private Sub PLOperacion()
    VLTCont = 0
    If optOper(2).Value = True Then   'Otros Ingresos
      VLTOpera$ = "I"
      VLTabla$ = "cc_causa_oioe"
    End If
    If optOper(3).Value = True Then   'Otros Egresos
        VLTOpera$ = "E"
        VLTabla$ = "cc_causa_oe"
    End If
    
    If chkIva.Value = True Then
      VLTIva$ = "S"
    Else
      VLTIva$ = "N"
    End If
    
    If chkGastoB.Value = True Then
      VLTGasto$ = "S"
    Else
      VLTGasto$ = "N"
    End If
    
    If ChkEfectivo.Value = True Then
      VLTEfect$ = "S"
      VLTCont = VLTCont + 1
    Else
      VLTEfect$ = "N"
    End If
    
    If ChkChequeL.Value = True Then
      VLTCHL$ = "S"
      VLTCont = VLTCont + 1
    Else
      VLTCHL$ = "N"
    End If
    
    If ChkChequeP.Value = True Then
      VLTCHP$ = "S"
      VLTCont = VLTCont + 1
    Else
      VLTCHP$ = "N"
    End If
    
    If Optndnc.Value = True Then
      VLTCont = VLTCont + 1
    End If
    
    If chk_ndncaho.Value = True Then
      VLNDNC_AH$ = "S"
    Else
      VLNDNC_AH$ = "N"
    End If
    
    If chk_ndncc.Value = True Then
      VLNDNC_CC$ = "S"
    Else
      VLNDNC_CC$ = "N"
    End If

End Sub
Private Sub PLCrear()

    PLOperacion
    ' Validacion de mandatoriedades
    If txtCampo(0).Text = "" Then
       MsgBox "La Causal de Ingreso / Egreso es madatoria", 0 + 16, "Mensaje de Error"
       txtCampo(0).SetFocus
       Exit Sub
    End If
    If Val(mskValor.ClipText) < 0 Then
       MsgBox "El costo asociado debe ser mayor o igual a cero", 0 + 16, "Mensaje de Error"
       mskValor.SetFocus
       Exit Sub
    End If
    If VLTCont = 0 Then
       MsgBox "Se requiere mínimo un medio de pago", 0 + 16, "Mensaje de Error"
       ChkEfectivo.SetFocus
       Exit Sub
    End If
    
    If Error_causales_ndnc = True Then
       Exit Sub
    End If
    
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2913"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VLTOpera$
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_cobro_iva", 0, SQLCHAR, VLTIva$
    PMPasoValores sqlconn&, "@i_costo", 0, SQLMONEY, (mskValor.Text)
    PMPasoValores sqlconn&, "@i_gasto_banco", 0, SQLCHAR, VLTGasto$
    PMPasoValores sqlconn&, "@i_efectivo", 0, SQLCHAR, VLTEfect$
    PMPasoValores sqlconn&, "@i_chq_propio", 0, SQLCHAR, VLTCHP$
    PMPasoValores sqlconn&, "@i_chq_local", 0, SQLCHAR, VLTCHL$
    
    PMPasoValores sqlconn&, "@i_ndnc_cte", 0, SQLCHAR, VLNDNC_CC$
    PMPasoValores sqlconn&, "@i_ndnc_aho", 0, SQLCHAR, VLNDNC_AH$
    PMPasoValores sqlconn&, "@i_causa_cte", 0, SQLCHAR, txtCaucc(0).Text
    PMPasoValores sqlconn&, "@i_caurev_cte", 0, SQLCHAR, txtCaucc(1).Text
    PMPasoValores sqlconn&, "@i_causa_aho", 0, SQLCHAR, txtCauaho(0).Text
    PMPasoValores sqlconn&, "@i_caurev_aho", 0, SQLCHAR, txtCauaho(1).Text
    PMPasoValores sqlconn&, "@i_programa", 0, SQLVARCHAR, CmbPrograma.Text
    PMPasoValores sqlconn&, "@i_vigencia", 0, SQLINT2, txtVigencia.Text
   
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_causa_ingegr", True, "Ok... Creación Parametrizac. Causales Otros IE") Then
       PMChequea sqlconn&
       'cmdBoton(3).Enabled = False
       PLBuscar ' Refrescrar la causales de Otros IE existentes
    Else
       txtCampo(0).Enabled = True
       txtCampo(0).Text = ""
       txtCampo(0).SetFocus
       lblDescripcion.Caption = ""
       'PLLimpiar
    End If
End Sub

Private Sub PLEliminar()

    PLOperacion
    If txtCampo(0).Text = "" Then
       MsgBox "La Causal de Ingreso / Egreso es madatoria", 0 + 16, "Mensaje de Error"
       txtCampo(0).SetFocus
       Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2915"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VLTOpera$
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_cobro_iva", 0, SQLCHAR, VLTIva$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_causa_ingegr", True, "Ok... Eliminacion de Causales Ingresos-Egresos Varios") Then
       PMChequea sqlconn&
       PLBuscar    'Refresca causales otros IE existentes
    Else
       PLLimpiar
    End If

    txtCampo(0).Enabled = True
    txtCampo(0).Text = ""
    lblDescripcion.Caption = ""
End Sub

Private Sub PLLimpiar()

   txtCampo(0).Enabled = True
   txtCampo(0).Text = ""
   txtCampo(0).SetFocus
   lblDescripcion.Caption = ""
   txtVigencia.Clear
   CmbPrograma.ListIndex = 0
   cmdBoton(3).Enabled = True
   cmdBoton(2).Enabled = False
   cmdBoton(4).Enabled = False
   PMLimpiaGrid grdRegistros
   optOper(2).Enabled = True
   optOper(2).Value = True
   mskValor.Format = VGDecimales$
   mskValor.Text = Format$(0, VGDecimales$)
   ChkEfectivo.Enabled = True
   ChkChequeL.Enabled = True
   ChkChequeP.Enabled = True
   chkGastoB.Enabled = False
   mskValor.Enabled = True
   chkIva.Value = False
   ChkEfectivo.Value = False
   ChkChequeL.Value = False
   ChkChequeP.Value = False
   chkGastoB.Value = False
   
   Optndnc.Value = False
  
   
End Sub

Private Sub PLSiguientes()

    grdRegistros.Col = 1
    grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2916"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VLTOpera$
    
    If grdRegistros.Text + 1 < 100 Then
        PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, "0" & (grdRegistros.Text + 1)
    Else
        PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, grdRegistros.Text + 1
    End If
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_causa_ingegr", True, "Ok... Consulta de Causales Ingresos-Egresos Varios") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&
       If txtCampo(0).Enabled Then
          txtCampo(0).SetFocus
       End If
       If grdRegistros.Tag >= 15 Then
          cmdBoton(5).Enabled = True
       Else
          cmdBoton(5).Enabled = False
       End If
    End If
End Sub
Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Costo Asociado de Ingreso o Egreso [F5 Ayuda]"
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
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
Private Sub mskValor_LostFocus()
    If mskValor.Text = "" Then
       mskValor.Format = VGDecimales$
       mskValor.Text = Format$(0, VGDecimales$)
    End If
End Sub

Private Sub Optndnc_Click(Value As Integer)
  If Optndnc.Value = True Then
    Habilita_Caundnc ("S")
  Else
    Habilita_Caundnc ("N")
    Limpia_Caundnc
  End If
End Sub

Private Sub optOper_Click(Index As Integer, Value As Integer)
      lblDescripcion.Caption = ""
      txtCampo(0) = ""
      txtCampo(0).Enabled = True
      chkIva.Value = False
      ChkEfectivo.Value = False
      ChkChequeL.Value = False
      ChkChequeP.Value = False
      chkGastoB.Value = False
      
      PMLimpiaGrid grdRegistros
      
      If optOper(2).Value = True Then
         ChkChequeL.Enabled = True
         ChkChequeL.Caption = "Cheque Local"
         ChkChequeP.Enabled = True
         ChkChequeP.Caption = "Cheque Propio  " ' jcpc Req-001 egresos Chq Gerencia
         chkGastoB.Enabled = False
         mskValor.Enabled = True
         Optndnc.Caption = "Nota Debito "
         Frame4(2).Caption = "Nota Debito"
      End If
      If optOper(3).Value = True Then
         ChkChequeL.Enabled = True
         ChkChequeL.Caption = "Chq. Ot. Banco"
         ChkChequeP.Enabled = True            ' jcpc Req-001 egresos Chq Gerencia
         ChkChequeP.Caption = "Cheque Gerencia" ' jcpc Req-001 egresos Chq Gerencia
         chkGastoB.Enabled = True
         mskValor.Enabled = False
         Optndnc.Caption = "Nota Credito"
         Frame4(2).Caption = "Causal Nota Credito"
      End If
      
      Optndnc.Value = False
      Limpia_Caundnc
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
         FPrincipal!pnlHelpLine.Caption = "Causal de Ingreso o Egreso [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
        VLPaso% = True
        txtCampo(Index%) = ""
        Select Case Index%
           Case 0
              If optOper(2).Value = True Then
                 PMCatalogo "A", "cc_causa_oioe", txtCampo(Index%), lblDescripcion
              Else
                 PMCatalogo "A", "cc_causa_oe", txtCampo(Index%), lblDescripcion
              End If
              If txtCampo(Index%).Text = "" Then
                 txtCampo(Index%).Text = ""
                 lblDescripcion.Caption = ""
              End If
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
       Case 0
          If VLPaso% = False And txtCampo(Index%) <> "" Then
              If optOper(2).Value = True Then
                  PMCatalogo "V", "cc_causa_oioe", txtCampo(Index%), lblDescripcion
                  optOper(2).Enabled = True
              Else
                   PMCatalogo "V", "cc_causa_oe", txtCampo(Index%), lblDescripcion
                   VLPaso% = True
                   optOper(2).Enabled = False
              End If
              If txtCampo(Index%).Text = "" Then
                 lblDescripcion.Caption = ""
              End If
          End If
    End Select
End Sub

Private Sub txtCauaho_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
         FPrincipal!pnlHelpLine.Caption = "Causal de ND/NC [F5 Ayuda]"
    End Select
    txtCauaho(Index%).SelStart = 0
    txtCauaho(Index%).SelLength = Len(txtCauaho(Index%).Text)
End Sub
Private Sub txtCauaho_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub
Private Sub txtCauaho_LostFocus(Index As Integer)
Dim tablita As String
If txtCauaho(Index).Text <> "" Then
      If chk_ndncaho.Value = True Then  ' NDA
      
        If optOper(2).Value = True Then  'OI ND
           Select Case Index
              Case 0
                 tablita$ = "ah_causa_nd"
              Case 1
                tablita$ = "ah_causa_nc"
              End Select
        Else                          'OE NC
            Select Case Index
              Case 0
                   tablita$ = "ah_causa_nc"
              Case 1
                   tablita$ = "ah_causa_nd"
              End Select
        End If
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, tablita$
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCauaho(Index).Text)
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCauaho(Index) & "]") Then
                 PMMapeaObjeto sqlconn&, Lblcauho(Index)
                 PMChequea sqlconn&
            Else
                VLPaso% = True
                txtCauaho(Index).Text = ""
                Lblcauho(Index).Caption = ""
                'txtCauaho(Index).SetFocus
            End If
      Else
           txtCauaho(Index).Text = ""
           Lblcauho(Index).Caption = ""
      End If
 Else
   txtCauaho(Index).Text = ""
   Lblcauho(Index).Caption = ""
 End If
End Sub
Private Sub txtCauaho_Change(Index As Integer)
   VLPaso% = False
End Sub
Private Sub txtCauaho_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Dim tablita As String
     If Keycode% = VGTeclaAyuda% Then
      VLPaso% = True
      If chk_ndncaho.Value = True Then  ' NDA
      
        If optOper(2).Value = True Then  'OI ND
           Select Case Index
              Case 0
                 tablita$ = "ah_causa_nd"
              Case 1
                tablita$ = "ah_causa_nc"
              End Select
             
        Else                             'OE NC
            Select Case Index
              Case 0
                   tablita$ = "ah_causa_nc"
              Case 1
                   tablita$ = "ah_causa_nd"
              End Select
        End If

            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, tablita$
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de causas") Then
                    PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                    PMChequea sqlconn&
                    FCatalogo.Show 1
                    txtCauaho(Index).Text = VGACatalogo.Codigo$
                    Lblcauho(Index).Caption = VGACatalogo.Descripcion$
                    SendKeys "{TAB}"
            Else
                    txtCauaho(Index).Text = ""
                    Lblcauho(Index).Caption = ""
                    txtCauaho(Index).SetFocus
            End If
      End If
 End If
End Sub
Private Sub txtCaucc_Change(Index As Integer)
   VLPaso% = False
End Sub
Private Sub txtCaucc_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Dim tablita As String
  If Keycode% = VGTeclaAyuda% Then
      VLPaso% = True
      
      If chk_ndncc.Value = True Then  ' NDCC then
       If optOper(2).Value = True Then  'OI ND
          Select Case Index
            Case 0
              tablita$ = "cc_causa_nd"
            Case 1
              tablita$ = "cc_causa_nc"
            End Select
       Else
          Select Case Index              'OE NC
            Case 0
              tablita$ = "cc_causa_nc"
            Case 1
               tablita$ = "cc_causa_nd"
            End Select
       End If
            
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, tablita$
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de causas") Then
                    PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                    PMChequea sqlconn&
                    FCatalogo.Show 1
                    txtCaucc(Index).Text = VGACatalogo.Codigo$
                    Lblcaucc(Index).Caption = VGACatalogo.Descripcion$
                    SendKeys "{TAB}"
            Else
                    txtCaucc(Index).Text = ""
                    Lblcaucc(Index).Caption = ""
                    txtCaucc(Index).SetFocus
            End If
     End If
 End If
End Sub
Private Sub txtCaucc_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub
Private Sub txtCaucc_LostFocus(Index As Integer)
    Dim tablita As String
    If txtCaucc(Index).Text <> "" Then

      If chk_ndncc.Value = True Then  ' NDCC then
      
       If optOper(2).Value = True Then  'OI ND
          Select Case Index
            Case 0
              tablita$ = "cc_causa_nd"
            Case 1
              tablita$ = "cc_causa_nc"
            End Select
       Else
           Select Case Index              'OE NC
            Case 0
              tablita$ = "cc_causa_nc"
            Case 1
               tablita$ = "cc_causa_nd"
            End Select
       End If
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, tablita$
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCaucc(Index).Text)
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCaucc(Index) & "]") Then
                 PMMapeaObjeto sqlconn&, Lblcaucc(Index)
                 PMChequea sqlconn&
            Else
                VLPaso% = True
                txtCaucc(Index).Text = ""
                Lblcaucc(Index).Caption = ""
                txtCaucc(Index).SetFocus
            End If
     Else
        txtCaucc(Index).Text = ""
        Lblcaucc(Index).Caption = ""
     End If
  Else
        txtCaucc(Index).Text = ""
        Lblcaucc(Index).Caption = ""
  End If
End Sub

