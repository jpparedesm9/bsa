VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran205 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Actualización General de Cuentas de Ahorros"
   ClientHeight    =   5535
   ClientLeft      =   1995
   ClientTop       =   1515
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
   HelpContextID   =   1087
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5535
   ScaleWidth      =   9300
   Tag             =   "3101"
   Begin VB.Frame frmDirecciones 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   945
      Left            =   2520
      TabIndex        =   43
      Top             =   4020
      Width           =   2670
      Begin Threed.SSOption optDireccion 
         Height          =   195
         Index           =   0
         Left            =   45
         TabIndex        =   44
         Top             =   140
         WhatsThisHelpID =   5352
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Enviar a dirección del cliente"
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
         Index           =   1
         Left            =   45
         TabIndex        =   45
         Top             =   334
         WhatsThisHelpID =   5353
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Enviar a casilla postal del cliente"
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
         Index           =   2
         Left            =   45
         TabIndex        =   46
         Top             =   528
         WhatsThisHelpID =   5354
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Retener en agencia del banco"
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
         TabIndex        =   47
         Top             =   720
         WhatsThisHelpID =   5355
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Retener en casillero del banco"
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
   End
   Begin VB.Frame Frame1dv 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   945
      Left            =   2520
      TabIndex        =   38
      Top             =   4020
      Visible         =   0   'False
      Width           =   2670
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   3
         Left            =   45
         TabIndex        =   39
         TabStop         =   0   'False
         Top             =   720
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
      End
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   2
         Left            =   45
         TabIndex        =   40
         TabStop         =   0   'False
         Top             =   528
         Width           =   2550
         _Version        =   65536
         _ExtentX        =   4498
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Retener en agencia del banco"
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
         TabIndex        =   41
         TabStop         =   0   'False
         Top             =   334
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
      End
      Begin Threed.SSOption optDirecciondv 
         Height          =   195
         Index           =   0
         Left            =   45
         TabIndex        =   42
         Top             =   140
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
         Value           =   -1  'True
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   13
      Left            =   5220
      MaxLength       =   4
      TabIndex        =   35
      Top             =   4380
      Visible         =   0   'False
      Width           =   1920
   End
   Begin VB.OptionButton optdir 
      Caption         =   "*Estado de Cuenta"
      Enabled         =   0   'False
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   480
      TabIndex        =   34
      Top             =   4320
      WhatsThisHelpID =   5348
      Width           =   1995
   End
   Begin VB.OptionButton optdir 
      Caption         =   "*Cheques Devueltos"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   480
      TabIndex        =   33
      Top             =   4620
      Value           =   -1  'True
      WhatsThisHelpID =   5349
      Width           =   1995
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   6
      Left            =   7800
      MaxLength       =   64
      TabIndex        =   31
      Top             =   720
      Visible         =   0   'False
      Width           =   585
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   4335
      MaxLength       =   2
      TabIndex        =   7
      Top             =   3195
      Width           =   420
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H00800000&
      Height          =   375
      Left            =   4335
      TabIndex        =   12
      Top             =   2805
      Width           =   4005
      Begin Threed.SSOption optcausa 
         Height          =   195
         Index           =   1
         Left            =   2685
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   120
         WhatsThisHelpID =   5351
         Width           =   780
         _Version        =   65536
         _ExtentX        =   1376
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Canje"
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
         Left            =   525
         TabIndex        =   5
         Top             =   120
         WhatsThisHelpID =   5350
         Width           =   1470
         _Version        =   65536
         _ExtentX        =   2593
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Lev. Anulación"
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   1860
      MaxLength       =   8
      TabIndex        =   4
      Top             =   2865
      Width           =   1785
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   9
      Tag             =   "6335"
      Top             =   2325
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1875
      MaxLength       =   2
      TabIndex        =   2
      Top             =   3540
      Visible         =   0   'False
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   5220
      MaxLength       =   2
      TabIndex        =   13
      Top             =   4380
      Width           =   1920
   End
   Begin Threed.SSCheck chkFuncionario 
      Height          =   195
      Left            =   1860
      TabIndex        =   14
      Top             =   2310
      WhatsThisHelpID =   5361
      Width           =   2175
      _Version        =   65536
      _ExtentX        =   3837
      _ExtentY        =   344
      _StockProps     =   78
      Caption         =   "*Cuenta de funcionario"
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
      Enabled         =   0   'False
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   1245
      Left            =   0
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   640
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   2196
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2205
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
      Left            =   8415
      TabIndex        =   8
      Top             =   3090
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
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
      Left            =   8415
      TabIndex        =   10
      Top             =   3855
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
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
      Left            =   8415
      TabIndex        =   11
      Top             =   4620
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   0
      Left            =   1860
      MaxLength       =   64
      TabIndex        =   1
      Top             =   1980
      Width           =   6465
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   2
      Left            =   1860
      MaxLength       =   2
      TabIndex        =   3
      Top             =   2520
      Width           =   675
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   48
      Top             =   10
      WhatsThisHelpID =   2071
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Bene&ficiarios"
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
   Begin VB.Label lbldesalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   407
      Left            =   2565
      TabIndex        =   51
      Top             =   5085
      Width           =   5775
   End
   Begin VB.Label Lblalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   1875
      TabIndex        =   50
      Top             =   5085
      Width           =   675
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Alianza:"
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   30
      TabIndex        =   49
      Top             =   5145
      Width           =   735
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
      Left            =   5220
      TabIndex        =   37
      Top             =   4140
      WhatsThisHelpID =   5260
      Width           =   1845
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   14
      Left            =   5220
      TabIndex        =   36
      Top             =   4680
      Visible         =   0   'False
      Width           =   3130
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   4
      Left            =   5220
      TabIndex        =   32
      Top             =   4680
      Width           =   3130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nom.Libreta Cotitular:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   360
      TabIndex        =   30
      Top             =   1440
      Visible         =   0   'False
      Width           =   1860
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
      Index           =   0
      Left            =   4770
      TabIndex        =   29
      Top             =   3195
      Width           =   3555
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Causa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   3720
      TabIndex        =   28
      Top             =   3195
      WhatsThisHelpID =   5155
      Width           =   675
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Número de Libreta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   30
      TabIndex        =   27
      Top             =   2910
      WhatsThisHelpID =   5267
      Width           =   1710
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
      TabIndex        =   26
      Top             =   0
      WhatsThisHelpID =   5255
      Width           =   2715
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H000000FF&
      Height          =   285
      Index           =   3
      Left            =   7185
      TabIndex        =   25
      Top             =   15
      Width           =   1170
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Bancario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   45
      TabIndex        =   16
      Top             =   3525
      Visible         =   0   'False
      WhatsThisHelpID =   5176
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2565
      TabIndex        =   17
      Top             =   3510
      Visible         =   0   'False
      Width           =   5775
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Dirección:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   30
      TabIndex        =   19
      Top             =   4005
      WhatsThisHelpID =   5259
      Width           =   960
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
      Left            =   5220
      TabIndex        =   24
      Top             =   4140
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   30
      TabIndex        =   18
      Top             =   405
      WhatsThisHelpID =   5055
      Width           =   1890
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -30
      X2              =   8385
      Y1              =   1920
      Y2              =   1920
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
      Left            =   30
      TabIndex        =   23
      Top             =   15
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -60
      X2              =   8355
      Y1              =   330
      Y2              =   330
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5370
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2550
      TabIndex        =   22
      Top             =   2520
      Width           =   5775
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Ciclo de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   30
      TabIndex        =   21
      Top             =   2520
      WhatsThisHelpID =   5266
      Width           =   1695
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   20
      Top             =   2010
      WhatsThisHelpID =   5017
      Width           =   1725
   End
End
Attribute VB_Name = "FTran205"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran205.frm
' NOMBRE LOGICO:    FTran205
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
' Permite realizar la actualizacion de los datos generales de
' una cuenta de ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLNumero As Integer
Dim VLTitular As Integer
Dim VLPaso As Integer
Dim VLNumLib As String
Dim VLTipoEnte As String
Dim VLEnte As Integer
Dim VLCedula1 As String
Dim VLCotitular As String
Dim VLTraslado As String
Dim VLBeneficiarios As Boolean

Private Sub cmdBoton_Click(Index As Integer)
    Dim i As Integer
    Dim VTNumLib As Integer
    Dim VLCausa As String

    If txtCampo(4).Text = "" Then
        VTNumLib = 0
    Else
        VTNumLib = CLng(txtCampo(4).Text)
    End If
    Select Case Index%
      Case 0  'Transmitir

        'Valida Número de Cuenta
        If mskCuenta.ClipText = "" Then
           MsgBox "Número de Cuenta es mandatorio"
           mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
           mskCuenta.SetFocus
           Exit Sub
        End If
        ' Direccion del estado de cuenta
        If txtCampo(1).Text = "" Then
            MsgBox "La dirección del estado de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            If txtCampo(1).Visible Then
               txtCampo(1).SetFocus
            Else
               txtCampo(13).SetFocus
            End If
            Exit Sub
        End If

        ' Direccion de cheques devueltos
        If txtCampo(13).Text = "" Then
            txtCampo(13).Text = txtCampo(3).Text
            txtCampo(13).Tag = txtCampo(3).Tag
            For i = 0 To 3
                If optDireccion(i).Value = True Then
                     optDirecciondv(i).Value = True
                End If
            Next i
        End If
        '  Verifica que se cambiaron datos de la libreta
        If optcausa(0).Value = True Or optcausa(1).Value = True Or (VLNumLib <> txtCampo(4).Text) Then
        'Valida Número de Libreta y Causa
            If txtCampo(4).Text = "" Or VTNumLib = 0 Then
                MsgBox "Número de libreta mandatorio y distinto de CERO"
                txtCampo(4).SetFocus
                Exit Sub
             ElseIf VLNumLib = txtCampo(4).Text And optcausa(1).Value = True Then
                MsgBox "Cambio del número de libreta es mandatorio en Canje"
                txtCampo(4).SetFocus
                Exit Sub
              ElseIf VLNumLib <> txtCampo(4).Text And optcausa(0).Value = True Then
                  MsgBox "No se debe cambiar el número de libreta en el Levantamiento"
                  txtCampo(4).SetFocus
                  Exit Sub
                ElseIf optcausa(0).Value = False And optcausa(1).Value = False Then
                   MsgBox "Selección de Lev. Anulación o Canje es mandatoria"
                   txtCampo(4).SetFocus
                   Exit Sub
                  ElseIf optcausa(1).Value = True And txtCampo(5).Text = "" Then
                    MsgBox "Causa de Canje es Mandatorio"
                    If txtCampo(5).Enabled = False Then
                       txtCampo(5).Enabled = True
                    End If
                    txtCampo(5).SetFocus
                    Exit Sub
                    ElseIf optcausa(0).Value = True Then
                          VLCausa = "A"
                        Else
                          VLCausa = "C"
                    End If
        Else
            VLCausa$ = ""
        End If
                   
        If mskCuenta.ClipText <> "" Then
                If txtCampo(0).Text <> "" Then
                    If txtCampo(1).Text <> "" Then
                        If txtCampo(2).Text <> "" Then
                            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "205"
                            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
                            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                            PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, (txtCampo(0).Text)
                            PMPasoValores sqlconn&, "@i_cli1", 0, SQLINT4, VLCotitular$
                            PMPasoValores sqlconn&, "@i_nombre1", 0, SQLVARCHAR, " "

                            If VLCedula1 <> "" Then
                                PMPasoValores sqlconn&, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1$
                            Else
                                VLCedula1 = " "
                                PMPasoValores sqlconn&, "@i_cedruc1", 0, SQLVARCHAR, VLCedula1$
                            End If
                            If optDireccion(0).Value = True Then
                                PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, (txtCampo(1).Text)
                                PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, (txtCampo(1).Tag)
                                PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "D"
                              ElseIf optDireccion(1).Value = True Then
                                    PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, (txtCampo(1).Text)
                                    PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, (txtCampo(1).Tag)
                                    PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "C"
                                  ElseIf optDireccion(3).Value = True Then
                                        PMPasoValores sqlconn&, "@i_casillero", 0, SQLVARCHAR, (txtCampo(1).Text)
                                        PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "S"
                                        PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, "0"
                                        PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, "0"
                                    ElseIf optDireccion(2).Value = True Then
                                            PMPasoValores sqlconn&, "@i_agencia", 0, SQLINT2, (txtCampo(1).Text)
                                            PMPasoValores sqlconn&, "@i_tipodir", 0, SQLCHAR, "R"
                                            PMPasoValores sqlconn&, "@i_direc", 0, SQLINT1, "0"
                                            PMPasoValores sqlconn&, "@i_cli_ec", 0, SQLINT4, "0"
                            End If
                            '  Cheques devueltos
                              If optDirecciondv(0).Value = True Then
                                PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, (txtCampo(13).Text)
                                PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, (txtCampo(13).Tag)
                                PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "D"
                              ElseIf optDirecciondv(1).Value = True Then
                                    PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, (txtCampo(13).Text)
                                    PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, (txtCampo(13).Tag)
                                    PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "C"
                                  ElseIf optDirecciondv(3).Value = True Then
                                        PMPasoValores sqlconn&, "@i_casillero_dv", 0, SQLVARCHAR, (txtCampo(13).Text)
                                        PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "S"
                                        PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, "0"
                                        PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, "0"
                                    ElseIf optDirecciondv(2).Value = True Then
                                            PMPasoValores sqlconn&, "@i_agencia_dv", 0, SQLINT2, (txtCampo(13).Text)
                                            PMPasoValores sqlconn&, "@i_tipodir_dv", 0, SQLCHAR, "R"
                                            PMPasoValores sqlconn&, "@i_direc_dv", 0, SQLINT1, "0"
                                            PMPasoValores sqlconn&, "@i_cli_dv", 0, SQLINT4, "0"
                               End If
                            PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, (txtCampo(2).Text)
                            PMPasoValores sqlconn&, "@i_numlib", 0, SQLINT4, (txtCampo(4).Text)
                            PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, (VLCausa$)
                            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_up_gral_ctahorro", True, " Ok... Actualización de la cuenta de ahorros") Then
                                PMMapeaObjeto sqlconn&, lblDescripcion(3)
                                PMChequea sqlconn&
                                ' Desactivar el boton de Transmitir
                                cmdBoton(0).Enabled = False
                                cmdBoton(3).Enabled = True
                            Else
                                cmdBoton_Click (1)
                            End If
                          Else
                            MsgBox "El código del ciclo de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
                            txtCampo(2).SetFocus
                        End If
                      Else
                        MsgBox "La dirección del estado de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
                        txtCampo(1).SetFocus
                    End If
                  Else
                    MsgBox "El nombre de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If
              Else
                MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
                mskCuenta.SetFocus
        End If

      Case 1 'Limpiar
        txtCampo(3).Enabled = True
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        For i% = 0 To 6
            txtCampo(i%).Text = ""
        Next i%
        lblDescripcion(0).Caption = ""
        For i% = 1 To 4
            lblDescripcion(i%).Caption = ""
        Next i%
        PMLimpiaGrid grdPropietarios
        VLNumero% = 0
        VLTitular% = 0
        'chkFuncionario.Enabled = True
        chkFuncionario.Value = False
        optcausa(0).Value = False
        optcausa(1).Value = False

        ' Activar el Boton de Transmitir
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False 'Beneficiarios
        optDireccion(0).Value = True
        optDirecciondv(0).Value = True
        mskCuenta.Enabled = True
        VLEnte% = True
        VLCotitular$ = "0"
        VLTipoEnte$ = ""
        optdir(0).Enabled = False
        optdir(1).Value = True
        Lblalianza.Caption = ""
        lbldesalianza.Caption = ""
        mskCuenta.SetFocus
      Case 2    'Salir
        Unload FTran205
      Case 3    'Imprimir
        PLImprimir
      Case 4 'Beneficiarios
        ReDim VGADatosI(3) As String
        VGADatosI(0) = mskCuenta.ClipText
        VGADatosI(1) = txtCampo(0).Text
        VGADatosI(2) = "4"
        VGADatosI(3) = "mantenimiento"
        FBenCta.Show 1
    End Select
End Sub

Private Sub Form_Load()
    FTran205.Left = 0   '15
    FTran205.Top = 0   '15
    FTran205.Width = 9450   '9420
    FTran205.Height = 6040   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    VLNumero% = 0
    VLTitular% = 0
    mskCuenta.Mask = VGMascaraCtaAho$
    optcausa(0).Value = False
    optcausa(1).Value = False
    VLEnte% = True
    VLCedula1$ = ""
    VLCotitular$ = "0"
    VLTipoEnte$ = ""
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
    If Frame1dv.Visible = False Then
        If optDireccion(0).Value = True Then
            txtCampo(1).Text = ""
            lblDescripcion(4).Caption = ""
        End If
    Else
        If optDirecciondv(0).Value = True Then
            txtCampo(13).Text = ""
            lblDescripcion(14).Caption = ""
        End If
    End If
End Sub

Private Sub grdPropietarios_DblClick()
  'Para Perzonalizacion Banco Caribe manejo Titular y Cotitular
  'If VLEnte% = True Then
  '   grdPropietarios.Col = 3
  '   VLTipoEnte$ = grdPropietarios.Text
  '   For I% = 1 To (grdPropietarios.Rows - 1)
  '     grdPropietarios.Row = I%
  '     If (grdPropietarios.Text) = "C" Then
  '        VLTipoEnte$ = grdPropietarios.Text
  '         grdPropietarios.Col = 5
  '         If (Trim$(grdPropietarios.Text) = "T") Then
  '            Exit For
  '         End If
  '     End If
  '   Next I%
  '  VLEnte% = False
  'End If
'  If (VLTipoEnte$ = "P") And (cmdBoton(0).Enabled = True) Then
'      grdPropietarios.Col = 5
'      If (Trim$(grdPropietarios.Text) = "C") And (VLTipoEnte$ = "P") Then
'          txtCampo(6).Enabled = True
'          grdPropietarios.Col = 4
'          txtCampo(6).Text = grdPropietarios.Text
'          grdPropietarios.Col = 2
'          VLCedula1$ = grdPropietarios.Text
'          txtCampo(6).Enabled = False
'          grdPropietarios.Col = 1
'          VLCotitular$ = grdPropietarios.Text
'          txtCampo(4).SetFocus
'      End If
'  End If
End Sub

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta de ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    Dim VTR As Integer
    Dim i As Integer
    Dim VLCed As String
    Dim VTR1 As Integer
    Dim VLPasolibreta As Integer
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "297"
            PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_gral_up_ah", True, " Ok... Consulta de la cuenta de ahorros") Then
                ReDim Valores(8, 40) As String
                VTR = FMMapeaMatriz(sqlconn&, Valores())
                PMLimpiaGrid grdPropietarios
                grdPropietarios.Cols = 8
                For i = 1 To VTR%
                    If Valores(1, i) <> "" Then
                        VLCed = Valores(1, i)
                    Else
                        VLCed = Valores(2, i)
                    End If
                    grdPropietarios.AddItem Str$(i) & Chr(9) & Valores(0, i) & Chr(9) & VLCed$ & Chr(9) & Valores(3, i) & Chr(9) & Valores(4, i%) & Chr(9) & Valores(5, i) & Chr(9) & Valores(6, i) & Chr(9) & Valores(7, i)
                    If Valores(3, i) = "P" And Valores(5, i) = "T" Then 'Activa botón de beneficiarios
                        VLBeneficiarios = True
                    End If
                Next i
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
                grdPropietarios.Text = "ROL"
                grdPropietarios.Col = 6
                grdPropietarios.Text = "DESCRIPCION"
                ReDim VTArreglo(20) As String
                VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                If VTR1 <= 0 Then
                   Exit Sub
                'Else
                '   mskCuenta.Enabled = False
                End If
                PMMapeaObjetoAB sqlconn&, txtCampo(2), lblDescripcion(1)
                PMMapeaObjetoAB sqlconn&, txtCampo(3), lblDescripcion(2)
                PMMapeaObjeto sqlconn&, txtCampo(4)
                PMMapeaVariable sqlconn&, VLCotitular$
                PMMapeaVariable sqlconn&, VLTraslado$
                VLNumLib = txtCampo(4).Text
                PMChequea sqlconn&
                lblDescripcion(3).Caption = VTArreglo(8)
                VLNumero% = grdPropietarios.Rows - 1
                If VLTraslado$ = "S" Then
                    optdir(0).Enabled = True
                    optdir(0).Value = True
                Else
                    optdir(0).Enabled = False
                    optdir(1).Value = True
                End If
                For i% = 1 To grdPropietarios.Rows - 1
                   grdPropietarios.Row = i%
                   grdPropietarios.Col = 5
                   If grdPropietarios.Text = "T" Then
                      VLTitular% = i%
                   End If
                Next i%
                grdPropietarios.ColWidth(0) = 1
                grdPropietarios.ColWidth(1) = 960
                grdPropietarios.ColWidth(2) = 1440
                grdPropietarios.ColWidth(3) = 300
                grdPropietarios.ColWidth(4) = 3915
                grdPropietarios.ColWidth(5) = 375
                grdPropietarios.ColWidth(6) = 1230
                txtCampo(0).Text = VTArreglo(1)
                txtCampo(6).Text = VTArreglo(9)
                VLCedula1$ = VTArreglo(10)
                Select Case VTArreglo(2)
                Case "D"
                    optDireccion(0).Value = True
                    txtCampo(1).Text = VTArreglo(3)
                    lblDescripcion(4).Caption = VTArreglo(4)
                    txtCampo(1).Tag = VTArreglo(5)
                Case "C"
                    optDireccion(1).Value = True
                    txtCampo(1).Text = VTArreglo(3)
                    lblDescripcion(4).Caption = VTArreglo(4)
                    txtCampo(1).Tag = VTArreglo(5)
                Case "R"
                    optDireccion(2).Value = True
                    txtCampo(1).Text = VTArreglo(6)
                    lblDescripcion(4).Caption = VTArreglo(4)
                    txtCampo(1).Tag = VTArreglo(5)
                Case "S"
                    optDireccion(3).Value = True
                    txtCampo(1).Text = Mid$(VTArreglo(4), 13, Len(VTArreglo(4)))
                    txtCampo(1).Tag = VTArreglo(5)
                End Select
                Select Case VTArreglo(11)
                Case "D"
                    optDirecciondv(0).Value = True
                    txtCampo(13).Text = VTArreglo(12)
                    lblDescripcion(14).Caption = VTArreglo(13)
                    txtCampo(13).Tag = VTArreglo(14)
                Case "C"
                    optDirecciondv(1).Value = True
                    txtCampo(13).Text = VTArreglo(12)
                    lblDescripcion(14).Caption = VTArreglo(13)
                    txtCampo(13).Tag = VTArreglo(14)
                Case "R"
                    optDirecciondv(2).Value = True
                    txtCampo(13).Text = VTArreglo(15)
                    lblDescripcion(14).Caption = VTArreglo(13)
                    txtCampo(13).Tag = VTArreglo(14)
                Case "S"
                    optDirecciondv(3).Value = True
                    txtCampo(13).Text = Mid$(VTArreglo(13), 13, Len(VTArreglo(13)))
                    txtCampo(13).Tag = VTArreglo(14)
                End Select
                Call optdir_Click(0)
                If VTArreglo(7) = "S" Then
                    chkFuncionario.Value = True
                    chkFuncionario.Enabled = False
                Else
                    chkFuncionario.Value = False
                    chkFuncionario.Enabled = False
                End If

                txtCampo(3).Enabled = False
                'If txtCampo(3).Text = "2" Then
                '    lblEtiqueta(2).Visible = True
                '    lblEtiqueta(12).Visible = True
                '    frmDirecciones.Visible = True
                '    txtCampo(1).Visible = True
                '    lbldescripcion(0).Visible = True
                'End If
                VLPasolibreta = False
                If VLBeneficiarios Then
                    VLBeneficiarios = False
                    cmdBoton(4).Enabled = True 'Beneficiarios
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
   
   'Para Perzonalizacion Banco Caribe manejo Titular y Cotitular

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
   End If
  End If

End Sub

Private Sub optcausa_GotFocus(Index As Integer)
    If Index = 0 Then
       txtCampo(5).Text = ""
       lblDescripcion(0).Caption = ""
       txtCampo(5).Enabled = False
    Else
       txtCampo(5).Enabled = True
    End If
End Sub

Private Sub optdir_Click(Index As Integer)
    '   selecciona entre direccion de estado de cuenta y direccion de cheques devueltos
    If optdir(1).Value = True Then          ' Cheques devueltos
       Frame1dv.Visible = True
       lblDescripcion(14).Visible = True
       txtCampo(13).Visible = True
       lblEtiqueta(19).Visible = True
    Else                                    ' Estado de cuenta
       Frame1dv.Visible = False
       lblDescripcion(14).Visible = False
       txtCampo(13).Visible = False
       lblEtiqueta(19).Visible = False
    End If
    frmDirecciones.Visible = Not Frame1dv.Visible
    lblDescripcion(4).Visible = (Not optDireccion(3).Value) And optdir(0).Value
    lblDescripcion(14).Visible = (Not optDirecciondv(3).Value) And optdir(1).Value
    txtCampo(1).Visible = Not txtCampo(13).Visible
    lblEtiqueta(12).Visible = Not lblEtiqueta(19).Visible
End Sub

Private Sub optDireccion_Click(Index As Integer, Value As Integer)
    Select Case Index%
    Case 0
        If Value% = True Then
            lblDescripcion(4).Visible = True
            lblEtiqueta(12).Caption = "Código de dirección:"
            txtCampo(1).Text = ""
            lblDescripcion(4).Caption = ""
        End If
    Case 1
        If Value% = True Then
            lblDescripcion(4).Visible = True
            lblEtiqueta(12).Caption = "Código de casilla:"
            txtCampo(1).Text = ""
            lblDescripcion(4).Caption = ""
        End If
    Case 2
        If Value% = True Then
            lblDescripcion(4).Visible = True
            lblEtiqueta(12).Caption = "Código de agencia:"
            txtCampo(1).Text = ""
            lblDescripcion(4).Caption = ""
        End If
     Case 3
        If Value% = True Then
            lblDescripcion(4).Visible = False
            lblEtiqueta(12).Caption = "No. de casillero:"
            txtCampo(1).Text = ""
        End If
    End Select
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Imprimir los datos de actualizacion de la cuenta
'            de ahorros.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VTTipo As String
    If frmDirecciones.Visible = True Then
        If optDireccion(0).Value = True Then
            VTTipo$ = lblDescripcion(4).Caption
        ElseIf optDireccion(1).Value = True Then
            VTTipo$ = "Casilla : " & lblDescripcion(4).Caption
        ElseIf optDireccion(2).Value = True Then
            VTTipo$ = "Agencia : " & lblDescripcion(4).Caption
        ElseIf optDireccion(3).Value = True Then
            VTTipo$ = "Casillero : " & txtCampo(1).Text
        End If
    End If

    If MsgBox("Esta seguro de imprimir los datos de atualización", 1 + 32 + 0, "Mensaje del Sistema") = 1 Then
        Screen.MousePointer = 11
        'Printer.FontName = "Courier"
''        Printer.FontBold = True
''        Printer.CurrentX = 0
''        Printer.CurrentY = 0
''        Printer.FontSize = 12
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print "                                                               Fecha: " & VGFecha$
''
''        Printer.FontBold = True
''        Printer.CurrentX = 0
''        Printer.CurrentY = 0
''        Printer.FontSize = 24
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print VGBanco$
''        Printer.FontSize = 10
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print ""
''        Printer.FontSize = 16
''        Printer.Print "ACTUALIZACION GENERAL CUENTAS DE AHORROS"
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print ""
''        Printer.FontSize = 12
        FMCabeceraReporte VGBanco$, Date, "ACTUALIZACION GENERAL CUENTAS DE AHORROS", _
                          Time(), Me.Caption, VGFecha$, Printer.Page
        Printer.FontBold = True
        Printer.Print String$(85, "-")
        Printer.Print "Número de Cuenta           :"; Tab(30); mskCuenta.Text
        Printer.Print ""
        Printer.Print "Nombre de la Cuenta        :"; Tab(30); txtCampo(0).Text
        Printer.Print ""
        Printer.Print "Producto bancario          :"; Tab(30); lblDescripcion(2).Caption
        Printer.Print ""
        If frmDirecciones.Visible = True Then
            Printer.Print "Dirección estado de cuenta :"; Tab(30); VTTipo$ & lblDescripcion(6).Caption
            Printer.Print ""
        End If
        Printer.Print "Ciclo de la cuenta         :"; Tab(30); lblDescripcion(1).Caption
        Printer.Print ""
        If optcausa(0).Value Then
            Printer.Print "Causa de Actualización     : "; "LEVANTAMIENTO DE ANULACIÓN"
            Printer.Print ""
        End If
        If optcausa(1).Value Then
            Printer.Print "Causa de Actualización     : "; "CANJE DE LIBRETA"
            Printer.Print ""
            Printer.Print "Causa de Canje             : "; lblDescripcion(0).Caption
            Printer.Print ""
        End If

        Printer.Print String$(85, "-")
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "_________________                                                 _________________"
        Printer.Print "  PROCESADO POR                                                     VERIFICADO POR "
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print String$(18, "-")
        Printer.Print "Firma del Cliente"
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        If VGCodPais$ <> "CO" Then
            Printer.Print "---  U L T I M A   L I N E A  ---"
        End If
        Printer.EndDoc
        Screen.MousePointer = 0
    End If
End Sub

Private Sub optDirecciondv_Click(Index As Integer, Value As Integer)
    Select Case Index%
    Case 0
        If Value% = True Then
            lblDescripcion(14).Visible = True
            lblEtiqueta(19).Caption = "Código de dirección:"
            txtCampo(13).Text = ""
            lblDescripcion(14).Caption = ""
        End If
    Case 1
        If Value% = True Then
            lblDescripcion(14).Visible = True
            lblEtiqueta(19).Caption = "Código de casilla:"
            txtCampo(13).Text = ""
            lblDescripcion(14).Caption = ""
        End If
    Case 2
        If Value% = True Then
            lblDescripcion(14).Visible = True
            lblEtiqueta(19).Caption = "Código de agencia:"
            txtCampo(13).Text = ""
            lblDescripcion(14).Caption = ""
        End If
    Case 3
        If Value% = True Then
            lblDescripcion(14).Visible = False
            lblEtiqueta(19).Caption = "No. de casillero:"
            txtCampo(13).Text = ""
        End If
    End Select
End Sub


Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 1, 2, 3, 5
        VLPaso% = False
    End Select
    'If index% = 4 Then
    '   VLPasolibreta% = True
    'End If
End Sub

Private Sub txtCampo_Click(Index As Integer)

   Select Case Index%
      Case Index% = 5
         If txtCampo(Index%).Enabled = False Then
            txtCampo(Index%).Enabled = True
         End If
         txtCampo(Index%).SetFocus
   End Select


End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Dim VLPasolibreta As String
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Nombre de la Cuenta de Ahorros"
    Case 1
        VLPaso% = True
        If optDireccion(0).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección del estado de cuenta [F5 Ayuda]"
        ElseIf optDireccion(1).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la casilla postal [F5 Ayuda]"
        ElseIf optDireccion(2).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la agencia [F5 Ayuda]"
        ElseIf optDireccion(3).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Número del casillero."
        End If
    Case 2
        VLPaso% = True
        FPrincipal!pnlHelpLine.Caption = " Código del ciclo de la cuenta [F5 Ayuda]"
    Case 3
        VLPaso% = True
        FPrincipal!pnlHelpLine.Caption = " Código de Producto Bancario"
    Case 4
        VLPasolibreta = True
        FPrincipal!pnlHelpLine.Caption = " Número de control de libreta"
    Case 5
        VLPasolibreta = True
        FPrincipal!pnlHelpLine.Caption = " Causa del Canje de Libreta"
    'Case 6
    '    FPrincipal!pnlHelpLine.Caption = " Nombre del Cotitular de Libreta de Ahorros"
    Case 13
        VLPaso% = True
        If optDirecciondv(0).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de Cheques Devueltos [F5 Ayuda]"
        ElseIf optDirecciondv(1).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la casilla postal [F5 Ayuda]"
        ElseIf optDirecciondv(2).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Código de la dirección de la agencia [F5 Ayuda]"
        ElseIf optDirecciondv(3).Value = True Then
            FPrincipal!pnlHelpLine.Caption = " Número del casillero."
        End If
    End Select

    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        Select Case Index%
        Case 1: 'F5 Código de Dirección
            If VLNumero% <> 0 Then
                VLPaso% = True
                If optDireccion(0).Value = True Then
                    If VLNumero% <> 0 Then
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de direcciones") Then
                            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                            PMChequea sqlconn&
                            FCatalogo.Show 1
                            txtCampo(1).Text = VGACatalogo.Codigo$
                            lblDescripcion(4).Caption = VGACatalogo.Descripcion$
                            grdPropietarios.Col = 1
                            txtCampo(1).Tag = grdPropietarios.Text
                            VLPaso% = True
                        Else
                            txtCampo(1).Tag = ""
                        End If
                    Else
                        MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                        txtCampo(1).SetFocus
                    End If
                ElseIf optDireccion(1).Value = True Then
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
                            txtCampo(1).Text = VGACatalogo.Codigo$
                            lblDescripcion(4).Caption = VGACatalogo.Descripcion$
                            grdPropietarios.Col = 1
                            txtCampo(1).Tag = grdPropietarios.Text
                        Else
                            txtCampo(1).Tag = ""
                        End If
                    Else
                        MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                        txtCampo(0).SetFocus
                    End If
                ElseIf optDireccion(2).Value = True Then
                    If VLNumero% <> 0 Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "O"
                        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de agencias") Then
                            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                            PMChequea sqlconn&
                            VLPaso% = True
                            FCatalogo.Show 1
                            txtCampo(1).Text = VGACatalogo.Codigo$
                            lblDescripcion(4).Caption = VGACatalogo.Descripcion$
                            grdPropietarios.Col = 1
                            txtCampo(1).Tag = grdPropietarios.Text
                        Else
                            txtCampo(1).Tag = ""
                        End If
                    Else
                        MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                        txtCampo(0).SetFocus
                    End If
                End If
            End If
        Case 2: 'F5 Ciclo de la Cuenta
            VLPaso% = True
            PMCatalogo "A", "cc_ciclo", txtCampo(2), lblDescripcion(1)
            If txtCampo(2) <> "" Then
               txtCampo(4).SetFocus
            End If
        Case 5: 'F5 Causa
            VLPaso% = True
            PMCatalogo "A", "ah_causa_canje", txtCampo(5), lblDescripcion(0)
        Case 13  '  Cheques devueltos
             If VLNumero% <> 0 Then
                VLPaso% = True
                If optDirecciondv(0).Value = True Then
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
                        txtCampo(13).SetFocus
                    End If
                ElseIf optDirecciondv(1).Value = True Then
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
                        txtCampo(0).SetFocus
                    End If
                ElseIf optDirecciondv(2).Value = True Then
                    If VLNumero% <> 0 Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "O"
                        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de agencias") Then
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
                        txtCampo(0).SetFocus
                    End If
                End If
            End If
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1, 2, 3, 4, 5
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    Case 0
        KeyAscii% = FMVAlidaTipoDato("B", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 1  'F5 Código de Dirección
        If VLPaso% = False Then
            If optDireccion(0).Value = True Then
                If VLNumero% <> 0 Then
                    If txtCampo(1).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                        PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT2, (txtCampo(1).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1229"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(4)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(1).Tag = grdPropietarios.Text
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(4).Caption = ""
                            txtCampo(1).Tag = ""
                            txtCampo(1).SetFocus
                        End If
                    Else
                        lblDescripcion(4).Caption = ""
                        txtCampo(1).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Tag = ""
                    txtCampo(1).SetFocus
                End If
            ElseIf optDireccion(1).Value = True Then
                If VLNumero% <> 0 Then
                    If txtCampo(1).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_cli", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_casi", 0, SQLINT2, (txtCampo(1).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "92"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_casilla", True, " Ok... Consulta de casilla " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(4)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(1).Tag = grdPropietarios.Text
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(4).Caption = ""
                            txtCampo(1).Tag = ""
                            txtCampo(1).SetFocus
                        End If
                    Else
                        lblDescripcion(1).Caption = ""
                        txtCampo(1).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Tag = ""
                    txtCampo(1).SetFocus
                End If
            ElseIf optDireccion(2).Value = True Then
                If VLNumero% <> 0 Then
                    If txtCampo(1).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "H"
                        PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(1).Text)
                        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de agencias") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(4)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(1).Tag = grdPropietarios.Text
                        Else
                            txtCampo(1).Text = ""
                            lblDescripcion(4).Caption = ""
                            txtCampo(1).Tag = ""
                            txtCampo(1).SetFocus
                        End If
                    Else
                        lblDescripcion(4).Caption = ""
                        txtCampo(1).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Tag = ""
                    txtCampo(1).SetFocus
                End If
            End If
        End If
    Case 2  'F5 Ciclo de la Cuenta
        If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                PMCatalogo "V", "cc_ciclo", txtCampo(2), lblDescripcion(1)
            Else
                lblDescripcion(1).Caption = ""
            End If
        End If
    Case 5  'F5 Causa
        If VLPaso% = False Then
            If txtCampo(5).Text <> "" Then
                PMCatalogo "V", "ah_causa_canje", txtCampo(5), lblDescripcion(0)
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If
    Case 13  'F5 Direccion Cheques devueltos
        If VLPaso% = False Then
            If optDirecciondv(0).Value = True Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                        grdPropietarios.Col = 1
                        PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (grdPropietarios.Text)
                        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                        PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1229"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de la dirección " & "[" & txtCampo(Index%) & "]") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(4)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(14).Caption = ""
                            txtCampo(13).Tag = ""
                            txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(14).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    txtCampo(13).SetFocus
                End If
            ElseIf optDirecciondv(1).Value = True Then
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
                            txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(13).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    txtCampo(13).SetFocus
                End If
            ElseIf optDirecciondv(2).Value = True Then
                If VLNumero% <> 0 Then
                    If txtCampo(13).Text <> "" Then
                        PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "H"
                        PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(13).Text)
                        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Ok... Consulta de agencias") Then
                            PMMapeaObjeto sqlconn&, lblDescripcion(14)
                            PMChequea sqlconn&
                            grdPropietarios.Col = 1
                            txtCampo(13).Tag = grdPropietarios.Text
                        Else
                            txtCampo(13).Text = ""
                            lblDescripcion(14).Caption = ""
                            txtCampo(13).Tag = ""
                            txtCampo(13).SetFocus
                        End If
                    Else
                        lblDescripcion(14).Caption = ""
                        txtCampo(13).Tag = ""
                    End If
                Else
                    MsgBox "No existen propietarios de la cuenta", 0 + 16, "Mensaje de Error"
                    txtCampo(13).Tag = ""
                    txtCampo(13).SetFocus
                End If
            End If
        End If
    End Select
End Sub


