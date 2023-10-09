VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{39EB654A-9F9F-11D4-BD09-000102BF5D0F}#1.10#0"; "Map60.ocx"
Begin VB.MDIForm FPrincipal 
   Appearance      =   0  'Flat
   BackColor       =   &H8000000C&
   Caption         =   "C.O.B.I.S. - TERMINAL ADMINISTRATIVA"
   ClientHeight    =   6525
   ClientLeft      =   2115
   ClientTop       =   2055
   ClientWidth     =   9465
   LinkTopic       =   "MDIForm1"
   LockControls    =   -1  'True
   WindowState     =   2  'Maximized
   Begin Threed.SSPanel pnlBarraMensajes 
      Align           =   2  'Align Bottom
      Height          =   345
      Left            =   0
      TabIndex        =   5
      Top             =   6180
      Width           =   9465
      _Version        =   65536
      _ExtentX        =   16700
      _ExtentY        =   614
      _StockProps     =   15
      ForeColor       =   0
      BackColor       =   -2147483633
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.32
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   1
      Alignment       =   1
      Begin Threed.SSPanel pnlHelpLine 
         Height          =   255
         Left            =   45
         TabIndex        =   1
         Top             =   45
         Width           =   3690
         _Version        =   65536
         _ExtentX        =   6509
         _ExtentY        =   450
         _StockProps     =   15
         ForeColor       =   0
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
         FloodColor      =   12632256
         Alignment       =   1
      End
      Begin Threed.SSPanel pnlHora 
         Height          =   255
         Left            =   7080
         TabIndex        =   11
         Top             =   45
         Width           =   1455
         _Version        =   65536
         _ExtentX        =   2566
         _ExtentY        =   450
         _StockProps     =   15
         ForeColor       =   0
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BorderWidth     =   1
         BevelOuter      =   1
      End
      Begin Threed.SSPanel Focos 
         Height          =   135
         Index           =   0
         Left            =   8550
         TabIndex        =   10
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "L"
         ForeColor       =   0
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12.5
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
         TabIndex        =   9
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "T"
         ForeColor       =   0
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12.5
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
         TabIndex        =   8
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "R"
         ForeColor       =   0
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12.5
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
         Index           =   3
         Left            =   9180
         TabIndex        =   7
         Top             =   165
         Width           =   195
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   15
         Caption         =   "P"
         ForeColor       =   0
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   12.5
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
      Begin Threed.SSPanel pnlTransaccionLine 
         Height          =   255
         Left            =   3750
         TabIndex        =   6
         Top             =   45
         Width           =   3300
         _Version        =   65536
         _ExtentX        =   5821
         _ExtentY        =   450
         _StockProps     =   15
         ForeColor       =   0
         BackColor       =   -2147483633
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
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
         BackColor       =   &H00C0C0C0&
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
         TabIndex        =   4
         Top             =   30
         Width           =   870
      End
   End
   Begin Threed.SSPanel pnlBarraAyuda 
      Align           =   1  'Align Top
      Height          =   372
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9468
      _Version        =   65536
      _ExtentX        =   16700
      _ExtentY        =   656
      _StockProps     =   15
      ForeColor       =   0
      BackColor       =   -2147483633
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.18
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   0
      BevelInner      =   2
      Begin VB.Timer tmrMail 
         Left            =   1560
         Top             =   120
      End
      Begin COBISMap60.Map32 Map 
         Height          =   135
         Left            =   2040
         Top             =   120
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   238
      End
      Begin VB.Timer tmrHora 
         Interval        =   60000
         Left            =   525
         Top             =   -30
      End
      Begin Threed.SSRibbon gpbHelp 
         Height          =   330
         Left            =   30
         TabIndex        =   12
         Top             =   15
         Visible         =   0   'False
         Width           =   375
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   65
         BackColor       =   -2147483633
         GroupAllowAllUp =   0   'False
         Autosize        =   1
         BevelWidth      =   0
      End
      Begin VB.ComboBox cmbMoneda 
         Appearance      =   0  'Flat
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
         Height          =   255
         Left            =   5610
         TabIndex        =   2
         Tag             =   "2879"
         Top             =   60
         Visible         =   0   'False
         Width           =   3780
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "&Moneda:"
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
         Left            =   4830
         TabIndex        =   3
         Top             =   60
         Visible         =   0   'False
         Width           =   750
      End
   End
   Begin VB.Menu mnuConexion 
      Caption         =   "* Cone&xión"
      HelpContextID   =   1000
      Begin VB.Menu mnuLogon 
         Caption         =   "* Log o&n"
         HelpContextID   =   1001
      End
      Begin VB.Menu mnuLogoff 
         Caption         =   "* Log o&ff"
         Enabled         =   0   'False
         HelpContextID   =   1002
      End
      Begin VB.Menu mnuLinea1 
         Caption         =   "-"
         Index           =   0
      End
      Begin VB.Menu mnuPreferencias 
         Caption         =   "* Preferencias"
         HelpContextID   =   1003
      End
      Begin VB.Menu mnuPassword 
         Caption         =   "* Cambio de &Password"
         Enabled         =   0   'False
         HelpContextID   =   1004
      End
      Begin VB.Menu mnuLineas 
         Caption         =   "-"
      End
      Begin VB.Menu mnuBloquear 
         Caption         =   "* Bloquear Terminal"
         Enabled         =   0   'False
         HelpContextID   =   1005
      End
      Begin VB.Menu mnuLinea2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSalir 
         Caption         =   "* &Salir"
         HelpContextID   =   1006
         Shortcut        =   ^S
      End
   End
   Begin VB.Menu mnuAhorros 
      Caption         =   "C. de &Ahorros"
      Enabled         =   0   'False
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "Cuentas"
         Index           =   0
         Begin VB.Menu mnuTranAho1 
            Caption         =   "Solicitud"
            Enabled         =   0   'False
            Index           =   0
            Tag             =   "352"
         End
         Begin VB.Menu mnuTranAho1 
            Caption         =   "Autorizacion de Solicitud"
            Enabled         =   0   'False
            Index           =   1
            Tag             =   "354"
         End
         Begin VB.Menu mnuTranAho1 
            Caption         =   "Apertura"
            Enabled         =   0   'False
            Index           =   2
            Tag             =   "201"
         End
         Begin VB.Menu mnuTranAho1 
            Caption         =   "*Actualización Crítica"
            Enabled         =   0   'False
            HelpContextID   =   1066
            Index           =   3
            Tag             =   "202"
         End
         Begin VB.Menu mnuTranAho1 
            Caption         =   "Actualización General"
            Enabled         =   0   'False
            Index           =   4
            Tag             =   "205"
            Visible         =   0   'False
         End
         Begin VB.Menu mnuTranAho1 
            Caption         =   "Apertura de Cuentas Cifradas"
            Enabled         =   0   'False
            Index           =   5
            Tag             =   "320"
            Visible         =   0   'False
         End
         Begin VB.Menu mnuTranAho1 
            Caption         =   "Activación de Cuentas con Autorización"
            Index           =   6
            Tag             =   "4144"
         End
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "Bloqueos"
         Index           =   1
         Begin VB.Menu mnuTranAho2 
            Caption         =   "De Movimientos"
            Enabled         =   0   'False
            Index           =   0
            Tag             =   "211"
         End
         Begin VB.Menu mnuTranAho2 
            Caption         =   "*De Valores"
            Enabled         =   0   'False
            HelpContextID   =   3076
            Index           =   1
            Tag             =   "217"
         End
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "Levantamientos"
         Index           =   2
         Begin VB.Menu mnuTranAho3 
            Caption         =   "De Bloqueo de Movimientos"
            Enabled         =   0   'False
            Index           =   0
            Tag             =   "212"
         End
         Begin VB.Menu mnuTranAho3 
            Caption         =   "*De Bloqueo de Valores"
            Enabled         =   0   'False
            HelpContextID   =   1059
            Index           =   1
            Tag             =   "218"
         End
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "Cancelacion"
         Index           =   3
         Begin VB.Menu mnuTranAho6 
            Caption         =   "Reactivación de Cuentas"
            Enabled         =   0   'False
            Index           =   0
            Tag             =   "203"
         End
         Begin VB.Menu mnuTranAho6 
            Caption         =   "Reapertura de Cuentas"
            Enabled         =   0   'False
            Index           =   1
            Tag             =   "204"
            Visible         =   0   'False
         End
         Begin VB.Menu mnuTranAho6 
            Caption         =   "*Cierre de Cuentas"
            Enabled         =   0   'False
            HelpContextID   =   1022
            Index           =   2
            Tag             =   "214"
         End
         Begin VB.Menu mnuTranAho6 
            Caption         =   "*Inactivacion de Cuentas"
            HelpContextID   =   1095
            Index           =   3
            Tag             =   "367"
            Visible         =   0   'False
         End
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "Cobro de Valores en Suspenso"
         Enabled         =   0   'False
         Index           =   7
         Tag             =   "303"
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "-"
         Index           =   8
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "Consultas"
         Index           =   9
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*De Bloqueo de Valores"
            Enabled         =   0   'False
            HelpContextID   =   1060
            Index           =   1
            Tag             =   "216"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "De Bloqueo de Movimientos"
            Enabled         =   0   'False
            Index           =   2
            Tag             =   "245"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "De Solicitudes de Apertura"
            Enabled         =   0   'False
            Index           =   3
            Tag             =   "357"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "-"
            Index           =   4
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "De Saldos"
            Enabled         =   0   'False
            Index           =   5
            Tag             =   "230"
            Visible         =   0   'False
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*Monetaria"
            Enabled         =   0   'False
            HelpContextID   =   1061
            Index           =   6
            Tag             =   "220"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*No Monetaria"
            Enabled         =   0   'False
            HelpContextID   =   1058
            Index           =   7
            Tag             =   "235"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "De Movimientos"
            Enabled         =   0   'False
            Index           =   8
            Tag             =   "232"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "De Valores en Suspenso"
            Enabled         =   0   'False
            Index           =   9
            Tag             =   "247"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "Detalle de cálculo de intereses"
            Enabled         =   0   'False
            Index           =   10
            Tag             =   "343"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "-"
            Index           =   11
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*Solicitud de Estado de Cuenta"
            Enabled         =   0   'False
            HelpContextID   =   1047
            Index           =   14
            Tag             =   "234"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*Solicitud de Estado de Cuenta sin Costo"
            Enabled         =   0   'False
            HelpContextID   =   1048
            Index           =   15
            Tag             =   "223"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "-"
            Index           =   17
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*Operaciones superiores a un monto en Cuentas de Ahorros"
            Enabled         =   0   'False
            HelpContextID   =   1057
            Index           =   18
            Tag             =   "302"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "-"
            Index           =   19
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*De Reservas Locales por Cuenta"
            Enabled         =   0   'False
            HelpContextID   =   3119
            Index           =   22
            Tag             =   "331"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*Cuentas con Caracteristicas Especiales"
            HelpContextID   =   3892
            Index           =   23
            Tag             =   "393"
         End
         Begin VB.Menu mnuTranAho7 
            Caption         =   "*Seguimiento Plan de Ahorro Progresivo"
            HelpContextID   =   3893
            Index           =   24
            Tag             =   "395"
         End
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "&Históricos"
         Index           =   10
         Begin VB.Menu mnuTranAho8 
            Caption         =   "*Transacciones Monetarias"
            Enabled         =   0   'False
            HelpContextID   =   1069
            Index           =   1
            Tag             =   "281"
         End
         Begin VB.Menu mnuTranAho8 
            Caption         =   "*Transacciones de Servicio"
            Enabled         =   0   'False
            HelpContextID   =   1068
            Index           =   2
            Tag             =   "282;283"
         End
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "-"
         Index           =   11
      End
      Begin VB.Menu mnuTranctaaho 
         Caption         =   "*Liberación Anticipada de Reserva Local"
         Enabled         =   0   'False
         HelpContextID   =   3122
         Index           =   15
         Tag             =   "332"
      End
      Begin VB.Menu mnuExcepciones 
         Caption         =   "Excepciones"
         Begin VB.Menu mnuAutRetOfi 
            Caption         =   "Autorización Retiros en Oficina"
            Enabled         =   0   'False
            Tag             =   "4133;4134"
         End
      End
   End
   Begin VB.Menu mnuReCamara 
      Caption         =   "&Procesos"
      Enabled         =   0   'False
      Begin VB.Menu mnuRemesas 
         Caption         =   "*&Remesas"
         HelpContextID   =   1136
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Acuse de Remesas"
            Enabled         =   0   'False
            HelpContextID   =   1142
            Index           =   0
            Tag             =   "603"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Novedades de Remesa"
            Enabled         =   0   'False
            HelpContextID   =   1143
            Index           =   1
            Tag             =   "604"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Confirmación de Remesas"
            Enabled         =   0   'False
            HelpContextID   =   1137
            Index           =   2
            Tag             =   "403"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "-"
            Index           =   3
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Cartas por Banco Corresponsal"
            Enabled         =   0   'False
            HelpContextID   =   1138
            Index           =   4
            Tag             =   "410"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Consulta de Cheques por Cuenta"
            Enabled         =   0   'False
            HelpContextID   =   1139
            Index           =   5
            Tag             =   "408"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Consulta de Cheques por Oficina"
            Enabled         =   0   'False
            HelpContextID   =   1140
            Index           =   6
            Tag             =   "429"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Consulta de Cartas Remesas por Oficina"
            Enabled         =   0   'False
            HelpContextID   =   1141
            Index           =   7
            Tag             =   "602"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Relacion de Cheques via Bancos"
            Enabled         =   0   'False
            HelpContextID   =   1144
            Index           =   8
            Tag             =   "606"
         End
         Begin VB.Menu mnuTranRemesas 
            Caption         =   "*Total Cheques via Bancos por Oficina"
            Enabled         =   0   'False
            HelpContextID   =   1145
            Index           =   9
            Tag             =   "607"
         End
      End
      Begin VB.Menu mnuHoldRes 
         Caption         =   "*Aumentar días de hold para reservas locales"
         HelpContextID   =   1101
         Tag             =   "710"
      End
      Begin VB.Menu mnuLinea20 
         Caption         =   "-"
      End
      Begin VB.Menu mnuautndnc 
         Caption         =   "*Autorización de Notas de Crédito / Débito"
         Enabled         =   0   'False
         HelpContextID   =   1071
         Tag             =   "2850"
      End
      Begin VB.Menu mnundcahocc 
         Caption         =   "*""Notas de Crédito / Débito"""
         HelpContextID   =   1088
         Tag             =   "253; 48; 264; 50"
      End
      Begin VB.Menu mnuLinea25 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTransferencias 
         Caption         =   "*Transferencias entre cuentas automáticas"
         Enabled         =   0   'False
         HelpContextID   =   1070
         Index           =   1
         Tag             =   "714;717"
      End
      Begin VB.Menu mnuVolEfectivo 
         Caption         =   "*Monitorio de Clientes con volúmen de Efectivo"
         Enabled         =   0   'False
         HelpContextID   =   1135
         Tag             =   "2938"
      End
      Begin VB.Menu mnuLinea26 
         Caption         =   "-"
      End
      Begin VB.Menu mnuTotales 
         Caption         =   "*De Totales por Agencia"
         Enabled         =   0   'False
         HelpContextID   =   1035
         Index           =   0
         Tag             =   "80"
      End
      Begin VB.Menu mnuTotales 
         Caption         =   "De Totales por Operador"
         Enabled         =   0   'False
         Index           =   1
         Tag             =   "90"
      End
      Begin VB.Menu mnuTotales 
         Caption         =   "Totales Nacionales de Caja"
         Enabled         =   0   'False
         Index           =   2
         Tag             =   "2700"
      End
      Begin VB.Menu mnuTotales 
         Caption         =   "Consulta Transacciones en Efectivo"
         Enabled         =   0   'False
         Index           =   3
         Tag             =   "2669"
      End
      Begin VB.Menu mnuTotales 
         Caption         =   "Marcacion Servicios"
         HelpContextID   =   1146
         Index           =   4
         Tag             =   "722"
      End
      Begin VB.Menu mnuConsTransf 
         Caption         =   "Consulta Archivo Transferencias Masivas"
         Tag             =   "702"
      End
      Begin VB.Menu mnuLinea27 
         Caption         =   "-"
      End
      Begin VB.Menu mnuRelCtaCanal 
         Caption         =   "Relacion Cuentas a Canales"
         Enabled         =   0   'False
         Tag             =   "743"
      End
      Begin VB.Menu mnuCB 
         Caption         =   "Corresponsal Bancario Red Posicionada"
         Enabled         =   0   'False
         Tag             =   "400"
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Mantenimiento de Corresponsal"
            Enabled         =   0   'False
            Index           =   0
            Tag             =   "4155"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Mantenimiento de Cupo Corresponsal"
            Enabled         =   0   'False
            Index           =   1
            Tag             =   "4149"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Consulta de Cupo Corresponsal"
            Enabled         =   0   'False
            Index           =   2
            Tag             =   "4150"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Consulta de Movimientos de C.B."
            Enabled         =   0   'False
            Index           =   3
            Tag             =   "4151"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Devolución Valores Recaudados  C.B."
            Enabled         =   0   'False
            Index           =   4
            Tag             =   "4152"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Gestión Cuentas de Corresponsalia"
            Enabled         =   0   'False
            Index           =   5
            Tag             =   "4153"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Consolidado Redes Posicionadas"
            Enabled         =   0   'False
            Index           =   6
            Tag             =   "4154"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Liberación de Cupo Corresponsal"
            Index           =   7
            Tag             =   "381"
         End
         Begin VB.Menu mnuMttoCB 
            Caption         =   "Cancelación Cuenta C.B."
            Index           =   8
            Tag             =   "394"
         End
      End
   End
   Begin VB.Menu mnuadmin 
      Caption         =   "A&dministración"
      Enabled         =   0   'False
      Begin VB.Menu mnuAdmin0 
         Caption         =   "&Transacciones a Contabilizar"
         Enabled         =   0   'False
         Index           =   0
         Tag             =   "494"
      End
      Begin VB.Menu mnuAdmin0 
         Caption         =   "&Conceptos Contables por Transaccion"
         Enabled         =   0   'False
         Index           =   1
         Tag             =   "4107"
      End
      Begin VB.Menu mnuAdmin0 
         Caption         =   "&Parametrización Contable"
         Enabled         =   0   'False
         Index           =   2
         Tag             =   "708"
      End
      Begin VB.Menu mnuAdmin0 
         Caption         =   "&Relacion de Perfiles Contables"
         Enabled         =   0   'False
         Index           =   3
         Tag             =   "720"
      End
      Begin VB.Menu mnuAdmin0 
         Caption         =   "-"
         Index           =   5
      End
      Begin VB.Menu mnuAdmin3 
         Caption         =   "Mantenim. de Acción de Notas de Débito"
         Enabled         =   0   'False
         Index           =   7
         Tag             =   "2581;2582;2583;2584"
      End
      Begin VB.Menu mnuAdmin3 
         Caption         =   "Parametrizacion Impresion y Causales de Notas DB/CR"
         Enabled         =   0   'False
         HelpContextID   =   1064
         Index           =   8
         Tag             =   "707"
      End
      Begin VB.Menu mnuAdmin7 
         Caption         =   "*Mantenim. de Causales de Notas Deb/Cre Caja"
         HelpContextID   =   1102
         Index           =   0
         Tag             =   "2696"
      End
      Begin VB.Menu mnuAdmin7 
         Caption         =   "*Mantenim. de Causales Otros Ingresos/Egresos"
         HelpContextID   =   1103
         Index           =   1
         Tag             =   "2913"
      End
      Begin VB.Menu mnuAdmin7 
         Caption         =   "*Cuentas para Consignacion por Oficina"
         HelpContextID   =   1104
         Index           =   2
         Tag             =   "697"
      End
      Begin VB.Menu mnuAdmin7 
         Caption         =   "Mantenimiento Causales ND/NC por Oficina"
         Enabled         =   0   'False
         Index           =   4
         Tag             =   "738"
      End
      Begin VB.Menu mnuMtoEquiv 
         Caption         =   "*Mantenimiento Equivalencias"
         Enabled         =   0   'False
         HelpContextID   =   1150
         Tag             =   "4163"
      End
      Begin VB.Menu mnuadmin4 
         Caption         =   "*Bancos Corresponsales"
         Enabled         =   0   'False
         HelpContextID   =   1106
         Index           =   8
         Tag             =   "2585;2586;2587;2588"
      End
      Begin VB.Menu mnuAdmin5 
         Caption         =   "*Agencias del Banco"
         Enabled         =   0   'False
         HelpContextID   =   1031
         Index           =   9
         Tag             =   "2589;2590;2591;2592"
      End
      Begin VB.Menu mnuadmin6 
         Caption         =   "Bancos"
         Enabled         =   0   'False
         Index           =   10
         Tag             =   "2593;2594;2595;2596"
      End
      Begin VB.Menu mnuadmin6 
         Caption         =   "Mensajes de Estados de Cuenta"
         Enabled         =   0   'False
         Index           =   11
         Tag             =   "99"
      End
      Begin VB.Menu mnuadmin6 
         Caption         =   "-"
         Index           =   30
      End
      Begin VB.Menu mnuadmin6 
         Caption         =   "Administración de Autorizaciones ND/NC"
         Index           =   32
         Begin VB.Menu mnuadminaut 
            Caption         =   "*Mantenimiento de Funcionarios Autorizantes"
            HelpContextID   =   1084
            Index           =   0
            Tag             =   "700;701;699"
         End
         Begin VB.Menu mnuadminaut 
            Caption         =   "*Mantenimiento de Funcionarios Ejecutores"
            HelpContextID   =   1085
            Index           =   1
            Tag             =   "702;704;703"
         End
      End
      Begin VB.Menu mnuadmin6 
         Caption         =   "-"
         Index           =   33
      End
      Begin VB.Menu mnugmf 
         Caption         =   "Mantenimiento Gravamen Movimiento Financiero"
         Tag             =   "4101;4102;4103;4104;4105;4106"
         Begin VB.Menu mnuctasexegmf 
            Caption         =   "Conceptos de Exención Gravamen Movimiento Financiero"
            Enabled         =   0   'False
            Tag             =   "4108"
         End
         Begin VB.Menu mnuupdgmf 
            Caption         =   "Actualización GMF Ahorros / Corriente"
            Enabled         =   0   'False
            Tag             =   "4106"
         End
      End
      Begin VB.Menu mnuadmin8 
         Caption         =   "-"
         Index           =   0
      End
      Begin VB.Menu mnuadmin8 
         Caption         =   "*Mantenimiento de Catálogos"
         HelpContextID   =   1108
         Index           =   2
         Tag             =   "584"
         Begin VB.Menu mnuMantCat 
            Caption         =   "*De Cuentas de Ahorros"
            HelpContextID   =   1110
            Index           =   1
         End
         Begin VB.Menu mnuMantCat 
            Caption         =   "*De Cámara-Remesas"
            HelpContextID   =   1111
            Index           =   2
         End
         Begin VB.Menu mnuMantCat 
            Caption         =   "*De Personalizacion"
            HelpContextID   =   1112
            Index           =   3
         End
      End
      Begin VB.Menu mnuadmin8 
         Caption         =   "-"
         Index           =   3
      End
      Begin VB.Menu mnuadmin8 
         Caption         =   "*Mantenimeinto Centro de Canje"
         HelpContextID   =   1114
         Index           =   4
         Tag             =   "2810"
      End
      Begin VB.Menu mnuadmin8 
         Caption         =   "*Mantenimiento Plazas Bco. República"
         HelpContextID   =   1115
         Index           =   5
         Tag             =   "2564"
      End
      Begin VB.Menu mnuadmin8 
         Caption         =   "*Parametrización por Tipo de Canje"
         HelpContextID   =   1116
         Index           =   6
         Tag             =   "672"
      End
      Begin VB.Menu mnuMantDTN 
         Caption         =   "Mantenimiento Códigos DTN"
         Enabled         =   0   'False
         Tag             =   "390"
      End
   End
   Begin VB.Menu mnuVentanas 
      Caption         =   "* &Ventanas"
      HelpContextID   =   1007
      WindowList      =   -1  'True
      Begin VB.Menu mnuBarraAyuda 
         Caption         =   "* Barra de ayuda"
         Checked         =   -1  'True
         HelpContextID   =   1008
      End
      Begin VB.Menu mnuBarraMensajes 
         Caption         =   "* Barra de mensajes"
         Checked         =   -1  'True
         HelpContextID   =   1009
      End
      Begin VB.Menu mnuLinea15 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCascada 
         Caption         =   "* Cascada"
         HelpContextID   =   1010
      End
      Begin VB.Menu mnuHorizontal 
         Caption         =   "* Horizontal"
         HelpContextID   =   1012
      End
      Begin VB.Menu mnuVertical 
         Caption         =   "* Vertical"
         HelpContextID   =   1011
      End
      Begin VB.Menu mnuIconos 
         Caption         =   "* Iconos"
         HelpContextID   =   1013
      End
      Begin VB.Menu mnuLinea16 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSizetoFit 
         Caption         =   "* Ajustar la ventana"
         HelpContextID   =   1014
      End
   End
   Begin VB.Menu mnuAyuda 
      Caption         =   "* Ay&uda"
      HelpContextID   =   1015
      Begin VB.Menu mnuContenido 
         Caption         =   "* Contenido"
         Enabled         =   0   'False
         HelpContextID   =   1016
      End
      Begin VB.Menu mnuLinea17 
         Caption         =   "-"
      End
      Begin VB.Menu mnuAcerca 
         Caption         =   "* Acerca de ..."
         HelpContextID   =   1018
      End
   End
End
Attribute VB_Name = "FPrincipal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14-Aug-10
'*************************************************************
' ARCHIVO:          FPRINCIP.frm
' NOMBRE LOGICO:    FPrincipal
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
' Esta forma contiene el menú para acceso a las diferentes
' opciones que ofrece la Terminal Administrativa.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Personalización AgroMercantil
'*************************************************************
'! removed Public FMain As FPrincipal

'! removed Public VLTag As String


' Control de tiempo para timeout de conexion
Public WithEvents VGHook As COBISTools.IdleTimeout
Attribute VGHook.VB_VarHelpID = -1
Public VGTipoDesconexion As Boolean

Private Sub cmbMoneda_Click()
    Dim VTpos As Integer
    Dim VTMoneda As String
    Dim VTDescMoneda As String
    Dim VTR1 As Integer
    
    VTpos% = InStr(1, cmbMoneda.Text, "-", 0)
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    VTMoneda$ = Mid(cmbMoneda.Text, 1, VTpos% - 1)
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
    VTDescMoneda$ = Mid(cmbMoneda.Text, VTpos% + 1, Len(cmbMoneda.Text))
    If VTMoneda$ <> VGMoneda$ Then
        VGMoneda$ = VTMoneda$
        VGDescMoneda$ = VTDescMoneda$
        ' Determinacion de los decimales que usa la moneda

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "78"
         PMPasoValores sqlconn&, "@i_prod", 0, SQLVARCHAR, "CTE"
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, "", "cobis", "sp_cons_param_inicio", False, "") Then
            ReDim VTArreglo(10) As String
             VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
             PMChequea sqlconn&
            If VTR1% <> 0 Then
                If VTArreglo(5) = "N" Then
                    VGDecimales$ = "#,##0"
                Else
                    VGDecimales$ = "#,##0.00"
                End If
                VGCtaGerencia$ = VTArreglo(8)
            Else
                MsgBox "Error en consulta de Parámetros iniciales de Depósitos Monetarios", 0 + 16, "Mensaje del Servidor"
                PMLogOff
                Exit Sub
            End If
        Else
            MsgBox "Error en consulta de Parámetros iniciales de Depósitos Monetarios", 0 + 16, "Mensaje del Servidor"
            PMLogOff
            Exit Sub
        End If

    End If

End Sub

Private Sub cmbMoneda_KeyPress(KeyAscii As Integer)
    KeyAscii% = 0
End Sub

Private Sub MDIForm_Load()
Dim VGPrefDBError As Boolean
Dim VGPrefDBMensaje As Boolean
Dim VGPathImagen As String
Dim VLDebug As String

Set VGMap = Map
Set VGBitmap32 = CreateObject("COBIS.Bitmap32")
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
        VGPrefDBError = False
    VGPrefDBMensaje = True
    Call PMDireccionPath
    VGPath$ = PathUnico
    ARCHIVOINI = VGPath$ & "\tadmin.ini"
    App.HelpFile = VGPath$ & "\hccca.hlp"
    FPrincipal!Focos(0).FloodPercent = 100
    FPrincipal!Focos(1).FloodPercent = 0
    FPrincipal!Focos(2).FloodPercent = 0
    FPrincipal!Focos(3).FloodPercent = 0
    FPrincipal.Left = 0   '15
    FPrincipal.Top = 0   '15
    FPrincipal.Width = 9570
    FPrincipal.Height = 7430
    VGTeclaAyuda% = 116
    Iniciar_Preferencias ARCHIVOINI
    VGLogTransacciones$ = Get_Preferencia("ARCHIVO-LOG")
    VGPathImagen$ = Get_Preferencia("IMAGENES")
    ' Max Bravo
    VGFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    pnlHora.Caption = Format$(Now, VGFormatoFecha$ + " hh:mm")
    VGSaip$ = Get_Preferencia("SAIP")  'OUS
    VLDebug$ = Get_Preferencia("DEBUG")
    If VLDebug$ = "S" Then VGDebug% = True Else VGDebug% = False
    If VGPathImagen$ = "" Then
        VGPathImagen$ = "c:\cobis"
        Set_Preferencia "IMAGENES", "c:\cobis"
        Set_Forma_Preferencia "IMAGENES", "c:\cobis"
    End If
    FMInitMap Me!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$
    Forma_Preferencias
   '********************************************
   'CloVargas Añadir obtencion de formato fecha
   '********************************************
    VGFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    PMCargar_FechaSP (VGFormatoFecha)
    
    If Not FMVerificar_WinIni() Then
        Unload Me
        Exit Sub
    End If
    mnuTotales(4).Enabled = True
End Sub

Private Sub MDIForm_QueryUnload(Cancel As Integer, UnloadMode As Integer)
  PMFormCloseAll_Salir
  PMLogOff
End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
Dim VTTemporal As String

     If sqlconn& <> 0 And sqlconn& <> -1 Then
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "1502"
         PMPasoValores sqlconn&, "@i_server", 0, SQLVARCHAR, ServerNameLocal$
         PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR, VGLogin$
         If FMTransmitirRPC(sqlconn&, ServerName$, "master", "sp_endlogin", False, "") Then
             PMMapeaVariable sqlconn&, VTTemporal$
             PMChequea sqlconn&
             SqlClose sqlconn&
            SqlExit
            SqlWinExit
             sqlconn& = 0
            PMFormCloseAll_Salir
            Set VGMap = Nothing    'PARA QUE NO QUEDE LA INSTANCIA DEL EJECUTABLE ABIERTA
            PMLiberarBCliente
        Else
           PMLiberarBCliente
           PMFormCloseAll_Salir
            MsgBox "El usuario no se desconectó del servidor", 0, "Mensaje del Servidor"
        End If
    End If
    'End
End Sub

Private Sub mnuAcerca_Click()
    FAcerca.Show 1
End Sub

Private Sub mnuAdmin0_Click(Index As Integer)
    Select Case Index%
    Case 0
        FTran493.Show
    Case 1
        FConcTrn.Show
    'INI BPT CMU I010-AHO
    Case 2
        FParamConta.Show
    'FIN BPT CMU I010-AHO
    Case 3
        FPerfil.Show        'ream 21.abr.2010
    End Select
End Sub

Private Sub mnuAdmin3_Click(Index As Integer)
    Select Case Index%
    Case 7
        FTran2581.Show
    'LBM 040305
    Case 8
        FTRAN707.Show
    End Select

End Sub

Private Sub mnuAdmin4_Click(Index As Integer)
    Select Case Index%
    Case 8
        FTran2585.Show
    End Select
    
End Sub

Private Sub mnuAdmin5_Click(Index As Integer)
    Select Case Index%
    Case 9
        FTran2589.Show
    End Select
End Sub

Private Sub mnuAdmin6_Click(Index As Integer)
  Select Case Index%
  Case 10
    FTran2593.Show
  Case 11
    FTran099.Show
  End Select
End Sub
Private Sub mnuadmin7_Click(Index As Integer)
Select Case Index
    Case 0
        FTran2696.Show
    Case 1
        FTran2913.Show
    Case 2
        FCtaBcoOfi.Show
    Case 4
        FMantCausalOfi.Show
End Select
End Sub
Private Sub mnuMtoEquiv_Click()
   FMantenimiento.Show
End Sub

Private Sub mnuadmin8_Click(Index As Integer)
Select Case Index
    Case 4
        Load FTran2810
        FTran2810.Show
    Case 5
        FTran2564.Show
    Case 6
        FTipoCanje.Show
End Select
End Sub

Private Sub mnuadminaut_Click(Index As Integer)

    Select Case Index
        Case 0 'Mantenimiento de Funcionarios Autorizantes
            Ftran2872.Show
        Case 1 'Mantenimiento de Funcionarios Ejecutores
            Ftran2875.Show
    End Select
End Sub

Private Sub mnuautndnc_Click()
FTRAN2850.Show
End Sub
 
Private Sub mnuAutRetOfi_Click()
    FAUTRETOF.Show
End Sub

Private Sub mnuBarraAyuda_Click()
    If mnuBarraAyuda.Checked = False Then
        pnlBarraAyuda.Visible = True
        mnuBarraAyuda.Checked = True
    Else
        pnlBarraAyuda.Visible = False
        mnuBarraAyuda.Checked = False
    End If
End Sub

Private Sub mnuBarraMensajes_Click()
    If mnuBarraMensajes.Checked = False Then
        pnlBarraMensajes.Visible = True
        mnuBarraMensajes.Checked = True
    Else
        pnlBarraMensajes.Visible = False
        mnuBarraMensajes.Checked = False
    End If
End Sub

Private Sub mnuBloquear_Click()
    Me.Hide                         'Añadido por T. Suárez
    fpantalla.Show                  'Añadido por T. Suárez
End Sub

Private Sub mnuCascada_Click()
    FPrincipal.Arrange 0
End Sub

Private Sub mnuConsTransf_Click()
   FArchTransf.Show
End Sub

Private Sub mnuContenido_Click()
    Dim VTR1 As Integer
    VTR1 = Shell("winhelp " & PathUnico & "\hccca.hlp", 1)
End Sub

Private Sub mnuctasexegmf_Click()
    FPExenGMF.Show
End Sub

Private Sub mnuMantCat_Click(Index As Integer)
    Select Case Index
    Case 1
        mnuadmin8(2).Enabled = False
        VGProducto$ = "AHO"
        FMantCatalogo.WindowState = 0
        FMantCatalogo.Caption = FMantCatalogo.Caption + " - Ahorros - "
        FMantCatalogo.Show
    Case 2
        mnuadmin8(2).Enabled = False
        VGProducto$ = "REM"
        FMantCatalogo.WindowState = 0
        FMantCatalogo.Caption = FMantCatalogo.Caption + " - Cámara y Remesas - "
        FMantCatalogo.Show
    Case 3
        mnuadmin8(2).Enabled = False
        VGProducto$ = "PER"
        FMantCatalogo.WindowState = 0
        FMantCatalogo.Caption = FMantCatalogo.Caption + " - Personalización - "
        FMantCatalogo.Show
    End Select
End Sub

Private Sub mnuMantDTN_Click()
    FPARAMDTN.Show
End Sub

Private Sub mnuRelCtaCanal_Click()
    'Menu agregado para la relacion cuentas canales
    FMotorBusq.Caption = "Relacion Cuenta a Canales"
    PMLimpiaG FMotorBusq.grdCuentas
    FMotorBusq.Tag = 743
    FMotorBusq.Show
End Sub

Private Sub mnuMttoCB_Click(Index As Integer)
    Select Case Index%
        Case 0 'Mantenimiento de Corresponsal
            FMantenimientoCB.Show
        Case 1 'Mantenimiento de Cupo de Corresponsal
            FMantenimientoCupoCB.Show
        Case 2 'Consulta de Cupo Corresponsal
            FConsultaCupoCB.Show
        Case 3 'Consulta de Movimientos de C.B.
            FConsMovCB.Show
        Case 4 'Devolución Valores Recaudados C.B.
            FDevRecCB.Show
        Case 5 'Gestión Cuentas de Corresponsalia
            FGesCtaCB.Show
        Case 6 'Consolidado Redes Posicionadas
            FConRedCB.Show
        Case 7 'Liberación de Cupo
            FMotorBusq.Caption = "Liberación de Cupo CB Red Posicionada"
            PMLimpiaG FMotorBusq.grdCuentas
            FMotorBusq.Tag = 303
            FMotorBusq.Show
        Case 8 'Cancelaciòn Cuenta C.B.
            FMotorBusq.Caption = "Cancelación de Cuentas C.B."
            PMLimpiaG FMotorBusq.grdCuentas
            FMotorBusq.Tag = 214
            FMotorBusq.Show
    End Select
End Sub

Private Sub mnuTotales_Click(Index As Integer)
    Select Case Index%
        Case 0
            FTran080.Show
        Case 1
            FTran090.Show
        Case 2
            FTra2700.Show
        Case 3
            Ftran2797.Show
        Case 4
            'FTran433.Show
            FMotorBusq.Caption = "Marcacion Servicio"
            PMLimpiaG FMotorBusq.grdCuentas
            FMotorBusq.Tag = 433
            FMotorBusq.Show

    End Select
End Sub

Private Sub mnuupdgmf_Click()
    FTranUpGMF.Show
End Sub

Private Sub mnuHoldRes_Click()
    FHold.Show
End Sub
Private Sub mnuHorizontal_Click()
    FPrincipal.Arrange 1
End Sub

Private Sub mnuIconos_Click()
    FPrincipal.Arrange 3
End Sub

Private Sub mnuVolEfectivo_click()
'**************************************************************
' PROPOSITO: Invocar llamada a pantalla de consulta de clientes
'            que manejan volumenes de efectivo
' INPUT    : ninguna
' OUTPUT   : ninguna
'**************************************************************
'                    MODIFICACIONES
'FECHA          AUTOR                       RAZON
'13/Abr/2007  Clotilde Vargas de Coello     Para Cumplimiento
'**************************************************************
FTran2938.Show
End Sub

Private Sub mnuLogoff_Click()
    PMFormCloseAll_Salir
    PMLogOff
    Iniciar_Preferencias ARCHIVOINI
    Forma_Preferencias
End Sub
Private Sub mnuLogon_Click()
'*************************************************************
' PROPOSITO: Cuando se inicia sesion en el modulo
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'12/Sep/01  T.Suárez            Incorporación NCS
'*************************************************************

Dim CobSrv As String
Dim CobLogin As String
Dim CobPwd As String
Dim VTDBLibVersion As String
Dim VTAuxi As Integer
Dim VGUsuario As String
Dim VGUsuarioNombre As String

    Iniciar_Preferencias ARCHIVOINI
    Forma_Preferencias


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
    
    'Obtiene nombres de banco Proyecto Re-Branding
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_nombre_banco"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, "1"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2&, VGFilial
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
        PMMapeaVariable sqlconn&, VGNombreLargoBanco$
        PMChequea sqlconn&
    End If
    
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_nombre_banco"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, "2"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2&, VGFilial
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
        PMMapeaVariable sqlconn&, VGNombreCortoBanco$
        PMChequea sqlconn&
    End If

    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_nombre_banco"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, "3"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2&, VGFilial
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
        PMMapeaVariable sqlconn&, VGDireccionElectro$
        PMChequea sqlconn&
    End If
    
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_nombre_banco"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, "4"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2&, VGFilial
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
        PMMapeaVariable sqlconn&, VGDominio$
        PMChequea sqlconn&
    End If
    
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_nombre_banco"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, "5"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2&, VGFilial
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
        PMMapeaVariable sqlconn&, VGFonoBanex$
        PMChequea sqlconn&
    End If

    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_nombre_banco"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR&, "6"
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT2&, VGFilial
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
        PMMapeaVariable sqlconn&, VGLOGO$
        PMChequea sqlconn&
    End If

    
    If Not VerificarVersion(sqlconn&, App.EXEName + ".exe", App.Major, App.Minor, App.revision, 3) Then
        mnuLogoff_Click
        Exit Sub
    End If
    
    ElseIf sqlconn = 0 Then
    'Si el servidor no se conecto
        MsgBox "El servidor no se conectó debidamente", 0, "Mensaje del Servidor"
        Exit Sub
    End If
    Me.Caption = App.Title + "  [ " + ServerNameLocal$ + " ]"
End Sub


Private Sub mnundcahocc_Click()
    FTran358.Show
End Sub

Private Sub mnuPassword_Click()
'*************************************************************
' PROPOSITO: Menu cuando se desea cambiar el password de
'            un usuario
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'12/Sep/01  T.Suárez            Incorporación NCS
'*************************************************************
    'FPasswd.Show 1    'Comentado por T. Suárez
    PMCambioPassword sqlconn&, ServerName$, ServerNameLocal$, VGLogin$, VGFilial, VGOficina 'Añadido por T. Suárez
End Sub

Private Sub mnuPreferencias_Click()
    FPreferencias.Show 1
End Sub

Private Sub mnuSalir_Click()
    PMLiberarBCliente
    PMFormCloseAll_Salir
    PMLogOff
    SqlExit
    SqlWinExit
    End
End Sub
Private Sub mnuSizetoFit_Click()
    If Screen.ActiveForm.Caption = "C.O.B.I.S. - TERMINAL ADMNISTRATIVA" Then
        FPrincipal.Left = 0   '15
        FPrincipal.Top = 0   '15
        FPrincipal.Width = 9570
        FPrincipal.Height = 7170
    Else
        If Screen.ActiveForm.WindowState = 0 Then
            Screen.ActiveForm.Left = 0
            Screen.ActiveForm.Top = 0
            Screen.ActiveForm.Width = 9450
            Screen.ActiveForm.Height = 5900
        Else
            If FPrincipal.WindowState = 0 Then
              FPrincipal.Left = 0   '15
              FPrincipal.Top = 0   '15
              FPrincipal.Width = 9570
              FPrincipal.Height = 7170
            End If
        End If
    End If
End Sub

Private Sub mnuTranAho1_Click(Index As Integer)
    Select Case Index%
    Case 0
        FTran351.Show
    Case 1
        FTRAN354.Show
    Case 2
        VGAperCifrada = False
        FTran201.Show
    Case 3
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Actualización de Cuentas de Ahorro"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 202
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 4
        FTran205.Show
    Case 5
        VGAperCifrada = True
        FTran201.Show
    Case 6
       FMotorBusq.Caption = "Activación de Cuenta sin Depósito Inicial"
       PMLimpiaG FMotorBusq.grdCuentas
       FMotorBusq.Tag = 437
       FMotorBusq.Show
    End Select
End Sub

Private Sub mnuTranAho2_Click(Index As Integer)
    Select Case Index%
    Case 0
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Bloqueo de Movimientos"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 211
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 1
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Bloqueo de Valores en Cuenta de Ahorros"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 217
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    End Select
End Sub

Private Sub mnuTranAho3_Click(Index As Integer)
    Select Case Index%
    Case 0
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Desbloqueo de Movimientos"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 212
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
        
    Case 1
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "De Bloqueos de Valor en Cuentas de Ahorro"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 218
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    End Select
End Sub

Private Sub mnuTranAho6_Click(Index As Integer)
    Select Case Index%
    Case 0
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Reactivación de Cuentas"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 203
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 1
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Reapertura de Cuentas"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 204
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 2
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Cancelación de Cuentas"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 214
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 3
        FTran367.Show
    End Select
End Sub

Private Sub mnuTranAho7_Click(Index As Integer)
    Select Case Index%
    Case 1
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Bloqueos de Valores en la Cuentas"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 216
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 2
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Bloqueo de Movimientos"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 245
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 3
        FTran357.Show
    Case 5
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Saldos"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 230
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 6
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Saldos y Promedios"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 220
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 7
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta General"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 235
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 8
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Movimientos"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 232
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 9
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Valores en Suspenso"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 247
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 10
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Detalle de Cálculo de Intereses"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 14
         'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Extracto de Cuenta de Ahorros"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 234
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 15
        FMotorBusq.Caption = "Extracto de Cuenta de Ahorros Sin Costo"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 223
        FMotorBusq.Show
    Case 18
        Ftran302.Show
    Case 22
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta de Canje por Cuenta"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 96
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 23
        'INI CMUNOZ Req FRC-AHO-003 BPT
        FMotorBusq.Caption = "Consulta Cuentas con Caracteristicas Especiales"
        PMLimpiaG FMotorBusq.grdCuentas
        FMotorBusq.Tag = 96
        FMotorBusq.Show
        'FIN CMUNOZ Req FRC-AHO-003 BPT
    Case 24
        FTran436.Show
    End Select
End Sub

Private Sub mnuTranAho8_Click(Index As Integer)
    Select Case Index%
    Case 1
        FHistoricoAM.Show
    Case 2
        FHistoricoAS.Show
    End Select
End Sub

Private Sub mnuTranCtaAho_Click(Index As Integer)
    Select Case Index%
        Case 7
            'INI CMUNOZ Req FRC-AHO-003 BPT
            FMotorBusq.Caption = "Cobro de Valores en Suspenso"
            PMLimpiaG FMotorBusq.grdCuentas
            FMotorBusq.Tag = 303
            FMotorBusq.Show
            'FIN CMUNOZ Req FRC-AHO-003 BPT
        Case 15
            'INI CMUNOZ Req FRC-AHO-003 BPT
            FMotorBusq.Caption = "Liberación Anticipada de Canje"
            PMLimpiaG FMotorBusq.grdCuentas
            FMotorBusq.Tag = 98
            FMotorBusq.Show
            'FIN CMUNOZ Req FRC-AHO-003 BPT
    End Select
End Sub

Private Sub mnuTranRemesas_Click(Index As Integer)
    Select Case Index%
    Case 0
        FTran601.Show
    Case 1
        FTran602.Show
    Case 2
        FTran407.Show
    Case 4
        FTran410.Show
    Case 5
        FTran408.Show
    Case 6
        FTran429.Show
    Case 7
        FTran417.Show
    Case 8
        FTran604.Show
    Case 9
        FTran605.Show
    'Case 10
    '    FTran433.Show
    End Select
End Sub

Private Sub mnuTransferencias_Click(Index As Integer)
    Select Case Index%
        Case 1
            FTran2576.Show
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
    'pnlHora.Caption = Format$(Time$, "HH:MM")
   If VGFecha$ = "" Then
      pnlHora.Caption = Format$(Now, VGFormatoFecha$ + " hh:mm")
   Else
      pnlHora.Caption = Format(VGFecha$, VGFormatoFecha$) + Format$(Now, " hh:mm")
   End If
End Sub

Private Sub PMFormCloseAll_Salir()
'*************************************************************
' PROPOSITO: Cierra todas las Formas excepto la FPrincipal para Salir.
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21-Mar-03      J. Hidalgo        Emisión Inicial
'*************************************************************
Dim form As form
On Error GoTo manejo_error
  For Each form In Forms
    Select Case form.Name
           Case "FPrincipal"
           Case Else
                Unload form
    End Select
  Next form
  Exit Sub
manejo_error:
  Resume Next
End Sub

Public Sub PMDesconectar()
'*************************************************************
' PROPOSITO: Desconecta al usuario
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 11-Sep-09      O.Usiña        Emisión Inicial
'*************************************************************
    PMFormCloseAll_Salir
    PMLogOff
    Iniciar_Preferencias ARCHIVOINI
    Forma_Preferencias
End Sub

Private Sub PMLiberarBCliente()
    'reinicializar Busqueda de Clientes
    If Not (VGFBusCliente Is Nothing) Then
      Set VGFBusCliente = Nothing
    End If
End Sub

'OUS
Private Sub tmrMail_Timer()
'OJO Se debe descomentar cuando se ponga a funcionar VGEjecProc desde el FMTransmitir
'RQU:Para que revise constantemente si existe línea y en el caso de estar fuera de línea que avise cuando esta regresa
  If VGEjecProc% Then
     Exit Sub
  Else
    FMGetMail (FMGetServer())
  End If
End Sub

'-------------------------------------------
' Control de tiempo para timeout de conexion
'-------------------------------------------
Private Sub VGHook_timeout()
Dim VTForm As form
Dim ban As Boolean

ban = False
For Each VTForm In Forms
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
    If UCase(VTForm.Name) = UCase("FPrincipal") Then
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
End Sub


Private Sub PMDireccionPath()
On Error GoTo error
Dim cp As CopiaDir.CopiaDirectorios
Set cp = New CopiaDir.CopiaDirectorios
PathUnico = cp.CreaDirectorios(App.Path, App.EXEName, "TADMIN.INI")
If PathUnico = "" Then
   PathUnico = App.Path
End If
Exit Sub
error:
    MsgBox "Error: " + Err.Description, , "Atención"
    PathUnico = App.Path
End Sub

