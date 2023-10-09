VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTipoCanje 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parametrización  por Tipo de canje"
   ClientHeight    =   5700
   ClientLeft      =   -225
   ClientTop       =   1800
   ClientWidth     =   9300
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1072
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6101.408
   ScaleMode       =   0  'User
   ScaleWidth      =   9300
   Tag             =   "672"
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Oficinas por tipo de canje"
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
      Height          =   3420
      Index           =   0
      Left            =   45
      TabIndex        =   1
      Top             =   2235
      Width           =   8190
      Begin MSGrid.Grid grdRegistros 
         Height          =   3150
         Left            =   105
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   240
         Width           =   8055
         _Version        =   65536
         _ExtentX        =   14208
         _ExtentY        =   5556
         _StockProps     =   77
         ForeColor       =   0
         BackColor       =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin VB.Frame Frame4 
      BackColor       =   &H00C0C0C0&
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
      Height          =   2160
      Index           =   0
      Left            =   45
      TabIndex        =   12
      Top             =   -15
      Width           =   8175
      Begin VB.Frame Frame2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Competencia Cormecial"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00004080&
         Height          =   645
         Left            =   135
         TabIndex        =   19
         Top             =   1395
         Width           =   7845
         Begin VB.OptionButton Optcomp 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Bancaria"
            Height          =   195
            Index           =   2
            Left            =   1785
            TabIndex        =   3
            Top             =   315
            Value           =   -1  'True
            Width           =   1170
         End
         Begin VB.OptionButton Optcomp 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Sin competencia"
            Height          =   195
            Index           =   0
            Left            =   3495
            TabIndex        =   21
            Top             =   315
            Width           =   1665
         End
         Begin VB.OptionButton Optcomp 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Con Competencia"
            Height          =   195
            Index           =   1
            Left            =   5730
            TabIndex        =   20
            Top             =   315
            Width           =   1575
         End
      End
      Begin VB.Frame Frame3 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tipo de Canje"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   750
         Left            =   150
         TabIndex        =   16
         Top             =   600
         Width           =   7815
         Begin VB.OptionButton Optcanje 
            BackColor       =   &H00C0C0C0&
            Caption         =   "No CEDEC"
            Height          =   435
            Index           =   3
            Left            =   4530
            TabIndex        =   23
            Top             =   270
            Width           =   1440
         End
         Begin VB.OptionButton Optcanje 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Sin CANJE "
            Height          =   435
            Index           =   4
            Left            =   6135
            TabIndex        =   22
            Top             =   270
            Width           =   1440
         End
         Begin VB.OptionButton Optcanje 
            BackColor       =   &H00C0C0C0&
            Caption         =   "CEDEC"
            Height          =   495
            Index           =   2
            Left            =   3495
            TabIndex        =   18
            Top             =   225
            Width           =   1230
         End
         Begin VB.OptionButton Optcanje 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Canje delegado"
            Height          =   405
            Index           =   1
            Left            =   1800
            TabIndex        =   17
            Top             =   255
            Width           =   1440
         End
         Begin VB.OptionButton Optcanje 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Canje directo"
            Height          =   510
            Index           =   0
            Left            =   165
            TabIndex        =   2
            Top             =   210
            Value           =   -1  'True
            Width           =   1440
         End
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   1815
         MaxLength       =   5
         TabIndex        =   0
         Top             =   255
         Width           =   885
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   2715
         TabIndex        =   14
         Top             =   255
         Width           =   5235
      End
      Begin VB.Label lblEtiquetas 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Codigo de oficina:"
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
         Left            =   180
         TabIndex        =   13
         Top             =   225
         Width           =   1560
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   1
      Left            =   8390
      TabIndex        =   6
      Top             =   1651
      WhatsThisHelpID =   2030
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Ingresar"
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
      Picture         =   "FRMTIPCAN.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   3
      Left            =   8390
      TabIndex        =   9
      Top             =   4039
      WhatsThisHelpID =   2003
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
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
      Picture         =   "FRMTIPCAN.frx":001C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   0
      Left            =   8390
      TabIndex        =   4
      Top             =   57
      WhatsThisHelpID =   2000
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
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
      Picture         =   "FRMTIPCAN.frx":0038
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   2
      Left            =   8385
      TabIndex        =   7
      Top             =   2460
      WhatsThisHelpID =   2006
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
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
      Picture         =   "FRMTIPCAN.frx":0054
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   4
      Left            =   8390
      TabIndex        =   10
      Top             =   4836
      WhatsThisHelpID =   2008
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
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
      Picture         =   "FRMTIPCAN.frx":0070
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   5
      Left            =   8390
      TabIndex        =   5
      Top             =   855
      WhatsThisHelpID =   2001
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*Si&guiente"
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
      Picture         =   "FRMTIPCAN.frx":008C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   6
      Left            =   8390
      TabIndex        =   8
      Tag             =   "8002"
      Top             =   3244
      WhatsThisHelpID =   2031
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Modificar"
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
      Picture         =   "FRMTIPCAN.frx":00A8
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -15
      X2              =   8220
      Y1              =   2328.169
      Y2              =   2328.169
   End
   Begin VB.Label lblEtiquetas 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Codigo de la oficina:"
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
      Left            =   2640
      TabIndex        =   15
      Top             =   3000
      Width           =   1770
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8280
      X2              =   8265
      Y1              =   0
      Y2              =   6053.239
   End
End
Attribute VB_Name = "FTipoCanje"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Integer
Private Sub cmdBoton_Click(Index As Integer)

Select Case Index
 Case 0
    PLBuscar
 Case 1
   PLIngresar
 Case 2
   PLEliminar
 Case 3
   PLLimpiar
 Case 4
   Unload FTipoCanje
 Case 5
   PLSiguientes
 Case 6
   PLModificar
End Select

End Sub

Private Sub Form_Load()
    Dim VLInicio As Integer
    Me.Left = 15
    Me.Top = 15
    Me.Width = 9390
    Me.Height = 6180
    
    VLInicio% = True
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
End Sub



Private Sub Form_Unload(Cancel As Integer)
 FPrincipal!pnlHelpLine.Caption = ""
 FPrincipal!pnlTransaccionLine.Caption = ""

End Sub

Private Sub grdRegistros_Click()

cmdBoton(5).Enabled = False



End Sub

Private Sub grdregistros_DblClick()
 
 grdRegistros.Col = 1
 txtCampo(0).Text = grdRegistros.Text
 grdRegistros.Col = 3
   
 If grdRegistros.Text = "D" Then
       Optcanje(0).Value = True
 End If
 If grdRegistros.Text = "E" Then
       Optcanje(1).Value = True
 End If
 If grdRegistros.Text = "C" Then
       Optcanje(2).Value = True
 End If
 If grdRegistros.Text = "N" Then
       Optcanje(3).Value = True
 End If
 If grdRegistros.Text = "S" Then
       Optcanje(4).Value = True
 End If
 
 
 grdRegistros.Col = 6
 If grdRegistros.Text = "N" Then
    Optcomp(0).Value = True
 ElseIf grdRegistros.Text = "S" Then
     Optcomp(1).Value = True
 Else
     Optcomp(2).Value = True
 End If
 
 
 txtCampo_LostFocus 0
 cmdBoton(1).Enabled = True
 cmdBoton(2).Enabled = True
 cmdBoton(5).Enabled = False
 cmdBoton(6).Enabled = True
   
End Sub




Private Sub txtCampo_GotFocus(Index As Integer)

Select Case Index
 Case 0
  FPrincipal!pnlHelpLine.Caption = "Oficina [F5 Ayuda]"
End Select

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)


If Keycode% <> VGTeclaAyuda% Then
     Exit Sub
End If

Select Case Index

Case 0

VGOperacion$ = "sp_oficina"
VLPaso% = True
PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
   If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina ") Then
      PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
      PMChequea sqlconn&
      FCatalogo.Show 1
      txtCampo(Index%).Text = VGACatalogo.Codigo$
      lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
   Else
      txtCampo(Index%).Text = ""
      txtCampo(Index%).SetFocus
      lblDescripcion(Index%).Caption = ""
   End If

End Select

End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)

  Select Case Index
  
  Case 0
  If (KeyAscii <> 8 And ((KeyAscii < 47) Or (KeyAscii > 57))) Then
     KeyAscii% = 0
  End If
    
  End Select
  

End Sub

Private Sub txtCampo_LostFocus(Index As Integer)

Select Case Index
Case 0
If txtCampo(Index%).Text <> "" Then
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(Index%).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
        VLPaso% = True
        PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
        PMChequea sqlconn&
    Else
        txtCampo(Index%).Text = ""
        txtCampo(Index%).SetFocus
        lblDescripcion(Index%).Caption = ""
    End If
End If

End Select


End Sub



Public Sub PLBuscar()
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "672"
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, "0"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "S"
     PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_oficina_tipo_canje", True, "Consulta tipo de canje") Then
         PMMapeaGrid sqlconn&, grdRegistros, False
         PMChequea sqlconn&
        If Val(grdRegistros.Tag) >= 20 Then
            cmdBoton(5).Enabled = True
            
        Else
            cmdBoton(5).Enabled = False
            
        End If
        
        grdRegistros.ColWidth(1) = 900
        grdRegistros.ColWidth(2) = 1800
        grdRegistros.ColWidth(3) = 1000
        grdRegistros.ColWidth(4) = 1500
        grdRegistros.ColWidth(5) = 1000
        grdRegistros.ColWidth(6) = 1000
     End If
  
  
End Sub

Public Sub PLIngresar()

'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
 If (Trim$(txtCampo(0).Text) = "") Then
   MsgBox "El campo codigo de oficina es mandatorio.", vbCritical
   txtCampo(0).SetFocus
   Exit Sub
 End If
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "672"
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "I"
    
    If Optcanje(0).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "D"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(0).Caption)
    End If
      
    If Optcanje(1).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "E"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(1).Caption)
    End If
    
    If Optcanje(2).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "C"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(2).Caption)
    End If
    
    If Optcanje(3).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "N"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(3).Caption)
    End If
    
    If Optcanje(4).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "S"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(4).Caption)
    End If
    
    If Optcomp(0).Value = True Then
      PMPasoValores sqlconn&, "@i_competencia", 0, SQLCHAR, "N"
    ElseIf Optcomp(1).Value = True Then
      PMPasoValores sqlconn&, "@i_competencia", 0, SQLCHAR, "S"
    Else
      PMPasoValores sqlconn&, "@i_competencia", 0, SQLCHAR, "B"
    End If
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_oficina_tipo_canje", True, "Consulta tipo de canje") Then
        PMChequea sqlconn&
        PLLimpiar
        
    Else
        PMChequea sqlconn&
        txtCampo(0).SetFocus
    End If
    
    PLBuscar
    
 
 End Sub

Public Sub PLEliminar()
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
   If (Trim$(txtCampo(0).Text) = "") Then
      MsgBox "El campo codigo de oficina es mandatorio.", vbCritical
      txtCampo(0).SetFocus
      Exit Sub
   End If
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "672"
   PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtCampo(0).Text)
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "D"
   
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_oficina_tipo_canje", True, "Consulta tipo de canje") Then
        PMChequea sqlconn&
        PLLimpiar
        
   Else
        PMChequea sqlconn&
        txtCampo(0).SetFocus
   End If
   
   PLBuscar


End Sub

Public Sub PLLimpiar()
  Dim i As Integer
  Dim j As Integer
  txtCampo(0).Text = ""
  lblDescripcion(0).Caption = ""
  grdRegistros.Rows = 2
    For i% = 0 To grdRegistros.Cols - 1
        grdRegistros.Col = i%
        For j% = 0 To 1
            grdRegistros.Row = j%
            grdRegistros.Text = ""
        Next j%
    Next i%
    
 cmdBoton(1).Enabled = True
 cmdBoton(2).Enabled = False
 cmdBoton(5).Enabled = False
 cmdBoton(6).Enabled = False
 Optcanje(0).Value = True
 Optcanje(1).Value = False
 Optcanje(2).Value = False
 Optcanje(3).Value = False
 Optcanje(4).Value = False
 
End Sub

Public Sub PLSiguientes()
  Dim VTModo As Integer
  VTModo% = False
     grdRegistros.Row = grdRegistros.Rows - 1
     grdRegistros.Col = grdRegistros.Col - 5
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "672"
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (grdRegistros.Text)
     PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "1"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "S"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_oficina_tipo_canje", True, "Consulta tipo de canje") Then
         PMMapeaGrid sqlconn&, grdRegistros, True
         PMChequea sqlconn&
        If Val(grdRegistros.Tag) >= 20 Then
            cmdBoton(5).Enabled = True
        Else
            cmdBoton(5).Enabled = False
       
        End If
        
    End If


End Sub

Public Sub PLModificar()
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
  If (Trim$(txtCampo(0).Text) = "") Then
      MsgBox "El campo codigo de oficina es mandatorio.", vbCritical
      txtCampo(0).SetFocus
      Exit Sub
   End If
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "672"
   PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtCampo(0).Text)
      
      
   If Optcanje(0).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "D"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(0).Caption)
    End If
      
    If Optcanje(1).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "E"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(1).Caption)
    End If
    
    If Optcanje(2).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "C"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(2).Caption)
    End If
    
    If Optcanje(3).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "N"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(3).Caption)
    End If
    
    If Optcanje(4).Value = True Then
      PMPasoValores sqlconn&, "@i_tipo_canje", 0, SQLVARCHAR, "S"
      PMPasoValores sqlconn&, "@i_descripcion", 0, SQLVARCHAR, (Optcanje(4).Caption)
    End If
       
        
   
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "U"
   
    If Optcomp(0).Value = True Then
      PMPasoValores sqlconn&, "@i_competencia", 0, SQLCHAR, "N"
    ElseIf Optcomp(1).Value = True Then
      PMPasoValores sqlconn&, "@i_competencia", 0, SQLCHAR, "S"
    Else
      PMPasoValores sqlconn&, "@i_competencia", 0, SQLCHAR, "B"
    End If
   
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_oficina_tipo_canje", True, "Consulta tipo de canje") Then
        PMChequea sqlconn&
        PLLimpiar
        
   Else
        PMChequea sqlconn&
        txtCampo(0).SetFocus
   End If
   
   
   PLBuscar


End Sub
 







