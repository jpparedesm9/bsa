VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FClave 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Clave de Supervisor"
   ClientHeight    =   2505
   ClientLeft      =   1530
   ClientTop       =   3390
   ClientWidth     =   6885
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
   ScaleHeight     =   2505
   ScaleWidth      =   6885
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   5985
      TabIndex        =   8
      Top             =   1725
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
      Index           =   1
      Left            =   5985
      TabIndex        =   7
      Top             =   960
      WhatsThisHelpID =   2007
      Width           =   875
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      IMEMode         =   3  'DISABLE
      Index           =   1
      Left            =   2850
      PasswordChar    =   "»"
      TabIndex        =   6
      Top             =   1530
      Width           =   2700
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      IMEMode         =   3  'DISABLE
      Index           =   0
      Left            =   2850
      PasswordChar    =   "»"
      TabIndex        =   4
      Top             =   1230
      Width           =   2700
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Verificación de Clave:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   840
      TabIndex        =   1
      Top             =   1545
      Width           =   1890
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Clave:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   825
      TabIndex        =   5
      Top             =   1230
      Width           =   555
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   960
      TabIndex        =   3
      Top             =   420
      Width           =   4980
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   150
      TabIndex        =   2
      Top             =   420
      Width           =   795
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Funcionario (Supervisor):"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   135
      TabIndex        =   0
      Top             =   165
      Width           =   2145
   End
End
Attribute VB_Name = "FClave"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
'*************************************************************
' ARCHIVO:          FCLAVE.frm
' NOMBRE LOGICO:    FClave
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
' Solicita que el Supervisor ingrese su clave previa a la
' autorización para realizar ciertas transacciones.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Private Sub cmdBoton_Click(Index As Integer)
Dim VTResult As String

Dim VT1 As String
Dim VT2 As Integer
Dim VT3 As String
Dim VTR1 As Integer


 

    Select Case Index%
    Case 0
        Unload FClave
    Case 1
        If lblDescripcion(0).Caption = "" Then
            MsgBox "El código de funcionario es mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
        If txtcampo(0).Text = "" Then
            MsgBox "La clave de supervisor es mandatorio", 0 + 16, "Mensaje de Error"
            txtcampo(0).SetFocus
            Exit Sub
        End If
        If txtcampo(1).Text = "" Then
            MsgBox "La verificación de clave de supervisor es mandatorio", 0 + 16, "Mensaje de Error"
            txtcampo(1).SetFocus
            Exit Sub
        End If
        If txtcampo(0).Text <> txtcampo(1).Text Then
            MsgBox "La verificación de clave diferente a la clave", 0 + 16, "Mensaje de Error"
            txtcampo(1).SetFocus
            Exit Sub
        End If
        VTResult$ = ""
        For i% = 1 To Len(txtcampo(0).Text)
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            VT1$ = Mid(txtcampo(0).Text, i%, 1)
            VT2% = Asc(VT1$) + 3
            VT3$ = Chr$(VT2%)
            VTResult$ = VTResult$ + VT3$
        Next i%
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "417"
         PMPasoValores sqlconn&, "@i_fun", 0, SQLINT2, (lblDescripcion(0).Caption)
         PMPasoValores sqlconn&, "@i_pwd", 0, SQLVARCHAR, VTResult$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_supervisor", True, " Ok... Inserción de clave de supervisor") Then
             PMChequea sqlconn&
        End If
    End Select
End Sub

Private Sub Form_Load()
Dim VTR1 As Integer

    FClave.Width = 7005
    FClave.Top = 2400
    FClave.Left = 1300
    FClave.Height = 2910
    PMLoadResStrings Me
    PMLoadResIcons Me

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "419"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_supervisor", True, " Ok... Consulta de Funcionario") Then
        ReDim VTArreglo(10) As String
         VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
         PMChequea sqlconn&
        lblDescripcion(0).Caption = VTArreglo(1)
        lblDescripcion(1).Caption = VTArreglo(2)
    End If
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = " Causa del bloqueo por valor [F5 Ayuda]"
    txtcampo(Index%).SelStart = 0
    txtcampo(Index%).SelLength = Len(txtcampo(Index%).Text)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Digite su clave de supervisor"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Re-digite su clave de supervisor"
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii% = Asc(LCase$(Chr$(KeyAscii%)))
End Sub


