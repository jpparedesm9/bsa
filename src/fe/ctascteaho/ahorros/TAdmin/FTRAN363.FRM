VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran363 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Nota de Débito Cuenta Corriente"
   ClientHeight    =   5520
   ClientLeft      =   270
   ClientTop       =   2190
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
   HelpContextID   =   1021
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5520
   ScaleWidth      =   9300
   Begin Threed.SSFrame frmBloqueos 
      Height          =   1650
      Left            =   30
      TabIndex        =   15
      Top             =   720
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14605
      _ExtentY        =   2910
      _StockProps     =   14
      Caption         =   "Datos de la Transacción"
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
      Begin VB.TextBox txtsecuencial 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   5160
         MaxLength       =   120
         ScrollBars      =   2  'Vertical
         TabIndex        =   24
         Top             =   1200
         Visible         =   0   'False
         Width           =   1245
      End
      Begin VB.TextBox txtcuenta 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2100
         MaxLength       =   120
         ScrollBars      =   2  'Vertical
         TabIndex        =   22
         Top             =   1200
         Visible         =   0   'False
         Width           =   1245
      End
      Begin VB.TextBox txtObservacion 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2100
         MaxLength       =   120
         ScrollBars      =   2  'Vertical
         TabIndex        =   3
         Top             =   900
         Width           =   6045
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2100
         MaxLength       =   4
         TabIndex        =   1
         Top             =   300
         Width           =   735
      End
      Begin MSMask.MaskEdBox MskValor 
         Height          =   285
         Index           =   0
         Left            =   2100
         TabIndex        =   2
         Top             =   600
         Width           =   1620
         _ExtentX        =   2858
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         MaxLength       =   30
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
      Begin VB.Label lblObservacion 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Secuencial Trx:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   3720
         TabIndex        =   23
         Top             =   1200
         Visible         =   0   'False
         Width           =   1350
      End
      Begin VB.Label lblObservacion 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "No. Cuenta corriente:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   165
         TabIndex        =   21
         Top             =   1200
         Visible         =   0   'False
         Width           =   1845
      End
      Begin VB.Label lblObservacion 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Descripción: "
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   165
         TabIndex        =   17
         Top             =   900
         Width           =   1140
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Valor:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   165
         TabIndex        =   16
         Top             =   600
         Width           =   510
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   2880
         TabIndex        =   10
         Top             =   300
         Width           =   5295
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Causa:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   135
         TabIndex        =   11
         Top             =   300
         Width           =   600
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   7
      Top             =   4600
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      TabIndex        =   6
      Top             =   1550
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
      Index           =   0
      Left            =   8415
      TabIndex        =   4
      Top             =   780
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
   Begin MSGrid.Grid grdPropietarios 
      Height          =   2715
      Left            =   0
      TabIndex        =   8
      Top             =   2640
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   4789
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
      TabIndex        =   5
      Top             =   3070
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
      Enabled         =   0   'False
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   18
      Top             =   780
      Visible         =   0   'False
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8415
      TabIndex        =   19
      Top             =   3840
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8415
      TabIndex        =   20
      Top             =   2310
      WhatsThisHelpID =   2036
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Reversar"
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
      Left            =   2235
      TabIndex        =   0
      Top             =   45
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Transacciones:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   0
      TabIndex        =   14
      Top             =   2450
      Width           =   1320
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
      TabIndex        =   13
      Top             =   345
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
      Y2              =   5360
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -45
      X2              =   8370
      Y1              =   660
      Y2              =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de cuenta corriente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   105
      TabIndex        =   12
      Top             =   45
      Width           =   2100
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8380
      Y1              =   2415
      Y2              =   2400
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   90
      TabIndex        =   9
      Top             =   345
      Width           =   1845
   End
End
Attribute VB_Name = "FTran363"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran363.frm
' NOMBRE LOGICO:    FTran363
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
'Permite Ingreso de Notas Débito de Cuentas Corrientes.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 07-Sep-05      J.C. Suárez     Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Boolean

Private Sub cmdBoton_Click(Index As Integer)
Dim i As Integer
    Select Case Index
    Case 0
        'Transmitir
        ' Validacion de Mandatoriedades
        ' Numero de la cuenta de ahorros
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Causal de Nota Crédito
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "La causa de la nota crédito es mandatoria", 0 + 16, "Mensaje de Error"
            If txtCampo(0).Enabled = True Then
                txtCampo(0).SetFocus
            End If
            Exit Sub
        End If
        
        ' Valor
        If Val(mskValor(0).ClipText) <= 0 Then
            MsgBox "El valor de la nota debe ser mayor que cero", 0 + 16, "Mensaje de Error"
            If mskValor(0).Enabled = True Then
                mskValor(0).SetFocus
            End If
            Exit Sub
        End If

        ' Descripcion
        If Trim$(txtObservacion.Text) = "" Then
            MsgBox "La Descripción es mandatoria", 0 + 16, "Mensaje de Error"
            If txtObservacion.Enabled = True Then
                txtObservacion.SetFocus
            End If
            Exit Sub
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (mskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, ("cc_causa_nd")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_autndc_cte", True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
            PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton(4).Enabled = True
            cmdBoton_Click (1)
            cmdBoton_Click (3)
        End If

    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        For i = 0 To 1
            lblDescripcion(i).Caption = ""
        Next i
        For i = 0 To 0
            txtCampo(i).Text = ""
        Next i
        mskValor(0).Text = ""
        txtcuenta.Text = ""
        txtObservacion.Text = ""
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = True
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        txtcuenta.Visible = False
        lblObservacion(0).Visible = False
        mskCuenta.SetFocus

    Case 2
        'Salir
        Unload FTran363
    Case 3
        'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         PMPasoValores sqlconn&, "@i_siguiente", 0, SQLINT4, "0"
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (mskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_autndc_cte", True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
             
             If Val(grdPropietarios.Rows - 1) >= 20 Then
                cmdBoton(6).Enabled = True
                cmdBoton(3).Enabled = False
                txtCampo(0).Text = ""
                mskValor(0).Text = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                txtObservacion.Text = ""
                txtcuenta.Text = ""
                txtsecuencial.Text = ""
                lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
             Else
                cmdBoton(6).Enabled = False
             End If
             
             PLAjustaGrid grdPropietarios, Me
             grdPropietarios.ColWidth(4) = 1
             grdPropietarios.ColWidth(6) = 1
         Else
             PMLimpiaGrid grdPropietarios
         End If
    Case 5
        'Reversar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, txtcuenta.Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         PMPasoValores sqlconn&, "@i_sec_rev", 0, SQLINT4, txtsecuencial.Text
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (mskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_autndc_cte", True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
             PMChequea sqlconn&
             
             If Val(grdPropietarios.Rows - 1) >= 20 Then
                cmdBoton(6).Enabled = True
             Else
                cmdBoton(6).Enabled = False
             End If
             
             PLAjustaGrid grdPropietarios, Me
             cmdBoton_Click (1)
             cmdBoton_Click (3)
         Else
             PMLimpiaGrid grdPropietarios
         End If
    Case 6
        'Siguientes
         grdPropietarios.Row = grdPropietarios.Rows - 1
         grdPropietarios.Col = 8
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, "50"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         PMPasoValores sqlconn&, "@i_siguiente", 0, SQLINT4, grdPropietarios.Text
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (mskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_autndc_cte", True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
             PMMapeaGrid sqlconn&, grdPropietarios, True
             PMChequea sqlconn&
             
             If Val(grdPropietarios.Tag) >= 20 Then
                cmdBoton(6).Enabled = True
             Else
                cmdBoton(6).Enabled = False
                cmdBoton(3).Enabled = True
                mskCuenta.SetFocus
             End If
             
             If grdPropietarios.Rows <= 2 Then
                grdPropietarios.Col = 1
                grdPropietarios.Row = 1
               If grdPropietarios.Text = "" Then
                  'PLLimpiar
                  Exit Sub
               End If
             End If
             grdPropietarios.ColWidth(4) = 1
             grdPropietarios.ColWidth(6) = 1
         Else
             PMLimpiaGrid grdPropietarios
         End If
    End Select
End Sub
Sub PLAjustaGrid(Celdas As Grid, Ventana As Object)
Dim VTWidth As Integer
Dim i As Integer
Dim j As Integer
Dim Ancho As Integer
    With Celdas
        For i = 1 To .Cols - 1
            Ancho = 0
            For j = 0 To .Rows - 1
                .Row = j: .Col = i
'FIXIT: 'TextWidth(Celdas.Text' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'TextWidth(Celdas.Text' declare 'Ventana' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                VTWidth = Ventana.TextWidth(.Text)
                If VTWidth > Ancho Then Ancho = VTWidth
            Next j
            .ColWidth(i) = IIf(Ancho <= 0, 100, Ancho - 0.15 * Ancho)
        Next i
    End With
End Sub
Private Sub Form_Load()
    FTran363.Left = 0
    FTran363.Top = 0
    FTran363.Width = 9450
    FTran363.Height = 5900
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaAho
    mskValor(0).Format = VGDecimales
    mskValor(0).Text = Format$(0, VGDecimales)
    cmdBoton_Click (3)
End Sub
Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub
Private Sub grdPropietarios_DblClick()
'Cuenta
grdPropietarios.Col = 2
txtcuenta.Text = grdPropietarios.Text
txtcuenta.Enabled = False
'Causa
grdPropietarios.Col = 3
txtCampo(0).Text = grdPropietarios.Text
txtCampo_LostFocus (0)
txtCampo(0).Enabled = False
'Valor
grdPropietarios.Col = 5
mskValor(0).Text = grdPropietarios.Text
mskValor(0).Enabled = False
'Observacion
grdPropietarios.Col = 7
txtObservacion.Text = grdPropietarios.Text
txtObservacion.Enabled = False
'Secuencial
grdPropietarios.Col = 8
txtsecuencial.Text = grdPropietarios.Text

'Habilitar Botón de Reversa
cmdBoton(5).Enabled = True

'Habilitar datos de cuenta
lblObservacion(0).Visible = True
txtcuenta.Visible = True
End Sub
Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub
Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                'Causa
                txtCampo(0).Enabled = True
                'Valor
                mskValor(0).Enabled = True
                'Observacion
                txtObservacion.Enabled = True
                txtCampo(0).SetFocus
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(0).Caption = ""
                cmdBoton(3).Enabled = False
                PMLimpiaGrid grdPropietarios
                mskCuenta.SetFocus
                Exit Sub
            End If
            
            'Causa
            txtCampo(0).Enabled = True
            'Valor
            mskValor(0).Enabled = True
            'Observacion
            txtObservacion.Enabled = True
           
        Else
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
            lblDescripcion(0).Caption = ""
            PMLimpiaGrid grdPropietarios
            cmdBoton(3).Enabled = False
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
End Sub
Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = "Valor de la Nota Débito"
        mskValor(0).Text = Format$(mskValor(0).Text)
        mskValor(0).SelStart = 0
        mskValor(0).SelLength = Len(mskValor(0).Text)
        mskValor(0).MaxLength = 14
    End Select
End Sub
Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index
    Case 0, 1, 2
        If VGDecimales = "#,##0" Then
            If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        Else
            If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                KeyAscii = 0
            End If
        End If
    End Select
End Sub
Private Sub mskValor_LostFocus(Index As Integer)
    Select Case Index
    Case 0
        cmdBoton(1).Enabled = True
    End Select
End Sub
Private Sub txtCampo_Change(Index As Integer)
    VLPaso = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso = True
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Causa de Nota de Credito AHO [F5 Ayuda]"
    End Select
    txtCampo(Index).SelStart = 0
    txtCampo(Index).SelLength = Len(txtCampo(Index).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Select Case Index
    Case 0
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "cc_causa_nd"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
             If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de tipos de bloqueos") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo
                lblDescripcion(1).Caption = VGACatalogo.Descripcion
                If txtCampo(0).Text <> "" Then
                    mskValor(0).SetFocus
                End If
            Else
                txtCampo(0).Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(0).SetFocus
            End If
        End If
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index
    Case 0
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
    Case 2
        KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso = False Then
        Select Case Index
        Case 0
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_causa_nd"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(0).Text)
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
                 If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCampo(0).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                Else
                    VLPaso = True
                    txtCampo(0).Text = ""
                    lblDescripcion(1).Caption = ""
                    If txtCampo(0).Enabled = True Then
                        txtCampo(0).SetFocus
                    End If
                End If
            Else
                lblDescripcion(1).Caption = ""
            End If
       End Select
    End If
End Sub

Private Sub txtObservacion_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Descripción de la Nota Débito"
End Sub
