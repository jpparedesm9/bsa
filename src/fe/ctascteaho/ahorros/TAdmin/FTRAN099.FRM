VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran099 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Definición de Mensajes para Estados de Cuenta por Oficina"
   ClientHeight    =   5835
   ClientLeft      =   330
   ClientTop       =   2325
   ClientWidth     =   9420
   BeginProperty Font 
      Name            =   "Small Fonts"
      Size            =   6
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1097
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   Picture         =   "FTRAN099.frx":0000
   ScaleHeight     =   5835
   ScaleWidth      =   9420
   Begin VB.TextBox txtCampo 
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
      Height          =   285
      Index           =   7
      Left            =   1100
      MaxLength       =   79
      TabIndex        =   8
      Top             =   2720
      Width           =   7200
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   8460
      Picture         =   "FTRAN099.frx":08CA
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   24
      Top             =   1620
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8700
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   23
      Top             =   1620
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8430
      TabIndex        =   11
      Top             =   780
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Eliminar"
      ForeColor       =   0
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8430
      TabIndex        =   10
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8430
      TabIndex        =   14
      Top             =   5025
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8430
      TabIndex        =   13
      Top             =   4260
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8430
      TabIndex        =   12
      Top             =   3495
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
      ForeColor       =   0
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   1275
      Left            =   15
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   4500
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14684
      _ExtentY        =   2249
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
   Begin MSGrid.Grid grdOficinas 
      Height          =   1245
      Left            =   10
      TabIndex        =   25
      TabStop         =   0   'False
      Top             =   3150
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14684
      _ExtentY        =   2196
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
      Index           =   5
      Left            =   8430
      TabIndex        =   27
      Top             =   2730
      WhatsThisHelpID =   2031
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Actualizar"
      ForeColor       =   0
      Enabled         =   0   'False
   End
   Begin Threed.SSFrame frmBloqueo 
      Height          =   3120
      Left            =   0
      TabIndex        =   19
      Top             =   -45
      Width           =   8355
      _Version        =   65536
      _ExtentX        =   14737
      _ExtentY        =   5503
      _StockProps     =   14
      Caption         =   " Datos de las Líneas "
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin VB.ComboBox cmbProducto 
         Height          =   270
         Left            =   1100
         TabIndex        =   31
         Text            =   "CTA. AHORROS"
         Top             =   600
         Width           =   2175
      End
      Begin VB.TextBox txtCampo 
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
         Height          =   285
         Index           =   6
         Left            =   1100
         MaxLength       =   79
         TabIndex        =   7
         Top             =   2460
         Width           =   7200
      End
      Begin VB.TextBox txtCampo 
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
         Height          =   285
         Index           =   5
         Left            =   1100
         MaxLength       =   5
         TabIndex        =   2
         Top             =   920
         Width           =   735
      End
      Begin VB.TextBox txtCampo 
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
         Height          =   285
         Index           =   4
         Left            =   1100
         MaxLength       =   33
         TabIndex        =   6
         Top             =   2160
         Width           =   7200
      End
      Begin VB.TextBox txtCampo 
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
         Height          =   285
         Index           =   3
         Left            =   1100
         MaxLength       =   33
         TabIndex        =   5
         Top             =   1845
         Width           =   7200
      End
      Begin VB.TextBox txtCampo 
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
         Height          =   285
         Index           =   1
         Left            =   1100
         MaxLength       =   33
         TabIndex        =   3
         Top             =   1220
         Width           =   7200
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Index           =   0
         Left            =   1800
         TabIndex        =   0
         Top             =   270
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin VB.TextBox txtCampo 
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
         Height          =   285
         Index           =   2
         Left            =   1095
         MaxLength       =   33
         TabIndex        =   4
         Top             =   1530
         Width           =   7200
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Index           =   1
         Left            =   5220
         TabIndex        =   1
         Top             =   270
         Width           =   1455
         _ExtentX        =   2566
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Producto:"
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
         Index           =   9
         Left            =   75
         TabIndex        =   30
         Top             =   615
         Width           =   840
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Línea 6:"
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
         Index           =   8
         Left            =   75
         TabIndex        =   29
         Top             =   2720
         Width           =   735
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Línea 5:"
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
         Index           =   7
         Left            =   75
         TabIndex        =   28
         Top             =   2420
         Width           =   735
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Fecha Fin.Vigencia:"
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
         Index           =   1
         Left            =   3420
         TabIndex        =   26
         Top             =   300
         WhatsThisHelpID =   5047
         Width           =   1785
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   1840
         TabIndex        =   15
         Top             =   920
         Width           =   4545
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Producto B:"
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
         Index           =   4
         Left            =   75
         TabIndex        =   22
         Top             =   915
         Width           =   1020
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Línea 3:"
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
         Index           =   6
         Left            =   75
         TabIndex        =   17
         Top             =   1820
         Width           =   735
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Línea 2:"
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
         Index           =   5
         Left            =   75
         TabIndex        =   18
         Top             =   1520
         Width           =   735
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Línea 4:"
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
         Index           =   0
         Left            =   75
         TabIndex        =   21
         Top             =   2120
         Width           =   735
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Línea 1:"
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
         Index           =   3
         Left            =   75
         TabIndex        =   20
         Top             =   1220
         Width           =   735
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Fecha Ini.Vigencia:"
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
         Index           =   2
         Left            =   75
         TabIndex        =   16
         Top             =   300
         WhatsThisHelpID =   5046
         Width           =   1740
      End
   End
   Begin VB.Line Line2 
      X1              =   840
      X2              =   3960
      Y1              =   4200
      Y2              =   4200
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8355
      Y1              =   4440
      Y2              =   4455
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   -30
      Y2              =   5880
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8355
      Y1              =   3120
      Y2              =   3120
   End
End
Attribute VB_Name = "FTran099"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'*************************************************************
' ARCHIVO:          FTran099.frm
' NOMBRE LOGICO:    FTran099
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
' Permite definir los mensajes que se van a imprimir en los es-
' tados de cuenta por oficina.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLPaso As Integer
'Dim VLFormatoFecha As String
'CloVargas Oct/23/01 Manejo de Formato Fecha
Dim VLTipo As Integer
Dim vltodas As Integer
Dim VLPrimeravez As Integer
'FIXIT: Declare JTA 'VLDia' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Dim VLDia As Integer
Dim VLFechaAnt As String
Dim VLFechaFinAnt As String
Dim VLSigPuntos As Boolean      ' Controla el buscar siguientes automaticamente
Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Actualiza el valor de las lineas de los mensajes
'            que se van a imprimir en los estados de cuenta.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

       If mskValor(0).ClipText = "" Then
          MsgBox "La fecha inicial de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
          mskValor(0).SetFocus
          Exit Sub
       End If
       
       If mskValor(1).ClipText = "" Then
          MsgBox "La fecha final de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
          mskValor(1).SetFocus
          Exit Sub
       End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
       If Trim(txtCampo(5).Text) = "" Then
          MsgBox "El producto es mandatorios", 0 + 16, "Mensaje de Error"
          txtCampo(5).SetFocus
          Exit Sub
       End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
       If Trim(txtCampo(1).Text) = "" And Trim(txtCampo(2).Text) = "" And Trim(txtCampo(3).Text) = "" And Trim(txtCampo(4).Text) = "" And Trim(txtCampo(7).Text) = "" And Trim(txtCampo(6).Text) = "" Then
          MsgBox "Los campos líneas son mandatorios", 0 + 16, "Mensaje de Error"
          txtCampo(1).SetFocus
          Exit Sub
       End If
       For i% = 1 To grdOficinas.Rows - 1
           grdOficinas.Row = i%
           grdOficinas.Col = 0
           If grdOficinas.Picture = picVisto(0) Then
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "99"
              PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "U"
              grdOficinas.Col = 1
              PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (grdOficinas.Text)
              VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
              VTFFin$ = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
              PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFDesde$
              PMPasoValores sqlconn&, "@i_linea1", 0, SQLVARCHAR, (txtCampo(1).Text)
              PMPasoValores sqlconn&, "@i_linea2", 0, SQLVARCHAR, (txtCampo(2).Text)
              PMPasoValores sqlconn&, "@i_linea3", 0, SQLVARCHAR, (txtCampo(3).Text)
              PMPasoValores sqlconn&, "@i_linea4", 0, SQLVARCHAR, (txtCampo(4).Text)
              PMPasoValores sqlconn&, "@i_linea5", 0, SQLVARCHAR, (txtCampo(6).Text)
              PMPasoValores sqlconn&, "@i_linea6", 0, SQLVARCHAR, (txtCampo(7).Text)
              PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT2, "0"
              If txtCampo(5).Text <> "T" Then
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, txtCampo(5).Text
              Else
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "-1"
              End If
              PMPasoValores sqlconn&, "@i_fecha_ini_ant", 0, SQLDATETIME, FMConvFecha(VLFechaAnt$, VGFormatoFecha$, CGFormatoBase$)
              PMPasoValores sqlconn&, "@i_fecha_fin_ant", 0, SQLDATETIME, FMConvFecha(VLFechaFinAnt$, VGFormatoFecha$, CGFormatoBase$)
              PMPasoValores sqlconn&, "@i_fecha_fin", 0, SQLDATETIME, VTFFin$
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mensaje_estcta", True, " Ok... Actualización de Líneas de mensajes") Then
                 PMMapeaGrid sqlconn&, grdPropietarios, False
                 PMChequea sqlconn&
              Else
                 PMLimpiaGrid grdPropietarios
              End If
           End If
       Next i%
       'lblDescripcion(0).Caption = ""
       cmdBoton_Click 3
       For i% = 1 To 7
        If i% <> 5 Then
            txtCampo(i%) = ""
        End If
       Next i%
End Sub

Private Sub cmbProducto_LostFocus()
    PLLimpiar
End Sub

Private Sub Form_Load()
'FIXIT: Declare JTA 'VTFecha' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
  Dim VTFecha As String
  VLPrimeravez = False
  VLSigPuntos = False
  FTran099.Left = 0   '15
  FTran099.Top = 0   '15
  FTran099.Width = 9450   '9420
  FTran099.Height = 6350   '5730
  PMLoadResStrings Me
  PMLoadResIcons Me
'  VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
  mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha$)
  mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha$)
  ' Retorna el ultimo dia del mes en curso
  'VTFecha = DateAdd("m", 1, VGFecha$)
  'VTFecha = DateAdd("d", (-1) * (Day(VTFecha)), VTFecha)
  VTFecha = VGFecha$
  'Retorna el dia de la semana
  VLDia = Weekday(VTFecha)
  'Validacion para evitar el fin de semana
  Select Case VLDia
      Case 1 'Domingo
          VTFecha = DateAdd("d", -2, VTFecha)
      Case 7 'Sabado
          VTFecha = DateAdd("d", -1, VTFecha)
  End Select
  mskValor(0).Text = Format$(VTFecha, VGFormatoFecha$)
  mskValor(1).Text = Format$(VTFecha, VGFormatoFecha$)
  cmbProducto.AddItem "CTA. AHORROS", 0
  cmbProducto.AddItem "CTA. CORRIENTE", 1
  cmbProducto.ListIndex = 0
  PLConsultarOficinas 0
  Do While VLSigPuntos
     PLConsultarOficinas 1
  Loop
  For vti% = 1 To grdOficinas.Rows - 1
     grdOficinas.Row = vti%
     PMMarcarRegistro
  Next vti%
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
  Select Case Index%
  Case 0
       PLTransmitir
  Case 1
       PLLimpiar
  Case 2
       Unload FTran099
  Case 3
       PLBuscar
  Case 4
       PLEliminar
  Case 5
       PLActualizar
  End Select
End Sub
Private Sub grdOficinas_Click()
    grdOficinas.Col = 0
    grdOficinas.SelStartCol = 1
    grdOficinas.SelEndCol = grdOficinas.Cols - 1
    If grdOficinas.Row = 0 Then
        grdOficinas.SelStartRow = 1
        grdOficinas.SelEndRow = 1
    Else
        grdOficinas.SelStartRow = grdOficinas.Row
        grdOficinas.SelEndRow = grdOficinas.Row
    End If
End Sub

Private Sub grdOficinas_DblClick()
    If grdOficinas.Rows <= 2 Then
       grdOficinas.Row = 1
       grdOficinas.Col = 1
       If Trim$(grdOficinas.Text) = "" Then
          MsgBox "No existen Agencias", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If
    PMMarcarRegistro
End Sub

Private Sub grdPropietarios_DblClick()
    PLDesmarcarRegistros
    grdPropietarios.Col = 1
    If grdPropietarios.Text <> "" Then
       grdPropietarios.Col = 1
       VTValorcol$ = grdPropietarios.Text
       For i% = 1 To grdOficinas.Rows - 1
          grdOficinas.Row = i%
          grdOficinas.Col = 1
          VTOfiTemp$ = grdOficinas.Text
          If VTValorcol$ = VTOfiTemp Then
             grdOficinas.Col = 0
             grdOficinas.Picture = picVisto(0)
          End If
       Next i%
       grdPropietarios.Col = 2    'Mensaje 1
       txtCampo(1).Text = grdPropietarios.Text
       grdPropietarios.Col = 3    'Mensaje 2
       txtCampo(2).Text = grdPropietarios.Text
       grdPropietarios.Col = 4    'Mensaje 3
       txtCampo(3).Text = grdPropietarios.Text
       grdPropietarios.Col = 5    'Mensaje 4
       txtCampo(4).Text = grdPropietarios.Text
       grdPropietarios.Col = 6    'Mensaje 5
       txtCampo(6).Text = grdPropietarios.Text
       grdPropietarios.Col = 7    'Mensaje 6
       txtCampo(7).Text = grdPropietarios.Text
       grdPropietarios.Col = 8    'Fecha Inicial anterior para actualización
       VLFechaAnt$ = grdPropietarios.Text
       grdPropietarios.Col = 9    'Fecha Final anterior para actualización
       VLFechaFinAnt$ = grdPropietarios.Text
       
       'grdPropietarios.Col = 8    'mensaje 5
       'txtCampo(6).Text = grdPropietarios.Text
       'grdPropietarios.Col = 9    'mensaje 6
       'txtCampo(7).Text = grdPropietarios.Text

             
       If txtCampo(5).Text = "" Then
          txtCampo(5).Text = "T"
          lblDescripcion(0).Caption = "Todos los productos"
       End If
       txtCampo(5).Enabled = False
       'cmdBoton(4).Enabled = True
       cmdBoton(3).Enabled = False
       cmdBoton(5).Enabled = True
       cmdBoton(0).Enabled = False
    End If
End Sub
Private Sub mskValor_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Fecha de Impresión del Estado de Cuenta [" & VGFormatoFecha & "]"
    mskValor(Index).SelStart = 0
    mskValor(Index).SelLength = Len(mskValor(Index).Text)
    FPrincipal!pnlTransaccionLine.Caption = "FTran099 - V. 7"
End Sub

Private Sub mskValor_LostFocus(Index As Integer)
        If mskValor(Index).ClipText <> "" Then
            VTValido% = FMVerFormato((mskValor(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido% Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index).SetFocus
                Exit Sub
            End If
        End If
        mskValor(Index).Mask = FMMascaraFecha(VGFormatoFecha$)
        If Index% = 1 Then
           If mskValor(1).ClipText <> "" And mskValor(0).ClipText <> "" Then
              VTDias& = DateDiff("d", (mskValor(1).FormattedText), (mskValor(0).FormattedText))
              If VTDias& > 0 Then
                MsgBox "La fecha inicial debe ser menor que la fecha final de vigencia", 48, "Mensaje de Error"
                mskValor(0).SetFocus
                Exit Sub
               End If
           End If
        End If
        
        
'        If mskValor(0).ClipText <> "" Then
'            VTDias& = DateDiff("d", (mskValor(0).FormattedText), (VGFecha$))
'            If VTDias& > 0 Then
'                MsgBox "Fecha Fuera de Rango", 48, "Mensaje de Error"
'                mskValor(0).SetFocus
'                Exit Sub
'            End If
'        Else
'            mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha$)
'        End If
End Sub


Private Sub PLConsultarOficinas(parIndex As Integer)
'*************************************************************
' PROPOSITO: Llena el grid de oficinas con los datos retornados
'            por el stored procedure de consulta de oficinas.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    VTFirst% = True
    VTAnteriorVTR% = 1
    If parIndex% = 0 Then
       PMLimpiaGrid grdOficinas
       grdPropietarios.Enabled = False
       vltodas = False
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "34"
       PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
       PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "O"
     Else
       grdOficinas.Col = 1
       grdOficinas.Row = grdOficinas.Rows - 1
       
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "34"
       PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
       PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "O"
       PMPasoValores sqlconn&, "@i_sig", 0, SQLINT2, grdOficinas.Text
    End If
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", False, "") Then
       VTAnteriorVTR% = 1
       PMMapeaGrid sqlconn&, grdOficinas, parIndex
       PMChequea sqlconn&
       VTR% = Val(grdOficinas.Tag)
        If Val(grdOficinas.Tag) >= 20 Then
            VLSigPuntos = True
        Else
            VLSigPuntos = False
        End If
    Else
       PMChequea sqlconn&
    End If
    If grdOficinas.Row > 2 Then
        grdOficinas.Row = 0
        grdOficinas.Col = 0
        grdOficinas.Text = "No."
        grdOficinas.Col = 1
        grdOficinas.Text = "CODIGO"
        grdOficinas.Col = 2
        grdOficinas.Text = "NOMBRE DE OFICINA"
        grdOficinas.ColWidth(0) = 450
        grdOficinas.ColWidth(1) = 1000
        grdOficinas.ColWidth(2) = 6600
    End If
End Sub




Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Agencia para asignar los mensajes [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Primera línea de mensajes"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Segunda línea de mensajes"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Tercera línea de mensajes"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Cuarta línea de mensajes"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Producto Bancario [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Select Case Index%
    Case 0
        If Keycode% = VGTeclaAyuda% Then
            VGOperacion$ = "sp_oficina"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(0).Text & "]") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
            End If
            VLPaso% = True
        End If
    Case 5
        If Keycode% = VGTeclaAyuda% Then
            If cmbProducto.ListIndex = 0 Then
                VTProdBanc$ = 4
            Else
                VTProdBanc$ = 3
            End If
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
            PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, VTProdBanc$
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, " Consulta de Productos Bancarios") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(5).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            End If
            VLPaso% = True
        End If
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 5
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 1, 2, 3, 4, 6, 7
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso% = False Then
        Select Case Index%
        Case 0
'            If txtCampo(0).Text <> "" And txtCampo(0).Text <> "0" Then
'                PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "H"
'                PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, txtCampo(0).Text
'                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
'                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
'                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_agencia", True, " Ok... Consulta de agencias") Then
'                    PMMapeaObjeto sqlconn&, lblDescripcion(1)
'                    PMChequea sqlconn&
'                Else
'                    lblDescripcion(1).Caption = ""
'                    txtCampo(0).Text = ""
'                    txtCampo(0).SetFocus
'                End If
'            Else
'                If txtCampo(0).Text <> "0" Then
'                    lblDescripcion(1).Caption = ""
'                Else
'                    lblDescripcion(1).Caption = "AGENCIA GENERAL PARA LA FECHA " + mskValor(0).Text
'                End If
'            End If
        Case 5
            If txtCampo(5).Text <> "" Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
                PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, txtCampo(5).Text
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, " Ok... Consulta de Productos Bancarios") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    lblDescripcion(0).Caption = ""
                    txtCampo(5).Text = ""
                    'txtCampo(5).SetFocus
                End If
            Else
                 'txtCampo(5).SetFocus
                lblDescripcion(0).Caption = ""
            End If

        End Select
    End If
End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Selecciona y quita la seleccion a una fila del
'            grid de oficinas
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    
    If grdOficinas.Row <> 0 Then
       grdOficinas.Col = 0
       If grdOficinas.Picture = picVisto(1) Then
          grdOficinas.Text = Str$(grdOficinas.Row)
          grdOficinas.Picture = picVisto(0)
       Else
          grdOficinas.Text = Str$(grdOficinas.Row)
          grdOficinas.Picture = picVisto(1)
       End If
    End If
End Sub
Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Ingresa un mensaje para el estado de cuenta de una
'            oficina.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
       ' Validacion de Mandatoriedades
       ' Producto bancario
'       If txtCampo(5).Text = "" Then
'          MsgBox "El Producto Bancario es mandatorio", 0 + 16, "Mensaje de Error"
'          txtCampo(5).SetFocus
'          Exit Sub
'       End If
       If mskValor(0).ClipText = "" Then
          MsgBox "La fecha inicial de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
          mskValor(0).SetFocus
          Exit Sub
       End If
       
       If mskValor(1).ClipText = "" Then
          MsgBox "La fecha final de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
          mskValor(1).SetFocus
          Exit Sub
       End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
       If Trim(txtCampo(5).Text) = "" Then
          MsgBox "El producto es mandatorios", 0 + 16, "Mensaje de Error"
          txtCampo(5).SetFocus
          Exit Sub
       End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
       If Trim(txtCampo(1).Text) = "" And Trim(txtCampo(2).Text) = "" And Trim(txtCampo(3).Text) = "" And Trim(txtCampo(4).Text) = "" And Trim(txtCampo(6).Text) = "" And Trim(txtCampo(7).Text) = "" Then
          MsgBox "Los campos líneas son mandatorios", 0 + 16, "Mensaje de Error"
          txtCampo(1).SetFocus
          Exit Sub
       End If
       VTBandera% = 0
       For i% = 1 To grdOficinas.Rows - 1
           grdOficinas.Row = i%
           grdOficinas.Col = 0
           If grdOficinas.Picture = picVisto(0) Then
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "99"
              PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "I"
              grdOficinas.Col = 1
              PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (grdOficinas.Text)
              VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
              VTFFin$ = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
              PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFDesde$
              PMPasoValores sqlconn&, "@i_linea1", 0, SQLVARCHAR, (txtCampo(1).Text)
              PMPasoValores sqlconn&, "@i_linea2", 0, SQLVARCHAR, (txtCampo(2).Text)
              PMPasoValores sqlconn&, "@i_linea3", 0, SQLVARCHAR, (txtCampo(3).Text)
              PMPasoValores sqlconn&, "@i_linea4", 0, SQLVARCHAR, (txtCampo(4).Text)
              PMPasoValores sqlconn&, "@i_linea5", 0, SQLVARCHAR, (txtCampo(6).Text)
              PMPasoValores sqlconn&, "@i_linea6", 0, SQLVARCHAR, (txtCampo(7).Text)
              PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT2, "0"
              If txtCampo(5) <> "" Then
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, txtCampo(5).Text
              Else
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "-1"
              End If
              PMPasoValores sqlconn&, "@i_fecha_fin", 0, SQLDATETIME, VTFFin$
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mensaje_estcta", True, " Ok... Consulta de Líneas de mensajes") Then
                 PMMapeaGrid sqlconn&, grdPropietarios, False
                 PMChequea sqlconn&
                 VTBandera% = i%
              Else
                 PMLimpiaGrid grdPropietarios
              End If
           End If
       Next i%
       
      cmdBoton_Click 3
      If VTBandera% <> 0 Then
         For i% = 1 To 7
           If i% <> 5 Then
                txtCampo(i%).Text = ""
           End If
         Next i%
      End If
       
End Sub
Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Elimina los mensajes definidos para una oficina
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    For i% = 1 To grdOficinas.Rows - 1
        grdOficinas.Row = i%
        grdOficinas.Col = 0
        If grdOficinas.Picture = picVisto(0) Then
           grdOficinas.Col = 2
           If MsgBox("¿Seguro que desea eliminar los mensajes de la agencia: " & grdOficinas.Text & " ?", 32 + 4, "Mensaje del Sistema") = 6 Then
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "99"
              PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "E"
              grdOficinas.Col = 1
              PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (grdOficinas.Text)
              VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
              VTFFin$ = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
              PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFDesde$
              PMPasoValores sqlconn&, "@i_linea1", 0, SQLVARCHAR, (txtCampo(1).Text)
              PMPasoValores sqlconn&, "@i_linea2", 0, SQLVARCHAR, (txtCampo(2).Text)
              PMPasoValores sqlconn&, "@i_linea3", 0, SQLVARCHAR, (txtCampo(3).Text)
              PMPasoValores sqlconn&, "@i_linea4", 0, SQLVARCHAR, (txtCampo(4).Text)
              PMPasoValores sqlconn&, "@i_linea5", 0, SQLVARCHAR, (txtCampo(6).Text)
              PMPasoValores sqlconn&, "@i_linea6", 0, SQLVARCHAR, (txtCampo(7).Text)
              PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT2, "0"
              If txtCampo(5).Text <> "" Then
                 If txtCampo(5).Text <> "T" Then
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, txtCampo(5).Text
                 Else
                    PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "-1"
                 End If
              Else
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "-1"
              End If
              PMPasoValores sqlconn&, "@i_fecha_fin", 0, SQLDATETIME, VTFFin$
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mensaje_estcta", True, " Ok... Eliminación de Líneas de mensajes") Then
                 PMMapeaGrid sqlconn&, grdPropietarios, False
                 PMChequea sqlconn&
              Else
                 PMLimpiaGrid grdPropietarios
              End If
           End If
        End If
    Next i%
    For i% = 1 To 7
        If i% <> 5 Then
            txtCampo(i%) = ""
        End If
    Next i%
    
    cmdBoton_Click 3
    'lblDescripcion(0).Caption = ""
    mskValor(0).SetFocus
End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia los objetos de la forma
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha$)
    mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha$)
    ' Retorna el ultimo dia del mes en curso
    VTFecha = DateAdd("m", 1, VGFecha$)
    VTFecha = DateAdd("d", (-1) * (Day(VTFecha)), VTFecha)
    'Retorna el dia de la semana
    VLDia = Weekday(VTFecha)
    'Validacion para evitar el fin de semana
    Select Case VLDia
        Case 1 'Domingo
            VTFecha = DateAdd("d", -2, VTFecha)
        Case 7 'Sabado
            VTFecha = DateAdd("d", -1, VTFecha)
    End Select
    mskValor(0).Text = Format$(VTFecha, VGFormatoFecha$)
    mskValor(1).Text = Format$(VTFecha, VGFormatoFecha$)
    lblDescripcion(0).Caption = ""
    txtCampo(5).Enabled = True
    For i% = 1 To 7
        txtCampo(i%).Text = ""
    Next i%
    PMLimpiaGrid grdPropietarios
    PLDesmarcarRegistros
    cmdBoton(3).Enabled = True
    cmdBoton(0).Enabled = True
    mskValor(0).SetFocus
    cmdBoton(5).Enabled = False
    'cmdBoton(4).Enabled = False
    cmdBoton(3).Enabled = True
    For vti% = 1 To grdOficinas.Rows - 1
     grdOficinas.Row = vti%
     PMMarcarRegistro
    Next vti%
    
End Sub
Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid que contiene el listado de mensajes
'            definidos para los estados de cuenta.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

     ' Validacion de Mandatoriedades
     ' Producto bancario
'     If txtCampo(5).Text = "" Then
'        MsgBox "El Producto Bancario es mandatorio", 0 + 16, "Mensaje de Error"
'        txtCampo(5).SetFocus
'        Exit Sub
'     End If
     If mskValor(0).ClipText = "" Then
       MsgBox "La fecha inicial de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
       mskValor(0).SetFocus
       Exit Sub
     End If
       
     If mskValor(1).ClipText = "" Then
       MsgBox "La fecha final de vigencia es mandatoria", 0 + 16, "Mensaje de Error"
       mskValor(1).SetFocus
       Exit Sub
     End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim(txtCampo(5).Text) = "" Then
          MsgBox "El producto es mandatorios", 0 + 16, "Mensaje de Error"
          If txtCampo(5).Enabled = False Then
            txtCampo(5).Enabled = True
          End If
          txtCampo(5).SetFocus
          Exit Sub
    End If
     PLDesmarcarRegistros
     VLTipo = 1
     VTRows% = 20
     VTVez% = 1
     While VTRows% = 20
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "99"
           PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "C"
           If VLTipo = 1 Then
              If VTVez% = 1 Then
                 PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, "-1"
              Else
                 grdPropietarios.Row = grdPropietarios.Rows - 1
                 grdPropietarios.Col = 1
                 PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (grdPropietarios.Text)
              End If
           Else
              PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, txtCampo(0).Text
           End If
           VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
           VTFFin$ = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
           PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFDesde$
           If txtCampo(5).Text <> "" Then
              If txtCampo(5).Text <> "T" Then
                 PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, txtCampo(5).Text
                 Else
                    PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "-1"
              End If
            Else
              PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "-1"
           End If
           PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT2, "0"
           PMPasoValores sqlconn&, "@i_linea1", 0, SQLVARCHAR, (txtCampo(1).Text)
           PMPasoValores sqlconn&, "@i_linea2", 0, SQLVARCHAR, (txtCampo(2).Text)
           PMPasoValores sqlconn&, "@i_linea3", 0, SQLVARCHAR, (txtCampo(3).Text)
           PMPasoValores sqlconn&, "@i_linea4", 0, SQLVARCHAR, (txtCampo(4).Text)
           PMPasoValores sqlconn&, "@i_linea5", 0, SQLVARCHAR, (txtCampo(6).Text)
           PMPasoValores sqlconn&, "@i_linea6", 0, SQLVARCHAR, (txtCampo(7).Text)
           PMPasoValores sqlconn&, "@i_fecha_fin", 0, SQLDATETIME, VTFFin$
           PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT2, VGFecha_SP$
           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_mensaje_estcta", True, " Ok... Consulta de Líneas de mensajes") Then
              If VTVez% = 1 Then
                 PMMapeaGrid sqlconn&, grdPropietarios, False
                 If grdPropietarios.Row = 0 Then
                    grdPropietarios.Enabled = False
                 Else
                    grdPropietarios.Enabled = True
                 End If
              Else
                 PMMapeaGrid sqlconn&, grdPropietarios, True
              End If
              PMChequea sqlconn&
              VTRows% = Val(grdPropietarios.Tag)
              VTVez% = VTVez% + 1
           Else
              PMLimpiaGrid grdPropietarios
              VTRows% = 0
           End If
    Wend
End Sub

Private Sub PLDesmarcarRegistros()
'*************************************************************
' PROPOSITO: Quita la seleccion de una fila del grid que con-
'            tiene el listado de oficinas.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    For i% = 1 To grdOficinas.Rows - 1
        grdOficinas.Row = i%
        If grdOficinas.Row <> 0 Then
           grdOficinas.Col = 0
           If grdOficinas.Picture = picVisto(0) Then
              grdOficinas.Text = Str$(grdOficinas.Row)
              grdOficinas.Picture = picVisto(1)
           End If
       End If
    Next i%
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 1, 2, 3, 4, 6, 7
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub

