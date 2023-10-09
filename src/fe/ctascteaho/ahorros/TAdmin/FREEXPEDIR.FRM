VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FREEXPEDIR 
   Caption         =   "Ingrese Número Nueva Tarjeta…"
   ClientHeight    =   1440
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4905
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   1440
   ScaleWidth      =   4905
   Begin VB.TextBox txtTarjetaDebito 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   2640
      MaxLength       =   19
      TabIndex        =   0
      Top             =   120
      Width           =   2220
   End
   Begin VB.TextBox txtConfirmaTarjDeb 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   2640
      MaxLength       =   19
      TabIndex        =   1
      Top             =   435
      Width           =   2220
   End
   Begin Threed.SSCommand cmdOk 
      Height          =   495
      Left            =   1440
      TabIndex        =   2
      Top             =   840
      WhatsThisHelpID =   30049
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   873
      _StockProps     =   78
      Caption         =   "&OK"
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
   Begin Threed.SSCommand cmdSalir 
      Height          =   495
      Left            =   2640
      TabIndex        =   5
      Top             =   840
      WhatsThisHelpID =   30049
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   873
      _StockProps     =   78
      Caption         =   "&Salir"
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
   Begin VB.Label lblNuevaTarjeta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro. Tarjeta Debito:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   195
      Left            =   120
      TabIndex        =   4
      Top             =   120
      WhatsThisHelpID =   5466
      Width           =   1710
   End
   Begin VB.Label lblConfNuevaTarjeta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Confirm. Nro. Tarjeta Debito:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   3
      Top             =   435
      WhatsThisHelpID =   5467
      Width           =   2460
   End
End
Attribute VB_Name = "FREEXPEDIR"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FREEXPEDIR.frm
' NOMBRE LOGICO:    FREEXPEDIR
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
' Esta forma permite realizar la confirmacion de tarjeta de debito
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 16-Ago-13      I. Berganza        Emisión Inicial
'*************************************************************
Option explicit
Private Sub cmdOK_Click()
If Trim$(txtTarjetaDebito.Text) = "" Then
    MsgBox "Tarjeta Debito vacia. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
    txtTarjetaDebito.Text = ""
    txtTarjetaDebito.SetFocus
Else
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtTarjetaDebito.Text) <> Trim$(txtConfirmaTarjDeb.Text) Then
        MsgBox "Confirmación de Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
        txtConfirmaTarjDeb.Text = ""
        txtConfirmaTarjDeb.SetFocus
    Else
        FREEXPEDIR.Hide
        FRelCtaCanal.TxtNuevaTarjeta.Text = txtTarjetaDebito.Text
        FRelCtaCanal.Show
    End If
End If
End Sub

Private Sub cmdSalir_Click()
   Unload FREEXPEDIR
   Exit Sub
End Sub

Private Sub Form_Load()
    FREEXPEDIR.Left = 0
    FREEXPEDIR.Top = 0
    FREEXPEDIR.Width = 5025
    FREEXPEDIR.Height = 1950
    PMLoadResStrings Me
    PMLoadResIcons Me
    txtTarjetaDebito.Text = ""
    txtConfirmaTarjDeb.Text = ""
End Sub

Private Sub txtConfirmaTarjDeb_GotFocus()
    'No permite hacer pegado de texto
    Clipboard.Clear
    Clipboard.SetText ""
    FPrincipal!pnlHelpLine.Caption = " Confirmar Numero de tarjeta de debito"
End Sub

Private Sub txtConfirmaTarjDeb_KeyDown(Keycode As Integer, Shift As Integer)
    Call BorrarClipboard(Keycode, Shift, 0, False)
End Sub

Private Sub txtConfirmaTarjDeb_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtConfirmaTarjDeb_LostFocus()
If txtConfirmaTarjDeb.Text <> "" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtTarjetaDebito.Text) <> Trim$(txtConfirmaTarjDeb.Text) Then
        MsgBox "Confirmación de Nro. Tarjeta Incorrecta. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
        txtConfirmaTarjDeb.Text = ""
        txtConfirmaTarjDeb.SetFocus
    End If
End If
End Sub

Private Sub txtConfirmaTarjDeb_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call BorrarClipboard(0, 0, Button, True)
End Sub

Private Sub txtTarjetaDebito_GotFocus()
    'No permite hacer pegado de texto
    Clipboard.Clear
    Clipboard.SetText ""
    FPrincipal!pnlHelpLine.Caption = " Numero de tarjeta de debito"
End Sub

Private Sub txtTarjetaDebito_KeyDown(Keycode As Integer, Shift As Integer)
   Call BorrarClipboard(Keycode, Shift, 0, False)
End Sub

Private Sub txtTarjetaDebito_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtTarjetaDebito_LostFocus()
    If txtTarjetaDebito.Text <> "" And txtTarjetaDebito.Text <> "" Then
        If Len(txtTarjetaDebito.Text) < 16 Or Len(txtTarjetaDebito.Text) > 19 Then
            MsgBox "Longitud de Nro. de Tartjeta No Válida. Favor ingrese nuevamente", 0 + 16, "Mensaje de Error"
            txtTarjetaDebito.Text = ""
            txtConfirmaTarjDeb.Text = ""
            txtTarjetaDebito.SetFocus
        End If
    End If
End Sub

Private Sub txtTarjetaDebito_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Call BorrarClipboard(0, 0, Button, True)
End Sub

'FIXIT: Declare 'BorrarClipboard' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
sub BorrarClipboard(CodTecla As Integer, CtrlAltShift As Integer, BotonMouse As Integer, ClickMouse As Boolean)
    If ClickMouse = False Then
        If CodTecla = vbKeyInsert And CtrlAltShift = 1 Then
            Clipboard.Clear
            ElseIf CodTecla = vbKeyV And CtrlAltShift = 2 Then
            Clipboard.Clear
        End If
        Else
        If BotonMouse = 2 Then Clipboard.Clear
    End If
End sub

