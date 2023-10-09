VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form Fdatadi 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Perfil de la Cuenta"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   450
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
   HelpContextID   =   1022
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3081"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   10
      Left            =   5540
      MaxLength       =   5
      TabIndex        =   9
      Top             =   3105
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   18
      Left            =   2415
      MaxLength       =   5
      TabIndex        =   3
      Top             =   1440
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   17
      Left            =   2415
      MaxLength       =   5
      TabIndex        =   6
      Top             =   2060
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   16
      Left            =   5540
      MaxLength       =   5
      TabIndex        =   27
      Top             =   4920
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   15
      Left            =   5540
      MaxLength       =   5
      TabIndex        =   24
      Top             =   4615
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   14
      Left            =   5540
      MaxLength       =   5
      TabIndex        =   21
      Top             =   4313
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   13
      Left            =   5540
      MaxLength       =   5
      TabIndex        =   18
      Top             =   4011
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   12
      Left            =   5540
      MaxLength       =   5
      TabIndex        =   15
      Top             =   3709
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   11
      Left            =   5540
      MaxLength       =   5
      TabIndex        =   12
      Top             =   3407
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   9
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   26
      Top             =   4920
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   8
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   23
      Top             =   4615
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   7
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   20
      Top             =   4313
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   6
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   17
      Top             =   4011
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   14
      Top             =   3709
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   11
      Top             =   3407
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   4560
      MaxLength       =   5
      TabIndex        =   8
      Top             =   3105
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   5590
      MaxLength       =   5
      TabIndex        =   5
      Top             =   1755
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2415
      MaxLength       =   5
      TabIndex        =   4
      Top             =   1755
      Width           =   735
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   5590
      MaxLength       =   5
      TabIndex        =   2
      Top             =   1120
      Width           =   735
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2235
      TabIndex        =   0
      Top             =   60
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   1560
      TabIndex        =   1
      Top             =   1100
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   64
      Top             =   0
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   31
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   875
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
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   30
      Top             =   3780
      WhatsThisHelpID =   2003
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
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
      Index           =   4
      Left            =   8415
      TabIndex        =   29
      Tag             =   "2549"
      Top             =   3000
      WhatsThisHelpID =   2005
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Modificar"
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
      Index           =   0
      Left            =   8415
      TabIndex        =   28
      Top             =   2220
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   2
      Left            =   2280
      TabIndex        =   10
      Top             =   3407
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   3
      Left            =   2280
      TabIndex        =   13
      Top             =   3709
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   4
      Left            =   2280
      TabIndex        =   16
      Top             =   4011
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   5
      Left            =   2280
      TabIndex        =   19
      Top             =   4313
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   6
      Left            =   2280
      TabIndex        =   22
      Top             =   4615
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   7
      Left            =   2280
      TabIndex        =   25
      Top             =   4920
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   2280
      TabIndex        =   7
      Top             =   3105
      Width           =   2190
      _ExtentX        =   3863
      _ExtentY        =   503
      _Version        =   393216
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   5
      Left            =   6285
      TabIndex        =   65
      Top             =   3105
      Width           =   2060
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   12
      Left            =   3160
      TabIndex        =   63
      Top             =   1440
      Width           =   5180
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Origen de los Fondos:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   19
      Left            =   0
      TabIndex        =   62
      Top             =   1440
      WhatsThisHelpID =   5183
      Width           =   1950
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -30
      X2              =   8385
      Y1              =   2400
      Y2              =   2400
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   11
      Left            =   6285
      TabIndex        =   61
      Top             =   4920
      Width           =   2060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propósito de la Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   18
      Left            =   0
      TabIndex        =   60
      Top             =   2060
      WhatsThisHelpID =   5185
      Width           =   2085
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   10
      Left            =   6285
      TabIndex        =   59
      Top             =   4615
      Width           =   2060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Transf. Recibidas(Loc/Ext):"
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
      Index           =   17
      Left            =   0
      TabIndex        =   58
      Top             =   4980
      WhatsThisHelpID =   5192
      Width           =   2160
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   9
      Left            =   6285
      TabIndex        =   57
      Top             =   4313
      Width           =   2060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Transf. Enviadas (Loc/Ext):"
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
      Index           =   16
      Left            =   0
      TabIndex        =   56
      Top             =   4675
      WhatsThisHelpID =   5191
      Width           =   2145
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   8
      Left            =   6285
      TabIndex        =   55
      Top             =   4011
      Width           =   2060
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   7
      Left            =   6285
      TabIndex        =   54
      Top             =   3709
      Width           =   2060
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   6
      Left            =   6285
      TabIndex        =   53
      Top             =   3407
      Width           =   2060
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   2
      Left            =   3160
      TabIndex        =   52
      Top             =   2055
      Width           =   5180
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Compra de Chq. Gerencia:"
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
      Left            =   0
      TabIndex        =   51
      Top             =   4373
      WhatsThisHelpID =   5190
      Width           =   2055
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "FRECUENCIA"
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
      Index           =   14
      Left            =   5520
      TabIndex        =   50
      Top             =   2880
      Width           =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "NUM. TRN."
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
      Index           =   13
      Left            =   4560
      TabIndex        =   49
      Top             =   2880
      Width           =   870
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "MONTOS PROMEDIOS"
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
      Index           =   12
      Left            =   2280
      TabIndex        =   48
      Top             =   2880
      Width           =   1785
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "RUBRO"
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
      Index           =   11
      Left            =   0
      TabIndex        =   47
      Top             =   2880
      Width           =   600
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Posible Actividad de la Cuenta:"
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   10
      Left            =   0
      TabIndex        =   46
      Top             =   2520
      Width           =   2685
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   4
      Left            =   6340
      TabIndex        =   45
      Top             =   1755
      Width           =   1990
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Otros Productos a solicitar:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   0
      TabIndex        =   44
      Top             =   1755
      WhatsThisHelpID =   5184
      Width           =   2400
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   3
      Left            =   3165
      TabIndex        =   43
      Top             =   1755
      Width           =   2370
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Forma de Dep. Ini.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   3840
      TabIndex        =   42
      Top             =   1120
      WhatsThisHelpID =   5182
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   1
      Left            =   6340
      TabIndex        =   41
      Top             =   1120
      Width           =   1990
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Depósito Inicial:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   0
      TabIndex        =   40
      Top             =   1100
      WhatsThisHelpID =   5181
      Width           =   1470
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Dep. en Efectivo:"
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
      Left            =   0
      TabIndex        =   39
      Top             =   3465
      WhatsThisHelpID =   5187
      Width           =   1380
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Dep. Chq. Extranjeros:"
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
      Left            =   0
      TabIndex        =   38
      Top             =   3165
      WhatsThisHelpID =   5186
      Width           =   1770
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Retiro en Efectivo:"
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
      Left            =   0
      TabIndex        =   37
      Top             =   3765
      WhatsThisHelpID =   5188
      Width           =   1515
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Compra de Giros Bancarios:"
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
      Left            =   0
      TabIndex        =   36
      Top             =   4071
      WhatsThisHelpID =   5189
      Width           =   2235
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Información Adicional:"
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   4
      Left            =   45
      TabIndex        =   35
      Top             =   720
      Width           =   1905
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2235
      TabIndex        =   33
      Top             =   360
      UseMnemonic     =   0   'False
      Width           =   6120
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -30
      X2              =   8385
      Y1              =   675
      Y2              =   675
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta corriente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   75
      TabIndex        =   34
      Top             =   75
      WhatsThisHelpID =   5016
      Width           =   2175
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la chequera:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   75
      TabIndex        =   32
      Top             =   360
      WhatsThisHelpID =   5017
      Width           =   2130
   End
End
Attribute VB_Name = "Fdatadi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10

Option Explicit
Dim VLFormActiv As Integer
Dim VTR1 As Integer
Dim i As Integer



'*************************************************************
' ARCHIVO:          Fdatadi.frm
' NOMBRE LOGICO:    Fdatadi
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
' Esta forma permite realizar el mantenimiento de informacion
' adicional de una cuenta como parte del proceso de apertura
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 24-Mar-05      J. Hidalgo      Emisión Inicial
'*************************************************************
Dim VLPaso As Integer
Dim VLProducto As String
Dim VLBase As String
Dim VLSP As String
Dim VLSP1 As String
Dim VLMascara As String
Dim VLTitular As String

Private Sub Form_Load()
    Fdatadi.Left = 0   '15
    Fdatadi.Top = 0   '15
    Fdatadi.Width = 9450   '9420
    Fdatadi.Height = 5900   '5730
    If VGProducto$ = "CTE" Then
        lblEtiqueta(0).WhatsThisHelpID = "5016"
        lblEtiqueta(6).WhatsThisHelpID = "5017"
        VLMascara$ = VGMascaraCtaCte$
    Else
        lblEtiqueta(0).WhatsThisHelpID = "0"
        lblEtiqueta(0).Caption = "No. de cuenta ahorros:"
        lblEtiqueta(6).WhatsThisHelpID = "0"
        lblEtiqueta(6).Caption = "Nombre de la cuenta:"
        VLMascara$ = VGMascaraCtaAho$
    End If
    PMLoadResStrings Me
    PMLoadResIcons Me
    'mskCuenta.Mask = VLMascara$
    PLLimpiar
    txtCampo(2).MaxLength = 50
End Sub
Private Sub Form_Activate()

    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If VGProducto$ = "CTE" Then
            VLProducto$ = "3"
            VLBase$ = "cob_cuentas"
            VLSP$ = "sp_tr_query_nom_ctacte"
            VLSP1$ = "sp_datos_adic_cte"
            VLMascara$ = VGMascaraCtaCte$
'             VLFormActiv% = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
        Else
            If VGProducto$ = "AHO" Then
                VLProducto$ = "4"
                VLBase$ = "cob_ahorros"
                VLSP$ = "sp_tr_query_nom_ctahorro"
                VLSP1$ = "sp_datos_adic_aho"
                VLMascara$ = VGMascaraCtaAho$
                'VLFormActiv% = 2
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
            Else
                'MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                mskCuenta.SetFocus
            End If
        End If
        
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        If FMTransmitirRPC(sqlconn&, ServerName$, VLBase$, VLSP$, True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
            PMMapeaObjeto sqlconn&, lblDescripcion(0)
            PMChequea sqlconn&
            PLBuscar

'            If VLFormActiv% = 1 Then
'                If (FTran001!cmdBoton(8).Enabled = False And FTran001!cmdBoton(8).Visible) Then
'                     PLBuscar
'                End If
'            End If
'
'             If VLFormActiv% = 2 Then
'                 If (FTran201!cmdBoton(6).Enabled = False And FTran201!cmdBoton(6).Visible) Then
'                     PLBuscar
'                 End If
'             End If
        Else
            mskCuenta.Text = FMMascara("", VLMascara$)
            lblDescripcion(0).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
End Sub
Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Transmitir
        PLTransmitir "I"
    Case 1
        'Limpiar
        PLLimpiar
    Case 2
        'Salir
        Unload Fdatadi
    Case 4
        'Modificar
        PLTransmitir "U"
    Case 3
        PLBuscar
    
    End Select
End Sub

Private Sub mskCuenta_GotFocus()
    'FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta Corriente"
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub
Private Sub mskCuenta_LostFocus()

    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If VGProducto$ = "CTE" Then
            VLProducto$ = "3"
            VLBase$ = "cob_cuentas"
            VLSP$ = "sp_tr_query_nom_ctacte"
            VLSP1$ = "sp_datos_adic_cte"
            VLMascara$ = VGMascaraCtaCte$
            'VLFormActiv% = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
        Else
            If VGProducto$ = "AHO" Then
                VLProducto$ = "4"
                VLBase$ = "cob_ahorros"
                VLSP$ = "sp_tr_query_nom_ctahorro"
                VLSP1$ = "sp_datos_adic_aho"
                VLMascara$ = VGMascaraCtaAho$
                VLFormActiv = 2
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
            End If
        End If

        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        If FMTransmitirRPC(sqlconn&, ServerName$, VLBase$, VLSP$, True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
            PMMapeaObjeto sqlconn&, lblDescripcion(0)
            PMChequea sqlconn&
            
            If cmdBoton(3).Enabled And cmdBoton(3).Visible Then cmdBoton(3).SetFocus
            
            PLBuscaEnte
            PLBuscar

        Else
            PLLimpiar
            mskCuenta.Text = FMMascara("", VLMascara$)
            lblDescripcion(0).Caption = ""
            If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
            Exit Sub
        End If
    Else
       lblDescripcion(0).Caption = ""
    End If
End Sub
Private Sub PLBuscaEnte()
Dim VTSpEnte As String
Dim VTTrn As String
Dim VTBase As String
         If VGProducto$ = "AHO" Then
           VTSpEnte = "sp_tr_query_clientes_ah"
           VTTrn = "298"
           VTBase = "cob_ahorros"
         Else
           VTSpEnte = "sp_tr_query_clientes"
           VTTrn = "17"
           VTBase = "cob_cuentas"
         End If
         VLTitular = ""
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, VTTrn
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         ReDim VTEntes(6, 100) As String
         If FMTransmitirRPC(sqlconn&, ServerName$, VTBase, VTSpEnte, True, " Ok... Consulta de propietarios") Then
             VTR1% = FMMapeaMatriz(sqlconn&, VTEntes())
             PMChequea sqlconn&
             For i = 1 To VTR1%
               If VTEntes(4, i) = "T" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                 VLTitular = Trim(VTEntes(0, i))
                 Exit For
               End If
             Next i
         End If
End Sub
Private Sub mskValor_GotFocus(Index As Integer)
    'FPrincipal!pnlHelpLine.Caption = " Valor del Bloqueo"
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Valor del Depósito Inicial"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Valor del Depósito en Chq. Extranjeros"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Valor del Depósito en Efectivo"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Valor del Retiro en Efectivo"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Valor de la Compra de Giros Bancarios"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Valor de la Compra de Cheques de Gerencia"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Valor de las Transferencias Enviadas (Locales / Extranjeras)"
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Valor de las Transferencias Enviadas (Locales / Extranjeras)"
    End Select
    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)
End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
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

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Forma de Depósito de la Cuenta [F5 Ayuda]"
    Case 1, 2
        FPrincipal!pnlHelpLine.Caption = " Otros Productos Cobis a solicitar [F5 Ayuda]"
    Case 3, 4, 5, 6, 7, 8, 9
        FPrincipal!pnlHelpLine.Caption = " Número de transacciones del Rubro"
    Case 10, 11, 12, 13, 14, 15, 16
        FPrincipal!pnlHelpLine.Caption = " Frecuencia del Rubro [F5 Ayuda]"
    Case 17
        FPrincipal!pnlHelpLine.Caption = " Propósito de la Cuenta [F5 Ayuda]"
    Case 18
        FPrincipal!pnlHelpLine.Caption = " Origen de los Fondos [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 0
            PMCatalogo "A", "cl_forma_depini", txtCampo(Index%), lblDescripcion(1)
'            VLPaso% = True
'            PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cl_forma_depini"
'            PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
'            If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la Forma de Depósito Inicial") Then
'                PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
'                PMChequea SqlConn&
'                FCatalogo.Show 1
'                txtCampo(Index%).Text = VGACatalogo.Codigo$
'                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
'                txtCampo(Index%).SetFocus
'            End If
        Case 1, 2
            PMCatalogo "A", "pf_otros_prod_bancarios", txtCampo(Index%), lblDescripcion(Index% + 2)
'            PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR&, "H"
'            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2&, "15037"
'            PMPasoValores SqlConn&, "@i_modo", 0, SQLINT1&, "0"
'            PMPasoValores SqlConn&, "@i_tipo_h", 0, SQLCHAR&, "A"
'
'            PMHelpG "cobis", "sp_pro_mon", 4, 3
'            PMBuscarG 1, "@i_operacion", "H", SQLCHAR&
'            PMBuscarG 2, "@i_tipo_h", "A", SQLCHAR&
'            PMBuscarG 3, "@i_modo", "0", SQLINT1&
'            PMBuscarG 4, "@t_trn", "15037", SQLINT2&
'
'            PMSigteG 1, "@i_producto", 1, SQLINT1&
'            PMSigteG 2, "@i_tipo", 2, SQLCHAR&
'            PMSigteG 3, "@i_moneda", 3, SQLINT1&
'
'            If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_pro_mon", True, "OK...  Lista de valores") Then
'                PMMapeaGrid SqlConn&, grid_valores!gr_SQL, False
'                PMChequea SqlConn&
'               PMProcesG
'               grid_valores.Show 1
'               If Temporales(1) <> "" Then
'                   txtCampo(Index%).Text = Temporales(1)
'                   lblDescripcion(Index% + 2).Caption = Temporales(4)
'               Else
'                   txtCampo(Index%).Text = ""
'                   lblDescripcion(Index% + 2).Caption = ""
'               End If
'            End If
        Case 10, 11, 12, 13, 14, 15, 16
            PMCatalogo "A", "cl_frecuencia", txtCampo(Index%), lblDescripcion(Index% - 5)
'            VLPaso% = True
'            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_frecuencia"
'            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
'            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la frecuencia") Then
'                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
'                PMChequea sqlconn&
'                FCatalogo.Show 1
'                txtCampo(Index%).Text = VGACatalogo.Codigo$
'                lblDescripcion(Index% - 5).Caption = VGACatalogo.Descripcion$
'                txtCampo(Index%).SetFocus
'            End If
        Case 17
            PMCatalogo "A", "cl_pro_cta", txtCampo(Index%), lblDescripcion(2)
        Case 18
            PMCatalogo "A", "cl_orig_fond", txtCampo(Index%), lblDescripcion(12)
        
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1, 2, 3, 4, 5, 6, 7, 8, 9
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 10, 11, 12, 13, 14, 15, 16
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso% = False Then
        Select Case Index%
        Case 0
            If txtCampo(Index%).Text <> "" Then
                PMCatalogo "V", "cl_forma_depini", txtCampo(Index%), lblDescripcion(1)
            Else
                lblDescripcion(1).Caption = ""
            End If
        Case 1, 2
            If txtCampo(Index%).Text <> "" Then
                PMCatalogo "V", "pf_otros_prod_bancarios", txtCampo(Index%), lblDescripcion(Index% + 2)
            Else
                lblDescripcion(Index% + 2).Caption = ""
                txtCampo(Index%).Text = ""
            End If
        Case 10, 11, 12, 13, 14, 15, 16
           If txtCampo(Index%).Text <> "" Then
              PMCatalogo "V", "cl_frecuencia", txtCampo(Index%), lblDescripcion(Index% - 5)
           Else
              lblDescripcion(Index% - 5).Caption = ""
              txtCampo(Index%).Text = ""
           End If
        Case 17
           If txtCampo(Index%).Text <> "" Then
              PMCatalogo "V", "cl_pro_cta", txtCampo(Index%), lblDescripcion(2)
           Else
              lblDescripcion(2).Caption = ""
           End If
        Case 18
           If txtCampo(Index%).Text <> "" Then
              PMCatalogo "V", "cl_orig_fond", txtCampo(Index%), lblDescripcion(12)
           Else
              lblDescripcion(12).Caption = ""
           End If
        End Select
    End If
End Sub
Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Muestra la información relacionada con datos
'            adicionales de la cuenta
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 24-Mar-05      J. Hidalgo      Emisión Inicial
'*************************************************************
    
    If mskCuenta.ClipText = "" Then
        'MsgBox "El número de la cuenta corriente es mandatorio", 0 + 16, "Mensaje de Error"
        MsgBox "El número de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If

    If VGProducto$ = "CTE" Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2840"
    Else
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "347"
    End If
    
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
    ReDim VTArreglo(30) As String
    If FMTransmitirRPC(sqlconn&, ServerName$, VLBase$, VLSP1$, True, " Ok... Consulta de información de la cuenta " & "[" & mskCuenta.Text & "]") Then
        VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&

        If VTR1 <= 0 Then
            cmdBoton(4).Enabled = False
            cmdBoton(0).Enabled = True
            If mskValor(0).Enabled And mskValor(0).Visible Then mskValor(0).SetFocus
            For i% = 0 To 7
                mskValor(i%).Format = VGDecimales$
                mskValor(i%).Text = Format$(0, VGDecimales$)
            Next i%
            
            For i% = 1 To 12
                lblDescripcion(i%).Caption = ""
            Next i%
            
            For i% = 0 To 18
                txtCampo(i%).Text = ""
            Next i%
            Exit Sub
        End If

        cmdBoton(4).Enabled = True
        cmdBoton(0).Enabled = False

        mskValor(0).Text = VTArreglo(1)
        txtCampo(0).Text = VTArreglo(2)
        txtCampo_LostFocus 0
        txtCampo(17).Text = VTArreglo(3)
        txtCampo_LostFocus 17
        txtCampo(1).Text = VTArreglo(4)
        txtCampo_LostFocus 1
        txtCampo(2).Text = VTArreglo(5)
        txtCampo_LostFocus 2

        mskValor(1).Text = VTArreglo(6)
        txtCampo(3).Text = VTArreglo(7)
        txtCampo(10).Text = VTArreglo(8)
        txtCampo_LostFocus 10

        mskValor(2).Text = VTArreglo(9)
        txtCampo(4).Text = VTArreglo(10)
        txtCampo(11).Text = VTArreglo(11)
        txtCampo_LostFocus 11

        mskValor(3).Text = VTArreglo(12)
        txtCampo(5).Text = VTArreglo(13)
        txtCampo(12).Text = VTArreglo(14)
        txtCampo_LostFocus 12

        mskValor(4).Text = VTArreglo(15)
        txtCampo(6).Text = VTArreglo(16)
        txtCampo(13).Text = VTArreglo(17)
        txtCampo_LostFocus 13

        mskValor(5).Text = VTArreglo(18)
        txtCampo(7).Text = VTArreglo(19)
        txtCampo(14).Text = VTArreglo(20)
        txtCampo_LostFocus 14

        mskValor(6).Text = VTArreglo(21)
        txtCampo(8).Text = VTArreglo(22)
        txtCampo(15).Text = VTArreglo(23)
        txtCampo_LostFocus 15

        mskValor(7).Text = VTArreglo(24)
        txtCampo(9).Text = VTArreglo(25)
        txtCampo(16).Text = VTArreglo(26)
        txtCampo_LostFocus 16
        txtCampo(18).Text = VTArreglo(27)
        txtCampo_LostFocus 18

        If mskValor(0).Enabled And mskValor(0).Visible Then mskValor(0).SetFocus
    End If
End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia la información de la forma
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 24-Mar-05      J. Hidalgo      Emisión Inicial
'*************************************************************
    mskCuenta.Mask = VLMascara$
    For i% = 0 To 7
        mskValor(i%).Format = VGDecimales$
        mskValor(i%).Text = Format$(0, VGDecimales$)
    Next i%
    
    For i% = 0 To 12
        lblDescripcion(i%).Caption = ""
    Next i%
    
    For i% = 0 To 18
        txtCampo(i%).Text = ""
    Next i%
    cmdBoton(0).Enabled = True
    cmdBoton(4).Enabled = False
    mskCuenta.Text = FMMascara("", VLMascara$)
    If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
End Sub
Private Sub PLTransmitir(tipo As String)
Dim VTFecha As String

    ' Validacion de Mandatoriedades
    ' Numero de Cuenta
    
    If mskCuenta.ClipText = "" Then
       'MsgBox "El número de la cuenta corriente es mandatorio", 0 + 16, "Mensaje de Error"
       MsgBox "El número de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
       If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.SetFocus
       Exit Sub
    End If
    
    ' Depósito Inicial
    If Val(mskValor(0).Text) <= 0 Then
       MsgBox "El valor del Depósito Inicial debe ser mayor que cero", 0 + 16, "Mensaje de Error"
       If mskValor(0).Enabled And mskValor(0).Visible Then mskValor(0).SetFocus
       Exit Sub
    End If
    
    ' Forma de Deposito Inicial
    If txtCampo(0).Text = "" Then
       MsgBox "La forma de Depósito Inicial es mandatoria", 0 + 16, "Mensaje de Error"
       If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).SetFocus
       Exit Sub
    End If
    
    'Origen de los Fondos
    If txtCampo(18).Text = "" Then
       MsgBox "El origen de los fondos es mandatorio", 0 + 16, "Mensaje de Error"
       If txtCampo(18).Enabled And txtCampo(18).Visible Then txtCampo(18).SetFocus
       Exit Sub
    End If
    
    ' Propósito de la Cuenta
    If txtCampo(17).Text = "" Then
       MsgBox "El Propósito de la Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
       If txtCampo(17).Enabled And txtCampo(17).Visible Then txtCampo(17).SetFocus
       Exit Sub
    End If
    
    'Otros Productos a Solicitar
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim(txtCampo(1).Text) <> "" And Trim(txtCampo(2).Text) <> "" Then
       If txtCampo(1).Text = txtCampo(2).Text Then
          MsgBox "Debe elegir otro producto COBIS a solicitar", 0 + 16, "Mensaje de Error"
          If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
          Exit Sub
       End If
    End If
    
    'Números de transacción
    For i% = 3 To 9
       If Val(txtCampo(i%).Text) < 0 Then
           MsgBox "Existe al menos un número de transacción igual a cero o nulo", 0 + 16, "Mensaje de Error"
           If txtCampo(i%).Enabled And txtCampo(i%).Visible Then txtCampo(i%).SetFocus
           Exit Sub
       End If
       If Val(txtCampo(i%).Text) >= 10000 Then
           MsgBox "El número de transacción debe ser menor o igual a 10000", 0 + 16, "Mensaje de Error"
           If txtCampo(i%).Enabled And txtCampo(i%).Visible Then txtCampo(i%).SetFocus
           Exit Sub
       End If
       If txtCampo(i%).Text <> "" Then
         If Val(mskValor(i% - 2).Text) = 0 Then
           MsgBox "El monto debe ser diferente de cero", 0 + 16, "Mensaje de Error"
           If mskValor(i% - 2).Enabled And mskValor(i% - 2).Visible Then mskValor(i% - 2).SetFocus
           Exit Sub
         End If
         If txtCampo(i% + 7).Text = "" Then
            MsgBox "Debe ingresar la frecuencia ", 0 + 16, "Mensaje de Error"
            If txtCampo(i% + 7).Enabled And txtCampo(i% + 7).Visible Then txtCampo(i% + 7).SetFocus
            Exit Sub
         End If
       End If
       
       If Val(mskValor(i% - 2).Text) > 0 Then
         If txtCampo(i%).Text = "" Then
           MsgBox "Debe ingresar el número de transacción", 0 + 16, "Mensaje de Error"
           If txtCampo(i%).Enabled And txtCampo(i%).Visible Then txtCampo(i%).SetFocus
           Exit Sub
         End If
         If txtCampo(i% + 7).Text = "" Then
            MsgBox "Debe ingresar la frecuencia ", 0 + 16, "Mensaje de Error"
            If txtCampo(i% + 7).Enabled And txtCampo(i% + 7).Visible Then txtCampo(i% + 7).SetFocus
            Exit Sub
         End If
       End If
       
       If txtCampo(i% + 7) <> "" Then
         If Val(mskValor(i% - 2).Text) = 0 Then
           MsgBox "El monto debe ser diferente de cero", 0 + 16, "Mensaje de Error"
           If mskValor(i% - 2).Enabled And mskValor(i% - 2).Visible Then mskValor(i% - 2).SetFocus
           Exit Sub
         End If
         If txtCampo(i%).Text = "" Then
           MsgBox "Debe ingresar el número de transacción", 0 + 16, "Mensaje de Error"
           If txtCampo(i%).Enabled And txtCampo(i%).Visible Then txtCampo(i%).SetFocus
           Exit Sub
         End If
       End If
       
    Next i%
        
    If tipo$ = "I" Then
        If VGProducto$ = "CTE" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2838"
        Else
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "345"
        End If
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
        VTFecha = FMConvFecha(VGFecha$, VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_ingreso", 0, SQLDATETIME, VTFecha$
    Else
        If VGProducto$ = "CTE" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2839"
        Else
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "346"
        End If
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
        VTFecha$ = FMConvFecha(VGFecha$, VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_modif", 0, SQLDATETIME, VTFecha$
    End If
    
    PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
    PMPasoValores sqlconn&, "@i_origen_fondos", 0, SQLVARCHAR, (txtCampo(18).Text)
  
    PMPasoValores sqlconn&, "@i_dep_inicial", 0, SQLMONEY, (mskValor(0).Text)
    PMPasoValores sqlconn&, "@i_forma_dep_inicial", 0, SQLVARCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_proposito_cuenta", 0, SQLVARCHAR, (txtCampo(17).Text)
    PMPasoValores sqlconn&, "@i_prod_cobis1", 0, SQLVARCHAR, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_prod_cobis2", 0, SQLVARCHAR, (txtCampo(2).Text)
    
    PMPasoValores sqlconn&, "@i_monto_ext", 0, SQLMONEY, (mskValor(1).Text)
    PMPasoValores sqlconn&, "@i_trx_ext", 0, SQLINT2, (txtCampo(3).Text)
    PMPasoValores sqlconn&, "@i_frecuencia_ext", 0, SQLVARCHAR, (txtCampo(10).Text)
    
    PMPasoValores sqlconn&, "@i_monto_efec", 0, SQLMONEY, (mskValor(2).Text)
    PMPasoValores sqlconn&, "@i_trx_efec", 0, SQLINT2, (txtCampo(4).Text)
    PMPasoValores sqlconn&, "@i_frecuencia_efec", 0, SQLVARCHAR, (txtCampo(11).Text)
    
    PMPasoValores sqlconn&, "@i_monto_refec", 0, SQLMONEY, (mskValor(3).Text)
    PMPasoValores sqlconn&, "@i_trx_refec", 0, SQLINT2, (txtCampo(5).Text)
    PMPasoValores sqlconn&, "@i_frecuencia_refec", 0, SQLVARCHAR, (txtCampo(12).Text)
    
    PMPasoValores sqlconn&, "@i_monto_giro", 0, SQLMONEY, (mskValor(4).Text)
    PMPasoValores sqlconn&, "@i_trx_giro", 0, SQLINT2, (txtCampo(6).Text)
    PMPasoValores sqlconn&, "@i_frecuencia_giro", 0, SQLVARCHAR, (txtCampo(13).Text)
    
    PMPasoValores sqlconn&, "@i_monto_gerencia", 0, SQLMONEY, (mskValor(5).Text)
    PMPasoValores sqlconn&, "@i_trx_gerencia", 0, SQLINT2, (txtCampo(7).Text)
    PMPasoValores sqlconn&, "@i_frecuencia_gerencia", 0, SQLVARCHAR, (txtCampo(14).Text)
    
    PMPasoValores sqlconn&, "@i_monto_transfer", 0, SQLMONEY, (mskValor(6).Text)
    PMPasoValores sqlconn&, "@i_trx_transfer", 0, SQLINT2, (txtCampo(8).Text)
    PMPasoValores sqlconn&, "@i_frecuencia_transfer", 0, SQLVARCHAR, (txtCampo(15).Text)
    
    PMPasoValores sqlconn&, "@i_monto_recib", 0, SQLMONEY, (mskValor(7).Text)
    PMPasoValores sqlconn&, "@i_trx_recib", 0, SQLINT2, (txtCampo(9).Text)
    PMPasoValores sqlconn&, "@i_frecuencia_recib", 0, SQLVARCHAR, (txtCampo(16).Text)
    
    If FMTransmitirRPC(sqlconn&, ServerName$, VLBase$, VLSP1$, True, "Ok... Inserción de Información Adicional [" + mskCuenta.Text + "]") Then
        PMChequea sqlconn&
        cmdBoton(4).Enabled = True
        cmdBoton(0).Enabled = False
        
        VGPerfilCta = "S"
    Else
        Exit Sub
    End If
    
    'Llama al sp de clientes para guardar la información
    
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, tipo$
    Select Case tipo$
        Case "I"
            'codigo de transaccion
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1421"
        Case "U"
            'codigo de transaccion
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1423"
    End Select
        
    PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, VLTitular
    PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR&, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR&, VGProducto
    PMPasoValores sqlconn&, "@i_descmoneda", 0, SQLVARCHAR&, VGDescMoneda
    PMPasoValores sqlconn&, "@i_origen", 0, SQLVARCHAR&, txtCampo(18).Text
    PMPasoValores sqlconn&, "@i_proposito", 0, SQLVARCHAR&, txtCampo(17).Text
    PMPasoValores sqlconn&, "@i_deposini", 0, SQLVARCHAR&, mskValor(0).ClipText
    PMPasoValores sqlconn&, "@i_ntrandeb", 0, SQLVARCHAR&, txtCampo(5).Text
    PMPasoValores sqlconn&, "@i_ntrancre", 0, SQLVARCHAR&, txtCampo(4).Text
    PMPasoValores sqlconn&, "@i_mpromdeb", 0, SQLVARCHAR&, mskValor(3).ClipText
    PMPasoValores sqlconn&, "@i_mpromcre", 0, SQLVARCHAR&, mskValor(2).ClipText
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_inf_cuenta", True, "Información de la Cuenta") Then
        PMChequea sqlconn&
        cmdBoton(4).Enabled = True
        cmdBoton(0).Enabled = False
    End If

    
End Sub

