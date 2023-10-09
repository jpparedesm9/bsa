VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FAcuseChq 
   Caption         =   "*Acuse de Novedad"
   ClientHeight    =   2565
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8160
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2565
   ScaleWidth      =   8160
   Tag             =   "3881"
   Begin Threed.SSFrame SSFrame1 
      Height          =   1515
      Left            =   60
      TabIndex        =   7
      Top             =   60
      WhatsThisHelpID =   5401
      Width           =   8010
      _Version        =   65536
      _ExtentX        =   14129
      _ExtentY        =   2672
      _StockProps     =   14
      Caption         =   "*Datos del Cheque"
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
      Begin VB.TextBox txtCheque 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   4965
         MaxLength       =   10
         TabIndex        =   4
         Top             =   840
         Width           =   1605
      End
      Begin VB.TextBox txtCarta 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1890
         MaxLength       =   8
         TabIndex        =   0
         Top             =   225
         Width           =   1605
      End
      Begin VB.TextBox txtRemesa 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1890
         MaxLength       =   8
         TabIndex        =   1
         Top             =   540
         Width           =   1605
      End
      Begin VB.TextBox txtCtaGirada 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1890
         MaxLength       =   14
         TabIndex        =   3
         Top             =   1185
         Width           =   1605
      End
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   285
         Left            =   1890
         TabIndex        =   2
         Top             =   855
         Width           =   1605
         _ExtentX        =   2831
         _ExtentY        =   503
         _Version        =   393216
         MaxLength       =   15
         Mask            =   "####-##-#####-#"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Left            =   4965
         TabIndex        =   5
         Top             =   1155
         Width           =   2190
         _ExtentX        =   3863
         _ExtentY        =   503
         _Version        =   393216
         MaxLength       =   22
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Valor:"
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
         Left            =   3795
         TabIndex        =   14
         Top             =   1200
         WhatsThisHelpID =   5439
         Width           =   585
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. Cheque:"
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
         Left            =   3780
         TabIndex        =   13
         Top             =   870
         WhatsThisHelpID =   5404
         Width           =   1155
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. de carta:"
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
         Left            =   135
         TabIndex        =   12
         Top             =   255
         WhatsThisHelpID =   5430
         Width           =   1215
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. Remesa:"
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
         Left            =   135
         TabIndex        =   11
         Top             =   570
         WhatsThisHelpID =   5402
         Width           =   1185
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Cuenta Depositada:"
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
         Left            =   135
         TabIndex        =   10
         Top             =   885
         WhatsThisHelpID =   5403
         Width           =   1770
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Cta. Girada:"
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
         Left            =   135
         TabIndex        =   9
         Top             =   1215
         WhatsThisHelpID =   5421
         Width           =   1110
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   7155
      TabIndex        =   8
      Top             =   1785
      WhatsThisHelpID =   2023
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Cancelar"
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
      Picture         =   "FAcuseChq.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   6300
      TabIndex        =   6
      Top             =   1785
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
      Picture         =   "FAcuseChq.frx":001C
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000002&
      BorderWidth     =   2
      X1              =   0
      X2              =   8160
      Y1              =   1725
      Y2              =   1725
   End
End
Attribute VB_Name = "FAcuseChq"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
Dim VLPas As Boolean
Dim VLPaso As Boolean


'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0: 'Transmitir
            PLTransmitir
        Case 1: 'Cancelar
            Unload Me
    End Select
End Sub
Sub PLTransmitir()
    If FLChequea() = True Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "601"
            PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
            PMPasoValores sqlconn&, "@i_ctadep", 0, SQLVARCHAR, mskCuenta.ClipText
            PMPasoValores sqlconn&, "@i_ctagir", 0, SQLVARCHAR, txtCtaGirada.Text
            PMPasoValores sqlconn&, "@i_bloq", 0, SQLVARCHAR, "A"
            PMPasoValores sqlconn&, "@i_chq", 0, SQLINT4, txtCheque.Text
            PMPasoValores sqlconn&, "@i_chq_sec", 0, SQLINT4, txtRemesa.Text
            PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, mskValor.ClipText
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_novedad_remesas", True, " Ok... Acuse de chque devuelto") Then
                PMChequea sqlconn&
                PLLimpiar
            End If
            'PLLimpiar
    End If

End Sub

Function FLChequea() As Integer
    FLChequea = False
    If Trim$(txtCarta.Text) = "" Then
        MsgBox "No. de Carta es mandatorio", 0 + 16, "Mensaje de Error"
        txtCarta.SetFocus
        Exit Function
    End If
    If Trim$(txtRemesa.Text) = "" Then
        MsgBox "No. de Remesa es mandatorio", 0 + 16, "Mensaje de Error"
        txtRemesa.SetFocus
        Exit Function
    End If
    If Trim$(mskCuenta.ClipText) = "" Then
        MsgBox "Cuenta Depositada es mandatoria", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Function
    End If
    If Trim$(txtCtaGirada.Text) = "" Then
        MsgBox "Cuenta Girada es mandatoria", 0 + 16, "Mensaje de Error"
        txtCtaGirada.SetFocus
        Exit Function
    End If
    If Trim$(txtCheque.Text) = "" Then
        MsgBox "No. de Cheque es mandatorio", 0 + 16, "Mensaje de Error"
        txtCheque.SetFocus
        Exit Function
    End If
    If Trim$(mskValor.Text) = "" Then
        MsgBox "Valor del cheque es mandatorio", 0 + 16, "Mensaje de Error"
        mskValor.SetFocus
        Exit Function
    End If
    FLChequea = True
End Function

Sub PLLimpiar()
        txtCarta = ""
        txtRemesa = ""
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        txtCtaGirada = ""
        txtCheque = ""
        mskValor.Format = VGDecimales$
        mskValor.Text = Format$(0, VGDecimales$)
        txtCarta.SetFocus
End Sub

Private Sub Form_Load()
    PMLoadResStrings Me
    PMLoadResIcons Me
    FAcuseChq.Top = 1600
    FAcuseChq.Left = 275
    mskCuenta.Mask = VGMascaraCtaCte$
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
End Sub

Private Sub mskCuenta_Change()


    VLPaso = False
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta Depositada"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
    VLPaso = True
End Sub

Private Sub mskCuenta_LostFocus()
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(mskCuenta.ClipText) <> "" Then
        If Not FMChequeaCtaCte((mskCuenta.ClipText)) Then
            MsgBox "Digito verificador errado"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            mskCuenta.SetFocus
        End If
    End If
End Sub

Private Sub mskValor_GotFocus()
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
End Sub

Private Sub txtCarta_GotFocus()
    txtCarta.SelStart = 0
    txtCarta.SelLength = Len(txtCarta.Text)
End Sub

Private Sub txtCarta_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

Private Sub txtCheque_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

Private Sub txtCtaGirada_GotFocus()
    txtCtaGirada.SelStart = 0
    txtCtaGirada.SelLength = Len(txtCtaGirada.Text)
End Sub

Private Sub txtCheque_GotFocus()
    txtCheque.SelStart = 0
    txtCheque.SelLength = Len(txtCheque.Text)
End Sub

Private Sub txtCtaGirada_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

Private Sub txtRemesa_GotFocus()
    txtRemesa.SelStart = 0
    txtRemesa.SelLength = Len(txtRemesa.Text)
End Sub

Private Sub txtRemesa_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

