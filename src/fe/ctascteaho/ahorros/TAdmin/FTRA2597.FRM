VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2597 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Notas de Crédito y Débito Empresariales"
   ClientHeight    =   5325
   ClientLeft      =   1080
   ClientTop       =   3105
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
   HelpContextID   =   1098
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "0"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   2010
      MaxLength       =   8
      TabIndex        =   10
      Top             =   1860
      Width           =   2235
   End
   Begin Threed.SSFrame Frame3D2 
      Height          =   400
      Left            =   4470
      TabIndex        =   36
      Top             =   -55
      Width           =   3880
      _Version        =   65536
      _ExtentX        =   6844
      _ExtentY        =   706
      _StockProps     =   14
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
      Alignment       =   2
      Begin Threed.SSOption optOper 
         Height          =   210
         Index           =   1
         Left            =   1950
         TabIndex        =   2
         TabStop         =   0   'False
         Tag             =   "S"
         Top             =   135
         Width           =   1710
         _Version        =   65536
         _ExtentX        =   3016
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Nota de &Débito:"
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
         Alignment       =   1
      End
      Begin Threed.SSOption optOper 
         Height          =   210
         Index           =   0
         Left            =   225
         TabIndex        =   1
         Tag             =   "S"
         Top             =   135
         Width           =   1710
         _Version        =   65536
         _ExtentX        =   3016
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Nota de &Crédito:"
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
         Alignment       =   1
         Value           =   -1  'True
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2010
      MaxLength       =   60
      TabIndex        =   5
      Top             =   960
      Width           =   6345
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8430
      TabIndex        =   14
      Tag             =   "2516"
      Top             =   2250
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
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
   Begin Threed.SSFrame Frame3D1 
      Height          =   1125
      Left            =   0
      TabIndex        =   21
      Top             =   2250
      Width           =   8355
      _Version        =   65536
      _ExtentX        =   14747
      _ExtentY        =   1976
      _StockProps     =   14
      Caption         =   " Datos de la Cuenta "
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
      Alignment       =   1
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Index           =   3
         Left            =   6135
         MaxLength       =   6
         TabIndex        =   13
         Top             =   780
         Width           =   2160
      End
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   285
         Left            =   1990
         TabIndex        =   11
         Top             =   180
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   503
         _Version        =   393216
         Enabled         =   0   'False
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Index           =   1
         Left            =   1995
         TabIndex        =   12
         Top             =   780
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   503
         _Version        =   393216
         Enabled         =   0   'False
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Número Secuencial:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   10
         Left            =   4260
         TabIndex        =   35
         Top             =   780
         Width           =   1725
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1995
         TabIndex        =   19
         Top             =   480
         Width           =   6300
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
         Left            =   105
         TabIndex        =   22
         Top             =   480
         WhatsThisHelpID =   5017
         Width           =   1920
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. de la cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   105
         TabIndex        =   23
         Top             =   180
         WhatsThisHelpID =   5016
         Width           =   1575
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Valor Monetario x cta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   20
         Left            =   105
         TabIndex        =   28
         Top             =   780
         Width           =   1890
      End
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   3
      Left            =   6150
      TabIndex        =   7
      Top             =   1245
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   2
      Left            =   2010
      TabIndex        =   6
      Top             =   1260
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2010
      MaxLength       =   7
      TabIndex        =   4
      Top             =   660
      Width           =   915
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   6150
      TabIndex        =   9
      Top             =   1530
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2010
      MaxLength       =   6
      TabIndex        =   3
      Top             =   345
      Width           =   915
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   2010
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   30
      Width           =   2445
   End
   Begin MSGrid.Grid grdCheques 
      Height          =   1740
      Left            =   15
      TabIndex        =   20
      TabStop         =   0   'False
      Top             =   3570
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   3069
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
      TabIndex        =   17
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
      Index           =   2
      Left            =   8415
      TabIndex        =   16
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   875
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
      Index           =   1
      Left            =   8430
      TabIndex        =   15
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Adicionar"
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
   Begin Threed.SSCheck ChkCrdFijo 
      Height          =   240
      Left            =   2010
      TabIndex        =   8
      Top             =   1590
      Width           =   225
      _Version        =   65536
      _ExtentX        =   388
      _ExtentY        =   423
      _StockProps     =   78
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
      Value           =   -1  'True
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Núm. de Doc.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   90
      TabIndex        =   37
      Top             =   1860
      Width           =   1245
   End
   Begin VB.Shape linShap 
      BackColor       =   &H00000000&
      BorderColor     =   &H000000FF&
      BorderWidth     =   2
      Height          =   285
      Left            =   60
      Top             =   1560
      Visible         =   0   'False
      Width           =   2205
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Comentario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   120
      TabIndex        =   34
      Top             =   945
      Width           =   1020
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Total Procesado C/D:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   4275
      TabIndex        =   33
      Top             =   1245
      Width           =   1875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Total a Procesar C/D:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   32
      Top             =   1245
      Width           =   1890
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   1
      Left            =   2955
      TabIndex        =   31
      Top             =   660
      UseMnemonic     =   0   'False
      Width           =   5400
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Empresa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   30
      Top             =   645
      Width           =   795
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Monetario fijo ?"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   120
      TabIndex        =   18
      Top             =   1590
      Width           =   1830
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Valor fijo por cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   4275
      TabIndex        =   29
      Top             =   1545
      Width           =   1800
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   120
      TabIndex        =   27
      Top             =   345
      Width           =   600
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2955
      TabIndex        =   26
      Top             =   345
      Width           =   5400
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   25
      Top             =   30
      Width           =   840
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8380
      Y1              =   3040
      Y2              =   3040
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "Cuentas Procesadas:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   0
      TabIndex        =   24
      Top             =   3360
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8395
      Y1              =   2190
      Y2              =   2190
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
End
Attribute VB_Name = "FTran2597"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRA2597.frm
' NOMBRE LOGICO:    FTran2597
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
' Permite realizar el mantenimiento de las notas de debito
' y credito empresariales
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso1 As Integer
Dim VLPaso As Integer
Dim VLTipoCuenta As String
Dim i As Integer
Dim tablita As String

Private Sub cmbTipo_Change()
    VLPaso% = False
End Sub

Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
     VLTipoCuenta$ = cmbTipo.Text
End Sub

Private Sub cmbTipo_KeyPress(KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
End Sub

Private Sub cmbTipo_LostFocus()
    txtCampo(0).Enabled = True
    If VLTipoCuenta$ <> cmbTipo.Text Then
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte$
        Else
            mskCuenta.Mask = VGMascaraCtaAho$
        End If
        txtCampo(0).Text = ""
        lblDescripcion(0).Caption = ""
        VLPaso% = True
    End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VLCD As String
    Dim VLSec As String
    Dim VLProd As String
    Dim VLRow As String
    Dim VLItem As String
    Dim vlMensaje As Integer
    Dim VLOut As String
    Select Case Index%
    Case 0 'Eliminar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2597"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT4, (txtCampo(1).Text)
        grdCheques.Col = 1
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (grdCheques.Text)
        grdCheques.Col = 4
         PMPasoValores sqlconn&, "@i_producto", 0, SQLCHAR, (grdCheques.Text)
        grdCheques.Col = 5
        VLCD$ = grdCheques.Text
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, (grdCheques.Text)
         PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, (mskValor(1).ClipText)
         PMPasoValores sqlconn&, "@i_causa", 0, SQLVARCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_comentario", 0, SQLVARCHAR, (txtCampo(2).Text)
         PMPasoValores sqlconn&, "@i_accion", 0, SQLVARCHAR, "D"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_ndnc_empr", True, " Ok... Eliminación Nota Débito/Crédito Empresarial") Then
             PMMapeaVariable sqlconn&, VLSec$
            If grdCheques.Rows = 2 Then
                grdCheques.Row = 1
                For i% = 1 To 6
                    grdCheques.Col = i%
                    grdCheques.Text = ""
                Next i%
            Else
                grdCheques.RemoveItem grdCheques.Row
            End If
            'If VLCD$ = "D" Then
            '    mskValor(3).Text = Str$(Val(mskValor(3).Text) + Val(mskValor(1).Text))
            'Else
                mskValor(3).Text = Str$(Val(mskValor(3).Text) - Val(mskValor(1).Text))
            'End If
            PLActGrid
        End If
         PMChequea sqlconn&
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        Else
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        End If
        txtCampo(3).Text = ""
        lblDescripcion(2).Caption = ""
        If ChkCrdFijo.Value = True Then
            mskValor(1).Text = mskValor(0).Text
        Else
            mskValor(1).Text = ""
            mskValor(1).Enabled = True
        End If
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = True
        grdCheques.Enabled = True
        mskCuenta.Enabled = True
        optOper(0).Enabled = True
        optOper(1).Enabled = True
        mskCuenta.SetFocus
        If Val(mskValor(3).Text) >= Val(mskValor(2).Text) And mskValor(2).Text <> "" Then
            cmdBoton(1).Enabled = False
            mskValor(1).Enabled = False
            mskCuenta.Enabled = False
            If Val(mskValor(3).Text) > Val(mskValor(2).Text) Then
                MsgBox "El Valor sumado no cuadra con el Valor ingresado como total", 0 + 16, "Mensaje de Error"
            Else
                MsgBox "El Valor sumado ya cuadró con el total", 0 + 64, "Mensaje de Información"
                cmdBoton(3).Enabled = True
            End If
        End If
    Case 1 'Adicionar

        ' Causa
        If txtCampo(0).Text = "" Then
            MsgBox "La causa es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        'Transmitir
        If lblDescripcion(2).Caption = "" Then
            VLPaso% = False
            mskCuenta_LostFocus
        End If
        If mskCuenta.ClipText <> "" And mskValor(1).Text <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2597"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT4, (txtCampo(1).Text)
            If cmbTipo.Text = "CUENTA CORRIENTE" Then
                VLProd$ = "CTE"
            Else
                VLProd$ = "AHO"
            End If
             PMPasoValores sqlconn&, "@i_producto", 0, SQLCHAR, VLProd$
            If optOper(0).Value = True Then
                VLCD$ = "C"
            Else
                VLCD$ = "D"
            End If
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, VLCD$
             PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, (mskValor(1).ClipText)
             PMPasoValores sqlconn&, "@i_causa", 0, SQLVARCHAR, (txtCampo(0).Text)
             PMPasoValores sqlconn&, "@i_comentario", 0, SQLVARCHAR, (txtCampo(2).Text)
             PMPasoValores sqlconn&, "@i_accion", 0, SQLVARCHAR, "I"
             PMPasoValores sqlconn&, "@i_serial", 0, SQLVARCHAR, (txtCampo(4).Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_ndnc_empr", True, " Ok... Inserción Nota Débito/Crédito Empresarial") Then
                 PMMapeaVariable sqlconn&, VLSec$
                grdCheques.Col = 1
                grdCheques.Row = 1
                If grdCheques.Rows = 2 And grdCheques.Text = "" Then
                    VLRow$ = "1"
                Else
                    VLRow$ = Str$(grdCheques.Rows)
                End If
                VLItem$ = VLRow$ + Chr$(9) + VLSec$ + Chr$(9) + mskCuenta.ClipText + Chr$(9) + mskValor(1).ClipText + Chr$(9) + VLProd$ + Chr$(9) + VLCD$ + Chr$(9) + lblDescripcion(2).Caption
                grdCheques.AddItem VLItem$
                grdCheques.Col = 1
                grdCheques.Row = 1
                If grdCheques.Rows = 3 And grdCheques.Text = "" Then
                    grdCheques.RemoveItem 1
                End If
                'If VLCD$ = "D" Then
                '    mskValor(3).Text = Str$(Val(mskValor(3).Text) - Val(mskValor(1).Text))
                'Else
                    mskValor(3).Text = Str$(Val(mskValor(3).Text) + Val(mskValor(1).Text))
                'End If
                If cmbTipo.Text = "CUENTA CORRIENTE" Then
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                End If
                lblDescripcion(2).Caption = ""
                If ChkCrdFijo.Value = False Then
                    mskValor(1).Text = ""
                End If
                cmdBoton(0).Enabled = False
                mskCuenta.SetFocus
                If Val(mskValor(3).Text) >= Val(mskValor(2).Text) And mskValor(2).Text <> "" Then
                    cmdBoton(1).Enabled = False
                    mskValor(1).Enabled = False
                    mskCuenta.Enabled = False
                    If Val(mskValor(3).Text) > Val(mskValor(2).Text) Then
                        MsgBox "El Valor sumado no cuadra con el Valor ingresado como total", 0 + 16, "Mensaje de Error"
                    Else
                        MsgBox "El Valor sumado ya cuadró con el total", 0 + 64, "Mensaje de Información"
                        cmdBoton(3).Enabled = True
                    End If
                End If
            Else
                mskCuenta.SetFocus
            End If
             PMChequea sqlconn&
        Else
                If cmbTipo.Text = "CUENTA CORRIENTE" And optOper(0) = True Then
                    MsgBox "El número de Cuenta y el Valor por Acreditar son mandatorios", 0 + 16, "Mensaje de Error"
                Else
                    If cmbTipo.Text = "CUENTA CORRIENTE" And optOper(1) = True Then
                        MsgBox "El número de Cuenta y el Valor a Debitar son mandatorios", 0 + 16, "Mensaje de Error"
                    Else
                        If cmbTipo.Text = "CUENTA DE AHORRO" And optOper(0) = True Then
                            MsgBox "El número de Cuenta de Ahorros y el Valor por Acreditar son mandatorios", 0 + 16, "Mensaje de Error"
                            tablita$ = "ah_causa_nc"
                        Else
                            If cmbTipo.Text = "CUENTA DE AHORRO" And optOper(1) = True Then
                                MsgBox "El número de Cuenta de Ahorros y el Valor a Debitar son mandatorios", 0 + 16, "Mensaje de Error"
                            End If
                        End If
                    End If
                End If

            If mskCuenta.ClipText <> "" Then
                mskValor(1).SetFocus
            Else
                mskCuenta.SetFocus
            End If
        End If
    Case 2 'Limpiar
        optOper(0).Enabled = True
        optOper(1).Enabled = True
        If txtCampo(4).Enabled Then
           txtCampo(4).Text = ""
        End If
        
        If txtCampo(0).Text = "" And txtCampo(1).Text = "" And txtCampo(2).Text = "" And mskValor(0).Text = "" And mskValor(1).Text = "" And mskValor(2).Text = "" And mskCuenta.Enabled = False Then
            vlMensaje% = MsgBox("¿ Está seguro de querer limpiar el Detalle de Transacciones ingresadas ?", 1, "Mensaje del Sistema")
            If vlMensaje% = 1 Then
                PMLimpiaGrid grdCheques
            End If
            VLOut$ = "1"
        Else
            If txtCampo(1).Text = "" And txtCampo(2).Text = "" And txtCampo(0).Enabled = True And mskValor(2).Text = "" And mskCuenta.Enabled = False Then
                txtCampo(0).Text = ""
                txtCampo(2).Text = ""
                lblDescripcion(0).Caption = ""
                VLOut$ = "1"
            Else
                If mskValor(2).Text = "" And txtCampo(1).Enabled = True And txtCampo(2).Enabled = True And mskCuenta.Enabled = False Then
                    txtCampo(1).Text = ""
                    txtCampo(2).Text = ""
                    lblDescripcion(1).Caption = ""
                    mskValor(3) = "0.00"
                    VLOut$ = "2"
                Else
                    If txtCampo(0).Enabled = True And mskValor(0).Text = "" And mskCuenta.Enabled = False Then
                        mskValor(2).Text = ""
                        mskValor(2).Enabled = True
                        VLOut$ = "3"
                    Else
                        If mskCuenta.ClipText = "" And mskCuenta.Enabled = True And (mskValor(1).Text = "" Or (mskValor(1).Text <> "" And mskValor(1).Enabled = False)) And grdCheques.Enabled = True Then
                            optOper(0).Enabled = True
                            optOper(1).Enabled = True
                            cmbTipo.Enabled = True
                            txtCampo(0).Enabled = True
                            txtCampo(1).Enabled = True
                            txtCampo(2).Enabled = True
                            mskValor(0).Enabled = False
                            mskCuenta.Enabled = False
                            mskValor(1).Enabled = False
                            cmdBoton(1).Enabled = False
                            mskValor(2).Enabled = True
                            ChkCrdFijo.Enabled = True
                            ChkCrdFijo.Value = False
                            VLOut$ = "4"
                        Else
                            lblDescripcion(2).Caption = ""
                            If ChkCrdFijo.Value = False Then
                                mskValor(1).Text = ""
                                mskValor(1).Enabled = True
                            End If
                            mskCuenta.Enabled = True
                            If cmbTipo.Text = "CUENTA CORRIENTE" Then
                                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                            Else
                                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                            End If
                            cmdBoton(0).Enabled = False
                            cmdBoton(1).Enabled = True
                            txtCampo(3).Text = ""
                            txtCampo(3).Enabled = False
                            optOper(0).Enabled = True
                            optOper(1).Enabled = True
                            grdCheques.Enabled = True
                            VLOut$ = "5"
                        End If
                    End If
                End If
            End If
        End If
        Select Case VLOut$
        Case "1"
            txtCampo(0).SetFocus
        Case "2"
            txtCampo(1).SetFocus
        Case "3"
            mskValor(2).SetFocus
        Case "4"
            ChkCrdFijo.SetFocus
        Case "5"
            mskCuenta.SetFocus
        Case "6"
            mskValor(2).SetFocus
        End Select
    Case 3  'Salir
        'Salir
        Unload FTran2597
    End Select
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
    'If Index% = 2 And Not mskValor(1).Enabled And Not cmdboton(1).Enabled Then
    '    PLBloquear
    'End If
    If Index% = 0 Then
        cmdBoton(1).Enabled = False
        mskCuenta.Enabled = False
        mskValor(1).Enabled = False
    End If
End Sub

Private Sub cmdBoton_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
End Sub

Private Sub ChkCrdFijo_Click(Value As Integer)
    If ChkCrdFijo.Value = True Then
        mskValor(0).Enabled = True
        mskValor(0).SetFocus
    Else
        mskValor(0).Enabled = False
        mskValor(0).Text = ""
        mskValor(1).Text = ""
    End If
End Sub

Private Sub ChkCrdFijo_GotFocus()
    linShap.Visible = True
End Sub

Private Sub ChkCrdFijo_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = 13 Then
        ChkCrdFijo.Value = Not ChkCrdFijo.Value
    End If
End Sub

Private Sub ChkCrdFijo_KeyPress(KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        VLPaso1% = True
    End If
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
End Sub

Private Sub ChkCrdFijo_LostFocus()
    If VLPaso1% Then
        PLBloquear
        'If mskCuenta.Enabled = True Then mskCuenta.SetFocus
        If txtCampo(4).Enabled = True Then txtCampo(4).SetFocus
        VLPaso1% = False
    End If
    linShap.Visible = False
End Sub

Private Sub Form_Load()
    FTran2597.Left = 0   '15
    FTran2597.Top = 0   '15
    FTran2597.Width = 9450   '9420
    FTran2597.Height = 5900   '5730
    
    If VGEmpAgencia Then
       Me.Tag = 3849
    Else
       Me.Tag = 3848
    End If
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte$
    mskValor(0).Format = VGDecimales$
    mskValor(1).Format = VGDecimales$
    mskValor(2).Format = VGDecimales$
    mskValor(3).Text = Format$(0, VGDecimales$)
    mskValor(0).MaxLength = 14
    mskValor(1).MaxLength = 14
    mskValor(2).MaxLength = 14
    mskValor(3).MaxLength = 14
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
    VLPaso1% = True
    PLLimGrid
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdCheques_Click()
    grdCheques.Col = 0
    grdCheques.SelStartCol = 1
    grdCheques.SelEndCol = grdCheques.Cols - 1
    If grdCheques.Row = 0 Then
        grdCheques.SelStartRow = 1
        grdCheques.SelEndRow = 1
    Else
        grdCheques.SelStartRow = grdCheques.Row
        grdCheques.SelEndRow = grdCheques.Row
    End If
End Sub

Private Sub grdCheques_DblClick()
    Dim VLValor As String
    grdCheques.Col = 1
    If (mskCuenta.Enabled = True Or (mskCuenta.Enabled = False And mskCuenta.ClipText = "")) And grdCheques.Text <> "" Then
        txtCampo(3).Text = grdCheques.Text
        grdCheques.Col = 2
        VLValor$ = grdCheques.Text
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            mskCuenta.Text = FMMascara(VLValor$, VGMascaraCtaCte$)
        Else
            mskCuenta.Text = FMMascara(VLValor$, VGMascaraCtaAho$)
        End If
        grdCheques.Col = 3
        mskValor(1).Text = grdCheques.Text
        grdCheques.Col = 6
        lblDescripcion(2).Caption = grdCheques.Text
        ChkCrdFijo.Enabled = False
        'cmbTipo.Enabled = False
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = False
        grdCheques.Enabled = False
        mskCuenta.Enabled = False
        mskValor(0).Enabled = False
        mskValor(1).Enabled = False
        mskValor(2).Enabled = False
        optOper(0).Enabled = False
        optOper(1).Enabled = False
        txtCampo(0).Enabled = False
        txtCampo(1).Enabled = False
        txtCampo(2).Enabled = False
        cmdBoton(0).SetFocus
    End If
End Sub

Private Sub lblEtiqueta_Click(Index As Integer)
    Select Case Index%
    Case 12
        If ChkCrdFijo.Value = True Then
            ChkCrdFijo.Value = False
        Else
            ChkCrdFijo.Value = True
        End If
    End Select
End Sub

Private Sub mskCuenta_Change()
    VLPaso% = False
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
    PLHabilitar
End Sub

Private Sub mskCuenta_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = 13 Then
        cmdBoton_Click (1)
        Exit Sub
    End If
End Sub

Private Sub mskCuenta_KeyPress(KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" And VLPaso% = False Then
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                    VLPaso% = True
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(2).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(2).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                    VLPaso% = True
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(2).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(2).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        End If
    End If
    If mskCuenta.ClipText = "" Then
        lblDescripcion(2).Caption = ""
    End If
End Sub

Private Sub mskValor_Change(Index As Integer)
    VLPaso% = False
    If Index% = 2 Then
        If Val(mskValor(2)) > 0 And Val(mskValor(2)) <> Val(mskValor(3)) Then
            cmdBoton(3).Enabled = False
        Else
            cmdBoton(3).Enabled = True
        End If
    End If
End Sub

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Valor Fijo a Procesar"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Valor a Procesar en la cuenta " + mskCuenta.Text
        PLHabilitar
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Valor Total del Proceso"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Valor Acumulado ya Procesado"
    End Select
    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)
End Sub

Private Sub mskValor_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% = 13 And Index% = 1 Then
        cmdBoton_Click (1)
        Exit Sub
    End If
End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
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

Private Sub mskValor_LostFocus(Index As Integer)
    Dim VLMonto As Integer
    If mskValor(0).Text = "" Then
        VLMonto = 0
    Else
        VLMonto = CCur(mskValor(0).ClipText)
    End If
    If Index% = 0 And ChkCrdFijo.Value = True And VLMonto = 0 Then
        MsgBox "El Valor fijo por cuenta no puede ser cero, cuando la opción de fijo ha sido activada", 0 + 16, "Mensaje de Error"
        mskValor(0).Text = ""
        mskValor(1).Text = ""
        SendKeys "{TAB}"
        ChkCrdFijo.Value = False
    End If
'    If Index% = 0 Then
'        PLBloquear
'    End If
'    If Index% = 0 And mskCuenta.Enabled = True Then
'       mskCuenta.SetFocus
'    End If
    If Index% = 0 And txtCampo(4).Enabled = True Then
        txtCampo(4).SetFocus
    End If
    If Index% = 2 Then
        If Val(mskValor(2).Text) < Val(mskValor(0).Text) Then
            MsgBox "El total a procesar C/D debe ser mayor al valor fijo por cuenta"
            mskValor(0).SetFocus
            Exit Sub
        End If
    End If
    If VLPaso% = False Then
        Select Case Index%
        Case 0
            If ChkCrdFijo.Value = True Then
                mskValor(1).Text = mskValor(0).Text
            End If
        End Select
        'VLPaso% = True
    End If
End Sub

Private Sub optOper_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
End Sub

Private Sub optOper_LostFocus(Index As Integer)
    PLBloquear
End Sub

Private Sub PLActGrid()
'*************************************************************
' PROPOSITO: Obtiene el numero de la ultima fila del grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdCheques.Col = 0
    For i% = 1 To grdCheques.Rows - 1
        grdCheques.Row = i%
        grdCheques.Text = i%
    Next i%
End Sub

Private Sub PLBloquear()
'*************************************************************
' PROPOSITO: Bloquea los campos si acepta o no un valor monetario
'            fijo
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    'If txtCampo(0).Text <> "" And txtCampo(1).Text <> "" And ((chkCrdFijo.Value = True And mskValor(0).ClipText <> "") Or chkCrdFijo.Value = False) Then
    If txtCampo(0).Text <> "" And ((ChkCrdFijo.Value = True And mskValor(0).ClipText <> "") Or ChkCrdFijo.Value = False) And txtCampo(4).Text <> "" Then
        mskCuenta.Enabled = True
        If ChkCrdFijo.Value = True Then
            mskValor(1).Enabled = False
        Else
            mskValor(1).Enabled = True
        End If
        cmdBoton(1).Enabled = True
    Else
        mskCuenta.Enabled = False
        mskValor(1).Enabled = False
        cmdBoton(1).Enabled = False
        lblDescripcion(2).Caption = ""
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        Else
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        End If
    End If
End Sub

Private Sub PLHabilitar()
'*************************************************************
' PROPOSITO: Habilita los campos de la cuenta
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    optOper(0).Enabled = False
    optOper(1).Enabled = False
    If txtCampo(0).Enabled Then
        'cmbTipo.Enabled = False
        'txtCampo(0).Enabled = False
        txtCampo(1).Enabled = False
        txtCampo(2).Enabled = False
        mskValor(0).Enabled = False
        mskValor(2).Enabled = False
        ChkCrdFijo.Enabled = False
    End If
End Sub

Private Sub PLLimGrid()
'*************************************************************
' PROPOSITO: Limpia los datos del grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdCheques.Rows = 2
    grdCheques.Cols = 7
    grdCheques.Row = 0
    grdCheques.Col = 1
    grdCheques.Text = "SECUENC."
    grdCheques.Col = 2
    grdCheques.Text = "CUENTA              "
    grdCheques.Col = 3
    grdCheques.Text = "VALOR               "
    grdCheques.Col = 4
    grdCheques.Text = "PROD."
    grdCheques.Col = 5
    grdCheques.Text = "C/D"
    grdCheques.Col = 6
    grdCheques.Text = "NOMBRE"
    grdCheques.ColWidth(1) = 750
    grdCheques.ColWidth(2) = 1400
    grdCheques.ColWidth(3) = 1400
    grdCheques.ColWidth(4) = 500
    grdCheques.ColWidth(5) = 300
    grdCheques.ColWidth(6) = 3500
    grdCheques.ColAlignment(1) = 1
    grdCheques.ColAlignment(2) = 1
    grdCheques.ColAlignment(3) = 1
    grdCheques.ColAlignment(4) = 2
    grdCheques.ColAlignment(5) = 2
    grdCheques.ColAlignment(6) = 0
End Sub

Private Sub txtCampo_Change(Index As Integer)
    If Index% = 4 Then
       VLPaso% = True
    Else
       VLPaso% = False
    End If
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de la causa del Crédito [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código de la Empresa [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Comentario acerca del crédito"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        Select Case Index%
        Case 0
            txtCampo(0).Text = ""
            If Keycode% = VGTeclaAyuda% Then
                VLPaso% = True
                If cmbTipo.Text = "CUENTA CORRIENTE" And optOper(0) = True Then
                    If VGEmpAgencia Then
                       tablita$ = "cc_causa_credemp"
                    Else
                       tablita$ = "cc_causa_nc"
                    End If
                Else
                    If cmbTipo.Text = "CUENTA CORRIENTE" And optOper(1) = True Then
                        If VGEmpAgencia Then
                           tablita$ = "cc_causa_debemp"
                        Else
                           tablita$ = "cc_causa_nd"
                        End If
                    Else
                        If cmbTipo.Text = "CUENTA DE AHORRO" And optOper(0) = True Then
                            If VGEmpAgencia Then
                               tablita$ = "ah_causa_credemp"
                            Else
                               tablita$ = "ah_causa_nc"
                            End If
                        Else
                            If cmbTipo.Text = "CUENTA DE AHORRO" And optOper(1) = True Then
                                If VGEmpAgencia Then
                                   tablita$ = "ah_causa_debemp"
                                Else
                                   tablita$ = "ah_causa_nd"
                                End If
                            End If
                        End If
                    End If
                End If
                
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, tablita$
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de causas") Then
                     PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                     PMChequea sqlconn&
                    FCatalogo.Show 1
                    txtCampo(0).Text = VGACatalogo.Codigo$
                    lblDescripcion(0).Caption = VGACatalogo.Descripcion$
                    SendKeys "{TAB}"
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                End If
            End If
        Case 1 'Empresa
            txtCampo(1).Text = ""
            ' Forma de busqueda de compañías
            FBuscarCliente!optCliente(0).Enabled = False
            FBuscarCliente!optCliente(0).Value = False
            FBuscarCliente!optCliente(1).Value = True
            FBuscarCliente.Show 1
            If VGBusqueda(1) <> "" Then
                txtCampo(1).Text = VGBusqueda(1)
                lblDescripcion(1).Caption = VGBusqueda(2)
                VLPaso% = True
            End If
            FBuscarCliente!optCliente(0).Enabled = True
            FBuscarCliente!optCliente(0).Value = True
            FBuscarCliente!optCliente(1).Value = False
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    Select Case Index%
    Case 0, 1
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 2
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTR1 As Integer
    Select Case Index%
    Case 0 'Causa
        If txtCampo(0).Text <> "" Then
            If cmbTipo.Text = "CUENTA CORRIENTE" And optOper(0) = True Then
               If VGEmpAgencia Then
                  tablita$ = "cc_causa_credemp"
               Else
                  tablita$ = "cc_causa_nc"
               End If
            Else
                If cmbTipo.Text = "CUENTA CORRIENTE" And optOper(1) = True Then
                    If VGEmpAgencia Then
                       tablita$ = "cc_causa_debemp"
                    Else
                       tablita$ = "cc_causa_nd"
                    End If
                Else
                    If cmbTipo.Text = "CUENTA DE AHORRO" And optOper(0) = True Then
                        If VGEmpAgencia Then
                           tablita$ = "ah_causa_credemp"
                        Else
                           tablita$ = "ah_causa_nc"
                        End If
                    Else
                        If cmbTipo.Text = "CUENTA DE AHORRO" And optOper(1) = True Then
                           If VGEmpAgencia Then
                              tablita$ = "ah_causa_debemp"
                           Else
                              tablita$ = "ah_causa_nd"
                           End If
                        End If
                    End If
                End If
            End If

             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, tablita$
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(0).Text)
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCampo(0).Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
            Else
                VLPaso% = True
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(0).SetFocus
            End If
        Else
            lblDescripcion(0).Caption = ""
        End If
        If txtCampo(Index%) <> "" And grdCheques.Cols = 2 Then
            PLLimGrid
        End If
    Case 1 'Empresa
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(1).Text)
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2543"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente_cc", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    ReDim VTValores(20) As String
                     VTR1% = FMMapeaArreglo(sqlconn&, VTValores())
                     PMChequea sqlconn&
                    lblDescripcion(1).Caption = VTValores(2)
                Else
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Caption = ""
                    txtCampo(1).SetFocus
                End If
            Else
                lblDescripcion(1).Caption = ""
                
            End If
        End If
     Case 4
        PLBloquear
        If mskCuenta.Enabled Then
           mskCuenta.SetFocus
           txtCampo(4).Enabled = False
        End If
    End Select
    If VLPaso% = False Then
        PLBloquear
        VLPaso% = True
    End If
End Sub


