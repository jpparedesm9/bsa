VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran212 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Levantamiento de Bloqueos de Movimientos a la Cuenta de Ahorros"
   ClientHeight    =   5325
   ClientLeft      =   30
   ClientTop       =   1875
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
   HelpContextID   =   1075
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9510
   Tag             =   "3104"
   Begin Threed.SSFrame frmBloqueos 
      Height          =   2550
      Left            =   45
      TabIndex        =   9
      Top             =   2730
      WhatsThisHelpID =   5141
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14606
      _ExtentY        =   4498
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
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   2355
         TabIndex        =   5
         Top             =   1575
         Width           =   5820
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2355
         MaxLength       =   2
         TabIndex        =   4
         Top             =   1275
         Width           =   735
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   2355
         MaxLength       =   1
         TabIndex        =   3
         Top             =   975
         Width           =   735
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
         Left            =   105
         TabIndex        =   18
         Top             =   1575
         WhatsThisHelpID =   5270
         Width           =   1320
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Tipo de Bloqueo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   105
         TabIndex        =   12
         Top             =   1275
         WhatsThisHelpID =   5276
         Width           =   1545
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   3105
         TabIndex        =   13
         Top             =   1275
         Width           =   5070
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   3105
         TabIndex        =   16
         Top             =   975
         Width           =   5070
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Causa del Levantamiento:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   120
         TabIndex        =   17
         Top             =   975
         WhatsThisHelpID =   5275
         Width           =   2295
      End
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8600
      TabIndex        =   1
      Top             =   1020
      WhatsThisHelpID =   2026
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
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
   Begin MSGrid.Grid grdPropietarios 
      Height          =   1635
      Left            =   15
      TabIndex        =   2
      Top             =   1020
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
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
      Height          =   750
      Index           =   0
      Left            =   8600
      TabIndex        =   6
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8600
      TabIndex        =   7
      Top             =   3795
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
      Index           =   2
      Left            =   8600
      TabIndex        =   8
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
      Index           =   4
      Left            =   8600
      TabIndex        =   19
      Tag             =   "6335"
      Top             =   2265
      WhatsThisHelpID =   2009
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
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
      Left            =   60
      TabIndex        =   15
      Top             =   765
      WhatsThisHelpID =   5055
      Width           =   1155
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
      TabIndex        =   14
      Top             =   390
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8550
      Y1              =   2685
      Y2              =   2685
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
      TabIndex        =   11
      Top             =   60
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8550
      Y1              =   675
      Y2              =   675
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
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   10
      Top             =   360
      UseMnemonic     =   0   'False
      Width           =   6550
   End
End
Attribute VB_Name = "FTran212"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran212.frm
' NOMBRE LOGICO:    FTran212
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
' Permite realizar el levantamiento al bloqueo de movimientos
' de una cuenta de ahorros.
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
        ' Numero de Cuenta de Ahorros
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        
        ' Causa de Bloqueo
        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "La Causa de Levantamiento es mandatoria", 0 + 16, "Mensaje de Error"
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

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "212"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_tbloq", 0, SQLCHAR, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_causa", 0, SQLCHAR, (txtCampo(1).Text)
         PMPasoValores sqlconn&, "@i_solicit", 0, SQLVARCHAR, (txtCampo(2).Text)
         PMPasoValores sqlconn&, "@i_aut", 0, SQLVARCHAR, VGLogin$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_bloqueo_mov_ah", True, " Ok... Levantamiento de Bloqueo de Movimientos") Then
            PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton(4).Enabled = True
            MsgBox "El levantamiento del bloqueo de movimientos fue realizado con exito", 0 + vbInformation, "Informacion"
        End If
    Case 1  'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        For i% = 0 To 2
            lblDescripcion(i%).Caption = ""
        Next i%
        For i% = 0 To 2
            txtCampo(i%).Text = ""
        Next i%
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(0).Enabled = True
        mskCuenta.SetFocus
    
    Case 2
        'Salir

        Unload FTran212
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
    FTran212.Left = 0   '15
    FTran212.Top = 0   '15
    FTran212.Width = 9600   '9420
    FTran212.Height = 5900   '5730
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
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
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
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "ah_motivo_levbloq_mov"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
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
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "ah_motivo_levbloq_mov"
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

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Permite imprimir los datos consultados en el grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA           AUTOR           RAZON
' 06-Agos-06      A. Riggs        Emisión Inicial
'*************************************************************

    If MsgBox("Esta seguro de Imprimir el Levantamiento de Movimiento", 1 + 32 + 0, "Mensaje del Sistema") = 1 Then
        Screen.MousePointer = 11

        FMCabeceraReporte VGBanco$, Date, "LEVANTAMIENTO DE MOVIMIENTO EN CUENTAS DE AHORROS", _
                          Time(), Me.Caption, VGFecha$, 1
        Printer.FontBold = True
        Printer.Print Tab(4); "Número de Cuenta        :   "; mskCuenta.Text
        Printer.Print ""
        Printer.Print Tab(4); "Nombre de la Cuenta     :   "; lblDescripcion(0).Caption
        Printer.Print ""
        Printer.Print Tab(4); "Causa de Levantamiento  :   "; lblDescripcion(2).Caption
        Printer.Print ""
        Printer.Print Tab(4); "Tipo de Bloqueo         :   "; lblDescripcion(1).Caption
        Printer.Print ""
        Printer.Print Tab(4); "Solicitado por          :   "; txtCampo(2).Text
        Printer.Print ""
      
        Printer.Print "  " & String$(94, "_")
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        Printer.Print Tab(4); VGLogin
        Printer.Print "  _________________                      _________________"
        Printer.Print "  PROCESADO POR                          AUTORIZADO POR "
        Printer.Print ""
        Printer.Print ""
        If VGCodPais$ <> "CO" Then
            Printer.Print "---  U L T I M A   L I N E A  ---"
        End If
        Printer.EndDoc
        Screen.MousePointer = 0
    End If
End Sub




