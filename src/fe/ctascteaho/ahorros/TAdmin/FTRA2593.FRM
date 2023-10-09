VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2593 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Bancos"
   ClientHeight    =   5385
   ClientLeft      =   45
   ClientTop       =   1815
   ClientWidth     =   9315
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
   HelpContextID   =   1019
   Icon            =   "FTRA2593.frx":0000
   LinkTopic       =   "Form14"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5385
   ScaleWidth      =   9315
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1800
      MaxLength       =   12
      TabIndex        =   4
      Top             =   960
      Width           =   3015
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1800
      MaxLength       =   1
      TabIndex        =   3
      Top             =   645
      Width           =   540
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   0
      Top             =   45
      Width           =   555
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   12
      Top             =   4605
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2593.frx":030A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8415
      TabIndex        =   5
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
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
      Picture         =   "FTRA2593.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8415
      TabIndex        =   7
      Top             =   780
      WhatsThisHelpID =   2001
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
      Picture         =   "FTRA2593.frx":0342
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   10
      Tag             =   "2516"
      Top             =   3075
      WhatsThisHelpID =   2006
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Eliminar"
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
      Picture         =   "FTRA2593.frx":035E
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   8
      Tag             =   "2548"
      Top             =   1545
      WhatsThisHelpID =   2030
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Crear"
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
      Picture         =   "FTRA2593.frx":037A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   9
      Tag             =   "2549"
      Top             =   2310
      WhatsThisHelpID =   2031
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Actualizar"
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
      Picture         =   "FTRA2593.frx":0396
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3735
      Left            =   15
      TabIndex        =   13
      Top             =   1590
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   6588
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
      Cols            =   4
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   390
      Left            =   4710
      TabIndex        =   15
      Top             =   -60
      Width           =   3585
      Begin Threed.SSOption optVigente 
         Height          =   195
         Index           =   1
         Left            =   1980
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   150
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "Cancelado"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   29.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optVigente 
         Height          =   195
         Index           =   0
         Left            =   480
         TabIndex        =   1
         Top             =   150
         Width           =   1110
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "Vigente"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   29.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1800
      MaxLength       =   64
      TabIndex        =   2
      Top             =   345
      Width           =   6510
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   11
      Top             =   3840
      WhatsThisHelpID =   2003
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
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
      Picture         =   "FTRA2593.frx":03B2
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nit del Banco:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   120
      TabIndex        =   21
      Top             =   960
      Width           =   1230
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Código de Filial:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   90
      TabIndex        =   20
      Top             =   660
      Width           =   1380
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Bancos Existentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   90
      TabIndex        =   16
      Top             =   1400
      Width           =   1635
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8370
      X2              =   0
      Y1              =   1380
      Y2              =   1380
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   3840
      TabIndex        =   19
      Top             =   60
      Width           =   660
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2340
      TabIndex        =   14
      Top             =   645
      Width           =   5955
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre del Banco:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   18
      Top             =   360
      Width           =   1635
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Código de Banco:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   17
      Top             =   60
      Width           =   1530
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
End
Attribute VB_Name = "FTran2593"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
option explicit
Dim VLPaso As Integer

Private Sub cmdBoton_Click(Index As Integer)

  Select Case Index%
    Case 0  'Salir
         Unload FTran2593
    Case 1  'Limpiar
       PLLimpiar
       PMLimpiaGrid grdRegistros
    Case 2  'Eliminar
       PLEliminar
    Case 3  ' Crear
       PLCrear
    Case 4  ' Actualizar
       PLActualizar
    Case 5  'Siguientes
       PLSiguientes
    Case 6  'Buscar
       PLBuscar
  End Select

End Sub

Private Sub Form_Load()

    FTran2593.Left = 15
    FTran2593.Top = 15
    FTran2593.Width = 9420
    FTran2593.Height = 5865
    PMBotonSeguridad FTran2593, 4   'Seguridades
    cmdBoton(4).Enabled = False
    cmdBoton(5).Enabled = False
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRegistros_Click()
    grdRegistros.Col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
       grdRegistros.SelStartRow = 1
       grdRegistros.SelEndRow = 1
    Else
       grdRegistros.SelStartRow = grdRegistros.Row
       grdRegistros.SelEndRow = grdRegistros.Row
    End If
End Sub

Private Sub grdregistros_DblClick()
    If grdRegistros.Rows <= 2 Then
       grdRegistros.Row = 1
       grdRegistros.Col = 1
       If Trim$(grdRegistros.Text) = "" Then
          MsgBox "No existen Bancos", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If

    grdRegistros.Col = 1
    txtCampo(1).Text = grdRegistros.Text
    txtCampo(1).Enabled = False

    grdRegistros.Col = 2
    txtCampo(0).Text = grdRegistros.Text
  
    grdRegistros.Col = 3
    txtCampo(2).Text = grdRegistros.Text
    txtCampo(2).Enabled = False

    grdRegistros.Col = 4
    lblDescripcion.Caption = grdRegistros.Text

    grdRegistros.Col = 5
    If grdRegistros.Text = "V" Then
       optVigente(0).Value = True
    Else
       optVigente(1).Value = True
    End If

    grdRegistros.Col = 6
    txtCampo(3).Text = grdRegistros.Text

    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = True
    cmdBoton(2).Enabled = True
End Sub

Private Sub PLActualizar()

   'Valida Código de Banco
   If txtCampo(1).Text = "" Then
      MsgBox "Código de Banco es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(1).SetFocus
      Exit Sub
   End If
   
   'Valida Nombre del Banco
   If txtCampo(0).Text = "" Then
      MsgBox "Descripción de Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
   End If

   'Valida Filial
   If txtCampo(2).Text = "" Then
      MsgBox "Filial del Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(2).SetFocus
      Exit Sub
   End If

   'Valida Nit
   If txtCampo(3).Text = "" Then
      MsgBox "Nit del Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(3).SetFocus
      Exit Sub
   End If

   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2594"
   PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (txtCampo(1).Text)
   PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, (txtCampo(0).Text)
   PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, (txtCampo(2).Text)
   PMPasoValores sqlconn&, "@i_nit", 0, SQLVARCHAR, (txtCampo(3).Text)
   If optVigente(0).Value = True Then
      PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "V"
   Else
      PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "C"
   End If
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_banco", True, "Ok... Consulta de Tipos de Bancos") Then
      PMChequea sqlconn&
      PLBuscar  'Refresca Datos
      cmdBoton(4).Enabled = False
   End If
   PLLimpiar

End Sub

Private Sub PLBuscar()

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2595"
    PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, "-1"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_banco", True, "Ok... Consulta de tipos de bancos") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
       If grdRegistros.Rows <= 2 Then
         grdRegistros.Col = 1
         grdRegistros.Row = 1
         If grdRegistros.Text = "" Then
            PLLimpiar
            Exit Sub
         End If
       End If
       
      Call PintaGrid
       
      If txtCampo(1).Enabled = False Then
         txtCampo(1).Enabled = True
      End If
      txtCampo(1).SetFocus
      If Val(grdRegistros.Tag) >= 20 Then
         cmdBoton(5).Enabled = True
      Else
         cmdBoton(5).Enabled = False
      End If
   End If

End Sub
Private Sub PintaGrid()
    grdRegistros.ColAlignment(1) = 2
    grdRegistros.ColWidth(1) = 600      ' Banco
    grdRegistros.ColWidth(2) = 3100     ' Nombre del Banco
    grdRegistros.ColAlignment(3) = 2
    grdRegistros.ColWidth(3) = 500      ' Filial
    grdRegistros.ColWidth(4) = 1400     ' Nombre de Filia
    grdRegistros.ColAlignment(5) = 2
    grdRegistros.ColWidth(5) = 700      ' Estado
    grdRegistros.ColWidth(6) = 1100     ' Nit Banco
End Sub
Private Sub PLCrear()

   'Valida Código de Banco
   If txtCampo(1).Text = "" Then
      MsgBox "Código de Banco es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(1).SetFocus
      Exit Sub
   End If
   
   'Valida Nombre del Banco
   If txtCampo(0).Text = "" Then
      MsgBox "Descripción de Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
   End If

   'Valida Filial
   If txtCampo(2).Text = "" Then
      MsgBox "Filial del Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(2).SetFocus
      Exit Sub
   End If
         
   'Valida Nit
   If txtCampo(3).Text = "" Then
      MsgBox "Nit del Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(3).SetFocus
      Exit Sub
   End If
         
         
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2593"
   PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (txtCampo(1).Text)
   PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, (txtCampo(0).Text)
   PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, (txtCampo(2).Text)
   PMPasoValores sqlconn&, "@i_nit", 0, SQLVARCHAR, (txtCampo(3).Text)
   If optVigente(0).Value = True Then
      PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "V"
   Else
      PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, "C"
   End If
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_banco", True, "Ok... Consulta de Tipos de Bancos") Then
      PMChequea sqlconn&
      PLBuscar  'Refresca Datos
   End If
   PLLimpiar

End Sub

Private Sub PLEliminar()

   'Valida Código de Banco
   If txtCampo(1).Text = "" Then
      MsgBox "Código de Banco es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(1).SetFocus
      Exit Sub
   End If
   
   'Valida Nombre del Banco
   If txtCampo(0).Text = "" Then
      MsgBox "Descripción de Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
   End If

   'Valida Filial
   If txtCampo(2).Text = "" Then
      MsgBox "Filial del Banco es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(2).SetFocus
      Exit Sub
   End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2596"
    PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, (txtCampo(2).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_banco", True, "Ok... Consulta de Tipos de Bancos") Then
       PMChequea sqlconn&
      PLBuscar  'Refresca Datos
      cmdBoton(3).Enabled = True
      cmdBoton(2).Enabled = False
      cmdBoton(4).Enabled = False
   End If
   PLLimpiar

End Sub

Private Sub PLLimpiar()

   txtCampo(0).Text = ""
   txtCampo(1).Text = ""
   txtCampo(2).Text = ""
   txtCampo(3).Text = ""
   lblDescripcion.Caption = ""
   If txtCampo(1).Enabled = False Then
      txtCampo(1).Enabled = True
   End If
   txtCampo(1).SetFocus
   If txtCampo(2).Enabled = False Then
      txtCampo(2).Enabled = True
   End If
 
   cmdBoton(3).Enabled = True
   cmdBoton(2).Enabled = False
   cmdBoton(4).Enabled = False
   cmdBoton(5).Enabled = False

End Sub

Private Sub PLSiguientes()

    grdRegistros.Col = 1
    grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2595"
    PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (grdRegistros.Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_banco", True, "Ok... Consulta de tipos de bancos") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&
       Call PintaGrid
       If Val(grdRegistros.Tag) >= 20 Then
          cmdBoton(5).Enabled = True
       Else
          cmdBoton(5).Enabled = False
       End If
   End If

End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 2
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Nombre del Banco"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código del Banco"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Filial del Banco [F5 Ayuda]"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Nit del Banco "
    End Select

    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
        Select Case Index%
        Case 2
            PMCatalogo "A", "cl_filial", txtCampo(Index%), lblDescripcion
            VLPaso% = True
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        If (KeyAscii > 47 And KeyAscii < 58) Or _
           (KeyAscii > 64 And KeyAscii < 91) Or _
           (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
           
           KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
        Else
           KeyAscii = 0
        End If
    Case 1, 2, 3
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 2
        ' Nivel de Banco
        If VLPaso% = False Then
            If txtCampo(Index%).Text <> "" Then
                ' Validacion del Tipo de dato
               PMCatalogo "V", "cl_filial", txtCampo(Index%), lblDescripcion
               VLPaso% = True
            Else
                lblDescripcion.Caption = ""
            End If
        End If
        Case 3
            'Nit del banco
            If txtCampo(3).Text <> "" Then
                If FMValidaNit(txtCampo(3).Text) = False Then
                    MsgBox "Digito de chequeo del Nit es Incorrecto", 0 + 16, "Mensaje de Error"
                    txtCampo(3).SetFocus
                End If
            End If
    End Select
End Sub


