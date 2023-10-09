VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{39EB654A-9F9F-11D4-BD09-000102BF5D0F}#1.10#0"; "Map60.ocx"
Begin VB.MDIForm FPrincipal 
   Appearance      =   0  'Flat
   BackColor       =   &H8000000F&
   Caption         =   "C.O.B.I.S - PERSONALIZACION"
   ClientHeight    =   6345
   ClientLeft      =   510
   ClientTop       =   1890
   ClientWidth     =   9465
   HelpContextID   =   1
   Icon            =   "FPRINCIP.frx":0000
   LinkTopic       =   "MDIForm1"
   Begin Threed.SSPanel pnlBarraAyuda 
      Align           =   1  'Align Top
      Height          =   345
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   9465
      _Version        =   65536
      _ExtentX        =   16695
      _ExtentY        =   609
      _StockProps     =   15
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
      BorderWidth     =   0
      BevelInner      =   2
      Begin COBISMap60.Map32 Map 
         Height          =   135
         Left            =   1680
         Top             =   120
         Width           =   375
         _ExtentX        =   661
         _ExtentY        =   238
      End
      Begin VB.ComboBox cmbFilial 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   5625
         TabIndex        =   2
         Text            =   "cmbFilial"
         Top             =   45
         Visible         =   0   'False
         Width           =   3780
      End
      Begin VB.OptionButton gpbHelp 
         Height          =   330
         Left            =   1035
         Picture         =   "FPRINCIP.frx":030A
         Style           =   1  'Graphical
         TabIndex        =   13
         Top             =   15
         Visible         =   0   'False
         Width           =   375
      End
      Begin VB.Timer tmrHora 
         Interval        =   60000
         Left            =   330
         Top             =   0
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Filial:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   4800
         TabIndex        =   10
         Top             =   45
         Visible         =   0   'False
         Width           =   465
      End
      Begin VB.Label lblMoneda 
         Appearance      =   0  'Flat
         BackStyle       =   0  'Transparent
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   270
         Index           =   0
         Left            =   1095
         TabIndex        =   12
         Top             =   45
         Visible         =   0   'False
         Width           =   4365
      End
   End
   Begin Threed.SSPanel pnlBarraMensajes 
      Align           =   2  'Align Bottom
      Height          =   345
      Left            =   0
      TabIndex        =   0
      Top             =   6000
      Width           =   9465
      _Version        =   65536
      _ExtentX        =   16695
      _ExtentY        =   609
      _StockProps     =   15
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
      BorderWidth     =   1
      Begin Threed.SSPanel pnlTransaccionLine 
         Height          =   255
         Left            =   4230
         TabIndex        =   11
         Top             =   45
         Width           =   3660
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         Alignment       =   1
      End
      Begin Threed.SSPanel Focos 
         Height          =   135
         Index           =   3
         Left            =   9180
         TabIndex        =   8
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "P"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   0
         BorderWidth     =   0
         BevelOuter      =   0
         Outline         =   -1  'True
         FloodType       =   1
         FloodColor      =   65280
         FloodShowPct    =   0   'False
      End
      Begin Threed.SSPanel Focos 
         Height          =   135
         Index           =   2
         Left            =   8970
         TabIndex        =   7
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "R"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   0
         BorderWidth     =   0
         BevelOuter      =   0
         Outline         =   -1  'True
         FloodType       =   1
         FloodColor      =   65280
         FloodShowPct    =   0   'False
      End
      Begin Threed.SSPanel Focos 
         Height          =   135
         Index           =   1
         Left            =   8760
         TabIndex        =   6
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "T"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   0
         BorderWidth     =   0
         BevelOuter      =   0
         Outline         =   -1  'True
         FloodType       =   1
         FloodColor      =   65280
         FloodShowPct    =   0   'False
      End
      Begin Threed.SSPanel Focos 
         Height          =   135
         Index           =   0
         Left            =   8550
         TabIndex        =   5
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "L"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   0
         BorderWidth     =   0
         BevelOuter      =   0
         Outline         =   -1  'True
         FloodType       =   1
         FloodColor      =   65280
         FloodShowPct    =   0   'False
      End
      Begin Threed.SSPanel pnlHora 
         Height          =   255
         Left            =   7905
         TabIndex        =   3
         Top             =   45
         Width           =   555
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
      End
      Begin Threed.SSPanel pnlHelpLine 
         Height          =   255
         Left            =   90
         TabIndex        =   1
         Top             =   45
         Width           =   4125
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   24
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         Alignment       =   1
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         Caption         =   " L   T   R  P"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   120
         Left            =   8535
         TabIndex        =   9
         Top             =   30
         Width           =   870
      End
   End
   Begin VB.Menu mnuConexion 
      Caption         =   "Cone&xión"
      Begin VB.Menu mnuLogon 
         Caption         =   "Log o&n"
      End
      Begin VB.Menu mnuLogoff 
         Caption         =   "Log o&ff"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuLinea1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCambioPass 
         Caption         =   "&Cambiar Password"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuPreferencias 
         Caption         =   "Preferencias"
      End
      Begin VB.Menu mnuLinea12 
         Caption         =   "-"
      End
      Begin VB.Menu mnuBloquear 
         Caption         =   "Bloquear Terminal"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuLinea2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSalir 
         Caption         =   "&Salir"
         Shortcut        =   ^S
      End
   End
   Begin VB.Menu mnuProductos 
      Caption         =   "&Productos"
      Enabled         =   0   'False
      Tag             =   "4002;4006;4101;4093;4097;4122"
      Begin VB.Menu mnuTranProd 
         Caption         =   "Productos Bancarios"
         Enabled         =   0   'False
         Index           =   0
         Tag             =   "4002"
      End
      Begin VB.Menu mnuTranProd 
         Caption         =   "Mercado"
         Enabled         =   0   'False
         Index           =   1
         Tag             =   "4006"
      End
      Begin VB.Menu mnuTranProd 
         Caption         =   "Productos Finales"
         Enabled         =   0   'False
         Index           =   2
         Tag             =   "4122"
      End
      Begin VB.Menu mnuTranProd 
         Caption         =   "Categorías por Producto Final"
         Enabled         =   0   'False
         Index           =   3
         Tag             =   "4101"
      End
      Begin VB.Menu mnuTranProd 
         Caption         =   "Tipo de Capitalización por Producto Final"
         Enabled         =   0   'False
         HelpContextID   =   1020
         Index           =   4
         Tag             =   "4093"
      End
      Begin VB.Menu mnuTranProd 
         Caption         =   "Ciclos por Producto Final"
         Enabled         =   0   'False
         HelpContextID   =   1021
         Index           =   5
         Tag             =   "4097"
      End
      Begin VB.Menu mnuProCont 
         Caption         =   "Caracteristicas Especiales"
         Enabled         =   0   'False
         Index           =   6
         Tag             =   "4143"
      End
      Begin VB.Menu mnuTranCaja 
         Caption         =   "Autorización de Transacciones en Caja"
         Enabled         =   0   'False
         Tag             =   "728;729;730;731"
      End
      Begin VB.Menu mnuParametros 
         Caption         =   "Parámetros"
         Begin VB.Menu mnuTopesOfi 
            Caption         =   "Topes de Retiro por Canal"
            Index           =   1
            Tag             =   "4129"
         End
         Begin VB.Menu mnuTopesOfi 
            Caption         =   "Parametro Extracto Cuenta"
            Index           =   2
            Tag             =   "4138"
         End
      End
   End
   Begin VB.Menu mnuRango 
      Caption         =   "&Rangos"
      Enabled         =   0   'False
      Tag             =   "4034;4037"
      Begin VB.Menu mnuRangos 
         Caption         =   "Tipo Rango"
         Enabled         =   0   'False
         Index           =   0
         Tag             =   "4034"
      End
      Begin VB.Menu mnuRangos 
         Caption         =   "Rango"
         Enabled         =   0   'False
         Index           =   1
         Tag             =   "4037"
      End
   End
   Begin VB.Menu mnuServicios 
      Caption         =   "&Servicios"
      Enabled         =   0   'False
      Tag             =   "4029;4017;4013;4109"
      Begin VB.Menu mnuTranServ 
         Caption         =   "Servicios Disponibles"
         Enabled         =   0   'False
         Index           =   0
         Tag             =   "4029"
      End
      Begin VB.Menu mnuTranServ 
         Caption         =   "Servicios Básicos"
         Enabled         =   0   'False
         Index           =   1
         Tag             =   "4040;4041;4042;4031;4012;4045"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuTranServ 
         Caption         =   "Servicios Contratados"
         Enabled         =   0   'False
         Index           =   2
         Tag             =   "4019;4020;4021;4022"
         Visible         =   0   'False
      End
      Begin VB.Menu mnuTranServ 
         Caption         =   "-"
         Index           =   3
      End
      Begin VB.Menu mnuTranServ 
         Caption         =   "Rubros de Servicios"
         Enabled         =   0   'False
         Index           =   5
         Tag             =   "4017"
      End
      Begin VB.Menu mnuTranServ 
         Caption         =   "Servicios Personalizables"
         Enabled         =   0   'False
         Index           =   6
         Tag             =   "4013"
      End
      Begin VB.Menu mnuTranServ 
         Caption         =   "Cobro de Comisiones"
         Enabled         =   0   'False
         Index           =   7
         Tag             =   "4109"
      End
   End
   Begin VB.Menu mnuCostos 
      Caption         =   "&Valores"
      Enabled         =   0   'False
      Tag             =   "4059;4082;4083;4084;4086;4020;4116;4118;4070;4072;4073"
      Begin VB.Menu mnuTranCos 
         Caption         =   "Valor de Servicio"
         Index           =   1
         Tag             =   "4059;4082;4083;4084;4086;4020;4116;4118"
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Mantenimiento"
            Enabled         =   0   'False
            Index           =   0
            Tag             =   "4020"
         End
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Mantenimiento en Línea"
            Enabled         =   0   'False
            Index           =   1
            Tag             =   "4116"
         End
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Mantenimiento masivo"
            Enabled         =   0   'False
            Index           =   2
            Tag             =   "4082"
         End
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Consulta de Valores Vigentes"
            Enabled         =   0   'False
            Index           =   3
            Tag             =   "4052"
            Visible         =   0   'False
         End
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Consulta de Próximos Valores Vigentes"
            Enabled         =   0   'False
            Index           =   4
            Tag             =   "4118"
         End
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Consulta de Valores en Línea"
            Enabled         =   0   'False
            Index           =   5
            Tag             =   "4083"
         End
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Consulta de Próximos Valores en Línea"
            Enabled         =   0   'False
            Index           =   6
            Tag             =   "4084"
         End
         Begin VB.Menu mnuTranCos1 
            Caption         =   "Consulta histórica de costos y tasas"
            Enabled         =   0   'False
            Index           =   7
            Tag             =   "4086"
         End
      End
      Begin VB.Menu mnuTranCos 
         Caption         =   "Personalización de Valores"
         Index           =   2
         Tag             =   "4070;4072;4073"
         Begin VB.Menu mnuTranCos0 
            Caption         =   "Contratación de Servicios"
            Index           =   0
            Tag             =   "4070"
            Visible         =   0   'False
         End
         Begin VB.Menu mnuTranCos0 
            Caption         =   "Personalización de Cuenta"
            Enabled         =   0   'False
            Index           =   1
            Tag             =   "4072"
         End
         Begin VB.Menu mnuTranCos0 
            Caption         =   "Consulta de Personalización"
            Enabled         =   0   'False
            Index           =   2
            Tag             =   "4073"
         End
      End
   End
   Begin VB.Menu mnuValoresEsp 
      Caption         =   "V&alores Especiales"
      Enabled         =   0   'False
      Tag             =   "4086;4089;4091"
      Visible         =   0   'False
      Begin VB.Menu mnucostoesp 
         Caption         =   "Definición de Costos"
         Enabled         =   0   'False
         Index           =   0
         Tag             =   "4086"
      End
      Begin VB.Menu mnucostoesp 
         Caption         =   "Personalización de Costos"
         Enabled         =   0   'False
         Index           =   1
         Tag             =   "4089"
      End
      Begin VB.Menu mnucostoesp 
         Caption         =   "Mantenimiento de Costos"
         Enabled         =   0   'False
         Index           =   2
         Tag             =   "4091"
      End
   End
   Begin VB.Menu mnuVentana 
      Caption         =   "V&entanas"
      WindowList      =   -1  'True
      Begin VB.Menu mnuBarraAyuda 
         Caption         =   "Barra de Ayuda"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuBarraMensajes 
         Caption         =   "Barra de Mensajes"
         Checked         =   -1  'True
      End
      Begin VB.Menu mnuGuion1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCascada 
         Caption         =   "Cascada"
      End
      Begin VB.Menu mnuHorizontal 
         Caption         =   "Horizontal"
      End
      Begin VB.Menu mnuVertical 
         Caption         =   "Vertical"
      End
      Begin VB.Menu mnuIconos 
         Caption         =   "Iconos"
      End
      Begin VB.Menu mnuGuion2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSizetoFit 
         Caption         =   "Ajustar Ventana"
      End
   End
   Begin VB.Menu mnuAyuda 
      Caption         =   "A&yuda"
      Begin VB.Menu mnuContenido 
         Caption         =   "Contenido"
         Enabled         =   0   'False
      End
      Begin VB.Menu mnuLinea17 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAcerca 
         Caption         =   "Acerca de ..."
      End
   End
End
Attribute VB_Name = "FPrincipal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLDescargar As Boolean
'-------------------------------------------
' Control de tiempo para timeout de conexion
Public WithEvents VGHook As COBISTools.IdleTimeout
Attribute VGHook.VB_VarHelpID = -1
Public VGTipoDesconexion As Boolean
'-------------------------------------------
Private Sub cmbFilial_Click()
Dim VTPos%
Dim VTFilial$
    VTPos% = InStr(1, cmbFilial.Text, "-", 0)
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    VTFilial$ = Mid$(cmbFilial.Text, 1, VTPos% - 1)
    If VTFilial$ <> VGFilial$ Then
        VGFilial$ = VTFilial$
    End If
End Sub

Private Sub cmbFilial_KeyPress(KeyAscii As Integer)
    KeyAscii% = 0
End Sub

Private Sub MDIForm_Activate()
If VLDescargar Then
    Unload Me
End If
End Sub

Private Sub MDIForm_Load()
Dim VGPrefDBError%
Dim VGPrefDBMensaje%
Dim VGPathImagen$
Dim VLDebug$
Set VGMap = Map
Set VGMap = Map
    PMFormCloseAll_Salir
    VGPrefDBError% = False
    VGPrefDBMensaje% = True
    Call PMDireccionPath
    VGPath$ = PathUnico
    ARCHIVOINI = VGPath$ & "\person.ini"
    FPrincipal.Focos(0).FloodPercent = 100
    FPrincipal.Focos(1).FloodPercent = 0
    FPrincipal.Focos(2).FloodPercent = 0
    FPrincipal.Focos(3).FloodPercent = 0
    FPrincipal.Left = 15
    FPrincipal.Top = 15
    FPrincipal.Width = 9570
    FPrincipal.Height = 7140
    VGTeclaAyuda% = 116
    Iniciar_Preferencias ARCHIVOINI
    VGLogTransacciones$ = Get_Preferencia("ARCHIVO-LOG")
    VGPathImagen$ = Get_Preferencia("IMAGENES")
    VGFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    PMCargar_FechaSP (VGFormatoFecha)
    VLDebug$ = Get_Preferencia("DEBUG")
    If VLDebug$ = "S" Then VGDebug% = True Else VGDebug% = False
    If VGPathImagen$ = "" Then
        VGPathImagen$ = "c:\cobis"
        Set_Preferencia "IMAGENES", "c:\cobis"
        Set_Forma_Preferencia "IMAGENES", "c:\cobis"
    End If
 FMInitMap Me.pnlHelpLine, FPrincipal.pnlTransaccionLine, FPrincipal.Focos(0), FPrincipal.Focos(1), FPrincipal.Focos(2), FPrincipal.Focos(3), VGLogTransacciones$
    Forma_Preferencias
    VLDescargar = False
    If Not FMVerificar_WinIni() Then
        VLDescargar = True
    End If
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
Dim VTTemporal$
     If sqlconn& <> 0 Then
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "1502"
         PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
         PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
         If FMTransmitirRPC(sqlconn&, ServerName$, "master", "sp_endlogin", False, "") Then
             PMMapeaVariable sqlconn&, VTTemporal$
            SqlExit
            SqlWinExit
             sqlconn& = 0
        Else
            MsgBox "El usuario no se desconectó del servidor", 0, "Mensaje del Servidor"
        End If
    End If
    mnuSalir_Click
    End
End Sub

Private Sub mnuAcerca_Click()
    FAcerca.Show 1
End Sub

Private Sub mnuBarraAyuda_Click()
 '   If mnuBarraAyuda.Checked = False Then
  '      pnlBarraAyuda.Visible = True
       ' mnuBarraAyuda.Checked = True
   ' Else
    '    pnlBarraAyuda.Visible = False
     '   mnuBarraAyuda.Checked = False
   ' End If
End Sub

Private Sub mnuBarraMensajes_Click()
    'If mnuBarraMensajes.Checked = False Then
     '   pnlBarraMensajes.Visible = True
      '  mnuBarraMensajes.Checked = True
    'Else
     '   pnlBarraMensajes.Visible = False
      '  mnuBarraMensajes.Checked = False
    'End If
End Sub

Private Sub mnuBloquear_Click()
'II - E.Pulido 09/21/2001 Cambio de Código para NCS
'    Main
'    FPrincipal.Show
'    FPrincipal.WindowState = 0
     Me.Hide
     fpantalla.Show
'FI - E.Pulido 09/21/2001 Cambio de Código para NCS
End Sub
Private Sub mnuCambioPass_Click()
'II - E.Pulido 09/21/2001 Cambio de Código para NCS
'    FPasswd.Show 1
     PMCambioPassword sqlconn&, ServerName$, ServerNameLocal$, VGLogin$, VGFilial, VGOficina
'FI - E.Pulido 09/21/2001 Cambio de Código para NCS
End Sub

Private Sub mnuCascada_Click()
    FPrincipal.Arrange 0
End Sub

Private Sub mnuContenido_Click()
Dim VTR1%
    VTR1% = Shell("winhelp " & App.Path & "\tadmin.hlp", 1)
End Sub

Private Sub mnucostoesp_Click(Index As Integer)
   Select Case Index%
    Case 0
        FCosEsp.Show
    Case 1
        FPersoEspecial.Show
    Case 2
        FManteEspecial.Show

    End Select
End Sub

Private Sub mnuHorizontal_Click()
    FPrincipal.Arrange 1
End Sub

Private Sub mnuIconos_Click()
    FPrincipal.Arrange 3
End Sub

Private Sub mnuLogoff_Click()
    ' PMFormCloseAll_LogOff
    Dim VTTemporal$
    VGCorreo% = False
    
    '-------------------------------------------
    ' Control de tiempo para timeout de conexion
    Set Me.VGHook = Nothing
    '-------------------------------------------
    
     PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "1502"
     PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
     PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
     If FMTransmitirRPC(sqlconn&, ServerName$, "master", "sp_endlogin", False, "") Then
         PMMapeaVariable sqlconn&, VTTemporal$
         PMChequea sqlconn&
        FPrincipal.lblEtiqueta.Visible = False
        FPrincipal.cmbFilial.Visible = False
        Escribir_Ini ARCHIVOINI
        MsgBox "OK...  Desconexión del Servidor: " + ServerName$, 0, "Mensaje del Servidor"
        
        SqlExit
        SqlWinExit
         sqlconn& = 0
        FPrincipal.mnuLogon.Enabled = True
        FPrincipal.mnuLogoff.Enabled = False
        FPrincipal.mnuCambioPass.Enabled = False
        
        FPrincipal.mnuProductos.Enabled = False
        FPrincipal.mnuServicios.Enabled = False
        FPrincipal.mnuRango.Enabled = False
        FPrincipal.mnuCostos.Enabled = False
        FPrincipal.mnuValoresEsp.Enabled = False
        FPrincipal.mnuContenido.Enabled = False
        FPrincipal.mnuBloquear.Enabled = False
        DescargarFormas 2
    Else
        MsgBox "El usuario no se pudo desconectar del servidor", 0, "Mensaje del Servidor"
    End If
End Sub

Private Sub mnuLogon_Click()
'II - E.Pulido 09/21/2001 Cambio de Código para NCS
'    FLogin!txtCampo(0).Text = Get_Preferencia("SERVIDOR")
'    FLogin!txtCampo(1).Text = Get_Preferencia("USUARIO")
'    FLogin.Show 1
'     If SqlConn& <> 0 Then
'        FGenerales.Show 1
'    End If
Dim CobSrv As String
Dim CobLogin As String
Dim CobPwd As String
Dim VTDBLibVersion$
Dim VTAuxi  As Integer
Dim VGUsuario$
Dim VGUsuarioNombre$
CobSrv = Get_Preferencia("SERVIDOR")
CobLogin = Get_Preferencia("USUARIO")
sqlconn& = 0
'Obtiene la versión de DBLibrary
VTDBLibVersion$ = SqlInit$()
'Obtiene el número de la conexión
sqlconn& = SqlOpenLogin(CobSrv, CobLogin, "Administrador", "Administrador")

VTAuxi = sqlconn& Mod 10000

If sqlconn& > 0 Then 'Si existe una conexión con el servidor
    'Setea variables globales para la aplicación
    'ServerNameLocal$ = txtCampo(0).Text
    ServerNameLocal$ = CobSrv
    ServerName$ = ""
    'VGLogin$ = txtCampo(1).Text
    'Password$ = txtCampo(2).Text
    VGLogin$ = CobLogin
    Password$ = CobPwd
    DatabaseName$ = "cobis"
    HostName$ = "Administrador"
    VGUsuario$ = ""
    VGUsuarioNombre$ = ""
    Set_Preferencia "USUARIO", VGLogin$
    Set_Forma_Preferencia "USUARIO", VGLogin$
    Set_Preferencia "SERVIDOR", ServerNameLocal$
    Set_Forma_Preferencia "SERVIDOR", ServerNameLocal$
    FGenerales.Show 1
    If Not VerificarVersion(sqlconn&, App.EXEName + ".exe", App.Major, App.Minor, App.revision, 17) Then
       mnuLogoff_Click
    End If
ElseIf sqlconn = 0 Then
    'Si el servidor no se conecto
    MsgBox "El servidor no se conectó debidamente", 0, "Mensaje del Servidor"
End If
'FI - E.Pulido 09/21/2001 Cambio de Código para NCS
End Sub

Private Sub mnuPreferencias_Click()
    FPreferencias.Show 1
End Sub

Private Sub mnuProCont_Click(Index As Integer)
 FProCont.Show
End Sub

Private Sub mnuRangos_Click(Index As Integer)
Select Case Index%
Case 0
    FTipRango.Show
Case 1
    FRango.Show
   
End Select
End Sub

Private Sub mnuSalir_Click()
Dim VTTemporal$
     'PMFormCloseAll_Salir
     If sqlconn& <> 0 Then
        VGCorreo% = False
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "1502"
         PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerName$
         PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
         If FMTransmitirRPC(sqlconn&, ServerName$, "master", "sp_endlogin", False, "") Then
             PMMapeaVariable sqlconn&, VTTemporal$
             PMChequea sqlconn&
            Escribir_Ini ARCHIVOINI
            SqlExit
            SqlWinExit
             sqlconn& = 0
             DescargarFormas 1
        Else
            MsgBox "El usuario no se pudo desconectar del servidor", 0, "Mensaje del Servidor"
        End If
    End If
    End
End Sub

Private Sub mnuSizetoFit_Click()
    If Screen.ActiveForm.Caption = "C.O.B.I.S. - PERSONALIZACION" Then
        FPrincipal.Left = 15
        FPrincipal.Top = 15
        FPrincipal.Width = 9570
        FPrincipal.Height = 7170
    Else
        If Screen.ActiveForm.WindowState = 0 Then
            Screen.ActiveForm.Left = 15
            Screen.ActiveForm.Top = 15
            Screen.ActiveForm.Width = 9420
            Screen.ActiveForm.Height = 5730
        Else
            FPrincipal.Left = 15
            FPrincipal.Top = 15
            FPrincipal.Width = 9570
            FPrincipal.Height = 7170
        End If
    End If
End Sub

Private Sub mnuTopesOfi_Click(Index As Integer)
  Select Case Index%
    Case 1
      FTopesOfi.Show
    Case 2
      FParExt.Show
End Select
End Sub

Private Sub mnuTranCaja_Click()
    FMantTranAutorizada.Show
End Sub

Private Sub mnuTranCos_Click(Index As Integer)
  Select Case Index%
    Case 1
        'FTran037.Show
    End Select
End Sub

Private Sub mnuTranCos0_Click(Index As Integer)
    Select Case Index%
    Case 0
        FContratacion.Show
    Case 1
        FPersoCuenta.Show
    Case 2
        FConsultaPer.Show

    End Select
End Sub

Private Sub mnuTranCos1_Click(Index As Integer)
    Select Case Index%
    Case 0
        FMantenimiento.Show
    Case 1
        FMantenLinea.Show
    Case 2
        FMantenLinea2.Show
    Case 3
         FConCostos.Show
    Case 4
         FConsVal.Show
    Case 5
         FConsulMas.Show
    Case 6
         FConsulMas2.Show
    Case 7
         FconVarCosto.Show
    End Select

End Sub

Private Sub mnuTranProd_Click(Index As Integer)
Select Case Index%
    Case 0
            FTrproban.Show
    Case 1
            FTrprobaen.Show
    Case 2
            FProFin.Show
    Case 3
            FCatProFinal.Show
    Case 4
            FCapProFinal.Show
    Case 5
            FCicProFinal.Show
End Select
End Sub

Private Sub mnuTranServ_Click(Index As Integer)
    Select Case Index%
    Case 0
        FCreaServ.Show
    Case 1
        FCreaBas.Show
    Case 2
         Fsrvcon.Show
    Case 5
         FVarServ.Show
    Case 6
        FRubros.Show
    Case 7
        FParCom.Show
    End Select
    
End Sub

Private Sub mnuVertical_Click()
    FPrincipal.Arrange 2
End Sub

Private Sub pnlTransaccionLine_DblClick()
     If sqlconn& > 0 Then
        If VGDebug% Then
             PMDebug sqlconn&, False
            VGDebug% = False
            pnlHora.BackColor = &HC0C0C0
        Else
             PMDebug sqlconn&, True
            VGDebug% = True
            pnlHora.BackColor = &HFFFF00
        End If
    End If
End Sub

Private Sub tmrHora_Timer()
    pnlHora.Caption = Format$(Now, "HH:MM")
End Sub
'! Sub PMFormCloseAll_LogOff()
'! '*
'! '* Cierra todas las Formas excepto la FPrincipal para Logoff *
'! '*
'!
'! On Error GoTo manejo_error
'!   For Each Form In Forms
'!     'ret% = FMMsgBox("EXCLAMATION", "Cerrando: " + Form.Name)
'!     Select Case Form.Name
'!            Case "FPrincipal", "FPreferencias"
'!            Case "fdump"
'!            Case Else
'!                 Unload Form
'!     End Select
'!   Next Form
'!   Exit Sub
'! manejo_error:
'!   Resume Next
'! End Sub
Sub PMFormCloseAll_Salir()
'*
'* Cierra todas las Formas excepto la FPrincipal para Salir *
'*
Dim Form As Object
On Error GoTo manejo_error
  For Each Form In Forms
    Select Case Form.Name
           Case "FPrincipal"
           Case Else
                Unload Form
    End Select
  Next Form
  Exit Sub
manejo_error:
  Resume Next
End Sub

Public Sub DescargarFormas(tipo As Integer)
'Cambio del código de descarga de las formas de forma
'manual a forma automatica movimiendonos por las instancias
'de la la Forms
'tipo=1 si debe cerrar todas las formas
'tipo<>1 si debe cerrar todas las formas excepto la principal


    Dim VTForm As Form
    For Each VTForm In Forms
        If tipo = 1 Then
            Unload VTForm
        Else
            If VTForm.Name <> "FPrincipal" And VTForm.Name <> "FPreferencias" Then 'Revisar nombres de formas
                Unload VTForm
            End If
        End If
    Next
End Sub

'-------------------------------------------
' Control de tiempo para timeout de conexion
'-------------------------------------------
Private Sub VGHook_timeout()
Dim VTForm As Form
Dim ban As Boolean

ban = False
For Each VTForm In Forms
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
    If UCase$(VTForm.Name) = UCase$("FPrincipal") Then
        If VTForm.Enabled = False Then  'Existe alguna forma como modal
            ban = True
            Exit For
        End If
    End If
Next

If ban = True Then
    For Each VTForm In Forms
        If VTForm.Enabled = True And VTForm.Visible = True Then 'Solo la forma modal cumple esto
            Unload VTForm
            Exit For
        End If
    Next
End If

If VGTipoDesconexion Then
    mnuLogoff_Click
Else
    mnuBloquear_Click
End If

'Manejo_errores:
'DescargarFormas 1
End Sub

Public Sub Desconectar()
Dim VTTemporal$
    VGCorreo% = False
     If sqlconn& <> 0 Then
     PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
     PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1502"
     FPrincipal.pnlTransaccionLine.Caption = ""
     If FMTransmitirRPC(sqlconn&, ServerName$, "master", "sp_endlogin", False, "") Then
         PMMapeaVariable sqlconn&, VTTemporal$
         PMChequea sqlconn&
         SqlClose (sqlconn&)
         MsgBox "OK... Desconexión del Servidor: " + ServerNameLocal$, 0, "Mensaje del Servidor"
         sqlconn& = 0
         DescargarFormas 2
    End If
    End If
End Sub


