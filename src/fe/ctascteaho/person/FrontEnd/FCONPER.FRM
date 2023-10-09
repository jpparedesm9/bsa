VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FConsultaPer 
   Appearance      =   0  'Flat
   Caption         =   "Consulta de Cuenta Personalizada"
   ClientHeight    =   5310
   ClientLeft      =   135
   ClientTop       =   1530
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
   ForeColor       =   &H80000008&
   Icon            =   "FCONPER.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9300
   Begin VB.Frame frmPerso 
      Caption         =   "Datos de la Consulta"
      ForeColor       =   &H000000FF&
      Height          =   5205
      Left            =   30
      TabIndex        =   16
      Top             =   0
      Width           =   8250
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   2265
         MaxLength       =   4
         TabIndex        =   3
         Top             =   2640
         Width           =   930
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2265
         MaxLength       =   4
         TabIndex        =   2
         Top             =   2340
         Width           =   930
      End
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   285
         Left            =   2265
         TabIndex        =   1
         Top             =   1440
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin VB.ComboBox cmbCuenta 
         Appearance      =   0  'Flat
         Height          =   300
         Left            =   2265
         Style           =   2  'Dropdown List
         TabIndex        =   0
         Top             =   1125
         Width           =   2205
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Rubro del Servicio:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   120
         TabIndex        =   13
         Top             =   2640
         Width           =   1650
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   2
         Left            =   3210
         TabIndex        =   19
         Top             =   2640
         Width           =   4980
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   6
         Left            =   3210
         TabIndex        =   20
         Top             =   2040
         Width           =   4980
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Producto Final:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   120
         TabIndex        =   21
         Top             =   2040
         Width           =   1305
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   7
         Left            =   2265
         TabIndex        =   22
         Top             =   2040
         Width           =   930
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo de Dato:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   105
         TabIndex        =   18
         Top             =   2940
         Width           =   1185
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   4
         Left            =   2265
         TabIndex        =   17
         Top             =   2940
         Width           =   1860
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   1
         Left            =   3210
         TabIndex        =   7
         Top             =   2340
         Width           =   4980
      End
      Begin VB.Label lblDescripcion 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   3
         Left            =   2265
         TabIndex        =   8
         Top             =   3240
         Width           =   1860
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   10
         Left            =   120
         TabIndex        =   9
         Top             =   1125
         Width           =   1110
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Número de Cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   120
         TabIndex        =   10
         Top             =   1440
         Width           =   1650
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Nombre de Cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   120
         TabIndex        =   11
         Top             =   1740
         Width           =   1650
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   0
         Left            =   2265
         TabIndex        =   12
         Top             =   1740
         Width           =   5925
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Servicio Disponible:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   120
         TabIndex        =   14
         Top             =   2340
         Width           =   1710
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Valor:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   105
         TabIndex        =   15
         Top             =   3240
         Width           =   510
      End
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Transmitir"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   0
      Left            =   8385
      Picture         =   "FCONPER.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   4
      Tag             =   "4073"
      Top             =   2985
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   2
      Left            =   8385
      Picture         =   "FCONPER.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   4530
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Limpiar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   1
      Left            =   8385
      Picture         =   "FCONPER.frx":09D6
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   3750
      Width           =   875
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   15
      Y2              =   5325
   End
End
Attribute VB_Name = "FConsultaPer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
Dim VLTipo As Integer
'! removed Dim VLDato As String

'! removed Dim VLFecha As String

Private Sub cmbCuenta_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Tipo de la Cuenta"
End Sub

Private Sub cmbCuenta_LostFocus()
    If cmbCuenta.Text <> "" Then

        If cmbCuenta.Text = "CTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte$
        Else
            mskCuenta.Mask = VGMascaraCtaAho$
        End If
    End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim VTR%
Dim VLValor$
Dim i%
   Select Case Index%
    Case 0
        'Validación de Mandatoriedades
        If mskCuenta.ClipText = "" Then
            MsgBox "El número de la cuenta  es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El código de servicio disponible es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4073"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
        If cmbCuenta.Text = "CTA AHORROS" Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
        Else
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
        End If
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, "1" 'VGOficina$
        ReDim VTValores(4) As String
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, " Ok...Consulta de Contratación") Then
             VTR% = FMMapeaArreglo(sqlconn&, VTValores())
             PMChequea sqlconn&
            If VTValores(1) <> "" Then
                 VLValor$ = VTValores(2)
                 lblDescripcion(4).Caption = VTValores(1)
                 If InStr(1, VLValor$, ".") > 0 Then
                    VLValor$ = Mid$(VLValor$, 1, InStr(1, VLValor$, ".")) & (Mid$(VLValor$, (InStr(1, VLValor$, ".") + 1), 2))
                 End If
                 lblDescripcion(3).Caption = VLValor$
            
            End If
        End If
         
         
    Case 1 'Limpiar
        
        If cmbCuenta.Text = "CTA CORRIENTE" Then
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        Else
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        End If
        
        
        cmbCuenta.Clear
        cmbCuenta.AddItem "CTA AHORROS", 0
        cmbCuenta.AddItem "CTA CORRIENTE", 1
        cmbCuenta.ListIndex = 0
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        For i% = 0 To 4
            lblDescripcion(i%).Caption = ""
        Next i%
        lblDescripcion(6).Caption = ""
        lblDescripcion(7).Caption = ""

    Case 2 'Salir
        
        Unload FConsultaPer

End Select
End Sub

Private Sub Form_Load()
    FConsultaPer.Left = 15
    FConsultaPer.Top = 15
    FConsultaPer.Width = 9420
    FConsultaPer.Height = 5730
    cmbCuenta.Clear
    cmbCuenta.AddItem "CTA AHORROS", 0
    cmbCuenta.AddItem "CTA CORRIENTE", 1
    cmbCuenta.ListIndex = 0
    mskCuenta.Mask = VGMascaraCtaAho$
    
    'cmdBoton(0).Enabled = True
 
 PMObjetoSeguridad cmdBoton(0)

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub mskCuenta_GotFocus()
    If cmbCuenta.Text <> "" Then

        If cmbCuenta.Text = "CTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte$
        Else
            mskCuenta.Mask = VGMascaraCtaAho$
        End If
    End If
    
    FPrincipal.pnlHelpLine.Caption = " Número de la cuenta corriente/ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)


End Sub

Private Sub mskCuenta_LostFocus()
Dim VTR1%
    On Error Resume Next
    If cmbCuenta.Text = "" Then
        MsgBox "El tipo de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        cmbCuenta.SetFocus
        Exit Sub
    End If
    If mskCuenta.ClipText <> "" Then
        If cmbCuenta.Text = "CTA CORRIENTE" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                VLTipo% = True
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, "") Then
                        ReDim VTArreglo(10) As String
                         VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTR1% <> 0 Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                            lblDescripcion(7).Caption = VTArreglo(2)
                            lblDescripcion(6).Caption = VTArreglo(3)
                        Else
                            MsgBox "Error en consulta de Cuenta", 0 + 16, "Mensaje del Servidor"
                        End If
                    Else
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                        mskCuenta.SetFocus
                    End If
                
            Else
                MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
            
        Else
            'OJO
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                VLTipo% = False
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
                     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", True, "") Then
                        ReDim VTArreglo(10) As String
                         VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTR1% <> 0 Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                            lblDescripcion(6).Caption = VTArreglo(3)
                            lblDescripcion(7).Caption = VTArreglo(2)
                        Else
                            MsgBox "Error en consulta de Cuenta", 0 + 16, "Mensaje del Servidor"
                        End If
                    Else
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                        mskCuenta.SetFocus
                    End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        End If
End If

End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Servicio Disponible [F5 Ayuda]"
    
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Rubro del Servicio [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

If KeyCode% = VGTeclaAyuda% Then
    VLPaso% = True
    Select Case Index%
    Case 0
        VGOperacion$ = "sp_help_serv_pe"
        'GBB26May98008 II:
        ' Se debe haver un load a la forma antes de cargar los valores
          Load FRegistros
        'GBB26May98008 IF:
            
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "Ok...Consulta de Servicios") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            FRegistros.Show 1
            If VGACatalogo.Codigo$ <> "" Then
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
            End If
        Else
            VGOperacion$ = ""
        End If
    Case 1
        If txtCampo(0).Text = "" Then
            MsgBox "El código de servicio disponible es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        VGOperacion$ = "sp_valor_contratado"
        ' GBB26May98008 II:
        ' Se debe haver un load a la forma antes de cargar los valores
          Load FRegistros
        'GBB26May98008 IF:
            
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", False, "Ok...Consulta de Detalles") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            FRegistros.Show 1
            
            If VGACatalogo.Codigo$ <> "" Then
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
            End If
        Else
            txtCampo(1).Text = ""
            lblDescripcion(2).Caption = ""

        End If

    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
        End If
    Case 1
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 0
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                    
                Else
                    lblDescripcion(1).Caption = ""
                    txtCampo(0).Text = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(1).Caption = ""
            End If
        End If
    Case 1
        If VLPaso% = False Then
        If txtCampo(0).Text = "" Then
            MsgBox "El código de servicio disponible es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
            
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4074"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "I"
                 PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(0).Text
                 PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, txtCampo(1).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_valor_contratado", False, "Ok...Consulta de Detalles") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                Else
                    lblDescripcion(2).Caption = ""
                    txtCampo(1).Text = ""
                End If
                
            
            Else
                lblDescripcion(2).Caption = ""
            End If
        End If
    End Select
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


