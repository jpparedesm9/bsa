VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form FTran214 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "*Consulta de Cierre de Cuentas de Ahorros"
   ClientHeight    =   6135
   ClientLeft      =   780
   ClientTop       =   2430
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
   HelpContextID   =   1034
   LinkTopic       =   "Form7"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6135
   ScaleWidth      =   9510
   Tag             =   "3839"
   Begin Threed.SSFrame frmCuentas 
      Height          =   4065
      Left            =   0
      TabIndex        =   28
      Top             =   2055
      WhatsThisHelpID =   5362
      Width           =   4080
      _Version        =   65536
      _ExtentX        =   7197
      _ExtentY        =   7170
      _StockProps     =   14
      Caption         =   "*Datos para Cierre de Cuentas de Ahorros"
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
      Begin Threed.SSCommand cmdBoton 
         Height          =   750
         Index           =   7
         Left            =   6840
         TabIndex        =   48
         Top             =   3120
         WhatsThisHelpID =   2026
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1543
         _ExtentY        =   1323
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
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   10
         Left            =   2190
         TabIndex        =   50
         Top             =   945
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Reintegro de GMF (+):"
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
         Left            =   75
         TabIndex        =   49
         Top             =   990
         Width           =   1695
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Saldo de Cierre:"
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
         TabIndex        =   40
         Top             =   3300
         WhatsThisHelpID =   5286
         Width           =   1290
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0FFFF&
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
         Height          =   285
         Index           =   8
         Left            =   2205
         TabIndex        =   39
         Top             =   3225
         Width           =   1845
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
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   7
         Left            =   2205
         TabIndex        =   38
         Top             =   3570
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*IDB (-):"
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
         Left            =   30
         TabIndex        =   37
         Top             =   2280
         Visible         =   0   'False
         WhatsThisHelpID =   5284
         Width           =   630
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. Lineas Pendientes:"
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
         TabIndex        =   36
         Top             =   3630
         WhatsThisHelpID =   5287
         Width           =   1830
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
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   6
         Left            =   2190
         TabIndex        =   35
         Top             =   2220
         Visible         =   0   'False
         Width           =   1845
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
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   5
         Left            =   2190
         TabIndex        =   34
         Top             =   1620
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Valor en Suspenso (-):"
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
         TabIndex        =   33
         Top             =   1680
         WhatsThisHelpID =   5281
         Width           =   1770
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
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   9
         Left            =   2190
         TabIndex        =   32
         Top             =   1920
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Monto Embargado (-) :"
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
         TabIndex        =   31
         Top             =   1980
         WhatsThisHelpID =   5283
         Width           =   1800
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
         ForeColor       =   &H80000008&
         Height          =   300
         Index           =   4
         Left            =   2190
         TabIndex        =   30
         Top             =   2550
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Multa (-):"
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
         Left            =   30
         TabIndex        =   29
         Top             =   2625
         WhatsThisHelpID =   5243
         Width           =   720
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
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   1
         Left            =   2190
         TabIndex        =   21
         Top             =   330
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Saldo Disponible (+):"
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
         Left            =   45
         TabIndex        =   22
         Top             =   375
         WhatsThisHelpID =   5235
         Width           =   1650
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Intereses Ganados (+):"
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
         TabIndex        =   24
         Top             =   675
         WhatsThisHelpID =   5236
         Width           =   1785
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
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   2
         Left            =   2190
         TabIndex        =   25
         Top             =   630
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Impuesto (-):"
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
         TabIndex        =   26
         Top             =   1380
         WhatsThisHelpID =   5282
         Width           =   1050
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
         ForeColor       =   &H80000008&
         Height          =   315
         Index           =   3
         Left            =   2190
         TabIndex        =   27
         Top             =   1260
         Width           =   1845
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   2
      Left            =   8595
      TabIndex        =   17
      Top             =   5340
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
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
      Height          =   780
      Index           =   0
      Left            =   8600
      TabIndex        =   2
      Top             =   763
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   3
      Left            =   8600
      TabIndex        =   1
      Top             =   0
      WhatsThisHelpID =   2026
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
      _StockProps     =   78
      Caption         =   "*&Propietario."
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   0
      Top             =   75
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   945
      Left            =   15
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   1020
      Width           =   8500
      _Version        =   65536
      _ExtentX        =   14993
      _ExtentY        =   1667
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
   Begin Threed.SSFrame frmformapago 
      Height          =   4065
      Left            =   4080
      TabIndex        =   41
      Top             =   2055
      WhatsThisHelpID =   5363
      Width           =   4395
      _Version        =   65536
      _ExtentX        =   7752
      _ExtentY        =   7170
      _StockProps     =   14
      Caption         =   "*Cierre de Cuenta "
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
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   132
         MaxLength       =   8
         TabIndex        =   10
         Top             =   2640
         Width           =   975
      End
      Begin Threed.SSFrame SSFrame1 
         Height          =   612
         Left            =   132
         TabIndex        =   45
         Top             =   160
         Width           =   4200
         _Version        =   65536
         _ExtentX        =   7408
         _ExtentY        =   1080
         _StockProps     =   14
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin VB.OptionButton optFPago 
            Caption         =   "*Contable"
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
            Index           =   2
            Left            =   3000
            TabIndex        =   6
            Top             =   240
            WhatsThisHelpID =   5442
            Width           =   1095
         End
         Begin VB.OptionButton optFPago 
            Caption         =   "*Cheque Gerencia"
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
            Index           =   1
            Left            =   1250
            TabIndex        =   5
            Top             =   240
            WhatsThisHelpID =   5441
            Width           =   1695
         End
         Begin VB.OptionButton optFPago 
            Caption         =   "*Efectivo"
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
            Index           =   0
            Left            =   120
            TabIndex        =   4
            Top             =   240
            Value           =   -1  'True
            WhatsThisHelpID =   5440
            Width           =   1095
         End
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   132
         MaxLength       =   50
         TabIndex        =   8
         Top             =   1755
         Width           =   4200
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   3
         Left            =   132
         MaxLength       =   50
         TabIndex        =   9
         Top             =   2055
         Width           =   4200
      End
      Begin Threed.SSCheck chknomulta 
         Height          =   315
         Left            =   132
         TabIndex        =   11
         Top             =   3330
         WhatsThisHelpID =   5244
         Width           =   3915
         _Version        =   65536
         _ExtentX        =   6906
         _ExtentY        =   556
         _StockProps     =   78
         Caption         =   "*No cobrar multa por cierre anticipado"
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
      Begin TxtinLib.TextValid txtcausa 
         Height          =   285
         Left            =   132
         TabIndex        =   7
         Top             =   1125
         Width           =   615
         _Version        =   65536
         _ExtentX        =   1085
         _ExtentY        =   503
         _StockProps     =   253
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   0
         Character       =   0
         Type            =   0
         HelpLine        =   "Código del Promotor [F5 Ayuda]"
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Beneficiario:"
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
         Left            =   135
         TabIndex        =   47
         Top             =   2445
         WhatsThisHelpID =   5443
         Width           =   1050
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   570
         Index           =   11
         Left            =   1125
         TabIndex        =   46
         Top             =   2640
         UseMnemonic     =   0   'False
         Width           =   3210
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Observaciones:"
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
         Left            =   135
         TabIndex        =   44
         Top             =   1560
         WhatsThisHelpID =   5132
         Width           =   1260
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Causa de Cierre:"
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
         Left            =   135
         TabIndex        =   43
         Top             =   930
         WhatsThisHelpID =   5288
         Width           =   1335
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
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   12
         Left            =   750
         TabIndex        =   42
         Top             =   1125
         Width           =   3570
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   6
      Left            =   8600
      TabIndex        =   12
      Top             =   1526
      WhatsThisHelpID =   2027
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   4
      Left            =   8600
      TabIndex        =   15
      Tag             =   "6335"
      Top             =   3815
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   1
      Left            =   8600
      TabIndex        =   16
      Top             =   4578
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
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
      Height          =   780
      Index           =   5
      Left            =   8600
      TabIndex        =   13
      Tag             =   "6335"
      Top             =   2289
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
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
      Enabled         =   0   'False
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   780
      Index           =   8
      Left            =   8600
      TabIndex        =   14
      Top             =   3052
      WhatsThisHelpID =   2044
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1376
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   23
      Top             =   780
      WhatsThisHelpID =   5055
      Width           =   1155
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   20
      Top             =   375
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
      Y2              =   6120
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -45
      X2              =   8550
      Y1              =   720
      Y2              =   720
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   19
      Top             =   75
      WhatsThisHelpID =   5254
      Width           =   2055
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
      TabIndex        =   18
      Top             =   375
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8550
      Y1              =   2040
      Y2              =   2040
   End
End
Attribute VB_Name = "FTran214"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran214.frm
' NOMBRE LOGICO:    FTran214
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
' Permite realizar la consulta del los datos de cierre de una
' cuenta de ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************


Dim VLMulta As String
Dim VLTasaGMF As Currency
Dim VLContractual As String
Dim VLProdbanc As String
Dim VLCategoria As String
Dim VLTipoEnte As String
Dim VLCuentaAct As String
Dim VLPaso As Boolean
Dim VLFormatoFecha As String

Private Sub chknomulta_Click(Value As Integer)

    cmdBoton_Click (0)
    'If Value = True Then
    '   lblDescripcion(4).Caption = "0.00"
    '   If Trim$(lblDescripcion(8).Caption) <> "" Then lblDescripcion(8).Caption = Format$(CStr(CCur(lblDescripcion(8).Caption) + CCur(VLMulta)), "#,##0.00")
    'Else
    '   lblDescripcion(4).Caption = VLMulta
    '   If Trim$(lblDescripcion(8).Caption) <> "" Then lblDescripcion(8).Caption = Format$(CStr(CCur(lblDescripcion(8).Caption) - CCur(VLMulta)), "#,##0.00")
    'End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    '*************************************************************
    ' PROPOSITO: Logica de los command buttons
    ' INPUT    : Ninguno
    ' OUTPUT   : Ninguno
    '*************************************************************
    '                       MODIFICACIONES
    ' FECHA          AUTOR           RAZON
    ' 02-May-2006    Pedro Coello       Devolver valores en suspenso para enviar mensaje al usuario indicandole esta eventualidad con la cuenta
    '************************************************************
    Dim VTR1 As Integer
    Dim VTMsg As String
    Dim VTR As Integer
    Dim VTResp As Integer
    Dim i As Integer
    Select Case Index%
    Case 0  'buscar
        If mskCuenta.ClipText <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "214"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_val_inac", 0, SQLVARCHAR, "N"  ' ROL 12122006
             If Me.Caption = "Cancelación de Cuentas C.B." Then
                PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
             End If
             If chknomulta.Value = True Then
                  PMPasoValores sqlconn&, "@i_cob_multa", 0, SQLVARCHAR, "N"
             Else
                  PMPasoValores sqlconn&, "@i_cob_multa", 0, SQLVARCHAR, "S"
             End If
             
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_cons_cierre_ah", True, " Ok... Consulta de cancelación de cuentas") Then
                ReDim VTArreglo(20) As String
                VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                PMChequea sqlconn&
                For i% = 1 To 9
                    lblDescripcion(i%).Caption = VTArreglo(i%)
                Next i%
                VLTasaGMF = VTArreglo(11)
                VLMulta = lblDescripcion(4).Caption
                lblDescripcion(9).Caption = VTArreglo(10)
                VLContractual = VTArreglo(12)
                VLCategoria = VTArreglo(13)
                VLTipoEnte = VTArreglo(14)
                VLProdbanc = VTArreglo(15)
                lblDescripcion(10).Caption = VTArreglo(16)
                'lblDescripcion(12).Caption = VTArreglo(17)
                
                If Trim$(lblDescripcion(5).Caption) <> "" Then
                  If CCur(lblDescripcion(5).Caption) <> 0 Then
                      VTMsg$ = "La cuenta que intenta cancelar tiene valores en suspenso pendientes de cobro por un total de $ " + Format$(CStr(CCur(lblDescripcion(5).Caption)), "#,##0.00") + ". "
                      VTMsg$ = VTMsg$ + "Se sugiere antes de cancelar la cuenta ir a la consulta de valores en suspenso para determinar el origen de estos valores pendientes de cobro." + Chr(13)
                      VTMsg$ = VTMsg$ + "Desea continuar con la cancelación?."
                      VTR% = MsgBox(VTMsg$, vbYesNo + vbQuestion, "Cierre Cuenta")
                      If VTR% = vbNo Then
                         Exit Sub
                      End If
                  End If
                End If
                If VLContractual = "S" Then
                   cmdBoton(8).Enabled = True
                End If
                txtcausa.Enabled = True
                lblEtiqueta(14).Enabled = True
                cmdBoton(4).Enabled = False
                cmdBoton(0).Enabled = False
                cmdBoton(5).Enabled = True
                txtcausa.SetFocus
            End If
        Else
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
        End If
    Case 1  'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        For i% = 0 To 12
            lblDescripcion(i%).Caption = ""
        Next i%
        
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        cmdBoton(8).Enabled = False
        txtcausa.Text = ""
        txtCampo(0).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        lblDescripcion(11).Caption = ""
        txtcausa.Enabled = True
        lblEtiqueta(14).Enabled = False
        PMLimpiaGrid grdPropietarios
        mskCuenta.SetFocus
        VLMulta = ""
        VLTasaGMF = 0
        chknomulta.Enabled = True
        chknomulta.Value = False
        optFPago(0).Enabled = True
        optFPago(1).Enabled = True
        optFPago(2).Enabled = True
    Case 2  'Salir
        Unload FTran214
    Case 3  'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "298"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         PMPasoValores sqlconn&, "@i_val_inac", 0, SQLVARCHAR, "N"  ' ROL 12122006
         If Me.Caption = "Cancelación de Cuentas C.B." Then
            PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
         End If
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
        Else
            PMLimpiaGrid grdPropietarios
        End If
    Case 4 'Imprimir los datos de la pantalla
        'cmdBoton_Click (0)
        PLImprimir
    Case 5 'Cancelar cuenta
        cmdBoton_Click (0)
        VTResp = MsgBox("¿Desea Cancelar la Cuenta?", vbOKCancel, "Mensaje del Sistema")
        If VTResp = 1 Then
            PLCancelar
        Else
            Exit Sub
        End If
    Case 6 ' Consulta de firmas de la cuenta
        If mskCuenta.ClipText <> "" Then
            ReDim VGADatosI(4)
            VGADatosI(1) = mskCuenta.ClipText
            VGADatosI(2) = "AHO"
            VGADatosI(3) = "0"
            If Me.Caption = "Cancelación de Cuentas C.B." Then
                VGADatosI(4) = "S"
            Else
                VGADatosI(4) = "N"
            End If
            FImagenes.Caption = "Firmas y/o sellos de la Cuenta [" & mskCuenta.Text & "]"
            FImagenes.Show 1
        Else
            MsgBox "Se ha omitido el número de cuenta", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
        End If
   Case 8
         PLBuscar_marca
    End Select
End Sub
Private Sub PLCancelar()
    '*************************************************************
    ' PROPOSITO: Realiza la cancelacion de la cuenta.
    ' INPUT    : Ninguno
    ' OUTPUT   : Ninguno
    '*************************************************************
    '                       MODIFICACIONES
    ' FECHA          AUTOR           RAZON
    ' 04-Jun-03      F. Escudero        Emisión Inicial
    ' 17-Mar-10      C.Munoz            Opciones de entrega Dinero Cliente
    '************************************************************
    Dim VTSaldomulta As String
    Dim VTImpuesto As String
    Dim VTNuevoInteres As String
    Dim VTSaldomulta1 As String
    
    If Trim$(txtcausa.Text) = "" Then
       MsgBox "La Causa de Cancelación es Mandatoria", vbExclamation, "Mensaje de Información"
       Exit Sub
    End If
    If optFPago(0).Value = False And optFPago(1).Value = False And optFPago(2).Value = False Then
       MsgBox "La forma de pago es mandatoria", vbExclamation, "Mensaje de Información"
       Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "213"
    PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (lblDescripcion(8).Caption)
    PMPasoValores sqlconn&, "@i_sldlib", 0, SQLMONEY, 0
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
    PMPasoValores sqlconn&, "@i_cau", 0, SQLVARCHAR, txtcausa.Text
    PMPasoValores sqlconn&, "@i_ord", 0, SQLVARCHAR, "M"
    PMPasoValores sqlconn&, "@i_aut", 0, SQLVARCHAR, VGLogin$
    PMPasoValores sqlconn&, "@i_nctrl", 0, SQLINT2, 0
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
    PMPasoValores sqlconn&, "@i_monto_maximo", 0, SQLVARCHAR, "S"
    PMPasoValores sqlconn&, "@i_tadmin", 0, SQLINT1, "1"
    
    'INI CMUNOZ REQ016 BANCAMIA
    If optFPago(0).Value = True Then
        PMPasoValores sqlconn&, "@i_fcancel", 0, SQLVARCHAR, "E"
    ElseIf optFPago(1).Value = True Then
        PMPasoValores sqlconn&, "@i_fcancel", 0, SQLVARCHAR, "G"
    ElseIf optFPago(2).Value = True Then
        PMPasoValores sqlconn&, "@i_fcancel", 0, SQLVARCHAR, "C"
    End If
    PMPasoValores sqlconn&, "@i_codbene", 0, SQLINT4, txtCampo(0).Text
    'FIN CMUNOZ REQ016 BANCAMIA
    
    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_cobra", 0, SQLINT1, "0"
    PMPasoValores sqlconn&, "@i_observacion", 0, SQLVARCHAR, txtCampo(2).Text
    PMPasoValores sqlconn&, "@i_observacion1", 0, SQLVARCHAR, txtCampo(3).Text
    PMPasoValores sqlconn&, "@i_val_inac", 0, SQLVARCHAR, "N"  ' ROL 12122006
    If chknomulta.Value = True Then
        PMPasoValores sqlconn&, "@i_cobra_multa_ant", 0, SQLVARCHAR, "N" 'PCOELLO MARZO DEL 2007
    Else
        PMPasoValores sqlconn&, "@i_cobra_multa_ant", 0, SQLVARCHAR, "S" 'PCOELLO MARZO DEL 2007
    End If
    PMPasoValores sqlconn&, "@i_gmf_reintegro", 0, SQLMONEY, lblDescripcion(10).Caption
    
    PMPasoValores sqlconn&, "@o_multa", 1, SQLMONEY, "0"
    PMPasoValores sqlconn&, "@o_ssn", 1, SQLINT4, "0"
    PMPasoValores sqlconn&, "@o_nombre", 1, SQLCHAR, "0"
    PMPasoValores sqlconn&, "@o_valir", 1, SQLMONEY, "0"
    PMPasoValores sqlconn&, "@o_sldint", 1, SQLMONEY, "0"
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_ah_cierre", True, " Ok... Cancelación de Cuenta") Then
        PMChequea sqlconn&
        If VGCodPais <> "CO" Then
           VTSaldomulta$ = FMRetParam(sqlconn&, 1)
           VTImpuesto$ = FMRetParam(sqlconn&, 4)
           VTNuevoInteres$ = FMRetParam(sqlconn&, 5)
    
           lblDescripcion(3).Caption = Format$(VTImpuesto$, "#,##0.00")
           If Trim$(VTSaldomulta$) = "" Then VTSaldomulta$ = "0"
           If Trim$(VTSaldomulta1$) = "" Then VTSaldomulta1$ = "0"
           lblDescripcion(2).Caption = Format$(CStr(CCur(VTNuevoInteres$)), "#,##0.00")
           lblDescripcion(4).Caption = Format$(CStr(CCur(VTSaldomulta$) + CCur(VTSaldomulta1$)), "#,##0.00")
           lblDescripcion(8).Caption = Format$(CStr(CCur(lblDescripcion(1).Caption) + CCur(lblDescripcion(2).Caption) + CCur(lblDescripcion(9).Caption)) - (CCur(lblDescripcion(5).Caption) + CCur(lblDescripcion(3).Caption) + CCur(lblDescripcion(6).Caption) + CCur(lblDescripcion(4).Caption)), "#,##0.00")
        End If
        cmdBoton(5).Enabled = False
        cmdBoton(4).Enabled = True
        chknomulta.Enabled = False
        MsgBox "La Cuenta se ha Cancelado con Éxito", vbInformation, "Cierre Cuenta"
    Else
       PMChequea sqlconn&
       cmdBoton(4).Enabled = False
    End If
End Sub
Private Sub Form_Load()
    FTran214.Left = 0   '15
    FTran214.Top = 0   '15
    FTran214.Width = 9630   '9420
    FTran214.Height = 6645 '6130   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaAho$
    cmdBoton(4).Enabled = False
    If VGCodPais = "CO" Then
        lblEtiqueta(4).Visible = True
        lblEtiqueta(10).Visible = True
        lblDescripcion(3).Visible = True
        lblDescripcion(6).Visible = True
    Else
        lblEtiqueta(4).Visible = False
        lblEtiqueta(10).Visible = False
        lblDescripcion(3).Visible = False
        lblDescripcion(6).Visible = False
    End If
    If VGLineaPend$ = "N" Then
        lblEtiqueta(9).Visible = False
        lblDescripcion(7).Visible = False
    Else
        lblEtiqueta(9).Visible = True
        lblDescripcion(7).Visible = True
    End If
    txtCampo(0).Visible = False
    lblEtiqueta(13).Visible = False
    lblDescripcion(11).Visible = False
    
    If VGCB = True Then
        optFPago(2).Value = True
        optFPago(0).Enabled = False
        optFPago(1).Enabled = False
        lblEtiqueta(3).Visible = False
        lblDescripcion(2).Visible = False
        lblEtiqueta(15).Visible = False
        lblDescripcion(10).Visible = False
        lblEtiqueta(4).Visible = False
        lblDescripcion(3).Visible = False
        lblEtiqueta(7).Visible = False
        lblDescripcion(9).Visible = False
        lblEtiqueta(10).Visible = False
        lblDescripcion(6).Visible = False
        lblEtiqueta(5).Visible = False
        lblDescripcion(4).Visible = False
    End If
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
    VGCB = False
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

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de Propietarios de la Cuenta de Ahorros"
End Sub



Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If Me.Caption = "Cancelación de Cuentas C.B." Then
                PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
             End If
             PMPasoValores sqlconn&, "@i_val_inac", 0, SQLVARCHAR, "N" ' ROL 12122006
                 
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                If VLCuentaAct <> mskCuenta.ClipText Then
                   PMLimpiaGrid grdPropietarios
                End If
            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
        VLCuentaAct = mskCuenta.ClipText
    End If
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Imprime los datos de cancelacion de la cuenta.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim banderaContinuar As Boolean
banderaContinuar = True

        If MsgBox("¿Está Seguro de Imprimir la Consulta de Cancelación?", 4 + 32 + 0, "Mensaje del Sistema") = 7 Then
            banderaContinuar = False
        End If
   
    If (banderaContinuar = True) Then
        Screen.MousePointer = 11
        'FMCabeceraReporte VGBanco$, Date, "CONSULTA DE CANCELACION DE CUENTAS DE AHORROS",
        FMCabeceraReporte VGBanco$, Date, "SOLICITUD DE CANCELACIÓN DE CUENTAS DE AHORROS", _
                          Time(), Me.Caption, VGFecha$, 1 'Printer.Page
        Printer.FontBold = True
        Printer.FontSize = 8

        Printer.Print "  Número de Cuenta           :"; Tab(32); mskCuenta.Text
        Printer.Print ""
        Printer.Print "  Nombre de la Cuenta        :"; Tab(32); lblDescripcion(0).Caption
        Printer.Print ""
        'If lblDescripcion(7).Caption <> "0" Then
        '  Printer.Print "  No. Líneas Pendientes      :"; Tab(32); lblDescripcion(7).Caption
        '  Printer.Print ""
        'End If
        Printer.Print "  Saldo Disponible           :"; Tab(32); lblDescripcion(1).Caption
        Printer.Print
        If lblDescripcion(2).Caption <> "0.00" Then
          Printer.Print "  Intereses Ganados          :"; Tab(32); lblDescripcion(2).Caption
          Printer.Print
        End If
        If lblDescripcion(9).Caption <> "0.00" Then
          Printer.Print "  Mant. de Valor             :"; Tab(32); lblDescripcion(9).Caption
          Printer.Print
        End If
        If lblDescripcion(4).Caption <> "0.00" Then
          Printer.Print "  Multa                      :"; Tab(32); lblDescripcion(4).Caption
          Printer.Print
        End If
        If lblDescripcion(3).Caption <> "0.00" Then
          Printer.Print "  Impuesto                   :"; Tab(32); lblDescripcion(3).Caption
          Printer.Print
        End If
        If lblDescripcion(5).Caption <> "0.00" Then
          Printer.Print "  Valores en Suspenso        :"; Tab(32); lblDescripcion(5).Caption
          Printer.Print
        End If
        If lblDescripcion(6).Caption <> "0.00" Then
            If VGCodPais$ = "CO" Then
                Printer.Print "  GMF                        :"; Tab(32); lblDescripcion(6).Caption
            Else
                Printer.Print "  Imp. al Débito Bancario    :"; Tab(32); lblDescripcion(6).Caption
            End If
            Printer.Print
        End If
        Printer.Print "  Saldo de Cancelación       :"; Tab(32); lblDescripcion(8).Caption
        Printer.Print "  "
        Printer.Print "  Causa Cancelación          :"; Tab(32); txtcausa.Text & " - " & lblDescripcion(12).Caption
        Printer.Print ""
        Printer.Print "  Observaciones              :"; Tab(32); txtCampo(2).Text
        Printer.Print "                              "; Tab(32); txtCampo(3).Text
        Printer.Print ""
        Printer.Print "  " & String$(130, "_")
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        'Printer.Print String$(18, "_")
        'Printer.Print "Firma del Cliente"
        Printer.Print Tab(6); VGLogin
        Printer.Print "  _________________                                                 _________________"
        Printer.Print "    PROCESADO POR                                                     AUTORIZADO POR "
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print "  _________________"
        Printer.Print "  FIRMA DEL CLIENTE"
        Printer.EndDoc
        Screen.MousePointer = 0
        
    Else 'si el usuario escogió NO en la pregunta
        Exit Sub
        
    End If
End Sub



Private Sub optFPago_Click(Index As Integer)
    ' CMUNOZ REQ016 BANCAMIA
    txtCampo(0).Text = ""
    lblDescripcion(11).Caption = ""
    txtCampo(0).Visible = False
    lblEtiqueta(13).Visible = False
    lblDescripcion(11).Visible = False
    Select Case Index%
        Case 1
            txtCampo(0).Visible = True
            lblEtiqueta(13).Visible = True
            lblDescripcion(11).Visible = True
    End Select
    'If txtcausa.Enabled And txtcausa.Visible Then txtcausa.SetFocus
End Sub

Private Sub optFPago_GotFocus(Index As Integer)
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Forma de Pago Efectivo "
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Forma de Pago Cheque de Gerencia "
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Forma de Pago Contable "
    End Select
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Beneficiario del Cheque [F5] Ayuda "
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Observaciones de Cierre "
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Observaciones de Cierre "
    End Select
    VLPaso = True
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub


Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
Dim VTCliente As String
Dim VLReferenah As String

If Keycode = VGTeclaAyuda% Then
VLPaso = True
Select Case Index%
Case 0  'F5 Cliente
            txtCampo(0).Text = ""
            VLPaso = True
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
            VTRes = VGFBusCliente.FMBuscarCliente(FMain, VGMap, sqlconn&, ServerName$, ServerNameLocal$, VLFormatoFecha$, VGRol$)
            'Si se selecciona un cliente visualizar datos
              If VTRes = True Then
                If VGFBusCliente.DatosCliente(1) <> "" Then
                    txtCampo(0).Text = VGFBusCliente.DatosCliente(1)
                    'lblDescripcion(12).Caption = VGFBusCliente.DatosCliente(0)
                    If VGFBusCliente.DatosCliente(0) = "P" Then
                        'lblDescripcion(10).Caption = VGFBusCliente.DatosCliente(5)
                        VTCliente = VGFBusCliente.DatosCliente(2) + " " + VGFBusCliente.DatosCliente(3) + " " + VGFBusCliente.DatosCliente(4)
                        lblDescripcion(11).Caption = VTCliente
                        VLReferenah = VGFBusCliente.DatosCliente(9)
                    Else
                       ' lblDescripcion(10).Caption = VGFBusCliente.DatosCliente(3)
                        lblDescripcion(11).Caption = VGFBusCliente.DatosCliente(2)
                        VLReferenah = VGFBusCliente.DatosCliente(5)
                    End If
                   ' txtCampo(1).SetFocus
                End If
             End If
End Select
VLPaso = True
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("U", KeyAscii%)
End Sub


Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTR1 As Integer
    Dim VTSubtipo As Integer
    Dim VTCliente As Integer
    Dim VLReferencia As String
    Dim VLMensajeBlq As String
    Dim VLBloqueado As String
    Dim VLMalaref As String
    Dim VLLista As String
    
            If VLPaso = False Then
            If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0).Text)
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1225"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    ReDim VTValores(15) As String
                    VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
                    PMChequea sqlconn&
                    VTSubtipo = VTValores(2)
                        VTCliente = VTValores(1) ' + " " + VTValores(3) + " " + VTValores(4)
                        lblDescripcion(11).Caption = VTCliente
                        VLReferencia = VTValores(9)
                Else
                    txtCampo(0).Text = ""
                   ' lblDescripcion(2).Caption = ""
                    lblDescripcion(11).Caption = ""
                    'lblDescripcion(3).Caption = ""
                    txtCampo(0).SetFocus
                End If
            Else
                'lblDescripcion(2).Caption = ""
                lblDescripcion(11).Caption = ""
                'lblDescripcion(3).Caption = ""
            End If
        End If
'--------------------------------------------------------------
        If txtCampo(0).Text <> "" Then
            VLMensajeBlq$ = ""
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "175"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "B"
            PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, (txtCampo(0).Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_ente_bloqueado", True, "Ok..Consulta Clientes Bloqueados") Then
                PMMapeaVariable sqlconn&, VLBloqueado$
                PMMapeaVariable sqlconn&, VLMalaref$
                PMMapeaVariable sqlconn&, VLLista$
                PMMapeaVariable sqlconn&, VLMensajeBlq$
                PMChequea sqlconn&
            Else
                lblDescripcion(11).Caption = ""
                txtCampo(0).Text = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
    
            If VLBloqueado$ = "S" And VLMalaref$ = "N" Then
               MsgBox "Cliente está Bloqueado", 48, "Control de Datos del Clientes"
               lblDescripcion(11).Caption = ""
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               Exit Sub
            End If
    
            If VLMalaref$ = "S" Then
               MsgBox VLMensajeBlq$, 48, "Control de Clientes Reportados"
               lblDescripcion(11).Caption = ""
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               Exit Sub
            End If
            
            If VLMalaref$ = "N" And VLMensajeBlq$ <> "" Then
               MsgBox VLMensajeBlq$, 48, "Control de Clientes Reportados"
            End If
        End If

'--------------------------------------------------------------
End Sub

Private Sub txtcausa_Change()
VLPaso = False
End Sub

Private Sub txtCausa_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Causa de Cancelación [F5] Ayuda"
End Sub

Private Sub txtcausa_KeyDown(Keycode As Integer, Shift As Integer)
If Keycode = VGTeclaAyuda% Then
            PMCatalogo "A", "ah_causa_cierre", txtcausa, lblDescripcion(12)
            If txtcausa.Text <> "" Then
               VLPaso = True
            End If
End If
End Sub

Private Sub txtcausa_LostFocus()
Dim VTParContracual(15, 2) As String
Dim VTR1 As Integer

    'catalogo lost focus
    If VLPaso = False Then
        If txtcausa.Text <> "" Then
            PMCatalogo "V", "ah_causa_cierre", txtcausa, lblDescripcion(12)
            VLPaso = True
        Else
            lblDescripcion(12).Caption = ""
        End If
    End If
    
    If txtcausa.Text = "6" Then
            optFPago(2).Value = True
            optFPago(0).Enabled = False
            optFPago(1).Enabled = False
            optFPago(2).Enabled = False
    Else
        If optFPago(0).Enabled = False Or optFPago(1).Enabled = False Or optFPago(1).Enabled = False Then
            optFPago(0).Enabled = True
            optFPago(1).Enabled = True
            optFPago(2).Enabled = True
        End If
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHCT"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
        VTR1 = FMMapeaMatriz(sqlconn&, VTParContracual())
        PMChequea sqlconn&
    End If
    
    If VLContractual = "S" And VLProdbanc = VTParContracual(6, 1) Then
        If txtcausa.Text = "1" Or txtcausa.Text = "" Then
            chknomulta.Value = False
            'chknomulta_Click (False)
            chknomulta.Enabled = False
        Else
            If txtcausa.Text <> "" Then
            chknomulta.Value = True
            'chknomulta_Click (True)
            chknomulta.Enabled = False
            End If
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
Dim VLParametro(15, 2) As String
Dim VTCambiaCategoria As String
Dim VTR1 As Integer
Dim VLMarca As String
Dim VLProdfinal As String
Dim VLParametriza As String
Dim VLContractual As String

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "CAMCAT"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(3, 1) = VLCategoria Then
        VTCambiaCategoria = "S"
    Else
        VTCambiaCategoria = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 734
PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, VLCategoria
PMPasoValores sqlconn&, "@i_prodban", 0, SQLVARCHAR, VLProdbanc
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
PMPasoValores sqlconn&, "@i_tipoente", 0, SQLCHAR, VLTipoEnte

If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mto_aho_contractual", True, "Ok... Consulta Marca Contractual") Then
   PMMapeaVariable sqlconn&, VLMarca$
   PMMapeaVariable sqlconn&, VLProdfinal$
   PMMapeaVariable sqlconn&, VLParametriza$
   PMMapeaVariable sqlconn&, VLContractual$
   PMChequea sqlconn&
   
   If VLMarca = "S" Then
      If VLParametriza$ <> 0 Or VTCambiaCategoria = "S" Then
         VGcategoria = VLCategoria
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

