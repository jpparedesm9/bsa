VERSION 5.00
Begin VB.Form FSupervisor 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Terminal Administrativa - Autorización Supervisor"
   ClientHeight    =   1470
   ClientLeft      =   2520
   ClientTop       =   2775
   ClientWidth     =   4695
   ControlBox      =   0   'False
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
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   1470
   ScaleWidth      =   4695
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Tag             =   "3268"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      IMEMode         =   3  'DISABLE
      Index           =   1
      Left            =   1320
      PasswordChar    =   "*"
      TabIndex        =   1
      Top             =   700
      Width           =   1935
   End
   Begin VB.OptionButton optSupervisor 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "True"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   330
      TabIndex        =   6
      Top             =   30
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.CommandButton cmdBoton 
      Appearance      =   0  'Flat
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Index           =   1
      Left            =   3390
      TabIndex        =   5
      Top             =   630
      WhatsThisHelpID =   1302
      Width           =   1215
   End
   Begin VB.CommandButton cmdBoton 
      Appearance      =   0  'Flat
      Caption         =   "&Aceptar"
      Default         =   -1  'True
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   315
      Index           =   0
      Left            =   3390
      TabIndex        =   4
      Tag             =   "1404"
      Top             =   240
      WhatsThisHelpID =   1310
      Width           =   1215
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1320
      TabIndex        =   0
      Top             =   300
      Width           =   1935
   End
   Begin VB.Label lblautorizasup 
      Caption         =   "N"
      Height          =   255
      Left            =   3060
      TabIndex        =   8
      Top             =   30
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.Label lblTimer 
      Alignment       =   2  'Center
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   526
      TabIndex        =   7
      Top             =   1050
      Visible         =   0   'False
      Width           =   2685
   End
   Begin VB.Label lblDescripcionç 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Password:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   330
      TabIndex        =   3
      Top             =   720
      WhatsThisHelpID =   1907
      Width           =   750
   End
   Begin VB.Label lblDescripcionç 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Login:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   0
      Left            =   330
      TabIndex        =   2
      Top             =   330
      WhatsThisHelpID =   1906
      Width           =   435
   End
End
Attribute VB_Name = "FSupervisor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'VLNumAutorizacion es el numero de autorización por el que se espera respuesta
Dim VLNumAutorizacion As Integer
'Deshabilita la salida de la forma mediante la tecla ESCAPE
Dim VTFlagESc As Boolean
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
        Case 0 'ACEPTAR
            If Trim$(txtCampo(0).Text) = "" Then
                MsgBox "Por favor, Ingrese el campo Login", 48, "Control de Ingreso de Datos"
                txtCampo(0).SetFocus
                Exit Sub
            End If
            If FLTransmitir("S") Then  'S indica si a autorizacion local
               optSupervisor.Value = True
               lblautorizasup.Caption = "S"
             Else
                optSupervisor.Value = False
                lblautorizasup.Caption = "N"
            End If
            
         Case 1 'CANCELAR
            optSupervisor.Value = False
            lblautorizasup.Caption = "N"
            Unload Me
    End Select
End Sub

'PROPOSITO:
'Ejecutar el stored procedure sp_supervisor

'FIXIT: Declare 'parLocal' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Private Function FLTransmitir(parLocal as string) As Integer
Dim VTRespuesta As String
Dim VTMsg As String
Dim VTNumAut As String
Dim VTEncripta As String
Dim VTLogin As String
   
VTEncripta$ = "S"
        
      If parLocal = "S" Then  'llenamos parametros de solicitud de autorización local
       
       'Implementacion Control de Login Password
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        VTLogin$ = Trim$(txtCampo(0).Text)
        
        If Not ValidaPass Then
            FLTransmitir% = False
            Exit Function
        End If
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "13005"
        PMPasoValores sqlconn&, "@i_local", 0, SQLCHAR&, "S"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_supervisor", 0, SQLVARCHAR&, Trim$(txtCampo(0).Text)
      End If
        
    'MVE: Transmitiendo solicitud de supervisor
    If FMTransmitirRPC(sqlconn&, ServerNameLocal$, "cobis", "sp_supervisor", True, VTMsg$) Then
        VLNumAutorizacion = -1
        PMMapeaVariable sqlconn&, VTRespuesta$
        PMChequea sqlconn&
        
        VTNumAut = FMRetParam$(sqlconn&, 1)
        If IsNumeric(VTNumAut) Then
            VLNumAutorizacion% = CInt(VTNumAut$)
        End If
    
        'Procesando respuesta
        If parLocal = "S" Then  'Respuesta a solicitud local
            If VTRespuesta$ = "0" Then
                FLTransmitir% = True
                'ojoVGClassInst.Generales.VGSupervisor = Trim(FSupervisor.txtCampo(0).Text)
            Else
                MsgBox "Clave de Supervisor incorrecta"   ' clave de sup erronea
                FLTransmitir% = False
            End If
            Unload Me
        End If
     Else
         FLTransmitir% = False
         Unload Me
     End If
     PMChequea sqlconn&
     
End Function
Private Sub Form_KeyDown(Keycode As Integer, Shift As Integer)
    Select Case Keycode%
        Case vbKeyEscape
            If Not VTFlagESc Then
                Unload Me
            End If
    End Select
End Sub

Private Sub Form_Load()
      VTFlagESc = False
      lblautorizasup.Caption = "N"
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Public Function ValidaPass() As Boolean
Dim VlPasswordCrypt As String
Dim VlCrypt As String
Dim VlNumC As Integer
If Trim(txtCampo(0).Text) <> "" Then
        VlPasswordCrypt$ = " "
        VlCrypt$ = txtCampo(1).Text

        VlNumC% = Len(RTrim$(txtCampo(1).Text))
        VlPasswordCrypt$ = Left$(RTrim$(VlCrypt$), VlNumC%)
        
         PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR&, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_clave", 0, SQLVARCHAR&, (VlPasswordCrypt$)
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "15222"
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_valida_password", True, "OK") Then
             PMChequea sqlconn&
             ValidaPass = True
         Else
             txtCampo(0).SetFocus
             ValidaPass = False
         End If
Else
    ValidaPass = False
End If

End Function


