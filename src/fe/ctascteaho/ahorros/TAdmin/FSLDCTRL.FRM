VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "Msmask32.ocx"
Begin VB.Form FSaldoControl 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "*Saldo de Libreta y Número de Control"
   ClientHeight    =   1620
   ClientLeft      =   1470
   ClientTop       =   2340
   ClientWidth     =   4560
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
   LinkTopic       =   "FClave"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1620
   ScaleWidth      =   4560
   Tag             =   "3110"
   Begin VB.CommandButton cmdBoton 
      Appearance      =   0  'Flat
      Caption         =   "*Cancelar"
      Height          =   435
      Index           =   1
      Left            =   2310
      TabIndex        =   3
      Top             =   1110
      WhatsThisHelpID =   2012
      Width           =   1230
   End
   Begin VB.CommandButton cmdBoton 
      Appearance      =   0  'Flat
      Caption         =   "*Aceptar"
      Height          =   435
      Index           =   0
      Left            =   1035
      TabIndex        =   2
      Top             =   1110
      WhatsThisHelpID =   2011
      Width           =   1230
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   2265
      MaxLength       =   4
      TabIndex        =   1
      Top             =   750
      Width           =   1815
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Left            =   2265
      TabIndex        =   0
      Top             =   390
      Width           =   1815
      _ExtentX        =   3201
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Número de Control:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   480
      TabIndex        =   4
      Top             =   750
      WhatsThisHelpID =   5295
      Width           =   1725
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Saldo de Libreta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   480
      TabIndex        =   5
      Top             =   390
      WhatsThisHelpID =   5294
      Width           =   1545
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*De la última línea impresa en la libreta:"
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   1
      Left            =   105
      TabIndex        =   6
      Top             =   60
      WhatsThisHelpID =   5293
      Width           =   3420
   End
End
Attribute VB_Name = "FSaldoControl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FSLDCTRL.frm
' NOMBRE LOGICO:    FSaldoControl
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
' Permite indicar el saldo de la libreta con el numero
' respectivo de control, de la ultima linea impresa de la
' libreta
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
option explicit
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        If txtCampo.Text = "" Then
            MsgBox "El número de control no puede ser nulo", 0 + 16, "Mensaje de Error"
            If txtCampo.Enabled = True Then txtCampo.SetFocus
            Exit Sub
        End If
        VGSaldoLib$ = mskValor.Text
        VGNControl$ = txtCampo.Text
        Unload FSaldoControl
    Case 1
        VGSaldoLib$ = "0"
        VGNControl$ = "*"
        Unload FSaldoControl
    End Select
End Sub

Private Sub Form_Load()
    FSaldoControl.Top = 2050
    FSaldoControl.Left = 2500
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
End Sub

Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Saldo de Libreta"
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

Private Sub txtCampo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de Control"
    txtCampo.SelStart = 0
    txtCampo.SelLength = Len(txtCampo.Text)
End Sub

Private Sub txtCampo_KeyPress(KeyAscii As Integer)
    'If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
     '   KeyAscii% = 0
    'End If
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtCampo_LostFocus()
    If Val(txtCampo.Text) > 9999 Then
        MsgBox "Número de Control errado", 0 + 16, "Mensaje de Error"
        If txtCampo.Enabled = True Then txtCampo.SetFocus
    End If
End Sub


