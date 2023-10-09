VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran204 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Reapertura de Cuentas de Ahorros"
   ClientHeight    =   5340
   ClientLeft      =   150
   ClientTop       =   1380
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
   HelpContextID   =   1110
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5340
   ScaleWidth      =   9510
   Tag             =   "3106"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   2295
      MaxLength       =   54
      TabIndex        =   10
      Top             =   4410
      Width           =   6060
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8590
      TabIndex        =   4
      Top             =   4560
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
      Left            =   8590
      TabIndex        =   3
      Top             =   3795
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
      Index           =   0
      Left            =   8590
      TabIndex        =   2
      Top             =   3030
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
   Begin MSGrid.Grid grdPropietarios 
      Height          =   1950
      Left            =   15
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   975
      Width           =   8500
      _Version        =   65536
      _ExtentX        =   14993
      _ExtentY        =   3440
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
      Left            =   8590
      TabIndex        =   1
      Top             =   1008
      WhatsThisHelpID =   2026
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Propiet."
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
      Left            =   1950
      TabIndex        =   0
      Top             =   60
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   3
      X1              =   -30
      X2              =   8550
      Y1              =   2985
      Y2              =   2985
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha de apertura:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   30
      TabIndex        =   19
      Top             =   3165
      WhatsThisHelpID =   5277
      Width           =   1710
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha de cancelación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   30
      TabIndex        =   18
      Top             =   3465
      WhatsThisHelpID =   5278
      Width           =   2040
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Saldo a la cancelación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   30
      TabIndex        =   17
      Top             =   3780
      WhatsThisHelpID =   5279
      Width           =   2100
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Causa de cancelación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   30
      TabIndex        =   16
      Top             =   4110
      WhatsThisHelpID =   5018
      Width           =   2040
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   300
      Index           =   2
      Left            =   2295
      TabIndex        =   15
      Top             =   3150
      Width           =   1695
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   300
      Index           =   1
      Left            =   2295
      TabIndex        =   14
      Top             =   3465
      Width           =   1695
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   300
      Index           =   4
      Left            =   2295
      TabIndex        =   13
      Top             =   3780
      Width           =   1695
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   7
      Left            =   2295
      TabIndex        =   12
      Top             =   4110
      Width           =   6060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Autorizado por:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   30
      TabIndex        =   11
      Top             =   4410
      WhatsThisHelpID =   5280
      Width           =   1380
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   75
      TabIndex        =   9
      Top             =   735
      WhatsThisHelpID =   5055
      Width           =   1155
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   8
      Top             =   360
      UseMnemonic     =   0   'False
      Width           =   6550
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8550
      X2              =   8550
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -60
      X2              =   8550
      Y1              =   675
      Y2              =   675
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
      Left            =   15
      TabIndex        =   7
      Top             =   60
      WhatsThisHelpID =   5254
      Width           =   2055
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
      Left            =   15
      TabIndex        =   6
      Top             =   360
      WhatsThisHelpID =   5265
      Width           =   1920
   End
End
Attribute VB_Name = "FTran204"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRAN204.frm
' NOMBRE LOGICO:    FTran204
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
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Transmitir

        ' Validacion de Mandatoriedades

        ' Numero de Cuenta de Ahorros
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "204"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_aut", 0, SQLVARCHAR, VGLogin$
         PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, (txtCampo.Text) 'ARiggs 08/30/06
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_reapertura_ah", True, " Ok... Reapertura de Cuentas de Ahorros") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
        End If

    Case 1
        'Limpiar
        
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        lblDescripcion(0).Caption = ""
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = False
        cmdBoton(0).Enabled = True
        mskCuenta.SetFocus
        'ARiggs 08-29-06
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(4).Caption = ""
        lblDescripcion(7).Caption = ""
        txtCampo = ""
    Case 2
        'Salir
        
        Unload FTran204
    Case 3
        'Consultar
        
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "298"
         PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
        Else
            PMLimpiaGrid grdPropietarios
        End If
    End Select
End Sub

Private Sub Form_Load()
    FTran204.Left = 0   '15
    FTran204.Top = 0   '15
    FTran204.Width = 9600   '9420
    FTran204.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaAho$
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

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta de ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    Dim VTR1 As Integer
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "204"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$) 'Ariggs 08-29-06
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_reapertura_ah", True, " Ok... Consulta de la cuenta") Then
          ReDim VTArreglo(10) As String
          VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
          PMChequea sqlconn&
          lblDescripcion(2).Caption = VTArreglo(1)
          lblDescripcion(1).Caption = VTArreglo(2)
          lblDescripcion(4).Caption = VTArreglo(3)
          lblDescripcion(7).Caption = VTArreglo(4)
        End If
    End If
End Sub

Private Sub txtCampo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Nombre de la persona que autoriza"
End Sub

Private Sub txtCampo_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("U", KeyAscii%)
End Sub

