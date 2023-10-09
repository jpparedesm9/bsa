VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FRelCtaCanal 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Relación Cuenta a Canales"
   ClientHeight    =   6660
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9330
   HelpContextID   =   1149
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6660
   ScaleWidth      =   9330
   Tag             =   "743"
   Begin VB.ComboBox cmbProducto 
      Height          =   315
      Left            =   2040
      TabIndex        =   0
      Text            =   "cmbProducto"
      Top             =   120
      Width           =   2535
   End
   Begin VB.Frame frmDatosCanales 
      Caption         =   "Datos de la Relacion Canales"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   3975
      Left            =   120
      TabIndex        =   21
      Top             =   2640
      WhatsThisHelpID =   5462
      Width           =   8115
      Begin VB.TextBox txtMotivo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   300
         Left            =   2640
         MaxLength       =   54
         TabIndex        =   3
         Top             =   1185
         Width           =   750
      End
      Begin VB.CommandButton cmdResetClave 
         Caption         =   "&Generar Clave"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   480
         Left            =   5880
         TabIndex        =   36
         Top             =   1500
         WhatsThisHelpID =   2512
         Width           =   1335
      End
      Begin VB.TextBox txtCanal 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   2640
         MaxLength       =   4
         TabIndex        =   2
         Top             =   870
         Width           =   750
      End
      Begin VB.TextBox txtTelCelular 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   2640
         MaxLength       =   2
         TabIndex        =   4
         Top             =   1500
         Width           =   750
      End
      Begin VB.TextBox txtConfirmaTarjDeb 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   2640
         MaxLength       =   19
         TabIndex        =   6
         Top             =   2130
         Width           =   2820
      End
      Begin VB.TextBox txtTarjetaDebito 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   2640
         MaxLength       =   19
         TabIndex        =   5
         Top             =   1815
         Width           =   2820
      End
      Begin MSGrid.Grid grdRelacionCanal 
         Height          =   975
         Left            =   120
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   2880
         Width           =   7860
         _Version        =   65536
         _ExtentX        =   13864
         _ExtentY        =   1720
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
      Begin VB.TextBox TxtNuevaTarjeta 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   2040
         MaxLength       =   54
         TabIndex        =   39
         Top             =   3720
         Visible         =   0   'False
         Width           =   2820
      End
      Begin VB.Label lblDescMotivo 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   300
         Left            =   3405
         TabIndex        =   38
         Top             =   1185
         Width           =   4575
      End
      Begin VB.Label lblMotivo 
         Caption         =   "*Motivo:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   135
         TabIndex        =   37
         Top             =   1185
         WhatsThisHelpID =   5469
         Width           =   1695
      End
      Begin VB.Label lblDescCanal 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   0
         Left            =   3405
         TabIndex        =   35
         Top             =   870
         Width           =   4575
      End
      Begin VB.Label LblCanal 
         Caption         =   "*Canal:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   255
         Left            =   120
         TabIndex        =   34
         Top             =   870
         WhatsThisHelpID =   5224
         Width           =   1695
      End
      Begin VB.Label lblDescRelEstado 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   7
         Left            =   3405
         TabIndex        =   33
         Top             =   2445
         Width           =   2055
      End
      Begin VB.Label lblTelCelular 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   9
         Left            =   3405
         TabIndex        =   31
         Top             =   1500
         Width           =   2055
      End
      Begin VB.Label lblDescCategoria 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   6
         Left            =   3405
         TabIndex        =   30
         Top             =   555
         Width           =   4575
      End
      Begin VB.Label lblDescProdBanc 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   5
         Left            =   3405
         TabIndex        =   29
         Top             =   240
         Width           =   4575
      End
      Begin VB.Label lblTitulo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Estado Relación:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Index           =   9
         Left            =   120
         TabIndex        =   27
         Top             =   2445
         WhatsThisHelpID =   5468
         Width           =   1545
      End
      Begin VB.Label lblRelEstado 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   3
         Left            =   2640
         TabIndex        =   16
         Top             =   2445
         Width           =   750
      End
      Begin VB.Label lblTitulo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Confirm. Nro. Tarjeta Debito:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Index           =   1
         Left            =   120
         TabIndex        =   26
         Top             =   2130
         WhatsThisHelpID =   5467
         Width           =   2535
      End
      Begin VB.Label lblTitulo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Producto Bancario:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Index           =   8
         Left            =   120
         TabIndex        =   25
         Top             =   240
         WhatsThisHelpID =   5463
         Width           =   1725
      End
      Begin VB.Label lblTitulo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Categoría:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Index           =   7
         Left            =   120
         TabIndex        =   24
         Top             =   555
         WhatsThisHelpID =   5464
         Width           =   990
      End
      Begin VB.Label lblTitulo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Teléfono Celular:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Index           =   5
         Left            =   120
         TabIndex        =   23
         Top             =   1500
         WhatsThisHelpID =   5465
         Width           =   1545
      End
      Begin VB.Label lblProdBanc 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   2
         Left            =   2640
         TabIndex        =   14
         Top             =   240
         Width           =   750
      End
      Begin VB.Label lblCategoria 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   300
         Index           =   1
         Left            =   2640
         TabIndex        =   15
         Top             =   555
         Width           =   750
      End
      Begin VB.Label lblTitulo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Nro. Tarjeta Débito:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C00000&
         Height          =   195
         Index           =   2
         Left            =   120
         TabIndex        =   22
         Top             =   1815
         WhatsThisHelpID =   5466
         Width           =   1785
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   12
      Top             =   5865
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
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   9
      Tag             =   "745"
      Top             =   3570
      WhatsThisHelpID =   2031
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
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
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   8
      Top             =   2805
      WhatsThisHelpID =   2030
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Crear"
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
      Height          =   870
      Left            =   75
      TabIndex        =   17
      TabStop         =   0   'False
      Top             =   1575
      Width           =   8145
      _Version        =   65536
      _ExtentX        =   14367
      _ExtentY        =   1535
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
      Index           =   3
      Left            =   8415
      TabIndex        =   7
      Top             =   255
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2040
      TabIndex        =   1
      Top             =   480
      Width           =   2535
      _ExtentX        =   4471
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   11
      Top             =   5100
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Index           =   5
      Left            =   8415
      TabIndex        =   10
      Top             =   4320
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
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
   Begin VB.Label lblProducto 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   195
      Index           =   10
      Left            =   90
      TabIndex        =   32
      Top             =   120
      WhatsThisHelpID =   5048
      Width           =   915
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   120
      X2              =   8355
      Y1              =   2520
      Y2              =   2505
   End
   Begin VB.Label lblPropietarios 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propietarios"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   20
      Top             =   1320
      WhatsThisHelpID =   5055
      Width           =   1095
   End
   Begin VB.Label lblNomCuenta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   195
      Index           =   6
      Left            =   75
      TabIndex        =   19
      Top             =   840
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Label lblCuenta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   195
      Index           =   0
      Left            =   75
      TabIndex        =   18
      Top             =   480
      WhatsThisHelpID =   5254
      Width           =   1365
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8325
      Y1              =   1200
      Y2              =   1200
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8355
      X2              =   8355
      Y1              =   15
      Y2              =   6600
   End
   Begin VB.Label lblCuentaDesc 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   2040
      TabIndex        =   13
      Top             =   840
      UseMnemonic     =   0   'False
      Width           =   6195
   End
End
Attribute VB_Name = "FRelCtaCanal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FRelCtaCanal.frm
' NOMBRE LOGICO:    FRelCtaCanal
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
' Esta forma permite realizar la reapertura de una cuenta de
' ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 05-Ago-13      I. Berganza        Emisión Inicial
'*************************************************************
Option Explicit
Dim VTCodigo As String
Dim VLTelCelular As String
Dim VLTelCelularold As String

Dim VLIdentificacion As String
Dim VLTarjetaDebito As String
Dim VLEstado As String
Dim VLCanal As String
Dim VLCuenta As String
Dim VLSecuencial As Integer
Dim VLMotivo As String

Dim VLSubtipo As String
Dim VLSubtipoRx As String
Dim VLDescSubtipo As String
Dim VTNumeroMensaje As String
Dim VLRespuesta As Integer



Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Crear

        PLCrear
    Case 1
        'Actualizar
        
        PLActualizar
    Case 2
        'Salir
        
        Unload FRelCtaCanal
    Case 3
        PLBuscar
        
    Case 4
        'Limpiar
        
        PLLimpiar
    Case 5
        'Eliminar
        
        PLEliminar
    End Select
End Sub

Private Sub PLCrear()
    'Numero de Cuenta de Ahorros
    If Trim$(mskCuenta.ClipText) = "" Then
        MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If
    
    If Trim$(txtTelCelular.Text) = "" Then
        MsgBox "Telefono Celular requerido. Favor ingresar nuevamente", 0 + 16, "Mensaje de Error"
        txtTelCelular.SetFocus
        lblTelCelular(9).Caption = ""
        Exit Sub
    End If
    
    If Trim$(txtCanal.Text) = "" Then
        MsgBox "Canal requerido. Favor ingresar nuevamente", 0 + 16, "Mensaje de Error"
        txtCanal.SetFocus
        lblDescCanal(0).Caption = ""
        Exit Sub
    End If
    
    If Trim$(txtTarjetaDebito.Text) <> "" And Trim$(txtConfirmaTarjDeb.Text) = "" Then
        MsgBox "Confirmación de Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
        txtConfirmaTarjDeb.SetFocus
        Exit Sub
    End If
    
    If Trim$(txtConfirmaTarjDeb.Text) <> "" And Trim$(txtTarjetaDebito.Text) = "" Then
        MsgBox "Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
        txtTarjetaDebito.SetFocus
        Exit Sub
    End If
    
    If txtCanal = "TAR" Then
        If Len(txtTarjetaDebito.Text) < 16 Or Len(txtTarjetaDebito.Text) > 19 Then
            MsgBox "Longitud de Nro. de Tartjeta No Válida. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
            txtTarjetaDebito.Text = ""
            txtConfirmaTarjDeb.Text = ""
            txtTarjetaDebito.SetFocus
        End If
    End If
    
    If txtConfirmaTarjDeb.Text <> "" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim$(txtTarjetaDebito.Text) <> Trim$(txtConfirmaTarjDeb.Text) Then
            MsgBox "Confirmación de Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
            txtConfirmaTarjDeb.Text = ""
            txtConfirmaTarjDeb.SetFocus
        End If
    End If
        
    'Guardar el codigo del propietario
    grdPropietarios.Col = 1
    VTCodigo = grdPropietarios.Text
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "744"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "I"
    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_cliente", 0, SQLVARCHAR, VTCodigo
    PMPasoValores sqlconn&, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Caption
    PMPasoValores sqlconn&, "@i_canal", 0, SQLVARCHAR, (txtCanal.Text)
    PMPasoValores sqlconn&, "@i_tarj_debito", 0, SQLVARCHAR, (txtTarjetaDebito.Text)
    PMPasoValores sqlconn&, "@i_confir_tarj_debito", 0, SQLVARCHAR, (txtConfirmaTarjDeb.Text)
    PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Ingresado") Then
        PMChequea sqlconn&
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        VTNumeroMensaje$ = Trim$(FmMapeaNumMensaje())
        If VTNumeroMensaje$ = "" Then
            MsgBox "Relación Cuenta - Canal ingresada Correctamente", vbInformation
        End If
    Else
        Exit Sub
    End If
    PLBuscar
    PLLimpiar_Eliminar
End Sub


Private Sub PLActualizar()
    'Numero de Cuenta de Ahorros
    If Trim$(mskCuenta.ClipText) = "" Then
        MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If
    
    If Trim$(txtTelCelular.Text) = "" Then
        MsgBox "Telefono Celular requerido. Favor ingresar nuevamente", 0 + 16, "Mensaje de Error"
        txtTelCelular.SetFocus
        lblTelCelular(9).Caption = ""
        Exit Sub
    End If
    
    If Trim$(txtCanal.Text) = "" Then
        MsgBox "Canal requerido. Favor ingresar nuevamente", 0 + 16, "Mensaje de Error"
        txtCanal.SetFocus
        lblDescCanal(0).Caption = ""
        Exit Sub
    End If
    
    If Trim$(txtMotivo.Text) = "" Then
        MsgBox "Motivo requerido. Favor ingresar nuevamente", 0 + 16, "Mensaje de Error"
        txtMotivo.SetFocus
        lblDescMotivo.Caption = ""
        Exit Sub
    End If
    
    If txtCanal.Text <> "CB" Then
        If txtConfirmaTarjDeb <> "" Then
            If Trim$(txtTarjetaDebito.Text) <> "" And Trim$(txtConfirmaTarjDeb.Text) = "" Then
                MsgBox "Confirmación de Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
                txtConfirmaTarjDeb.SetFocus
                Exit Sub
            End If
        
            If Trim$(txtConfirmaTarjDeb.Text) <> "" And Trim$(txtTarjetaDebito.Text) = "" Then
                MsgBox "Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
                txtConfirmaTarjDeb.SetFocus
                Exit Sub
            End If
        End If
    Else
        If txtMotivo.Text = "03" Then
            MsgBox "Motivo de eliminacion no corresponde al canal seleccionado", 0 + 16, "Mensaje de Error"
            txtMotivo.Text = ""
            lblDescMotivo.Caption = ""
            txtMotivo.SetFocus
            Exit Sub
        End If
    End If
    
    'Guardar el codigo del propietario
    grdPropietarios.Col = 1
    VTCodigo = grdPropietarios.Text
    
    grdRelacionCanal.Col = 7
    VLTelCelularold = grdRelacionCanal.Text
    
    'REQ 371 Tarjeta Debito
    TxtNuevaTarjeta.Text = ""
    'REQ 371 se cambio la condicion "REX" a "03" para q pudiera ser desplegada la pantalla de REEXPEDICION
    If txtMotivo.Text = "03" And txtCanal.Text <> "CB" Then
                If lblRelEstado(3).Caption <> "V" Then
            MsgBox "La Relación Cuenta - Canal debe estar en estado Vigente", vbCritical
            Exit Sub
        End If
        FREEXPEDIR.Show
        FREEXPEDIR.txtTarjetaDebito.Text = ""
        FREEXPEDIR.txtConfirmaTarjDeb.Text = ""
    Else
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "745"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "U"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_cliente", 0, SQLVARCHAR, VTCodigo
        PMPasoValores sqlconn&, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Caption
        PMPasoValores sqlconn&, "@i_tel_celular_old", 0, SQLVARCHAR, VLTelCelularold
        PMPasoValores sqlconn&, "@i_canal", 0, SQLVARCHAR, (txtCanal.Text)
        PMPasoValores sqlconn&, "@i_tarj_debito", 0, SQLVARCHAR, (txtTarjetaDebito.Text)
        PMPasoValores sqlconn&, "@i_confir_tarj_debito", 0, SQLVARCHAR, (txtConfirmaTarjDeb.Text)
        PMPasoValores sqlconn&, "@i_motivo", 0, SQLVARCHAR, (txtMotivo.Text)
        PMPasoValores sqlconn&, "@i_estado", 0, SQLVARCHAR, (lblRelEstado(3).Caption)
        PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Ingresado") Then
            PMChequea sqlconn&
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            VTNumeroMensaje$ = Trim$(FmMapeaNumMensaje())
            If VTNumeroMensaje$ = "" Then
                MsgBox "Relación Cuenta - Canal actualizada Correctamente", vbInformation
            End If
        Else
            Exit Sub
        End If
        PLBuscar
        PLLimpiar_Eliminar
        cmdResetClave.Enabled = False
        cmdBoton(0).Enabled = False
    End If
End Sub

Private Sub PLBuscar()
    If mskCuenta.ClipText <> "" Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "747"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, " Ok... Consulta de la cuenta") Then
            PMMapeaGrid sqlconn&, grdRelacionCanal, False
            PMChequea sqlconn&
            cmdBoton(0).Enabled = True
            cmdBoton(1).Enabled = False
            cmdBoton(5).Enabled = False
            PLAjustaGrid grdRelacionCanal, Me
        Else
            Exit Sub
        End If
        grdRelacionCanal.Col = 0
        grdRelacionCanal.ColWidth(10) = 1
    Else
        MsgBox "El numero de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
        PLLimpiar
        mskCuenta.SetFocus
    End If
End Sub

Private Sub PLEliminar()
    If VLIdentificacion <> "" Then
        'Guardar el codigo del propietario
        grdPropietarios.Col = 1
        VTCodigo = grdPropietarios.Text
    
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "746"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Caption
        PMPasoValores sqlconn&, "@i_cliente", 0, SQLVARCHAR, VTCodigo
        PMPasoValores sqlconn&, "@i_canal", 0, SQLVARCHAR, (txtCanal.Text)
        PMPasoValores sqlconn&, "@i_tarj_debito", 0, SQLVARCHAR, (txtTarjetaDebito.Text)
        PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo
        grdRelacionCanal.Col = 1
        VLCanal = grdRelacionCanal.Text
        grdRelacionCanal.Col = 6
        VLCuenta = grdRelacionCanal.Text
        VLRespuesta% = MsgBox("Desea eliminar el registro del canal " + VLCanal + " para la cuenta " + VLCuenta + " ? ", 1 + 32 + 256, "Eliminar Registros")
        If VLRespuesta% = 2 Then
            Exit Sub
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "OK Eliminación de Registro") Then
            PMChequea sqlconn&
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            VTNumeroMensaje$ = Trim$(FmMapeaNumMensaje())
            If VTNumeroMensaje$ = "" Then
                MsgBox "Relación Cuenta - Canal Eliminada Correctamente", vbInformation
            End If
            PLBuscar
            PLLimpiar_Eliminar
            cmdBoton(1).Enabled = False
            cmdBoton(5).Enabled = False
            cmdResetClave.Enabled = False
            cmdBoton(0).Enabled = False
        Else
            Exit Sub
        End If
    Else
        MsgBox "Registro a eliminarse no seleccionado", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
End Sub

Private Sub PLLimpiar()
    'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
    'lblCuentaDesc(0).Caption = ""
    'PMLimpiaGrid grdPropietarios
    PMLimpiaGrid grdRelacionCanal
    cmdBoton(0).Enabled = True
    cmdResetClave.Enabled = False
    cmdBoton(1).Enabled = False
    cmdBoton(5).Enabled = False
    'lblDescProdBanc(5).Caption = ""
    'lblDescCategoria(6).Caption = ""
    'lblProdBanc(2).Caption = ""
    'lblCategoria(1).Caption = ""
    lblTelCelular(9).Caption = ""
    lblRelEstado(3).Caption = ""
    lblDescRelEstado(7).Caption = ""
    txtTelCelular.Text = ""
    txtTarjetaDebito.Text = ""
    txtConfirmaTarjDeb.Text = ""
    txtCanal.Text = ""
    lblDescCanal(0).Caption = ""
    txtMotivo.Text = ""
    lblDescMotivo.Caption = ""
    txtMotivo.Enabled = False
    txtCanal.Enabled = True
    TxtNuevaTarjeta.Text = ""
    txtCanal.SetFocus
    'mskCuenta.SetFocus
End Sub

Private Sub PLLimpiar_Eliminar()
    'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
    'lblCuentaDesc(0).Caption = ""
    'PMLimpiaGrid grdPropietarios
    cmdBoton(0).Enabled = True
    cmdResetClave.Enabled = False
    cmdBoton(1).Enabled = False
    cmdBoton(5).Enabled = False
    'lblDescProdBanc(5).Caption = ""
    'lblDescCategoria(6).Caption = ""
    'lblProdBanc(2).Caption = ""
    'lblCategoria(1).Caption = ""
    lblTelCelular(9).Caption = ""
    lblRelEstado(3).Caption = ""
    lblDescRelEstado(7).Caption = ""
    txtTelCelular.Text = ""
    txtTarjetaDebito.Text = ""
    txtConfirmaTarjDeb.Text = ""
    txtCanal.Text = ""
    lblDescCanal(0).Caption = ""
    txtMotivo.Text = ""
    lblDescMotivo.Caption = ""
    txtMotivo.Enabled = False
    txtCanal.Enabled = True
    txtCanal.SetFocus
    'mskCuenta.SetFocus
End Sub

Private Sub cmdResetClave_Click()
    VLRespuesta% = MsgBox("En realidad desea Generar Nueva Clave al registro seleccionado ? ", 1 + 32 + 256, "Generar Clave")
    If VLRespuesta% = 2 Then
        Exit Sub
    End If
    
    'Guardar el codigo del propietario
    grdPropietarios.Col = 1
    VTCodigo = grdPropietarios.Text
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "748"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "V"
    PMPasoValores sqlconn&, "@i_cliente", 0, SQLVARCHAR, VTCodigo
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Ingresado") Then
        PMChequea sqlconn&
    Else
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "749"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "P"
    PMPasoValores sqlconn&, "@i_cliente", 0, SQLVARCHAR, VTCodigo
    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    PMPasoValores sqlconn&, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Caption
    PMPasoValores sqlconn&, "@i_canal", 0, SQLVARCHAR, (txtCanal.Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Ingresado") Then
        PMChequea sqlconn&
        MsgBox "Clavemía restablecida exitosamente", vbInformation + vbOKOnly
    Else
        MsgBox "No se pudo reestablecer la clavemía", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
    PLLimpiar
End Sub

Private Sub Form_Load()
    FRelCtaCanal.Left = 0
    FRelCtaCanal.Top = 0
    FRelCtaCanal.Width = 9420
    FRelCtaCanal.Height = 7140
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbProducto.AddItem "4 - CUENTA DE AHORROS"
    'cmbProducto.AddItem "3 - CUENTA CORRIENTE"
    cmbProducto.ListIndex = 0
    mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho$)
    mskCuenta.Enabled = False
    cmbProducto.Enabled = False
    txtTarjetaDebito.Enabled = False
    txtConfirmaTarjDeb.Enabled = False
       
    If cmbProducto.Text = "3 - CUENTA CORRIENTE" Then
        mskCuenta.Mask = VGMascaraCtaCte$
    Else
        mskCuenta.Mask = VGMascaraCtaAho$
    End If
    mskCuenta_LostFocus
    ' Chequeo de Seguridades a nivel de Botón
End Sub

Private Sub grdRelacionCanal_Click()
    'Se deshabilita boton Actualizar para CB

    
    'Guardar el codigo de identificacion
    If grdRelacionCanal.Text <> "" Then
            
        grdRelacionCanal.Col = 1
        VLCanal = grdRelacionCanal.Text
        
        grdRelacionCanal.Col = 4
        VLIdentificacion = grdRelacionCanal.Text
        
        grdRelacionCanal.Col = 6
        VGCuenta = grdRelacionCanal.Text
        mskCuenta.Mask = VGMascaraCtaAho$
        mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho$)
        mskCuenta_LostFocus
        'txtCanal.SetFocus
        txtTelCelular.SetFocus
        
        grdRelacionCanal.Col = 7
        VLTelCelular = grdRelacionCanal.Text
        
        grdRelacionCanal.Col = 2
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        VLEstado = Mid$(grdRelacionCanal.Text, 1, 1)
        If VLEstado = "V" Then
           lblDescRelEstado(7).Caption = "VIGENTE"
        Else
           lblDescRelEstado(7).Caption = "ELIMINADO"
        End If
        
        
        grdRelacionCanal.Col = 8
        VLTarjetaDebito = grdRelacionCanal.Text
        
        grdRelacionCanal.Col = 1
        VLCanal = grdRelacionCanal.Text
        
        grdRelacionCanal.Col = 10
        VLSecuencial = grdRelacionCanal.Text
        
        grdRelacionCanal.Col = 9
        VLMotivo = grdRelacionCanal.Text
        
        grdRelacionCanal.Col = 14
        VLSubtipoRx = grdRelacionCanal.Text
        
        cmdBoton(0).Enabled = False
        

        
        lblTelCelular(9).Caption = VLTelCelular
        txtTelCelular.Text = VLSecuencial
        
        txtMotivo.Enabled = True
        
        txtCanal.Text = VLCanal
        txtCanal_LostFocus
                        
        txtTarjetaDebito.Text = VLTarjetaDebito
        lblRelEstado(3).Caption = VLEstado
        
        txtTarjetaDebito.Enabled = False
        txtConfirmaTarjDeb.Enabled = False
        txtCanal.Enabled = False
        
        PMBotonSeguridad FRelCtaCanal, 1
        
        'cmdBoton(1).Enabled = True
        'cmdBoton(5).Enabled = True
        grdRelacionCanal.Col = 2
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        VLEstado = Mid$(grdRelacionCanal.Text, 1, 1)
        
        If VLEstado = "V" Then
           cmdBoton(1).Enabled = True
           cmdBoton(5).Enabled = True
        Else
           cmdBoton(1).Enabled = False
           cmdBoton(5).Enabled = False
        End If
        
        If txtCanal = "CB" Then
        cmdBoton(1).Enabled = False
    End If
        
    End If
End Sub

Private Sub mskCuenta_GotFocus()
    If CInt(Mid$(cmbProducto.Text, 1, 1)) = 3 Then 'CUENTAS CORRIENTES
        FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta Corriente"
    Else
        FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    End If
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
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

Private Sub grdPropietarios_DblClick()
    'Guardar el codigo del propietario
    grdPropietarios.Col = 1
    VTCodigo = grdPropietarios.Text
End Sub

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub

Private Sub lblRelEstado_Click(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Estado de Relacion del canal"
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    Dim VTR1 As Integer
    If CInt(Mid$(cmbProducto.Text, 1, 1)) = 3 Then 'CUENTAS CORRIENTES
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblCuentaDesc(0)
                    PMMapeaObjeto sqlconn&, lblProdBanc(2)
                    PMMapeaObjeto sqlconn&, lblCategoria(1)
                    PMMapeaGrid sqlconn&, grdPropietarios, False
                    PMChequea sqlconn&
                    cmdBoton(0).Enabled = True
                Else
                    cmdBoton_Click (4)
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                cmdBoton_Click (4)
                Exit Sub
            End If
        End If
    Else
        'CUENTAS DE AHORROS
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblCuentaDesc(0)
                    PMChequea sqlconn&
                    'Para llenar los label
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
                    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                        ReDim VTArreglo(20) As String
                        VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                        lblProdBanc(2).Caption = VTArreglo(2)
                        lblDescProdBanc(5).Caption = VTArreglo(3)
                        'Invoca catalogo para extraer la categoria de la cuenta
                        lblCategoria(1).Caption = VTArreglo(15)
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
                        PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "Q"
                        PMPasoValores sqlconn&, "@i_cons_cta", 0, SQLCHAR, "S"
                        PMPasoValores sqlconn&, "@i_tipo_cta", 0, SQLVARCHAR, "AHO"
                        PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                        PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
                        PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, (lblCategoria(1).Caption)
                        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                            PMMapeaObjeto sqlconn&, lblDescCategoria(6)
                            PMChequea sqlconn&
                        End If
                    End If
                    cmdBoton(0).Enabled = True
                    PMLimpiaGrid grdPropietarios
                Else
                    cmdBoton_Click (4)
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                cmdBoton_Click (4)
                Exit Sub
            End If
            'Llena el grid de propietarios
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "298"
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
                PMMapeaGrid sqlconn&, grdPropietarios, False
                PMChequea sqlconn&
            Else
                PMLimpiaGrid grdPropietarios
                Exit Sub
            End If
        End If
    End If
End Sub

Private Sub txtCanal_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Canal [F5 Ayuda]"
End Sub

Private Sub txtCanal_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = 116 Then
        'Si se desea invocar todo el catalogo cl_canal
        txtCanal.Text = ""
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "ah_canal_relcta"
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCanal.Text = VGACatalogo.Codigo$
            lblDescCanal(0).Caption = VGACatalogo.Descripcion$
        End If
    End If
End Sub

Private Sub txtCanal_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
End Sub

Private Sub txtCanal_LostFocus()
    If txtCanal.Text <> "" Then
        PMCatalogo "V", "ah_canal_relcta", txtCanal, lblDescCanal(0)
        If txtCanal.Text = "CB" Then
            txtTarjetaDebito.Text = ""
            txtConfirmaTarjDeb.Text = ""
            txtTarjetaDebito.Enabled = False
            txtConfirmaTarjDeb.Enabled = False
        Else
            txtTarjetaDebito.Enabled = True
            txtConfirmaTarjDeb.Enabled = True
        End If
        
        If txtCanal.Text <> "CB" Then
            cmdResetClave.Enabled = False
            txtMotivo.Enabled = True
            txtMotivo.SetFocus
        Else
            cmdResetClave.Enabled = True
            txtMotivo.Enabled = False
        End If
        
    Else
        lblDescCanal(0).Caption = ""
    End If
    
End Sub

Private Sub txtConfirmaTarjDeb_GotFocus()
    'No permite hacer pegado de texto
    If txtTarjetaDebito.Text <> "" And txtConfirmaTarjDeb.Text <> "" Then
        Clipboard.Clear
        Clipboard.SetText ""
        FPrincipal!pnlHelpLine.Caption = " Confirmar Numero de tarjeta de debito"
    End If
End Sub

Private Sub txtConfirmaTarjDeb_KeyDown(Keycode As Integer, Shift As Integer)
    Call BorrarClipboard(Keycode, Shift, 0, False)
End Sub

Private Sub txtConfirmaTarjDeb_LostFocus()
If txtConfirmaTarjDeb.Text <> "" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtTarjetaDebito.Text) <> Trim$(txtConfirmaTarjDeb.Text) Then
        MsgBox "Confirmación de Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
        txtConfirmaTarjDeb.Text = ""
        txtConfirmaTarjDeb.SetFocus
    End If
End If
End Sub

Private Sub txtConfirmaTarjDeb_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call BorrarClipboard(0, 0, Button, True)
End Sub

Private Sub txtMotivo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Motivo [F5 Ayuda]"
End Sub

Private Sub txtMotivo_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = 116 Then
        'Si se desea invocar todo el catalogo cl_canal
        txtMotivo.Text = ""
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "re_novedades_enroll"
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtMotivo.Text = VGACatalogo.Codigo$
            lblDescMotivo.Caption = VGACatalogo.Descripcion$
            SendKeys "{TAB}"
        End If
    End If
End Sub

Private Sub txtMotivo_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
End Sub

Private Sub txtMotivo_LostFocus()
Dim VLProd As String
If txtMotivo.Text <> "" Then
    PMCatalogo "V", "re_novedades_enroll", txtMotivo, lblDescMotivo
    'Extraccion del motivo
    If txtCanal.Text = "TAR" Then
       
       'REQ 543-AJUSTE PARA CAMBIO DE CELULAR
       
       If txtMotivo.Text = "15" Then
          grdRelacionCanal.Col = 15
          VLSubtipo = grdRelacionCanal.Text
       Else
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4159"
          PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
          VLProd = Mid$(cmbProducto.Text, 1, 1)
          PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, VLProd
          PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, lblProdBanc(2).Caption
          PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText
          PMPasoValores sqlconn&, "@i_motivo", 0, SQLVARCHAR, txtMotivo.Text
        'Guardar el codigo del propietario
          grdPropietarios.Col = 1
          VTCodigo = grdPropietarios.Text
          PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, VTCodigo
          If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_std", True, "Ok..Creación de Producto") Then
             PMMapeaVariable sqlconn&, VLSubtipo
             PMMapeaVariable sqlconn&, VLDescSubtipo
             PMChequea sqlconn&
          End If
          If VLSubtipo = "XXX" Then
             MsgBox "No puede asignar una nueva tarjeta al cliente, porque tiene vigente el número máximo de tarjetas permitido para cuentas " + CStr(lblDescProdBanc(5).Caption), 0 + 16, "Mensaje de Advertencia"
          Else
             If VLSubtipo <> "" Then
                If txtMotivo.Text = "03" Then
                   MsgBox "Si va a realizar una REEXPEDICION de tarjeta débito por favor utilice una tarjeta del grupo de tarjetas " + CStr(VLDescSubtipo), vbInformation, "Mensaje de Advertencia"
                End If
                If txtMotivo.Text = "01" Then
                   MsgBox "Si va a realizar un NUEVO asocio de tarjeta débito por favor utilice una tarjeta del grupo de tarjetas " + CStr(VLDescSubtipo), vbInformation, "Mensaje de Advertencia"
                End If
             Else
                MsgBox "Código de Subtipo NO Parametrizado para Producto de Ahorros ", 0 + 16, "Mensaje de Error"
             End If
          End If
       End If
    End If
Else
    lblDescMotivo.Caption = ""
End If
End Sub

Private Sub TxtNuevaTarjeta_Change()
    'Req. 371 Tarjeta Debito
    
    If TxtNuevaTarjeta.Text <> "" Then
    
        'Guardar el codigo del propietario
        grdPropietarios.Col = 1
        VTCodigo = grdPropietarios.Text
   
        'Guardar el telefono anterior del propietario
        grdRelacionCanal.Col = 7
        VLTelCelularold = grdRelacionCanal.Text
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "745"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "U"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_cliente", 0, SQLVARCHAR, VTCodigo
        PMPasoValores sqlconn&, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Caption
        PMPasoValores sqlconn&, "@i_tel_celular_old", 0, SQLVARCHAR, VLTelCelularold
        PMPasoValores sqlconn&, "@i_canal", 0, SQLVARCHAR, (txtCanal.Text)
        PMPasoValores sqlconn&, "@i_tarj_debito", 0, SQLVARCHAR, (txtTarjetaDebito.Text)
        PMPasoValores sqlconn&, "@i_confir_tarj_debito", 0, SQLVARCHAR, (TxtNuevaTarjeta.Text)
        PMPasoValores sqlconn&, "@i_motivo", 0, SQLVARCHAR, (txtMotivo.Text)
        PMPasoValores sqlconn&, "@i_estado", 0, SQLVARCHAR, (lblRelEstado(3).Caption)
                PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Ingresado") Then
            PMChequea sqlconn&
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            VTNumeroMensaje$ = Trim$(FmMapeaNumMensaje())
            If VTNumeroMensaje$ = "" Then
                MsgBox "Relación Cuenta - Canal actualizada Correctamente", vbInformation
            End If
        Else
            Exit Sub
        End If
        PLBuscar
        PLLimpiar_Eliminar
    Else
        Exit Sub
    End If
End Sub

Private Sub txtTarjetaDebito_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Numero de tarjeta de debito"
End Sub
'FIXIT: Declare 'BorrarClipboard' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
Sub BorrarClipboard(CodTecla As Integer, CtrlAltShift As Integer, BotonMouse As Integer, ClickMouse As Boolean)
    If ClickMouse = False Then
        If CodTecla = vbKeyInsert And CtrlAltShift = 1 Then
            Clipboard.Clear
            ElseIf CodTecla = vbKeyV And CtrlAltShift = 2 Then
            Clipboard.Clear
        End If
        Else
        If BotonMouse = 2 Then Clipboard.Clear
    End If
End Sub

Private Sub txtTarjetaDebito_KeyDown(Keycode As Integer, Shift As Integer)
    Call BorrarClipboard(Keycode, Shift, 0, False)
End Sub

Private Sub txtTarjetaDebito_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtConfirmaTarjDeb_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub


Private Sub txtTarjetaDebito_LostFocus()
    If txtTarjetaDebito.Text <> "" Then
        If Len(txtTarjetaDebito.Text) < 16 Or Len(txtTarjetaDebito.Text) > 19 Then
            MsgBox "Longitud de Nro. de Tartjeta No Válida. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
            txtTarjetaDebito.Text = ""
            txtConfirmaTarjDeb.Text = ""
            txtTarjetaDebito.SetFocus
        End If
    End If
End Sub

Private Sub txtTarjetaDebito_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call BorrarClipboard(0, 0, Button, True)
End Sub

Private Sub txtTelCelular_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Numero de telefono celular del cliente [F5 Ayuda]"
End Sub

Private Sub txtTelCelular_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = 116 Then
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "747"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
    PMPasoValores sqlconn&, "@i_tipo_id", 0, SQLVARCHAR, VGTipoDocValidado
    PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLVARCHAR, VGNumDocValidado
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, " Ok... Consulta de telefonos celulares") Then
        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
        PMChequea sqlconn&
        FCatalogo.Show 1
        txtTelCelular.Text = VGACatalogo.Codigo$
        lblTelCelular(9).Caption = VGACatalogo.Descripcion$
    End If
    Else
        MsgBox "Numero de telefono celular del cliente [F5 Ayuda]", 0 + 16, "Mensaje de Error"
        txtTelCelular.Text = ""
        txtTelCelular.SetFocus
    End If
End Sub

Private Sub txtTelCelular_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub cmbProducto_Change()
  'mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
  'lblCuentaDesc(0).Caption = ""
End Sub

Private Sub cmbProducto_Click()
  'mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
  'lblCuentaDesc(0).Caption = ""
End Sub

Private Sub cmbProducto_GotFocus()
  FPrincipal!pnlHelpLine.Caption = " Producto Cobis"
End Sub

Private Sub txtTelCelular_LostFocus()
    If txtTelCelular.Text = "" Then
        lblTelCelular(9).Caption = ""
    End If
End Sub



