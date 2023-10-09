VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2545 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Ajuste de Creación de O.D.N.P. Individual"
   ClientHeight    =   5325
   ClientLeft      =   150
   ClientTop       =   1470
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
   HelpContextID   =   1006
   Icon            =   "FTRA2545.frx":0000
   LinkTopic       =   "Form14"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin Threed.SSFrame frmCheques 
      Height          =   2520
      Left            =   45
      TabIndex        =   11
      Top             =   2760
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14606
      _ExtentY        =   4445
      _StockProps     =   14
      Caption         =   "Datos del Cheque"
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
         Index           =   0
         Left            =   3885
         MaxLength       =   7
         TabIndex        =   3
         Top             =   915
         Width           =   1830
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Left            =   3885
         TabIndex        =   4
         Top             =   1215
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   503
         _Version        =   393216
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Valor del cheque:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   1635
         TabIndex        =   8
         Top             =   1215
         Width           =   1515
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Número del cheque:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   1635
         TabIndex        =   13
         Top             =   915
         Width           =   1725
      End
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   1
      Top             =   1035
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Propiet."
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      Picture         =   "FTRA2545.frx":030A
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
         Size            =   6.75
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
      Left            =   8415
      TabIndex        =   5
      Top             =   3030
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Transmitir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2545.frx":0624
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   6
      Top             =   3795
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2545.frx":099A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   7
      Top             =   4560
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2545.frx":0D10
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   12
      Top             =   780
      Width           =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre de la chequera:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   90
      TabIndex        =   14
      Top             =   345
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -30
      X2              =   8385
      Y1              =   2685
      Y2              =   2685
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
      Left            =   90
      TabIndex        =   10
      Top             =   45
      Width           =   2100
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -60
      X2              =   8355
      Y1              =   690
      Y2              =   690
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2235
      TabIndex        =   9
      Top             =   345
      Width           =   6120
   End
End
Attribute VB_Name = "FTran2545"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Transmitir

        ' Validacion de Mandatoriedades

        ' Numero de Cuenta
        If mskCuenta.ClipText = "" Then
            MsgBox "El número de Cuenta Corriente es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Numero del cheque revocado
        If txtCampo(0).Text = "" Then
            MsgBox "El número del cheque revocado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        ' Valor del cheque revocado
        If Val(mskValor.Text) < 0 Then
            MsgBox "El valor del cheque no puede ser negativo", 0 + 16, "Mensaje de Error"
            mskValor.SetFocus
            Exit Sub
        End If


         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2545"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_nchq", 0, SQLINT4, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_valch", 0, SQLMONEY, (mskValor.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_ajuste_rvoca", True, "Ok... Ajuste de Revocatoria") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
        End If

    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        lblDescripcion(0).Caption = ""
        txtCampo(0).Text = ""
        mskValor.Text = ""
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = False
        cmdBoton(0).Enabled = True
        mskValor.Format = VGDecimales$
        mskValor.Text = Format$(0, VGDecimales$)
        mskCuenta.SetFocus
    Case 2
        'Salir
        Unload FTran2545
    Case 3
        'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "17"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_clientes", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
        End If
    End Select
End Sub

Private Sub Form_Load()
    FTran2545.Left = 15
    FTran2545.Top = 15
    FTran2545.Width = 9420
    FTran2545.Height = 5730
    mskValor.MaxLength = 14
    mskCuenta.Mask = VGMascaraCtaCte$
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
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
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta corriente"
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta Corriente"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "16"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                cmdBoton(3).Enabled = False
                PMLimpiaGrid grdPropietarios
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(0).Caption = ""
            PMLimpiaGrid grdPropietarios
            cmdBoton(3).Enabled = False
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
End Sub

Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del Cheque Revocado"
    mskValor.MaxLength = 14
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
End Sub

Private Sub mskValor_KeyPress(KeyAscii As Integer)
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

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Número del Cheque Revocado"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 1
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
        Case 0
            If Val(txtCampo(0).Text) < 1 Then
                MsgBox "El número de cheque no puede ser menor que 1", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
            End If
    End Select
End Sub


