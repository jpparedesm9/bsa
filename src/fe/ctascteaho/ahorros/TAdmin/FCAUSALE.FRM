VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FCausaLev 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Levantamiento de Bloqueo de Valores"
   ClientHeight    =   3720
   ClientLeft      =   240
   ClientTop       =   2220
   ClientWidth     =   8925
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
   ScaleHeight     =   3720
   ScaleWidth      =   8925
   Tag             =   "3074"
   Begin Threed.SSFrame Frame3D1 
      Height          =   2820
      Left            =   15
      TabIndex        =   4
      Top             =   45
      WhatsThisHelpID =   5144
      Width           =   8880
      _Version        =   65536
      _ExtentX        =   15664
      _ExtentY        =   4974
      _StockProps     =   14
      Caption         =   "*Ingrese la causa y el solicitante del Levantamiento de Bloqueo de Valores "
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
         Index           =   1
         Left            =   2070
         TabIndex        =   1
         Top             =   1665
         Width           =   6255
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2070
         TabIndex        =   0
         Top             =   1365
         Width           =   780
      End
      Begin VB.Label lblProducto 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   270
         Left            =   7920
         TabIndex        =   5
         Top             =   870
         Visible         =   0   'False
         Width           =   405
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Causa:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   555
         TabIndex        =   6
         Top             =   1365
         Width           =   600
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2865
         TabIndex        =   7
         Top             =   1365
         Width           =   5460
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Solicitado por:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   555
         TabIndex        =   8
         Top             =   1665
         Width           =   1245
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8010
      TabIndex        =   3
      Top             =   2940
      WhatsThisHelpID =   2023
      Width           =   875
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   7125
      TabIndex        =   2
      Top             =   2940
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      Visible         =   0   'False
      X1              =   0
      X2              =   9000
      Y1              =   2905
      Y2              =   2905
   End
End
Attribute VB_Name = "FCausaLev"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
'*************************************************************
' ARCHIVO:          FCAUSALE.frm
' NOMBRE LOGICO:    FCausaLev
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
' Ingresa la causa y el solicitante previos al Levantamiento
' de Bloqueos de Valores.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLPaso As Integer

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%  'lgra
    Case 0
        If txtCampo(0).Text = "" Then
            MsgBox "La Causa del Levantamiento no puede ser nula", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El solicitante del bloqueo es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        VGNControl$ = txtCampo(0).Text
        VGNSolicit$ = txtCampo(1).Text
        VGNCausa$ = lblDescripcion  'ARiggs 09-14-06
        Unload FCausaLev
    Case 1
        VGNControl$ = "*"
        VGNSolicit$ = "*"
        Unload FCausaLev
    End Select
End Sub

Private Sub Form_Load()
    FCausaLev.Top = 1600
    FCausaLev.Left = 275
    txtCampo(1).MaxLength = 45
    PMLoadResStrings Me
    PMLoadResIcons Me

End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Causa del Levantamiento"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Nombre del Solicitante"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Dim VTTabla As String
    
    If Keycode = VGTeclaAyuda And Index = 0 Then
        If lblProducto.Caption = "CTE" Then
            VTTabla = "cc_caulev_blqva"
        Else
            VTTabla = "ah_caulev_blqva"
        End If
        VLPaso% = True
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VTTabla$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(0).Text & "]") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
             PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(0).Text = VGACatalogo.Codigo$
            lblDescripcion.Caption = VGACatalogo.Descripcion$
''            If txtCampo(0).Text = "4" Then
''                txtCampo(0).Text = ""
''                lblDescripcion.Caption = ""
''                MsgBox "Causa no válida"
''                'txtCampo(0).SetFocus
''                SendKeys "{TAB}"
''                SendKeys "{TAB}"
''                SendKeys "{TAB}"
''            End If
            txtCampo(1).SetFocus
        End If
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 1
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTTabla As String

    If VLPaso = False And Index = 0 Then
        If txtCampo(0).Text <> "" Then
            If lblProducto.Caption = "CTE" Then
                VTTabla = "cc_caulev_blqva"
            Else
                VTTabla = "ah_caulev_blqva"
            End If
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VTTabla
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
'            If txtCampo(0).Text = "4" Then
'                VLPaso% = True
'                txtCampo(0).Text = ""
'                lblDescripcion.Caption = ""
'                MsgBox "Causa no válida"
'                txtCampo(0).SetFocus
'            Else
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(0).Text)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la filial " & "[" & txtCampo(0).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(0).Text = ""
                    lblDescripcion.Caption = ""
                    txtCampo(0).SetFocus
                End If
'            End If
        Else
            lblDescripcion.Caption = ""
        End If
    End If
End Sub


