VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran358 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Ingreso de Notas de Débito y Crédito para Cuentas Corrientes y Ahorros"
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
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5520
   ScaleWidth      =   9300
   Begin VB.Frame frmsigno 
      Caption         =   "Signo de la transacción"
      Height          =   645
      Left            =   4560
      TabIndex        =   29
      Top             =   30
      Width           =   3375
      Begin VB.OptionButton optsigno 
         Caption         =   "Crédito"
         Height          =   315
         Index           =   1
         Left            =   1770
         TabIndex        =   3
         Top             =   270
         Width           =   1365
      End
      Begin VB.OptionButton optsigno 
         Caption         =   "Débito"
         Height          =   315
         Index           =   0
         Left            =   210
         TabIndex        =   2
         Top             =   270
         Width           =   1365
      End
   End
   Begin VB.ComboBox cbotipocta 
      Height          =   315
      Left            =   2250
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   60
      Width           =   2205
   End
   Begin Threed.SSFrame frmBloqueos 
      Height          =   1770
      Left            =   30
      TabIndex        =   18
      Top             =   1080
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14605
      _ExtentY        =   3122
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
         TabIndex        =   27
         Top             =   1260
         Visible         =   0   'False
         Width           =   1245
      End
      Begin VB.TextBox txtcuenta 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2100
         MaxLength       =   120
         ScrollBars      =   2  'Vertical
         TabIndex        =   25
         Top             =   1260
         Visible         =   0   'False
         Width           =   1245
      End
      Begin VB.TextBox txtObservacion 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2100
         MaxLength       =   120
         ScrollBars      =   2  'Vertical
         TabIndex        =   6
         Top             =   960
         Width           =   6045
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2100
         MaxLength       =   4
         TabIndex        =   4
         Top             =   360
         Width           =   735
      End
      Begin MSMask.MaskEdBox MskValor 
         Height          =   285
         Index           =   0
         Left            =   2100
         TabIndex        =   5
         Top             =   660
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
         TabIndex        =   26
         Top             =   1320
         Visible         =   0   'False
         Width           =   1350
      End
      Begin VB.Label lblObservacion 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "No. Cuenta ahorros:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   165
         TabIndex        =   24
         Top             =   1320
         Visible         =   0   'False
         Width           =   1725
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
         TabIndex        =   20
         Top             =   1005
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
         TabIndex        =   19
         Top             =   675
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
         TabIndex        =   13
         Top             =   360
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
         TabIndex        =   14
         Top             =   360
         Width           =   600
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   10
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
      TabIndex        =   9
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
      TabIndex        =   7
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
      Height          =   2205
      Left            =   0
      TabIndex        =   11
      Top             =   3150
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   3889
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
      TabIndex        =   8
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2235
      TabIndex        =   1
      Top             =   435
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   21
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
      TabIndex        =   22
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
      TabIndex        =   23
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Cuenta"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   60
      TabIndex        =   28
      Top             =   90
      Width           =   1320
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
      TabIndex        =   17
      Top             =   2850
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
      TabIndex        =   16
      Top             =   735
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
      Y1              =   1050
      Y2              =   1050
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. De Cuenta"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   105
      TabIndex        =   15
      Top             =   450
      Width           =   1275
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8350
      Y1              =   3100
      Y2              =   3090
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
      TabIndex        =   12
      Top             =   735
      Width           =   1845
   End
End
Attribute VB_Name = "FTran358"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14-Aug-10
'*************************************************************
' ARCHIVO:          FTran358.frm
' NOMBRE LOGICO:    FTran358
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
'Permite Ingreso de Notas Crédito de Ahorros Sin Libreta.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 07-Sep-05      J.C. Suárez     Emisión Inicial
'*************************************************************
Dim VLPaso As Integer
Dim VLProducto As String

Private Sub cbotipocta_LostFocus()
If VLProducto <> cbotipocta.Text Then
    lblDescripcion(0).Caption = ""
         If cbotipocta.ListIndex = 0 Then
             mskCuenta.Mask = VGMascaraCtaCte$
             'mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
         ElseIf cbotipocta.ListIndex = 1 Then
             mskCuenta.Mask = VGMascaraCtaAho$
             'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
         End If
    VLProducto = cbotipocta.Text
End If
End Sub


Private Sub cmdBoton_Click(Index As Integer)
Dim VTBase As String
Dim VTProcedure As String
Dim VTTransaccion As String
    
        If cbotipocta.ListIndex = 0 Then 'CUENTAS CORRIENTES
            VTBase$ = "cob_cuentas"
            VTProcedure$ = "sp_autndc_cte"
            If optsigno(0).Value = True Then 'DEBITO
               VTTransaccion$ = 705
            ElseIf optsigno(1).Value = True Then 'CREDITO
               VTTransaccion$ = 706
            End If
        ElseIf cbotipocta.ListIndex = 1 Then 'CUENTAS DE AHORROS
            VTBase$ = "cob_ahorros"
            VTProcedure$ = "sp_autndc_aho"
            If optsigno(0).Value = True Then 'DEBITO
               VTTransaccion$ = 264
            ElseIf optsigno(1).Value = True Then 'CREDITO
               VTTransaccion$ = 253
            End If
        End If
        
    Select Case Index%
    Case 0
        'Transmitir
        ' Validacion de Mandatoriedades
        ' Numero de la cuenta de ahorros
        If cbotipocta.ListIndex = -1 Then
            MsgBox "El tipo de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            If cbotipocta.Enabled = True Then cbotipocta.SetFocus
            Exit Sub
        End If
        
        If optsigno(0).Value = False And optsigno(1).Value = False Then
            MsgBox "El signo de la Nota debe ser debito o credito", 0 + 16, "Mensaje de Error"
            If optsigno(0).Enabled = True Then optsigno(0).SetFocus
            Exit Sub
        End If
        
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El código de la cuenta corriente o ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            If mskCuenta.Enabled = True Then mskCuenta.SetFocus
            Exit Sub
        End If

        ' Causal de Nota Crédito
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "La causa de la nota de debito/crédito es mandatoria", 0 + 16, "Mensaje de Error"
            If txtCampo(0).Enabled = True Then
                txtCampo(0).SetFocus
            End If
            Exit Sub
        End If

        ' Valor
        If Val(MskValor(0).ClipText) <= 0 Then
            MsgBox "El valor de la nota debe ser mayor que cero", 0 + 16, "Mensaje de Error"
            If MskValor(0).Enabled = True Then
                MskValor(0).SetFocus
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
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         If cbotipocta.ListIndex = 0 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         ElseIf cbotipocta.ListIndex = 1 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
         End If
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (MskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, VTBase$, VTProcedure$, True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
            PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton(4).Enabled = True
            cmdBoton_Click (1)
            cmdBoton_Click (3)
        End If

    Case 1
        Dim i As Integer
        
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        For i% = 0 To 1
            lblDescripcion(i%).Caption = ""
        Next i%
        For i% = 0 To 0
            txtCampo(i%).Text = ""
        Next i%
        MskValor(0).Text = ""
        txtcuenta.Text = ""
        txtObservacion.Text = ""
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = True
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        txtcuenta.Visible = False
        lblObservacion(0).Visible = False
        mskCuenta.SetFocus
'        cbotipocta.ListIndex = 1
'        optsigno(0).Value = True
        VLProducto = cbotipocta.Text
    Case 2
        'Salir
        Unload FTran358
    Case 3
        'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         If cbotipocta.ListIndex = 0 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         ElseIf cbotipocta.ListIndex = 1 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
         End If
         PMPasoValores sqlconn&, "@i_siguiente", 0, SQLINT4, "0"
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (MskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, VTBase$, VTProcedure$, True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
             
             If Val(grdPropietarios.Rows - 1) >= 20 Then
                cmdBoton(6).Enabled = True
                cmdBoton(3).Enabled = False
                txtCampo(0).Text = ""
                MskValor(0).Text = ""
                
                'PCOELLO SETEAR LA MASCARA EN BASE AL PRODUCTO YA QUE ESTA PUEDE SER DIFERENTE
                If cbotipocta.ListIndex = 0 Then
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                ElseIf cbotipocta.ListIndex = 1 Then
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                End If
                'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                txtObservacion.Text = ""
                txtcuenta.Text = ""
                txtsecuencial.Text = ""
                lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
             Else
                cmdBoton(6).Enabled = False
             End If
             
             PLAjustaGrid grdPropietarios, Me
             grdPropietarios.ColWidth(5) = 1
             grdPropietarios.ColWidth(6) = 1
         Else
             PMLimpiaGrid grdPropietarios
         End If
'    Case 4
'        PLImprimir
    Case 5
        'Reversar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, txtcuenta.Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
         If cbotipocta.ListIndex = 0 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         ElseIf cbotipocta.ListIndex = 1 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
         End If
         PMPasoValores sqlconn&, "@i_sec_rev", 0, SQLINT4, txtsecuencial.Text
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (MskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, VTBase$, VTProcedure$, True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
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
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cau", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_fac", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         If cbotipocta.ListIndex = 0 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "3"
         ElseIf cbotipocta.ListIndex = 1 Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, "4"
         End If
         PMPasoValores sqlconn&, "@i_siguiente", 0, SQLINT4, grdPropietarios.Text
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, (MskValor(0).Text)
         PMPasoValores sqlconn&, "@i_nombre_ocx", 0, SQLVARCHAR, ("TADMIN.EXE")
         PMPasoValores sqlconn&, "@i_concep", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, VTBase$, VTProcedure$, True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
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
             grdPropietarios.ColWidth(5) = 1
             grdPropietarios.ColWidth(6) = 1
         Else
             PMLimpiaGrid grdPropietarios
         End If
    End Select
End Sub
Sub PLAjustaGrid(Celdas As Grid, Ventana As Object)
Dim i As Integer
Dim j As Integer
Dim ancho As Integer
Dim VTWidth As Integer

    With Celdas
        For i% = 1 To .Cols - 1
            ancho% = 0
            For j% = 0 To .Rows - 1
                .Row = j%: .Col = i%
'FIXIT: 'TextWidth(Celdas.Text' is not a property of the generic 'Form' object in Visual Basic .NET. To access 'TextWidth(Celdas.Text' declare 'Ventana' using its actual type instead of 'Form'     FixIT90210ae-R1460-RCFE85
                VTWidth% = Ventana.TextWidth(.Text)
                If VTWidth% > ancho% Then ancho% = VTWidth%
            Next j%
            .ColWidth(i%) = IIf(ancho% <= 0, 100, ancho% - 0.15 * ancho%)
        Next i%
    End With
End Sub
Private Sub Form_Load()
    FTran358.Left = 0   '15
    FTran358.Top = 0   '15
    FTran358.Width = 9450   '9420
    FTran358.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    cbotipocta.AddItem "Cuenta Corriente"
    cbotipocta.AddItem "Cuenta de Ahorros"
    cbotipocta.ListIndex = 1 'PCOELLO SE ESCOGE LA OPCION 1 POR QUE LA PANTALLA ORIGINALMENTE ERA DE CUENTAS DE AHORROS
    VLProducto = cbotipocta.Text
    optsigno(0).Value = True
    mskCuenta.Mask = VGMascaraCtaAho$
    MskValor(0).Format = VGDecimales$
    MskValor(0).Text = Format$(0, VGDecimales$)
 
    cmdBoton_Click (3)

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub
Private Sub grdPropietarios_DblClick()
'Producto
grdPropietarios.Col = 1
If grdPropietarios.Text = "3" Then
  cbotipocta.ListIndex = 0
  grdPropietarios.Col = 8
  If grdPropietarios.Text = "50" Then
     optsigno(0).Value = True
  Else
     optsigno(1).Value = True
  End If
Else
  cbotipocta.ListIndex = 1
  If grdPropietarios.Text = "264" Then
     optsigno(0).Value = True
  Else
     optsigno(1).Value = True
  End If
End If
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
grdPropietarios.Col = 4
MskValor(0).Text = grdPropietarios.Text
MskValor(0).Enabled = False
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
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta Corriente o de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub
Private Sub mskCuenta_LostFocus()
Dim VTBase As String
Dim VTProcedure As String
Dim VTTransaccion As String
Dim VTMensaje As String

    On Error Resume Next
    
    If cbotipocta.ListIndex = 0 Then 'CUENTAS CORRIENTES
        VTBase$ = "cob_cuentas"
        VTProcedure$ = "sp_tr_query_nom_ctacte"
        VTTransaccion$ = "16"
        If Not FMChequeaCtaCte((mskCuenta.ClipText)) And mskCuenta.ClipText <> "" Then
           VTMensaje$ = "El dígito verificador de la cuenta corriente está incorrecto"
           GoTo Salir_Pantalla
        End If
    ElseIf cbotipocta.ListIndex = 1 Then 'CUENTAS DE AHORROS
        VTBase$ = "cob_ahorros"
        VTProcedure$ = "sp_tr_query_nom_ctahorro"
        VTTransaccion$ = "206"
        
        If Not FMChequeaCtaAho((mskCuenta.ClipText)) And mskCuenta.ClipText <> "" Then
           VTMensaje$ = "El dígito verificador de la cuenta de ahorros está incorrecto"
           GoTo Salir_Pantalla
        End If
    End If
        
    If mskCuenta.ClipText <> "" Then
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTransaccion$
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, VTBase$, VTProcedure$, True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
             cmdBoton(3).Enabled = True
             
            'Causa
            txtCampo(0).Enabled = True
            'Valor
            MskValor(0).Enabled = True
            'Observacion
            txtObservacion.Enabled = True
            txtCampo(0).SetFocus
            
         Else
            cmdBoton_Click (1)
            Exit Sub
         End If
    End If
    
    Exit Sub
    
Salir_Pantalla:
    MsgBox VTMensaje$, 0 + 16, "Mensaje de Error"
    cmdBoton_Click (1)
    Exit Sub
End Sub
Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
    Case 0

        FPrincipal!pnlHelpLine.Caption = "Valor de la Nota Crédito"
        MskValor(0).Text = Format$(MskValor(0).Text)
        MskValor(0).SelStart = 0
        MskValor(0).SelLength = Len(MskValor(0).Text)
        MskValor(0).MaxLength = 14
    End Select
End Sub
Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2
        If VGDecimales$ = "#,##0" Then
            If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
            End If
        Else
            If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
            End If
        End If
    End Select
End Sub
Private Sub mskValor_LostFocus(Index As Integer)
    Select Case Index%
    Case 0
        cmdBoton(1).Enabled = True
    End Select
End Sub
Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Causa de Nota  [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTTabla As String
    Select Case Index%
    Case 0
        If cbotipocta.ListIndex = 0 Then 'CUENTAS CORRIENTES
           If optsigno(0).Value = True Then 'DEBITO
               VTTabla$ = "cc_causa_nd"
           ElseIf optsigno(1).Value = True Then 'CREDITO
               VTTabla$ = "cc_causa_nc"
           End If
        ElseIf cbotipocta.ListIndex = 1 Then 'CUENTAS DE AHORROS
           If optsigno(0).Value = True Then 'DEBITO
               VTTabla$ = "ah_causa_nd"
           ElseIf optsigno(1).Value = True Then 'CREDITO
               VTTabla$ = "ah_causa_nc"
           End If
        End If
        If KeyCode% = VGTeclaAyuda% Then
            VLPaso% = True
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, VTTabla$
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de tipos de bloqueos") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                If txtCampo(0).Text <> "" Then
                    MskValor(0).SetFocus
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
    Select Case Index%
    Case 0
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    Case 2
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTTabla As String
    If VLPaso% = False Then
        Select Case Index%
        Case 0
        If cbotipocta.ListIndex = 0 Then 'CUENTAS CORRIENTES
           If optsigno(0).Value = True Then 'DEBITO
               VTTabla$ = "cc_causa_nd"
           ElseIf optsigno(1).Value = True Then 'CREDITO
               VTTabla$ = "cc_causa_nc"
           End If
        ElseIf cbotipocta.ListIndex = 1 Then 'CUENTAS DE AHORROS
           If optsigno(0).Value = True Then 'DEBITO
               VTTabla$ = "ah_causa_nd"
           ElseIf optsigno(1).Value = True Then 'CREDITO
               VTTabla$ = "ah_causa_nc"
           End If
        End If
        
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VTTabla$
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(0).Text)
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCampo(0).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
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
    FPrincipal!pnlHelpLine.Caption = " Descripción de la Nota Crédito"
End Sub

