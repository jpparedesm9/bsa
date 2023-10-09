VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran211 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Bloqueo de Movimientos a la Cuenta de Ahorros"
   ClientHeight    =   5325
   ClientLeft      =   270
   ClientTop       =   2190
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
   HelpContextID   =   1021
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9510
   Tag             =   "3103"
   Begin Threed.SSFrame frmBloqueos 
      Height          =   2616
      Left            =   48
      TabIndex        =   18
      Top             =   2652
      WhatsThisHelpID =   5141
      Width           =   8424
      _Version        =   65536
      _ExtentX        =   14859
      _ExtentY        =   4614
      _StockProps     =   14
      Caption         =   "*Datos del Bloqueo"
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
      Begin VB.TextBox txtObservacion 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2100
         MaxLength       =   120
         ScrollBars      =   2  'Vertical
         TabIndex        =   5
         Top             =   1560
         Width           =   6045
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   2100
         TabIndex        =   4
         Top             =   1260
         Width           =   6045
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2100
         MaxLength       =   2
         TabIndex        =   3
         Top             =   960
         Width           =   735
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   2100
         MaxLength       =   2
         TabIndex        =   2
         Top             =   660
         Width           =   735
      End
      Begin VB.Label lblObservacion 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Observaciones: "
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   165
         TabIndex        =   20
         Top             =   1605
         WhatsThisHelpID =   5132
         Width           =   1470
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Solicitado por:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   165
         TabIndex        =   19
         Top             =   1275
         WhatsThisHelpID =   5270
         Width           =   1320
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   2850
         TabIndex        =   11
         Top             =   960
         Width           =   5295
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Tipo de bloqueo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   135
         TabIndex        =   12
         Top             =   960
         WhatsThisHelpID =   5269
         Width           =   1530
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Causa de bloqueo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   135
         TabIndex        =   16
         Top             =   660
         WhatsThisHelpID =   5268
         Width           =   1680
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   2850
         TabIndex        =   17
         Top             =   660
         Width           =   5295
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   2
      Left            =   8592
      TabIndex        =   8
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   876
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
      Height          =   756
      Index           =   1
      Left            =   8592
      TabIndex        =   7
      Top             =   3792
      WhatsThisHelpID =   2003
      Width           =   876
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
      Height          =   756
      Index           =   0
      Left            =   8592
      TabIndex        =   6
      Top             =   3036
      WhatsThisHelpID =   2007
      Width           =   876
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
      Height          =   1635
      Left            =   15
      TabIndex        =   9
      Top             =   960
      Width           =   8500
      _Version        =   65536
      _ExtentX        =   14993
      _ExtentY        =   2884
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
      Height          =   756
      Index           =   3
      Left            =   8604
      TabIndex        =   1
      Top             =   972
      WhatsThisHelpID =   2026
      Width           =   876
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
      Top             =   45
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   4
      Left            =   8580
      TabIndex        =   21
      Top             =   2280
      WhatsThisHelpID =   2009
      Width           =   876
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   15
      Top             =   750
      WhatsThisHelpID =   5055
      Width           =   1155
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   14
      Top             =   345
      UseMnemonic     =   0   'False
      Width           =   6550
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8560
      X2              =   8560
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8560
      Y1              =   660
      Y2              =   660
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
      TabIndex        =   13
      Top             =   45
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8560
      Y1              =   2640
      Y2              =   2640
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
      TabIndex        =   10
      Top             =   345
      WhatsThisHelpID =   5265
      Width           =   1920
   End
End
Attribute VB_Name = "FTran211"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran211.frm
' NOMBRE LOGICO:    FTran211
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
'Permite realizar el bloqueo de movimientos a una cuenta de
'ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLPaso As Integer

Private Sub cmdBoton_Click(Index As Integer)
Dim i As Integer
    Select Case Index%
    Case 0
        'Transmitir
        ' Validacion de Mandatoriedades
        ' Numero de la cuenta de ahorros
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Causa del Bloqueo
        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "La causa de bloqueo es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        ' Causa de Bloqueo no puede ser Embargo
        If txtCampo(1).Text = "9" Then
            MsgBox "No se puede escoger causa Embargo", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        ' Tipo de Bloqueo
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El tipo de bloqueo es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        ' Nombre del Solicitante
        If txtCampo(2).Text = "" Then
            MsgBox "El nombre del solicitante es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "211"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_tbloq", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, (txtCampo(1).Text)
         PMPasoValores sqlconn&, "@i_solicit", 0, SQLVARCHAR, (txtCampo(2).Text)
         PMPasoValores sqlconn&, "@i_aut", 0, SQLVARCHAR, VGLogin$
         PMPasoValores sqlconn&, "@i_observacion", 0, SQLVARCHAR, (txtObservacion.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_bloqueo_mov_ah", True, " Ok... Bloqueo de Movimientos a Cuenta de Ahorros") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton(4).Enabled = True
            MsgBox "El bloqueo de movimiento contra la cuenta de ahorros fue ingresado con exito", 0 + vbInformation, "Informacion"
        End If

    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        For i% = 0 To 2
            lblDescripcion(i%).Caption = ""
        Next i%
        For i% = 0 To 2
            txtCampo(i%).Text = ""
        Next i%
        txtObservacion.Text = ""
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = False
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        mskCuenta.SetFocus

    Case 2
        'Salir
        Unload FTran211
    Case 3
        'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "298"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
        Else
            PMLimpiaGrid grdPropietarios
        End If
    Case 4
        PLImprimir
    End Select
End Sub

Private Sub Form_Load()
    FTran211.Left = 0   '15
    FTran211.Top = 0   '15
    FTran211.Width = 9600   '9420
    FTran211.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    PMCatalogo "D", "cc_tbloqueo", txtCampo(0), lblDescripcion(1)
    mskCuenta.Mask = VGMascaraCtaAho$
    txtCampo(2).MaxLength = 50
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
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_val_inac", 0, SQLVARCHAR, "N" 'PCOELLO NO SE DEBE VALIDAR INACTIVIDAD
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
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Tipo de Bloqueo [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Causa del Bloqueo [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Nombre de quien solicita el Bloqueo"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Select Case Index%
    Case 0
        If Keycode% = VGTeclaAyuda% Then
            VLPaso% = True
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "ah_tbloqueo"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de tipos de bloqueos") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                If txtCampo(0).Text <> "" Then
                    txtCampo(2).SetFocus
                End If
            Else
                txtCampo(0).Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(0).SetFocus
            End If
        End If
    Case 1
        If Keycode% = VGTeclaAyuda% Then
            VLPaso% = True
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "ah_causa_bloqueo_mov"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de causas") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
                If txtCampo(1).Text = "9" Then
                    MsgBox "No se puede escoger causa Embargo", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    lblDescripcion(2).Caption = ""
                    Exit Sub
                End If
                If txtCampo(1).Text <> "" Then
                    txtCampo(0).SetFocus
                End If
            Else
                txtCampo(1).Text = ""
                lblDescripcion(2).Caption = ""
                txtCampo(1).SetFocus
            End If
        End If
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    Case 2
        KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso% = False Then
        Select Case Index%
        Case 0
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "ah_tbloqueo"
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
                    txtCampo(0).SetFocus
                End If
            Else
                lblDescripcion(1).Caption = ""
            End If
        Case 1
            If txtCampo(1).Text <> "" Then
                If txtCampo(1).Text = "9" Then
                    MsgBox "No se puede escoger causa Embargo", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    lblDescripcion(2).Caption = ""
                    Exit Sub
                End If
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "ah_causa_bloqueo_mov"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(1).Text)
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCampo(0).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(1).Text = ""
                    lblDescripcion(2).Caption = ""
                    txtCampo(1).SetFocus
                End If
            Else
                lblDescripcion(2).Caption = ""
            End If
        End Select
    End If
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub

Private Sub txtObservacion_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Observaciones"
    txtObservacion.SelStart = 0
    txtObservacion.SelLength = Len(txtObservacion.Text)
End Sub

Private Sub txtObservacion_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Imprime los datos de la pantalla luego de haber
'            transmitido el bloqueo
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-05      D. Villagómez   Emisión Inicial
'*************************************************************
    Dim banderaContinuar As Boolean
    banderaContinuar = True

    If MsgBox("Esta seguro de imprimir el resultado del bloqueo de movimientos?", 4 + 32 + 0, "Mensaje del Sistema") = 7 Then
        banderaContinuar = False
    End If
   
    If (banderaContinuar = True) Then
        Screen.MousePointer = 11
        FMCabeceraReporte VGBanco$, Date, "BLOQUEO DE MOVIMIENTOS EN CUENTA DE AHORROS", _
                          Time(), Me.Caption, VGFecha$, 1 'Printer.Page
        Printer.FontBold = True
        Printer.FontSize = 8
        Printer.Print "  Número de Cuenta           :"; Tab(32); mskCuenta.Text
        Printer.Print ""
        Printer.Print "  Nombre de la Cuenta        :"; Tab(32); lblDescripcion(0).Caption
        Printer.Print ""
        Printer.Print "  Causa del Bloqueo          :"; Tab(32); txtCampo(1).Text; "  "; lblDescripcion(2).Caption
        Printer.Print ""
        Printer.Print "  Tipo de   Bloqueo          :"; Tab(32); txtCampo(0).Text; "  "; lblDescripcion(1).Caption
        Printer.Print ""
        Printer.Print "  Solicitado por             :"; Tab(32); txtCampo(2).Text
        Printer.Print ""
        Printer.Print "  Observaciones              :"; Tab(32); txtObservacion.Text
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "_________________                                                 _________________"
        Printer.Print "  PROCESADO POR                                                     AUTORIZADO POR "
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.EndDoc
        Screen.MousePointer = 0
    Else 'si el usuario escogió NO en la pregunta
        Exit Sub
    End If
End Sub



