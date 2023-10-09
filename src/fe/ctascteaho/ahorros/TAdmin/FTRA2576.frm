VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2576 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Transferencias entre cuentas"
   ClientHeight    =   6135
   ClientLeft      =   2340
   ClientTop       =   2415
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
   HelpContextID   =   1096
   LinkTopic       =   "Form14"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6135
   ScaleWidth      =   9510
   Tag             =   "3082"
   Begin VB.Frame Frame2 
      BackColor       =   &H8000000B&
      Caption         =   "*Detalle de la Cuenta Débito:"
      ForeColor       =   &H000000FF&
      Height          =   2775
      Left            =   30
      TabIndex        =   39
      Top             =   45
      WhatsThisHelpID =   5225
      Width           =   8520
      Begin VB.CheckBox chkmodificable 
         BackColor       =   &H8000000B&
         Caption         =   "Modificable"
         Height          =   195
         Left            =   4485
         TabIndex        =   58
         Top             =   270
         Width           =   1860
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   4
         Left            =   1530
         MaxLength       =   5
         TabIndex        =   0
         Top             =   240
         Width           =   1890
      End
      Begin VB.ComboBox cmbprodb 
         Appearance      =   0  'Flat
         Height          =   288
         Left            =   1545
         Style           =   2  'Dropdown List
         TabIndex        =   1
         Top             =   555
         Width           =   1890
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   1545
         MaxLength       =   5
         TabIndex        =   3
         Top             =   1200
         Width           =   675
      End
      Begin VB.ComboBox cmbaplicacomision 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   315
         Left            =   1545
         Style           =   2  'Dropdown List
         TabIndex        =   6
         Top             =   1800
         Width           =   1965
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   1545
         MaxLength       =   1
         TabIndex        =   8
         Top             =   2120
         Width           =   675
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Index           =   2
         Left            =   6465
         MaxLength       =   2
         TabIndex        =   9
         Top             =   2115
         Width           =   600
      End
      Begin VB.TextBox txtCampo 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Index           =   3
         Left            =   7845
         MaxLength       =   2
         TabIndex        =   10
         Top             =   2120
         Width           =   600
      End
      Begin MSMask.MaskEdBox Mskcuentadb 
         Height          =   285
         Left            =   6465
         TabIndex        =   2
         Top             =   570
         Width           =   1980
         _ExtentX        =   3493
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskvalordb 
         Height          =   285
         Left            =   1545
         TabIndex        =   4
         Top             =   1500
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   503
         _Version        =   393216
         ClipMode        =   1
         Appearance      =   0
         Format          =   "#,##0.00;(#,##0.00)"
         PromptChar      =   "_"
      End
      Begin Threed.SSCheck sscobracomision 
         Height          =   300
         Left            =   4530
         TabIndex        =   5
         Top             =   1485
         WhatsThisHelpID =   5197
         Width           =   1755
         _Version        =   65536
         _ExtentX        =   3096
         _ExtentY        =   529
         _StockProps     =   78
         Caption         =   "*Cobra comisión"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin MSMask.MaskEdBox mskvalorcomision 
         Height          =   285
         Left            =   6465
         TabIndex        =   7
         Top             =   1785
         Width           =   1980
         _ExtentX        =   3493
         _ExtentY        =   503
         _Version        =   393216
         ClipMode        =   1
         Appearance      =   0
         Enabled         =   0   'False
         Format          =   "#,##0.00;(#,##0.00)"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskFecha 
         Height          =   285
         Left            =   1545
         TabIndex        =   11
         Top             =   2445
         Width           =   1980
         _ExtentX        =   3493
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         MaxLength       =   15
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskfechahasta 
         Height          =   285
         Left            =   6480
         TabIndex        =   12
         Top             =   2445
         Width           =   1980
         _ExtentX        =   3493
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         MaxLength       =   15
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Codigo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   18
         Left            =   30
         TabIndex        =   56
         Top             =   270
         Width           =   660
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Causa:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   30
         TabIndex        =   55
         Top             =   1230
         WhatsThisHelpID =   5155
         Width           =   675
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   3
         Left            =   1548
         TabIndex        =   54
         Top             =   900
         UseMnemonic     =   0   'False
         Width           =   6912
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. de Cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   4500
         TabIndex        =   53
         Top             =   600
         WhatsThisHelpID =   5016
         Width           =   1380
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Producto:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   14
         Left            =   30
         TabIndex        =   52
         Top             =   600
         WhatsThisHelpID =   5048
         Width           =   915
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   2
         Left            =   2232
         TabIndex        =   51
         Top             =   1200
         Width           =   6228
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Monto:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   17
         Left            =   30
         TabIndex        =   50
         Top             =   1560
         WhatsThisHelpID =   5196
         Width           =   675
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Aplica Comisión:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   19
         Left            =   30
         TabIndex        =   49
         Top             =   1875
         WhatsThisHelpID =   5198
         Width           =   1485
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Nombre:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   8
         Left            =   30
         TabIndex        =   48
         Top             =   930
         WhatsThisHelpID =   5007
         Width           =   795
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Valor:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   9
         Left            =   4515
         TabIndex        =   47
         Top             =   1875
         WhatsThisHelpID =   5054
         Width           =   585
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Periodicidad:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   15
         Left            =   30
         TabIndex        =   46
         Top             =   2150
         WhatsThisHelpID =   5193
         Width           =   1200
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   4
         Left            =   2235
         TabIndex        =   45
         Top             =   2120
         Width           =   1275
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Días a Aplicar:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   4530
         TabIndex        =   44
         Top             =   2160
         WhatsThisHelpID =   5194
         Width           =   1365
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*y"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   16
         Left            =   7320
         TabIndex        =   43
         Top             =   2175
         WhatsThisHelpID =   5195
         Width           =   180
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Fecha Vigencia:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   11
         Left            =   30
         TabIndex        =   42
         Top             =   2475
         WhatsThisHelpID =   5046
         Width           =   1470
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Fecha Vencimiento:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   12
         Left            =   4530
         TabIndex        =   41
         Top             =   2475
         WhatsThisHelpID =   5047
         Width           =   1770
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   23
         Left            =   60
         TabIndex        =   40
         Top             =   660
         Width           =   75
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "*Detalle de las Cuentas Crédito:"
      ForeColor       =   &H000000FF&
      Height          =   1350
      Left            =   0
      TabIndex        =   30
      Top             =   2940
      WhatsThisHelpID =   5199
      Width           =   8520
      Begin VB.ComboBox cmbTipo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   315
         Left            =   900
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Top             =   350
         Width           =   1995
      End
      Begin MSMask.MaskEdBox Mskcuentacr 
         Height          =   285
         Left            =   5085
         TabIndex        =   21
         Top             =   345
         Width           =   2520
         _ExtentX        =   4445
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         Enabled         =   0   'False
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskvalorcr 
         Height          =   285
         Left            =   900
         TabIndex        =   22
         Top             =   1000
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   503
         _Version        =   393216
         ClipMode        =   1
         Appearance      =   0
         Enabled         =   0   'False
         Format          =   "#,##0.00;(#,##0.00)"
         PromptChar      =   "_"
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   312
         Index           =   8
         Left            =   7630
         TabIndex        =   23
         Tag             =   "2753"
         Top             =   350
         Width           =   850
         _Version        =   65536
         _ExtentX        =   1499
         _ExtentY        =   550
         _StockProps     =   78
         Caption         =   "Crear"
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
         Height          =   312
         Index           =   9
         Left            =   7630
         TabIndex        =   24
         Tag             =   "2755"
         Top             =   672
         Width           =   850
         _Version        =   65536
         _ExtentX        =   1499
         _ExtentY        =   550
         _StockProps     =   78
         Caption         =   "Eliminar"
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
         Height          =   312
         Index           =   10
         Left            =   7630
         TabIndex        =   25
         Tag             =   "2752"
         Top             =   1000
         Width           =   850
         _Version        =   65536
         _ExtentX        =   1499
         _ExtentY        =   550
         _StockProps     =   78
         Caption         =   "Limpiar"
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
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Enabled         =   0   'False
         ForeColor       =   &H000000FF&
         Height          =   285
         Index           =   1
         Left            =   5115
         TabIndex        =   37
         Top             =   1005
         Width           =   2490
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Total:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   13
         Left            =   3075
         TabIndex        =   36
         Top             =   1050
         WhatsThisHelpID =   5178
         Width           =   585
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Producto:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   30
         TabIndex        =   35
         Top             =   360
         WhatsThisHelpID =   5048
         Width           =   915
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Nombre:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   30
         TabIndex        =   34
         Top             =   720
         WhatsThisHelpID =   5007
         Width           =   795
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. de Cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   3075
         TabIndex        =   33
         Top             =   360
         WhatsThisHelpID =   5016
         Width           =   1905
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   270
         Index           =   0
         Left            =   900
         TabIndex        =   26
         Top             =   672
         Width           =   6700
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   60
         TabIndex        =   32
         Top             =   660
         Width           =   75
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Monto:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   10
         Left            =   30
         TabIndex        =   31
         Top             =   1050
         WhatsThisHelpID =   5196
         Width           =   675
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   0
      Left            =   8600
      TabIndex        =   16
      Top             =   5355
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
      Height          =   735
      Index           =   6
      Left            =   8600
      TabIndex        =   17
      Tag             =   "2756"
      Top             =   735
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
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
      Height          =   735
      Index           =   2
      Left            =   8600
      TabIndex        =   14
      Tag             =   "2759"
      Top             =   3045
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Eliminar"
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
      Height          =   735
      Index           =   3
      Left            =   8600
      TabIndex        =   13
      Tag             =   "2757"
      Top             =   2265
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
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
   Begin MSGrid.Grid grdRegistros 
      Height          =   1515
      Left            =   15
      TabIndex        =   27
      Top             =   4530
      Width           =   8500
      _Version        =   65536
      _ExtentX        =   14993
      _ExtentY        =   2672
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
      Cols            =   4
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   1
      Left            =   8600
      TabIndex        =   15
      Top             =   4590
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   7
      Left            =   8600
      TabIndex        =   18
      Top             =   1500
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
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
      Height          =   735
      Index           =   5
      Left            =   8600
      TabIndex        =   28
      Top             =   735
      Visible         =   0   'False
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   4
      Left            =   8600
      TabIndex        =   19
      Tag             =   "2758"
      Top             =   -15
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
      Height          =   735
      Index           =   11
      Left            =   8600
      TabIndex        =   57
      Tag             =   "2932"
      Top             =   3795
      Visible         =   0   'False
      WhatsThisHelpID =   2503
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "*&Autorizar"
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
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      ForeColor       =   &H000000FF&
      Height          =   285
      Index           =   5
      Left            =   6960
      TabIndex        =   38
      Top             =   2040
      Width           =   1275
   End
   Begin VB.Line Line3 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8550
      X2              =   0
      Y1              =   2895
      Y2              =   2895
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Registos Existentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   29
      Top             =   4335
      WhatsThisHelpID =   5200
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8550
      X2              =   8550
      Y1              =   0
      Y2              =   6105
   End
End
Attribute VB_Name = "FTran2576"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRA2576.frm
' NOMBRE LOGICO:    FTran2576
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
' Mantenimiento de Transferencias Automáticas, cuenta origen
' incluye detalle de la transferencia: vigencia, periodicidad
' y monto
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 31-Abr-05      L. Bernuil      Consolidar Pantalla de Encabezados
'                                de transferencias con pantalla de
'                                detalle de transferencias
'*************************************************************
Option Explicit
Dim VLPaso As Integer
Dim VLFechahasta As String
Dim VLMonto As Double
Dim VLMonto_crtmp As Double
Dim VT As Integer
Dim VLError As Integer
Dim VTFecha1 As String
Dim VTFecha2 As String
Dim VTFecha As String
Dim VTModificable As String
Dim i As Integer
Dim j As Integer


Private Sub Form_Activate()
Screen.MousePointer = 1
End Sub

Private Sub Form_Load()
    FTran2576.Left = 0   '15
    FTran2576.Top = 0   '15
    FTran2576.Width = 9600   '9420
    FTran2576.Height = 6645 '5900 '5775
    PMLoadResStrings Me
    PMLoadResIcons Me
    Call PMBotonSeguridad(FTran2576, 11) ' ROL 12212006 */
    cmbprodb.AddItem "CORRIENTE", 0
    cmbprodb.AddItem "AHORROS", 1
    cmbprodb.ListIndex = 1

    cmbaplicacomision.AddItem "MONTO", 0
    cmbaplicacomision.AddItem "PORCENTAJE", 1
    cmbaplicacomision.ListIndex = 0

    Mskcuentadb.Mask = VGMascaraCtaAho$
    Mskcuentacr.Mask = VGMascaraCtaAho$
    chkmodificable.Value = 1
    
    txtCampo(2).Text = "0"
    txtCampo(3).Text = "0"
    mskvalordb.Text = "0.00"
    mskvalorcomision.Text = "0.00"
    mskvalorcr.Text = "0.00"

    cmbTipo.AddItem "CORRIENTE", 0
    cmbTipo.AddItem "AHORROS", 1
    cmbTipo.ListIndex = 1

    mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
    mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha$)
    
    'Se busca Proxima Fecha Laborable por requerimiento del Banco
    'mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
    PLBuscarLaborable
    VLFechahasta = mskfechahasta.Text
    VLMonto = mskvalordb.Text
    
    'mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha$)
    'mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
    
    cmdBoton(9).Enabled = False
    cmdBoton(4).Enabled = False

    lblDescripcion(1).Caption = "0.00"

    VLPaso% = True
End Sub
Private Sub cmbprodb_GotFocus()
FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
End Sub
Private Sub cmbaplicacomision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Base sobre la cual se aplica la comision"
End Sub
Private Sub cmbaplicacomision_LostFocus()
    If mskvalorcomision.ClipText = "" Then
        mskvalorcomision.Text = "0.00"
    End If
End Sub
Private Sub cmbprodb_LostFocus()
    If cmbTipo.ListIndex = 0 Then  '' Corrientes
        Mskcuentadb.Mask = VGMascaraCtaCte$
    Else
        Mskcuentadb.Mask = VGMascaraCtaAho$
    End If
    Call Mskcuentadb_LostFocus
End Sub

Private Sub Mskcuentadb_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta Débito"
    Mskcuentadb.SelStart = 0
    Mskcuentadb.SelLength = Len(Mskcuentadb.Text)
End Sub
Private Sub Mskcuentadb_LostFocus()
    On Error Resume Next
    If Mskcuentadb.ClipText <> "" Then
        If cmbprodb.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(3)
                    PMChequea sqlconn&
                    'cmdBoton(4).Enabled = True
                Else
                    'cmdboton_click (1)
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(3).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                'cmdboton_click (1)
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(3).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                
                Exit Sub
            End If
        Else  '  Ahorros
            If FMChequeaCtaAho((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(3)
                    PMChequea sqlconn&
                    'cmdBoton(4).Enabled = True
                Else
                    'cmdboton_click (1)
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(3).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                'cmdboton_click (1)
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(3).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub
Private Sub mskvalorcomision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor de la Comision"
    mskvalorcomision.SelStart = 0
    mskvalorcomision.SelLength = Len(mskvalorcomision.Text)
End Sub
Private Sub mskvalorcomision_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
       KeyAscii = 0
    End If
    If KeyAscii = 46 Then
        If InStr(1, mskvalorcomision.Text, ".") Then
            KeyAscii = 0
        End If
    End If
End Sub
Private Sub mskValorComision_LostFocus()
If mskvalorcomision.ClipText = "" Then
    mskvalorcomision.Text = "0.00"
End If

If cmbaplicacomision.ListIndex = 1 Then 'Aplicar por porcentaje
    If Val(mskvalorcomision.ClipText) > 100 Or Val(mskvalorcomision.ClipText) <= 0 Then
        MsgBox "El porcentaje debe estar en un rango de 0.01 a 100%", 0 + 16, "Mensaje de Error"
        mskvalorcomision.Text = "0.0"
        If mskvalorcomision.Enabled And mskvalorcomision.Visible Then mskvalorcomision.SetFocus
    End If
End If
End Sub
Private Sub mskvalorcr_LostFocus()
    If mskvalorcr.ClipText = "" Then
        mskvalorcr.Text = "0.00"
    End If
End Sub
Private Sub mskValordb_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Monto a transferir / debitar"
    mskvalordb.SelStart = 0
    mskvalordb.SelLength = Len(mskvalordb.Text)
End Sub
Private Sub mskValordb_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
       KeyAscii = 0
    End If
    If KeyAscii = 46 Then
        If InStr(1, mskvalordb.Text, ".") Then
            KeyAscii = 0
        End If
    End If
End Sub
Private Sub mskvalordb_LostFocus()
    If mskvalordb.ClipText = "" Then
        mskvalordb.Text = "0.00"
    End If
End Sub
Private Sub sscobracomision_Click(Value As Integer)
cmbaplicacomision.Enabled = sscobracomision.Value
mskvalorcomision.Enabled = sscobracomision.Value
If cmbaplicacomision.Enabled Then
    If cmbaplicacomision.Enabled And cmbaplicacomision.Visible Then cmbaplicacomision.SetFocus
End If
End Sub
Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
        Case 0, 1, 4 ' 4 codigo de la transferencia
            VLPaso% = False
    End Select
End Sub
Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Causa de la Transferencia y/o Débito [F5 Ayuda]"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Periodicidad de la Transferencia [F5 Ayuda]"
        Case 2
            FPrincipal!pnlHelpLine.Caption = " Primer Dia a Aplicar la Transferencia [F5 Ayuda]"
        Case 3
            FPrincipal!pnlHelpLine.Caption = " Segundo Dia a Aplicar la Transferencia [F5 Ayuda]"
        Case 4 ' NUEVO ROL 12192006
            FPrincipal!pnlHelpLine.Caption = " Codigo de la Transferencia [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
    
    FPrincipal!pnlTransaccionLine.Caption = "FTRA2576 - V 3"
    
End Sub
Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
If Keycode = VGTeclaAyuda% Then
    txtCampo(Index%).Text = ""

    Select Case Index%

        Case 0
            PMCatalogo "A", "re_tipo_transfer", txtCampo(0), lblDescripcion(2)
            VLPaso% = True
        Case 1
            PMCatalogo "A", "cc_period_transfer", txtCampo(1), lblDescripcion(4)
        Case 4
            ReDim VGADatosO(1) As String
            FCtranAut.Show 1
            Screen.MousePointer = 1
            txtCampo(4).Text = VGADatosO(0)
            If txtCampo(4).Text <> "" Then
               PLBuscar
            End If

    End Select
End If
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
        Case 0, 2, 3, 4
            KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
        Case 1
            If (KeyAscii% <> 8) And ((KeyAscii% < 65) Or (KeyAscii% > 90)) And ((KeyAscii% < 97) Or (KeyAscii% > 122)) Then
                KeyAscii% = 0
            Else
                KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
            End If
    End Select
End Sub
Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
        Case 0
            If VLPaso% = False Then
                If txtCampo(0).Text <> "" Then
                    PMCatalogo "V", "re_tipo_transfer", txtCampo(0), lblDescripcion(2)
                    
                    ' PLBuscar comentado ROL 12202006,
                Else
                    lblDescripcion(2).Caption = ""
                End If
            End If
        Case 1
            If VLPaso% = False Then
                If txtCampo(1).Text <> "" Then
                    PMCatalogo "V", "cc_period_transfer", txtCampo(1), lblDescripcion(4)
                Else
                    lblDescripcion(4).Caption = ""
                End If
                
                If txtCampo(1).Text = "Q" Then
                    'lblEtiqueta(5).Enabled = True
                    'lblEtiqueta(16).Enabled = True
                    txtCampo(2).Enabled = True
                    txtCampo(3).Enabled = True
                    
                    If txtCampo(2).Text = "" Then
                        txtCampo(2).Text = "0"
                    End If
                    
                    If txtCampo(3).Text = "" Then
                        txtCampo(3).Text = "0"
                    End If
                    
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Else
                    If txtCampo(1).Text = "M" Then
                        txtCampo(2).Enabled = True
                        txtCampo(3).Enabled = False
                        txtCampo(2).SetFocus
                    Else
                        'lblEtiqueta(5).Enabled = False
                        'lblEtiqueta(16).Enabled = False
                        txtCampo(2).Enabled = False
                        txtCampo(3).Enabled = False
                    End If
                End If
            End If
         Case 4
           If txtCampo(4).Text <> "" Then
              cmdBoton(6).Enabled = True
           End If
    End Select
End Sub
Private Sub cmbTipo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Tipo de Producto Cuenta Crédito"
End Sub
Private Sub cmbTipo_LostFocus()
    If cmbTipo.ListIndex = 0 Then  'Corrientes
        Mskcuentacr.Mask = VGMascaraCtaCte$
    Else
        Mskcuentacr.Mask = VGMascaraCtaAho$
    End If
    Call Mskcuentacr_LostFocus
End Sub
Private Sub Mskcuentacr_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta crédito"
    Mskcuentacr.SelStart = 0
    Mskcuentacr.SelLength = Len(Mskcuentacr.Text)
End Sub
Private Sub Mskcuentacr_LostFocus()
    On Error Resume Next
    If Mskcuentacr.ClipText <> "" Then
        If cmbTipo.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((Mskcuentacr.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentacr.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentacr.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                    'cmdBoton(4).Enabled = True
                Else
                    'cmdboton_click (1)
                    Mskcuentacr.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                'cmdboton_click (1)
                Mskcuentacr.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.SetFocus
                
                Exit Sub
            End If
        Else  '  Ahorros
            If FMChequeaCtaAho((Mskcuentacr.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentacr.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentacr.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                    'cmdBoton(4).Enabled = True
                Else
                    'cmdboton_click (1)
                    Mskcuentacr.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                'cmdboton_click (1)
                Mskcuentacr.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(0).Caption = ""
                If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub
Private Sub mskValorcr_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Monto a transferir"
    mskvalorcr.SelStart = 0
    mskvalorcr.SelLength = Len(mskvalorcr.Text)
End Sub
Private Sub mskValorcr_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
        KeyAscii = 0
    End If
    If KeyAscii = 46 Then
        If InStr(1, mskvalorcr.Text, ".") Then
            KeyAscii = 0
        End If
    End If
End Sub
Private Sub mskFecha_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Fecha de inicio de vigencia [" & VGFormatoFecha & "]"
    mskFecha.SelStart = 0
    mskFecha.SelLength = Len(mskFecha.Text)
End Sub
Private Sub mskFecha_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub
Private Sub MskFecha_LostFocus()
    If mskFecha.ClipText <> "" Then
        VT% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha)
        If Not VT% Then
            MsgBox "Formato de fecha inválido", 48, "Control Ingreso de Datos"
            
            VLError% = True
            If mskFecha.Enabled And mskFecha.Visible Then mskFecha.SetFocus
            Exit Sub
        End If
    End If
End Sub
Private Sub mskFechahasta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Fecha de vencimiento [" & VGFormatoFecha & "]"
    mskfechahasta.SelStart = 0
    mskfechahasta.SelLength = Len(mskfechahasta.Text)
End Sub
Private Sub mskFechahasta_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub
Private Sub mskFechahasta_LostFocus()
    If mskfechahasta.ClipText <> "" Then
        VT% = FMVerFormato((mskfechahasta.FormattedText), VGFormatoFecha)
        If Not VT% Then
            MsgBox "Formato de fecha inválido", 48, "Control Ingreso de Datos"
            VLError% = True
            If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.SetFocus
            Exit Sub
        Else
            'Verficar que fecha de consulta sea menor que la fecha del sistema
            VTFecha1$ = Format(mskfechahasta.Text, VGFormatoFecha$)
            VTFecha2$ = Format(mskFecha.Text, VGFormatoFecha$)
            If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
                MsgBox "Fecha de vencimiento debe ser mayor o igual a la fecha de vigencia", 0 + 16, "Mensaje de Error"
                If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub
Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
        Case 0 'Salir
            
            If FLTransferenciaCuadrada Then
                Unload FTran2576
            Else
                MsgBox "Se deben cuadrar los débitos y los créditos antes de salir de esta pantalla", vbOKOnly + vbCritical, "Advertencia"
                Exit Sub
            End If
        Case 1 'Limpiar
          If Not FLTransferenciaCuadrada Then
            If MsgBox("Esta seguro(a) de limpiar la información de la transferencia sin antes haber cuadrado débitos y créditos", vbQuestion + vbYesNo + vbDefaultButton2) = vbNo Then
            Exit Sub
            End If
          End If
          PLLimpiar
          VLMonto_crtmp = 0
          Screen.MousePointer = 1
          
        Case 2 'Eliminar
            PLEliminar
        Case 3 ' Inserta nuevo
            PLCrear
        Case 4 ' Actualizar
            PLActualizar
        Case 5 'Siguientes
            'PLSiguientes
        Case 6 'Buscar
            PLBuscar
        Case 7  'Imprmir
            PLImprimir
            Screen.MousePointer = 1
        Case 8 'Crear Detalle
            PLCrearDetalle
        Case 9 'Eliminar Detalle
            PLEliminarDetalle
        Case 10 'Limpiar Datos del Detalle
            PLLimpiarDetalle
            VLMonto_crtmp = 0
        Case 11 ' Autorizacion
            PLAutorizar
    End Select
End Sub
Private Sub PLBuscarLaborable()
'*************************************************************
' PROPOSITO: Busca La Próxima Fecha Laborable
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 29-Sep-05      J. Suárez       Emisión Inicial
'*************************************************************
                  
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "711"     '"2756"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
    
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If

    PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Consulta de Transferencias Automaticas") Then
        PMMapeaVariable sqlconn&, VTFecha$
        PMChequea sqlconn&
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Len(Trim$(VTFecha$)) = 0 Then
            MsgBox "No se han definido los dìas laborables", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
        mskFecha.Text = Format$(VTFecha$, VGFormatoFecha$)
        mskfechahasta.Text = Format$(VTFecha$, VGFormatoFecha$)
    Else
        mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
        PMChequea sqlconn&
    End If
End Sub
Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Busca los Encabezados de las transferencias
'            automáticas
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 01-Abr-05      L.Bernuil       Unificicación de Pantallas
'*************************************************************
    ' Validacion de mandatoriedades
         
    Dim VTR1 As Integer
    If txtCampo(4).Text = "" Then  ' ROL 12202006
       If Mskcuentadb.ClipText = "" Then
          MsgBox "La cuenta débito u origen es mandatoria", 0 + 16, "Mensaje de Error"
          If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
             Exit Sub
       End If
            
       If txtCampo(0).Text = "" Then
          MsgBox "La causa de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
          If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
          Exit Sub
       End If
    End If
                  
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "711"     '"2756"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text
    
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If

    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
    PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(4).Text

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Consulta de Transferencias Automaticas") Then
        ReDim VTArreglo(20) As String
        VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        txtCampo(0).Text = VTArreglo(1)
        lblDescripcion(2).Caption = VTArreglo(2)
        
        If VTArreglo(3) = "S" Then 'si aplica comision
            sscobracomision.Value = True
        Else
            sscobracomision.Value = False
        End If
        
        If VTArreglo(4) = "M" Then
            cmbaplicacomision.ListIndex = 0
            mskvalorcomision.Text = VTArreglo(6)
        Else
            cmbaplicacomision.ListIndex = 1
            mskvalorcomision.Text = VTArreglo(5)
        End If
        
        mskvalordb.Text = VTArreglo(7)
        
        txtCampo(1).Text = VTArreglo(8)
        lblDescripcion(4).Caption = VTArreglo(9)
        
        If VTArreglo(8) = "Q" Then
            txtCampo(2).Enabled = True
            txtCampo(3).Enabled = True
        Else
            txtCampo(2).Enabled = False
            txtCampo(3).Enabled = False
        End If
        
        txtCampo(2).Text = VTArreglo(10)
        txtCampo(3).Text = VTArreglo(11)
        mskFecha.Text = VTArreglo(12)
        mskfechahasta.Text = VTArreglo(13)
        VLFechahasta = mskfechahasta.Text
        VLMonto = mskvalordb.Text
        ' ROL 12202006
        txtCampo(4).Text = VTArreglo(14)
        txtCampo(4).Enabled = False
        If VTArreglo(16) = "CTE" Then    '  corriente
            cmbprodb.ListIndex = 0
        Else
            cmbprodb.ListIndex = 1       '  AHORROS
        End If
        
        If VTArreglo(17) = "S" Then
           Me.chkmodificable.Value = 1
        Else
           Me.chkmodificable.Value = 0
        End If
        
        Mskcuentadb.Enabled = True
        

        If VTArreglo(15) <> "" And VTArreglo(16) = "AHO" Then
           Mskcuentadb.Mask = VGMascaraCtaAho$
           Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
           Mskcuentadb.Text = FMMascara(VTArreglo(15), VGMascaraCtaAho$)
        End If
        
        If VTArreglo(15) <> "" And VTArreglo(16) = "CTE" Then
           Mskcuentadb.Mask = VGMascaraCtaCte$
           Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
           Mskcuentadb.Text = FMMascara(VTArreglo(15), VGMascaraCtaCte$)
        End If
        

        If VTArreglo(15) <> "" And VTArreglo(16) <> "" Then
           PLBuscar_Cuenta
        End If
        ' FIN ROL 12202006
                
        'Deshabilitar los campos que fueron el criterio de la busqueda
        cmbprodb.Enabled = False
        Mskcuentadb.Enabled = False
        txtCampo(0).Enabled = False
        
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = True 'False
        cmdBoton(2).Enabled = True
        cmdBoton(6).Enabled = False
        mskvalordb.Enabled = True 'False
        
        cmbaplicacomision.Enabled = False
        sscobracomision.Enabled = False
        'txtCampo(1).Enabled = False  ROL 12222006
        txtCampo(2).Enabled = False
        txtCampo(3).Enabled = False
        mskFecha.Enabled = False
        mskfechahasta.Enabled = True 'False
        mskvalorcomision.Enabled = False
        
        'Habilitar campos del detalle
        grdRegistros.Enabled = True
        Frame1.Enabled = True
        cmbTipo.Enabled = True
        Mskcuentacr.Enabled = True
        lblDescripcion(0).Enabled = True
        mskvalorcr.Enabled = True
        lblDescripcion(1).Enabled = True
        cmdBoton(8).Enabled = True
        cmdBoton(9).Enabled = True
        cmdBoton(10).Enabled = True
        
        'Se procede a efectuar la busqueda de los registros asociados a la cuenta Debito
        PLBuscarDetalle
        If cmbTipo.Enabled And cmbTipo.Visible Then cmbTipo.SetFocus
        
        lblDescripcion(1).Caption = Format(CCur(FLSumarValoresGrid), "###,###,##0.00")
        
        'Encuentra Si la cabecera está cuadrada
        If CCur((CDbl(lblDescripcion(1).Caption))) = CCur(mskvalordb.ClipText) Then
            lblDescripcion(5).Caption = "Cuadrado"
        Else
            lblDescripcion(5).Caption = "Descuadrado"
        End If
        
        
        
    Else
       'PLLimpiar
       'PLLimpiarDetalle
       'PMLimpiaGrid grdRegistros
       cmdBoton(4).Enabled = False
       cmdBoton(2).Enabled = False
       cmdBoton(3).Enabled = True
       If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.SetFocus
    End If
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


    cmbprodb.ListIndex = 1
    cmbaplicacomision.ListIndex = 0
    cmbTipo.ListIndex = 0
    Me.chkmodificable.Value = 1

    Mskcuentadb.Mask = FMMascara("", VGMascaraCtaAho$)
    Mskcuentacr.Mask = FMMascara("", VGMascaraCtaAho$)
        
    txtCampo(2).Text = "0"
    txtCampo(3).Text = "0"
    txtCampo(2).Enabled = False
    txtCampo(3).Enabled = False
    txtCampo(4).Text = ""       ' ROL 12202006
    txtCampo(4).Enabled = True  ' ROL 12202006

    mskvalordb.Text = "0.00"
    mskvalorcomision.Text = "0.00"
    mskvalorcr.Text = "0.00"
    sscobracomision.Value = False

    'mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
    'mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
    PLBuscarLaborable

    mskFecha.Enabled = True
    mskfechahasta.Enabled = True

    lblDescripcion(2).Caption = ""
    lblDescripcion(4).Caption = ""
    lblDescripcion(0).Caption = ""
    lblDescripcion(3).Caption = ""
    
    txtCampo(0).Text = ""
    txtCampo(1).Text = ""
    
    cmdBoton(3).Enabled = True
    cmdBoton(2).Enabled = False
    cmdBoton(4).Enabled = False
    cmdBoton(6).Enabled = True
    cmdBoton(7).Enabled = False

    cmdBoton(8).Enabled = True 'crear
    cmdBoton(9).Enabled = False 'Eliminar
    cmdBoton(10).Enabled = True 'Limpiar

    If cmbprodb.Enabled = False Then
        cmbprodb.Enabled = True
    End If
    Mskcuentadb.Enabled = True
    txtCampo(0).Enabled = True
   
    mskvalorcr.Enabled = True
    mskvalordb.Enabled = True
    Mskcuentacr.Enabled = True
    cmbTipo.Enabled = True

    cmbaplicacomision.Enabled = False
    sscobracomision.Enabled = True
    txtCampo(1).Enabled = True
    txtCampo(2).Enabled = True
    txtCampo(3).Enabled = True
    mskFecha.Enabled = True
    mskfechahasta.Enabled = True
    mskvalorcomision.Enabled = False
    
   lblDescripcion(1).Caption = "0.00"

    PMLimpiaGrid grdRegistros
    cmdBoton(9).Enabled = False
    
    'Deshabilitar campos de detalle
    grdRegistros.Enabled = False
    Frame1.Enabled = False
    cmbTipo.Enabled = False
    Mskcuentacr.Enabled = False
    lblDescripcion(0).Enabled = False
    mskvalorcr.Enabled = False
    lblDescripcion(1).Enabled = False
    cmdBoton(8).Enabled = False
    cmdBoton(9).Enabled = False
    cmdBoton(10).Enabled = False
    
    'If cmbprodb.Enabled And cmbprodb.Visible Then cmbprodb.SetFocus
    
    If txtCampo(4).Enabled = True Then txtCampo(4).SetFocus
End Sub
Private Sub PLLimpiarDetalle()
'*************************************************************
' PROPOSITO: Limpia los valores de las cuentas de detalle
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 02-Abr-05      L. Bernuil      Emisión Inicial
'*************************************************************
mskvalorcr.Enabled = True
Mskcuentacr.Enabled = True
cmbTipo.Enabled = True

cmbprodb.ListIndex = 1
Mskcuentacr.Mask = FMMascara("", VGMascaraCtaAho$)
lblDescripcion(0).Caption = ""
mskvalorcr.Text = "0.00"
PMLimpiaGrid grdRegistros

cmdBoton(8).Enabled = True 'crear
cmdBoton(9).Enabled = False 'Eliminar
cmdBoton(10).Enabled = True 'Limpiar
cmdBoton(8).Caption = "Crear"

If cmbTipo.Enabled And cmbTipo.Visible Then cmbTipo.SetFocus

PLBuscarDetalle
End Sub
Private Sub PLCrear()
'*************************************************************
' PROPOSITO: Crea un  nuevo contrato de transferencia
'            automatica
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 01-Abr-05      L. Bernuil      Personalizacion
'*************************************************************

    'Validacion de Madatoriedades al grabar

    If txtCampo(0).Text = "" Then
        MsgBox "La causa de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If

    If Mskcuentadb.ClipText = "" Then
        MsgBox "La cuenta débito u origen es mandatoria", 0 + 16, "Mensaje de Error"
        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
        Exit Sub
    End If

    If mskvalordb.ClipText = "" Then
        MsgBox "El monto Total a debitar es mandatorio", 0 + 16, "Mensaje de Error"
        If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.SetFocus
        Exit Sub
    Else
        If CCur(mskvalordb.ClipText) <= 0 Then
            MsgBox "El monto total a debitar debe ser mayor que 0.00", 0 + 16, "Mensaje de Error"
            If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.SetFocus
            Exit Sub
        End If
    End If
       
    If txtCampo(1).Text = "" Then
        MsgBox "La periodicidad de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).SetFocus
        Exit Sub
    Else
        If txtCampo(1).Text = "Q" Then
            
            If Val(txtCampo(2).Text) <= 0 Or Val(txtCampo(2).Text) > 31 Then
                MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el primer día a aplicar", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
            
            If Val(txtCampo(3).Text) <= 0 Or Val(txtCampo(3).Text) > 31 Then
                MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el segundo día a aplicar", 0 + 16, "Mensaje de Error"
                If txtCampo(3).Enabled And txtCampo(3).Visible Then txtCampo(3).SetFocus
                Exit Sub
            End If
                        
            If Val(txtCampo(2).Text) = Val(txtCampo(3).Text) Then
                MsgBox "Los dos días a aplicar deben ser diferentes", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
            
            If Val(txtCampo(2).Text) > Val(txtCampo(3).Text) Then
                MsgBox "El primer día de quincena a aplicar debe ser menor que el segundo dia", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
        End If
        
        If txtCampo(1).Text = "M" Then
            If Val(txtCampo(2).Text) <= 0 Or Val(txtCampo(2).Text) > 31 Then
                MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el primer día a aplicar", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
        End If
        
    End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "714"     '"2757"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, (txtCampo(0).Text)
         
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If
         
    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText
    PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(3).Caption
         
    If sscobracomision.Value = True Then
        PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
        
        If cmbaplicacomision.ListIndex = 0 Then 'Comision por Monto
            PMPasoValores sqlconn&, "@i_base_comision", 0, SQLCHAR, "M"
            PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, "0.0"
            PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, mskvalorcomision.ClipText
        Else
            PMPasoValores sqlconn&, "@i_base_comision", 0, SQLCHAR, "P"
            PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, mskvalorcomision.ClipText
            PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, "0.00"
        End If
    Else
        PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
        PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, "0.0"
        PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, "0.00"
    End If
             
    PMPasoValores sqlconn&, "@i_monto_total", 0, SQLMONEY, mskvalordb.ClipText
         
    PMPasoValores sqlconn&, "@i_periodicidad", 0, SQLCHAR, txtCampo(1).Text
    Select Case txtCampo(1).Text
        Case "Q"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, txtCampo(3).Text
        Case "M"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, "0"
        Case "D"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, "0"
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, "0"
    End Select
       
    If mskFecha.ClipText = "" Then
       MsgBox "La fecha de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
       If mskFecha.Enabled And mskFecha.Visible Then mskFecha.SetFocus
       Exit Sub
    End If

    If mskfechahasta.ClipText = "" Then
       MsgBox "La fecha de vencimiento es mandatoria", 0 + 16, "Mensaje de Error"
       If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.SetFocus
       Exit Sub
    End If
       
    VTFecha1$ = Format(mskfechahasta.Text, VGFormatoFecha$)
    VTFecha2$ = Format(mskFecha.Text, VGFormatoFecha$)
    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
         MsgBox "Fecha de vencimiento debe ser mayor a fecha de vigencia", 0 + 16, "Mensaje de Error"
         Exit Sub
    End If

    'Verficar que fecha de no sea menor que la fecha del sistema
    VTFecha1$ = Format(mskFecha.Text, VGFormatoFecha$)
    VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
         MsgBox "Fecha de vigencia no debe ser menor a fecha del sistema", 0 + 16, "Mensaje de Error"
         If mskFecha.Enabled And mskFecha.Visible Then mskFecha.SetFocus
         Exit Sub
    End If
        
    PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha((mskFecha.Text), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha((mskfechahasta.Text), VGFormatoFecha$, CGFormatoBase$)
    If chkmodificable.Value = 1 Then
       VTModificable = "S"
    Else
       VTModificable = "N"
    End If
    PMPasoValores sqlconn&, "@i_modificable", 0, SQLCHAR, VTModificable
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Inserción de Encabezado de Transferencia Automática") Then
        PMMapeaVariable sqlconn&, VTFecha$  ' ROL 12202006
        PMChequea sqlconn&
        MsgBox "Detalle de la cuenta débito creada con éxito", vbInformation + vbOKOnly, "Mensaje"
        txtCampo(4).Text = VTFecha$  ' ROL 12202006
        Mskcuentadb.Enabled = False
        txtCampo(0).Enabled = False
        cmbprodb.Enabled = False
        cmdBoton(4).Enabled = False 'True
        cmdBoton(2).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(6).Enabled = False

        cmbaplicacomision.Enabled = False
        sscobracomision.Enabled = False
        txtCampo(1).Enabled = False
        txtCampo(2).Enabled = False
        txtCampo(3).Enabled = False
        txtCampo(4).Enabled = False    ' ROL 12202006
        mskFecha.Enabled = False
        mskfechahasta.Enabled = False
        mskvalorcomision.Enabled = False
        
        mskvalordb.Enabled = False
        
        'Habilitar campos del detalle
        grdRegistros.Enabled = True
        Frame1.Enabled = True
        cmbTipo.Enabled = True
        Mskcuentacr.Enabled = True
        lblDescripcion(0).Enabled = True
        mskvalorcr.Enabled = True
        lblDescripcion(1).Enabled = True
        cmdBoton(8).Enabled = True
        cmdBoton(9).Enabled = True
        cmdBoton(10).Enabled = True
        
        'Variable de Local de Fecha debe ser igual a la transmitida
        VLFechahasta = mskfechahasta.Text
        VLMonto = mskvalordb.Text
        
        If cmbTipo.Enabled And cmbTipo.Visible Then cmbTipo.SetFocus
    Else
        'No debe limpiar si es que da error.......
        'PLLimpiar
        PMChequea sqlconn&
    End If
End Sub
Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Permite actualizar los datos respectivos al tipo
'            de transferencia automatica
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 01-Abr-05      L. Bernuil      Personalizacion
'*************************************************************
Dim VTValorSumadoGrid As Double
Dim VTEstado As String

    ' Valida que se haya hecho alguna modificación
   ' If (VLFechahasta = mskfechahasta.Text) And (mskvalordb.Text = VLMonto) Then
'        MsgBox "No hay cambios en el detalle de la cuenta débito", 0 + 16, "Mensaje de Error"
'        Exit Sub
'    End If
    VTEstado = "N"
    
    VTValorSumadoGrid = 0
    VTValorSumadoGrid = FLSumarValoresGrid
    
    If CCur(CDbl(VTValorSumadoGrid)) = CCur(mskvalordb.ClipText) Then
        VTEstado = "I"
    End If
    PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado

    ' Validacion de mandatoriedades
         
    If txtCampo(0).Text = "" Then
        MsgBox "La causa de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If

    If Mskcuentadb.ClipText = "" Then
        MsgBox "La cuenta débito u origen es mandatoria", 0 + 16, "Mensaje de Error"
        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
        Exit Sub
    End If

    If mskvalordb.ClipText = "" Then
        MsgBox "El monto total a debitar es mandatorio", 0 + 16, "Mensaje de Error"
        If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.SetFocus
        Exit Sub
    Else
        If CCur(mskvalordb.ClipText) <= 0 Then
            MsgBox "El monto total a debitar debe ser mayor que 0.00", 0 + 16, "Mensaje de Error"
            If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.SetFocus
            Exit Sub
        End If
    End If
       
    If txtCampo(1).Text = "" Then
        MsgBox "La periodicidad de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).SetFocus
        Exit Sub
    Else
        If txtCampo(1).Text = "Q" Then
            
            If Val(txtCampo(2).Text) <= 0 Or Val(txtCampo(2).Text) > 31 Then
                MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el primer día a aplicar", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
            
            If Val(txtCampo(3).Text) <= 0 Or Val(txtCampo(3).Text) > 31 Then
                MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el segundo día a aplicar", 0 + 16, "Mensaje de Error"
                If txtCampo(3).Enabled And txtCampo(3).Visible Then txtCampo(3).SetFocus
                Exit Sub
            End If
                        
            If Val(txtCampo(2).Text) = Val(txtCampo(3).Text) Then
                MsgBox "Los dos días a aplicar deben ser diferentes", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
            
            If Val(txtCampo(2).Text) > Val(txtCampo(3).Text) Then
                MsgBox "El primer día de quincena a aplicar debe ser menor que el segundo dia", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
        End If
        
        If txtCampo(1).Text = "M" Then
            If Val(txtCampo(2).Text) <= 0 Or Val(txtCampo(2).Text) > 31 Then
                MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el primer día a aplicar", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If
        End If
        
    End If
    VTValorSumadoGrid = 0
    VTValorSumadoGrid = FLSumarValoresGrid
    VLMonto_crtmp = CDbl(mskvalorcr.ClipText)
    
    'If CCur((CDbl(VTValorSumadoGrid) + VLMonto_crtmp)) > CCur(mskvalordb.ClipText) Then
    If CCur(CDbl(VTValorSumadoGrid)) > CCur(mskvalordb.ClipText) Then
         MsgBox "La Suma de los créditos no coincide con el monto a debitar", 0 + 16, "Mensaje de Error"
         If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.SetFocus
         Exit Sub
    End If

    VTFecha1$ = Format(mskfechahasta.Text, VGFormatoFecha$)
    VTFecha2$ = Format(mskFecha.Text, VGFormatoFecha$)
    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
         MsgBox "Fecha de vencimiento debe ser mayor a fecha de vigencia", 0 + 16, "Mensaje de Error"
         Exit Sub
    End If
    
    'Verficar que fecha de vencimiento no sea menor que la fecha del sistema
    VTFecha1$ = Format(mskfechahasta.Text, VGFormatoFecha$)
    VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
         MsgBox "Fecha de vencimiento no debe ser menor a fecha del sistema", 0 + 16, "Mensaje de Error"
         If mskFecha.Enabled And mskFecha.Visible Then mskFecha.SetFocus
         Exit Sub
    End If
    
    'Verifica que la nueva fecha, sea siempre mayor
    VTFecha1$ = Format(mskfechahasta.Text, VGFormatoFecha$)
    VTFecha2$ = Format(VLFechahasta, VGFormatoFecha$)
    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
        MsgBox "Fecha nueva debe ser mayor o igual a la fecha anterior", 0 + 16, "Mensaje de Error"
        mskfechahasta.Text = VLFechahasta
        If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.SetFocus
        Exit Sub
    End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "715"     '"2758"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, (txtCampo(0).Text)
         
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If
         
    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText
    PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(3).Caption
         
    If sscobracomision.Value = True Then
        PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
        
        If cmbaplicacomision.ListIndex = 0 Then 'Comision por Monto
            PMPasoValores sqlconn&, "@i_base_comision", 0, SQLCHAR, "M"
            PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, "0.0"
            PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, mskvalorcomision.ClipText
        Else
            PMPasoValores sqlconn&, "@i_base_comision", 0, SQLCHAR, "P"
            PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, mskvalorcomision.ClipText
            PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, "0.00"
        End If
    Else
        PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
        PMPasoValores sqlconn&, "@i_tasa", 0, SQLFLT8, "0.0"
        PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, "0.00"
    End If
             
    PMPasoValores sqlconn&, "@i_monto_total", 0, SQLMONEY, mskvalordb.ClipText
         
    PMPasoValores sqlconn&, "@i_periodicidad", 0, SQLCHAR, txtCampo(1).Text
    Select Case txtCampo(1).Text
        Case "Q"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, txtCampo(3).Text
        Case "M"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, "0"
        Case "D"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, "0"
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, "0"
    End Select
         
    If mskFecha.ClipText = "" Then
       MsgBox "La fecha de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
       If mskFecha.Enabled And mskFecha.Visible Then mskFecha.SetFocus
       Exit Sub
    End If

    If mskfechahasta.ClipText = "" Then
       MsgBox "La fecha de vencimiento es mandatoria", 0 + 16, "Mensaje de Error"
       If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.SetFocus
       Exit Sub
    End If
         
    VTFecha2$ = Format(mskFecha.Text, VGFormatoFecha$)
    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
         MsgBox "Fecha de vencimiento debe ser mayor a fecha de vigencia", 0 + 16, "Mensaje de Error"
         Exit Sub
    End If

    'Verficar que fecha de no sea menor que la fecha del sistema
    VTFecha1$ = Format(mskFecha.Text, VGFormatoFecha$)
    VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
'    If FMDateDiff("d", VTFecha1$, VTFecha2$, VGFormatoFecha) < 0 Then
'         MsgBox "Fecha de vigencia no debe ser menor a fecha del sistema", 0 + 16, "Mensaje de Error"
'         If MskFecha.Enabled And MskFecha.Visible Then MskFecha.SetFocus
'         Exit Sub
'    End If
        
    PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha((mskFecha.Text), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha((mskfechahasta.Text), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(4).Text
    If chkmodificable.Value = 1 Then
       VTModificable = "S"
    Else
       VTModificable = "N"
    End If
    PMPasoValores sqlconn&, "@i_modificable", 0, SQLCHAR, VTModificable
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Actualización de Transferencia Automatica") Then
        PMChequea sqlconn&
        MsgBox "El detalle de la cuenta débito fue modificado exitosamente", vbInformation + vbOKOnly, "Mensaje"
        
        Mskcuentadb.Enabled = False
        txtCampo(0).Enabled = False
        cmbprodb.Enabled = False
        VLFechahasta = mskfechahasta.Text
        VLMonto = mskvalordb.Text
                
    Else
        PLLimpiar
    End If
End Sub
Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar el registro de contrato de
'            transferencia automatica
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    If txtCampo(0).Text = "" Then
        MsgBox "La causa de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If

    If Mskcuentadb.ClipText = "" Then
        MsgBox "La cuenta débito u origen es mandatoria", 0 + 16, "Mensaje de Error"
        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
        Exit Sub
    End If

    If MsgBox("Esta seguro (a) de eliminar esta transferencia automática?", vbQuestion + vbYesNo + vbDefaultButton2, "Mensaje del Sistema") = vbNo Then
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "716"     '"2759"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text
         
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If
         
    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(4).Text
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Eliminación de Transferencia Automatica") Then
        PMChequea sqlconn&
        MsgBox "El encabezado de la transferencia Fue eliminado exitosamente", vbInformation + vbOKOnly, "Mensaje"
        PLLimpiar
    End If
End Sub
Private Sub PLCrearDetalle()
'*************************************************************
' PROPOSITO: Crea un detalle de transferencia
'            automatica
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 01-Abr-05      L. Bernuil      Emisión Inicial
'*************************************************************
Dim VTValorSumadoGrid As Double
    If cmdBoton(8).Caption = "Crear" Then
       VLMonto_crtmp = 0
    End If

    If Mskcuentadb.ClipText = "" Then
       MsgBox "La cuenta débito u origen es mandatoria", 0 + 16, "Mensaje de Error"
       If Mskcuentadb.Enabled = True Then
            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
       End If
       Exit Sub
    End If

    If Mskcuentacr.ClipText = "" Then
        MsgBox "La cuenta crédito o destino es mandatoria", 0 + 16, "Mensaje de Error"
        If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.SetFocus
       Exit Sub
    End If

    If Mskcuentadb.ClipText = Mskcuentacr.ClipText Then
       MsgBox "La cuenta de origen debe ser distinta a la cuenta destino", 0 + 16, "Mensaje de Error"
       If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.SetFocus
       Exit Sub
    End If

    If txtCampo(0).Text = "" Then
        MsgBox "La causa de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If
    
    If mskFecha.ClipText = "" Then
       MsgBox "La fecha de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
       If mskFecha.Enabled And mskFecha.Visible Then mskFecha.SetFocus
       Exit Sub
    End If

    If mskfechahasta.ClipText = "" Then
       MsgBox "La fecha de vencimiento es mandatoria", 0 + 16, "Mensaje de Error"
       If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.SetFocus
       Exit Sub
    End If

    If Val(mskvalorcr.ClipText) <= 0 Then
        MsgBox "El monto a transferir es mandatorio y debe ser mayor a 0.00", 0 + 16, "Mensaje de Error"
        If mskvalorcr.Enabled And mskvalorcr.Visible Then mskvalorcr.SetFocus
       Exit Sub
    End If

    'Verficar que fecha
    VTFecha1$ = Format(mskfechahasta.Text, VGFormatoFecha$)
    VTFecha2$ = Format(mskFecha.Text, VGFormatoFecha$)
    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
         MsgBox "Fecha de vencimiento debe ser mayor a fecha de vigencia", 0 + 16, "Mensaje de Error"
         Exit Sub
    End If

    'Verficar que fecha de no sea menor que la fecha del sistema
    VTFecha1$ = Format(mskFecha.Text, VGFormatoFecha$)
    VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
'    If FMDateDiff("d", VTFecha2$, VTFecha1$, VGFormatoFecha) < 0 Then
'         MsgBox "Fecha de vigencia no debe ser menor a fecha del sistema", 0 + 16, "Mensaje de Error"
'         If MskFecha.Enabled And MskFecha.Visible Then MskFecha.SetFocus
'         Exit Sub
'    End If

    VTValorSumadoGrid = 0
    VTValorSumadoGrid = FLSumarValoresGrid

    If CCur((CDbl(VTValorSumadoGrid) - CDbl(VLMonto_crtmp) + CDbl(mskvalorcr.ClipText))) > CCur(mskvalordb.ClipText) Then
         MsgBox "El monto a acreditar excede el Monto a Debitar", 0 + 16, "Mensaje de Error"
         If mskvalorcr.Enabled And mskvalorcr.Visible Then mskvalorcr.SetFocus
         Exit Sub
    End If
    
    If CCur((CDbl(VTValorSumadoGrid) + CDbl(mskvalorcr.ClipText))) = CCur(mskvalordb.ClipText) Then
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "I"
    End If
    
    If mskfechahasta.ClipText = "" Then
       MsgBox "La fecha de vencimiento es mandatoria", 0 + 16, "Mensaje de Error"
       If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.SetFocus
       Exit Sub
    End If
    
    If txtCampo(1).Text = "" Then
        MsgBox "La periodicidad es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(1).Enabled = True And txtCampo(1).Visible = True Then txtCampo(1).SetFocus
        Exit Sub
    End If
    
    If txtCampo(1).Text = "Q" Then
            
        If Val(txtCampo(2).Text) <= 0 Or Val(txtCampo(2).Text) > 31 Then
            MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el primer día a aplicar", 0 + 16, "Mensaje de Error"
            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
            Exit Sub
        End If
            
        If Val(txtCampo(3).Text) <= 0 Or Val(txtCampo(3).Text) > 31 Then
            MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el segundo día a aplicar", 0 + 16, "Mensaje de Error"
            If txtCampo(3).Enabled And txtCampo(3).Visible Then txtCampo(3).SetFocus
            Exit Sub
        End If
                        
        If Val(txtCampo(2).Text) = Val(txtCampo(3).Text) Then
            MsgBox "Los dos días a aplicar deben ser diferentes", 0 + 16, "Mensaje de Error"
            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
            Exit Sub
        End If
            
        If Val(txtCampo(2).Text) > Val(txtCampo(3).Text) Then
            MsgBox "El primer día de quincena a aplicar debe ser menor que el segundo dia", 0 + 16, "Mensaje de Error"
            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
            Exit Sub
        End If
    End If
        
    If txtCampo(1).Text = "M" Then
        If Val(txtCampo(2).Text) <= 0 Or Val(txtCampo(2).Text) > 31 Then
            MsgBox "Debe ingresar un valor mayor que cero y menor de 31 en el primer día a aplicar", 0 + 16, "Mensaje de Error"
            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
            Exit Sub
        End If
    End If

    'Validar si se han cambiado datos en la cabecera
    If mskfechahasta.Text <> VLFechahasta Then
        MsgBox "Se Modificaron Datos en el detalle de la cuenta débito, Favor Presionar Actualizar antes de ingresar un nuevo detalle", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
    
    'Validar si se han cambiado datos en la cabecera
    If mskvalordb.Text <> VLMonto Then
        MsgBox "Se Modificaron Datos en el detalle de la cuenta débito, Favor Presionar Actualizar antes de ingresar un nuevo detalle", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "717"     '"2753"
    If cmdBoton(8).Caption = "Crear" Then
       PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
       
    Else
       PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
    End If
    
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text
    
    'producto de la cuenta debito
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If

    'producto de la cuenta credito
    If cmbTipo.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_org", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_org", 0, SQLVARCHAR, "AHO"
    End If

    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText
    PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(3).Caption
    PMPasoValores sqlconn&, "@i_cta_banco_org", 0, SQLVARCHAR, Mskcuentacr.ClipText
    PMPasoValores sqlconn&, "@i_nombre_org", 0, SQLVARCHAR, lblDescripcion(0).Caption
    PMPasoValores sqlconn&, "@i_periodicidad", 0, SQLCHAR, txtCampo(1).Text
    
    Select Case txtCampo(1).Text
        Case "Q"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, txtCampo(3).Text
        Case "M"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, "0"
        Case "D"
            PMPasoValores sqlconn&, "@i_dia_1", 0, SQLINT1, "0"
            PMPasoValores sqlconn&, "@i_dia_2", 0, SQLINT1, "0"
    End Select
    
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
    PMPasoValores sqlconn&, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha((mskFecha.Text), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha((mskfechahasta.Text), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, mskvalorcr.ClipText
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(4).Text  'ROL 12202006 MANEJO CON CODIGO
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_transfer", True, "Ok... Inserción de Detalle de Transferencia Automática") Then
        PMChequea sqlconn&
        PLLimpiarDetalle
        PLBuscarDetalle
        
        lblDescripcion(1).Caption = Format(CCur(FLSumarValoresGrid), "###,###,##0.00")
        'Encuentra Si la cabecera está cuadrada
        If CCur((CDbl(lblDescripcion(1).Caption))) = CCur(mskvalordb.ClipText) Then
            lblDescripcion(5).Caption = "Cuadrado"
        Else
            lblDescripcion(5).Caption = "Descuadrado"
        End If
    Else
        'PLLimpiarDetalle
        PMChequea sqlconn&
        'Habilitar el campo de fecha
        PLBuscar
    End If
End Sub
Private Sub PLEliminarDetalle()
'*************************************************************
' PROPOSITO: Permite eliminar registros de transferencias
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 02-Abr-05      L. Bernuil     Emision Inicial
'*************************************************************
    If txtCampo(0).Text = "" Then
        MsgBox "La causa de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If

    If Mskcuentadb.ClipText = "" Then
        MsgBox "La cuenta débito u origen es mandatoria", 0 + 16, "Mensaje de Error"
        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
        Exit Sub
    End If

    If Mskcuentacr.ClipText = "" Then
        MsgBox "La cuenta crédito o destino es mandatoria", 0 + 16, "Mensaje de Error"
        If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.SetFocus
       Exit Sub
    End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "718"     '"2755"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText
    PMPasoValores sqlconn&, "@i_cta_banco_org", 0, SQLVARCHAR, Mskcuentacr.ClipText
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(4).Text  'ROL 12202006 MANEJO CON CODIGO
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_transfer", True, "Ok... Eliminación de Transferencia Automática") Then
       PMChequea sqlconn&
        PLLimpiarDetalle
        PLBuscarDetalle
        
        lblDescripcion(1).Caption = Format(CCur(FLSumarValoresGrid), "###,###,##0.00")
        'Encuentra Si la cabecera está cuadrada
        If CCur((CDbl(lblDescripcion(1).Caption))) = CCur(mskvalordb.ClipText) Then
            lblDescripcion(5).Caption = "Cuadrado"
        Else
            lblDescripcion(5).Caption = "Descuadrado"
        End If
    End If
End Sub
Private Sub PLBuscarDetalle()
'*************************************************************
' PROPOSITO: Busca los detalles de las transferencias automaticas
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 02-Abr-05      L.Bernuil       Unificicación de Pantallas
'*************************************************************
    Dim VTRegistros As Integer
    Dim VTFlag As Integer
    Dim VTCuentaCredito As String
    Dim VTModo As Integer
    VTRegistros% = 20
    VTFlag% = False
    VTCuentaCredito = ""
    VTModo% = 0

    While VTRegistros% = 20
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "713"     '"2752"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText

        If VTCuentaCredito <> "" Then
            PMPasoValores sqlconn&, "@i_cta_banco_org", 0, SQLVARCHAR, VTCuentaCredito
        End If
        
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, VTModo%
        
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(4).Text  'ROL 12202006 MANEJO CON CODIGO
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_transfer", True, "Ok... Consulta de Transferencias Automáticas") Then
            PMMapeaGrid sqlconn&, grdRegistros, VTFlag%
            PMChequea sqlconn&
            VTFlag% = True
            VTModo% = 1
            VTRegistros% = Val(grdRegistros.Tag)
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 2
            VTCuentaCredito = grdRegistros.Text
            
            cmdBoton(7).Enabled = True
        Else
            VTRegistros% = 0
        End If
    Wend
    grdRegistros.ColAlignment(5) = 1
    grdRegistros.ColAlignment(6) = 1
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
            MsgBox "No existen registros de transferencias automáticas", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    cmbTipo.Enabled = False
    grdRegistros.Col = 1
    If grdRegistros.Text = "CTE" Then
        cmbTipo.ListIndex = 0
        grdRegistros.Col = 2
        Mskcuentacr.Text = FMMascara(grdRegistros.Text, VGMascaraCtaCte$)
    Else
        cmbTipo.ListIndex = 1
        grdRegistros.Col = 2
        Mskcuentacr.Text = FMMascara(grdRegistros.Text, VGMascaraCtaAho$)
    End If
    Mskcuentacr.Enabled = False

    grdRegistros.Col = 3
    lblDescripcion(0).Caption = grdRegistros.Text
    grdRegistros.Col = 4
    mskvalorcr.Text = grdRegistros.Text
    mskvalorcr.Enabled = True
    VLMonto_crtmp = 0
    VLMonto_crtmp = mskvalorcr.Text
    
    If cmdBoton(8).Caption = "Crear" Then
       cmdBoton(8).Caption = "Actualizar"
'    Else
'       cmdBoton(8).Caption = "Crear"
    End If
    cmdBoton(8).Enabled = True 'crear
    cmdBoton(9).Enabled = True 'Eliminar
    cmdBoton(10).Enabled = True 'Limpiar
End Sub
Private Function FLSumarValoresGrid() As Double
FLSumarValoresGrid = 0
grdRegistros.Col = 1
If Trim$(grdRegistros.Text) <> "" Then
    For i% = 1 To grdRegistros.Rows - 1
        grdRegistros.Col = 4
        grdRegistros.Row = i
        
        FLSumarValoresGrid = FLSumarValoresGrid + CDbl(grdRegistros.Text)
    Next i
End If
End Function
Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Permite imprimir los datos consultados en el grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim Linea As String
Dim cmbtipodst As String
grdRegistros.Col = 1
If Trim$(grdRegistros.Text) = "" Then
    MsgBox "No hay registros que imprimir", vbInformation + vbOKOnly, "Mensaje del Sistema"
    Exit Sub
End If

    If MsgBox("Esta seguro de imprimir esta pantalla?", 4 + 32 + 0, "Mensaje del Sistema") = 6 Then
        Screen.MousePointer = 11
        FMCabeceraReporte VGBanco$, Date, "TRANSFERENCIAS AUTOMATICAS", _
        Time(), Me.Caption, VGFecha$, 1 'Printer.Page
        Printer.FontBold = True
        Printer.FontSize = 10
        Printer.Print String$(98, "-")
        Linea = "Codigo de Transferencia Automatica:    " & txtCampo(4).Text  'ROL 12202006
        Printer.Print Linea
        Linea = "Causa Transferencia:    " & txtCampo(0).Text
        Printer.Print Linea
        Linea = "Descripcion: " & lblDescripcion(2).Caption
        Printer.Print Linea
        Linea = "No. Cuenta Débito: " & cmbtipodst & "    " & Mskcuentadb.Text
        Printer.Print Linea
        Linea = "Nombre de la Cuenta :  " & lblDescripcion(3).Caption
        Printer.Print Linea
        Linea = "Monto Total a Debitar: " & Format(mskvalordb.ClipText, "###,###,##0.00")
        Printer.Print Linea
        Printer.Print String$(98, "-")
        Printer.Print ""
        Printer.Print ""
        Linea = "TIPO No. CUENTA NOMBRE                              MONTO    PROX.COBRO  ULT.COBRO"  'TOTAL.DEB."
        Printer.Print Linea
        Printer.Print String$(98, "-")
        Printer.Print ""
        For i = 1 To grdRegistros.Rows - 1
             Linea = ""
             grdRegistros.Row = i
             For j = 1 To grdRegistros.Cols - 1
                 grdRegistros.Col = j
                 Select Case j
                 Case 1
                       Linea = Linea & grdRegistros.Text & Space$(2)
                 Case 2
                       Linea = Linea & grdRegistros.Text & Space$(1)
                 Case 3
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                       Linea = Linea & Mid$(grdRegistros.Text, 1, 20) & Space$(25 - Len(Mid$(grdRegistros.Text, 1, 20)))
                 Case 4
                       Linea = Linea & Space$(15 - Len(grdRegistros.Text)) & grdRegistros.Text & Space$(4)
                 Case 5
                       Linea = Linea & grdRegistros.Text & Space$(2)
                 Case 6
                       Linea = Linea & grdRegistros.Text & Space$(2)
                 End Select
             Next j

             Printer.Print Linea
        Next i
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "_________________                                                 _________________"
        Printer.Print "  PROCESADO POR                                                     VERIFICADO POR "
        Printer.Print ""
        Printer.Print ""
        If VGCodPais$ <> "CO" Then
            Printer.Print "---  U L T I M A   L I N E A  ---"
        End If
        Printer.EndDoc
        Screen.MousePointer = 0
    End If
End Sub
Private Function FLTransferenciaCuadrada() As Boolean
On Error GoTo Error_Verifica_Cuadre

FLTransferenciaCuadrada = False

Dim VTMontoCreditos As Double
Dim VTMontoDebitos As Double

VTMontoCreditos = 0
VTMontoDebitos = 0

VTMontoDebitos = CDbl(mskvalordb.ClipText)

If (grdRegistros.Rows - 1) > 0 Then
    For i = 1 To grdRegistros.Rows - 1
    
        grdRegistros.Row = i
        grdRegistros.Col = 1
        If Trim$(grdRegistros.Text) = "" And VTMontoDebitos = 0 Then
            FLTransferenciaCuadrada = True
        End If
        
        grdRegistros.Col = 4
        
        VTMontoCreditos = VTMontoCreditos + CDbl(grdRegistros.Text)
        
    Next i
End If

If CCur(VTMontoDebitos) = CCur(VTMontoCreditos) Then
    FLTransferenciaCuadrada = True
Else
    FLTransferenciaCuadrada = False
End If
Exit Function

Error_Verifica_Cuadre:
Exit Function
End Function

Sub PLBuscar_Cuenta()
     On Error Resume Next
    If Mskcuentadb.ClipText <> "" Then
        If cmbprodb.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(3)
                    PMChequea sqlconn&
                Else
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(3).Caption = ""
                    PLLimpiar
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(3).Caption = ""
                PLLimpiar
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                
                Exit Sub
            End If
        Else  '  Ahorros
            If FMChequeaCtaAho((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(3)
                    PMChequea sqlconn&
                Else
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(3).Caption = ""
                    PLLimpiar
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(3).Caption = ""
                PLLimpiar
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub

Sub PLAutorizar()

    If txtCampo(4).Text = "" Then
        MsgBox "La causa de la transferencia es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
        Exit Sub
    End If

    If MsgBox("Esta seguro autorizar esta transferencia automática?", vbQuestion + vbYesNo + vbDefaultButton2, "Mensaje del Sistema") = vbNo Then
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "712"     '"2932"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
        
    If cmbprodb.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If
         
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(4).Text
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Eliminación de Transferencia Automatica") Then
        PMChequea sqlconn&
        MsgBox "La transferencia Fue Autorizado  exitosamente", vbInformation + vbOKOnly, "Mensaje"
        PLLimpiar
    End If
End Sub

