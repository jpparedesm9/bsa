VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FControl 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   2790
   ClientLeft      =   45
   ClientTop       =   45
   ClientWidth     =   7290
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   2790
   ScaleWidth      =   7290
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin Threed.SSPanel SSPPrincipal 
      Height          =   2535
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7095
      _Version        =   65536
      _ExtentX        =   12515
      _ExtentY        =   4471
      _StockProps     =   15
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderWidth     =   2
      BevelOuter      =   1
      BevelInner      =   2
      Font3D          =   2
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         IMEMode         =   3  'DISABLE
         Index           =   0
         Left            =   1605
         MaxLength       =   14
         PasswordChar    =   "*"
         TabIndex        =   3
         Top             =   1380
         Width           =   2040
      End
      Begin VB.CommandButton cmdSeleccion 
         Appearance      =   0  'Flat
         Caption         =   "&Cancelar"
         Height          =   375
         Index           =   1
         Left            =   4560
         TabIndex        =   2
         Top             =   1935
         Width           =   1215
      End
      Begin VB.CommandButton cmdSeleccion 
         Appearance      =   0  'Flat
         Caption         =   "&OK"
         Default         =   -1  'True
         Height          =   375
         Index           =   0
         Left            =   1080
         TabIndex        =   1
         Top             =   1935
         Width           =   1215
      End
      Begin VB.Label lblCampo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Servidor :"
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
         Left            =   480
         TabIndex        =   10
         Top             =   285
         Width           =   840
      End
      Begin VB.Label lblCampo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Login :"
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
         Left            =   480
         TabIndex        =   9
         Top             =   585
         Width           =   600
      End
      Begin VB.Label lblCampo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Password :"
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
         Left            =   480
         TabIndex        =   8
         Top             =   1425
         Width           =   945
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   0
         Left            =   1605
         TabIndex        =   7
         Top             =   240
         Width           =   2040
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   1
         Left            =   1605
         TabIndex        =   6
         Top             =   540
         Width           =   2040
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   2
         Left            =   1605
         TabIndex        =   5
         Top             =   840
         Width           =   4935
      End
      Begin VB.Label lblCampo 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Usuario :"
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
         Left            =   480
         TabIndex        =   4
         Top             =   885
         Width           =   780
      End
   End
End
Attribute VB_Name = "FControl"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*********************************************************
'   Archivo:        FControl.FRM
'   Producto:       General
'   Dise�ado por:   Fabi�n Espinosa
'   Fecha de Documentaci�n: 07/09/1994
'*********************************************************
'                       IMPORTANTE
' Esta Aplicaci�n es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido as� como cualquier alteraci�n o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
' Forma:    FControl
' Descripcion:  Forma para desbloqueo de terminal
'*********************************************************
'
'                       MODIFICACIONES
'
' FECHA             AUTOR                      RAZON
' 25-06-2001        Alfonso Duque A.        Implemantaci�n NCS
'**************************************************************

' Variables Globales necesarias
' VGFilal$
' VGOficina$
' VGLogin$
' ServerName$
'*********************************************************

' Declaracion de variables Locales
Dim VLUsuario$
Dim VLUsuarioNombre$
'! removed Dim VLNumIntentos%




Private Sub cmdSeleccion_Click(Index As Integer)
Select Case Index
    Case 0
        If ValidaPass Then
            fpantalla.Final
            Unload Me
            Unload fpantalla
        End If
    Case 1
        Me.Hide
End Select
End Sub

Private Sub Form_Load()
'! removed Dim i As Integer

Top = (Screen.Height - Me.Height) / 2
Left = (Screen.Width - Me.Width) / 2
    
    PLObtenerCodUsuario
    
    lblDescripcion(0) = ServerNameLocal$
    lblDescripcion(1) = VGLogin$
    lblDescripcion(2) = VLUsuarioNombre$


End Sub


Private Sub PLObtenerCodUsuario()
'*********************************************************
'Objetivo:  Procedimiento para obtener el codigo del
'           usuario en la secion actual
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'07/09/1994  F.Espinosa          Emisi�n Inicial
'*********************************************************
    Dim VTR%
    
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1577"
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "L"
     PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR&, VGLogin$
    
    ReDim Valores(2) As String
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_funcionario", False, "") Then
         VTR% = FMMapeaArreglo(sqlconn&, Valores())
         PMChequea sqlconn&
        VLUsuario$ = Valores(1)
        VLUsuarioNombre$ = Valores(2)
    End If

End Sub


Public Function ValidaPass() As Boolean
'--------------
'ADU 2001-04-11

'-------------------------------------------------------------------------
'Nuevo esquema de seguridades
'Validaci�n de password mediante el sp_valida_password
'-------------------------------------------------------------------------
Dim VLPasswordCrypt$
Dim VLCrypt$
Dim VLNumC%
If Trim$(txtCampo(0).Text) <> "" Then
        VLPasswordCrypt$ = " "
        VLCrypt$ = txtCampo(0).Text

        VLNumC% = Len(RTrim$(txtCampo(0).Text))
        VLPasswordCrypt$ = Left$(RTrim$(VLCrypt$), VLNumC%)
        
         PMPasoValores sqlconn&, "@i_login", 0, SQLVARCHAR&, (VGLogin$)
         PMPasoValores sqlconn&, "@i_clave", 0, SQLVARCHAR&, (VLPasswordCrypt$)
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
'--------------

End Function



