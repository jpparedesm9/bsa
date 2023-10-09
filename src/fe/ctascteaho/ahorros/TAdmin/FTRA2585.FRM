VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2585 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Ruta y Tránsito"
   ClientHeight    =   5355
   ClientLeft      =   1110
   ClientTop       =   1830
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
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form14"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5355
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   8
      Left            =   7305
      MaxLength       =   3
      TabIndex        =   8
      Top             =   735
      Width           =   990
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   7
      Left            =   7305
      MaxLength       =   3
      TabIndex        =   7
      Top             =   435
      Width           =   990
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   6
      Left            =   3150
      MaxLength       =   6
      TabIndex        =   6
      Top             =   690
      Width           =   550
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   2580
      MaxLength       =   4
      TabIndex        =   5
      Top             =   690
      Width           =   550
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   2010
      MaxLength       =   4
      TabIndex        =   4
      Top             =   690
      Width           =   550
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   3150
      MaxLength       =   6
      TabIndex        =   3
      Top             =   390
      Width           =   550
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2580
      MaxLength       =   4
      TabIndex        =   2
      Top             =   390
      Width           =   550
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2010
      MaxLength       =   4
      TabIndex        =   1
      Top             =   390
      Width           =   550
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   0
      Left            =   8415
      TabIndex        =   15
      Top             =   4530
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
      Height          =   740
      Index           =   6
      Left            =   8415
      TabIndex        =   9
      Top             =   25
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   5
      Left            =   8415
      TabIndex        =   10
      Top             =   780
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
      Height          =   740
      Index           =   2
      Left            =   8415
      TabIndex        =   13
      Tag             =   "2516"
      Top             =   3030
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   3
      Left            =   8415
      TabIndex        =   11
      Tag             =   "2548"
      Top             =   1530
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   4
      Left            =   8415
      TabIndex        =   12
      Tag             =   "2549"
      Top             =   2280
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3930
      Left            =   0
      TabIndex        =   16
      Top             =   1410
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   6933
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Cols            =   4
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2010
      MaxLength       =   4
      TabIndex        =   0
      Top             =   90
      Width           =   1020
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   1
      Left            =   8415
      TabIndex        =   14
      Top             =   3780
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Código contable:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   4560
      TabIndex        =   23
      Top             =   795
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   3045
      TabIndex        =   22
      Top             =   90
      Width           =   5250
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Número de días de Retención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   4560
      TabIndex        =   21
      Top             =   495
      Width           =   2625
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Banco Corresponsal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   60
      TabIndex        =   20
      Top             =   750
      Width           =   1770
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Ruta y Tránsito Existentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   60
      TabIndex        =   17
      Top             =   1170
      Width           =   2310
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8350
      X2              =   -30
      Y1              =   1110
      Y2              =   1110
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Banco Remesa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   19
      Top             =   450
      Width           =   1350
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Ciudad de Origen:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   18
      Top             =   150
      Width           =   1545
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
Attribute VB_Name = "FTran2585"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Integer
Dim VLCiudad As String
Dim VLCodigo As String
Dim i As Integer

Private Sub cmdBoton_Click(Index As Integer)

  Select Case Index%
    Case 0 'Salir
       Unload FTran2585
    Case 1 'Limpiar
       PLLimpiar
    Case 2 'Eliminar
       PLEliminar
    Case 3 ' Ingresar
       PLCrear
    Case 4 ' Actualizar
       PLActualizar
    Case 5 'Siguientes
       PLSiguientes
    Case 6 'Buscar
       PLBuscar
  End Select

End Sub

Private Sub Form_Load()

    FTran2585.Left = 15
    FTran2585.Top = 15
    FTran2585.Width = 9420
    FTran2585.Height = 5800
    PMLoadResStrings Me
    PMLoadResIcons Me
    PMBotonSeguridad FTran2585, 4 'Seguridad
    cmdBoton(4).Enabled = False
    cmdBoton(5).Enabled = False
    
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
          MsgBox "No existe Ruta y Tránsito", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If

    grdRegistros.Col = 1    'Banco Propietario
    txtCampo(1).Text = Format$(grdRegistros.Text, "0000")
    grdRegistros.Col = 3    'Oficina Propietario
    txtCampo(2).Text = Format$(grdRegistros.Text, "0000")
    grdRegistros.Col = 4    'Ciudad Propietario
    txtCampo(3).Text = Format$(grdRegistros.Text, "0000")
    
    grdRegistros.Col = 5    'Banco Corresponsal
    txtCampo(4).Text = Format$(grdRegistros.Text, "0000")
    grdRegistros.Col = 7    'Oficina Corresponsal
    txtCampo(5).Text = Format$(grdRegistros.Text, "0000")
    grdRegistros.Col = 8    'Ciudad Corresponsal
    txtCampo(6).Text = Format$(grdRegistros.Text, "0000")
    grdRegistros.Col = 9    'Días de Retención
    txtCampo(7).Text = grdRegistros.Text
    grdRegistros.Col = 10   'Causa contable
    txtCampo(8).Text = grdRegistros.Text

    VLCiudad$ = txtCampo(0).Text

    txtCampo(1).Enabled = False
    txtCampo(2).Enabled = False
    txtCampo(3).Enabled = False
    txtCampo(4).Enabled = False
    txtCampo(5).Enabled = False
    txtCampo(6).Enabled = False

    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = True
    cmdBoton(2).Enabled = True

End Sub

Private Sub PLActualizar()

   ' Valida Código de Localidad
   If txtCampo(0).Text = "" Then
      MsgBox "Código de la Ciudad Origen es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
   End If

   ' Valida Códigos de bancos Propietario y Corresponsal
   If txtCampo(1).Text = "" Then
      MsgBox "Código de Banco Remesa [BANCO] es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(1).SetFocus
      Exit Sub
     ElseIf txtCampo(2).Text = "" Then
         txtCampo(2).Text = "0"
       ' MsgBox "Código de Banco Remesa [OFICINA] es mandatorio", 0 + 16, "Mensaje de Error"
       ' txtCampo(2).SetFocus
       ' Exit Sub
       ElseIf txtCampo(3).Text = "" Then
          txtCampo(2).Text = "0"
          'MsgBox "Código de Banco Remesa [PARROQUIA] es mandatorio", 0 + 16, "Mensaje de Error"
          'txtCampo(3).SetFocus
          'Exit Sub
         ElseIf txtCampo(4).Text = "" Then
            MsgBox "Código de Banco Corresponsal [BANCO] es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
           ElseIf txtCampo(5).Text = "" Then
              MsgBox "Código de Banco Corresponsal [OFICINA] es mandatorio", 0 + 16, "Mensaje de Error"
              txtCampo(5).SetFocus
              Exit Sub
             ElseIf txtCampo(6).Text = "" Then
                MsgBox "Código de Banco Corresponsal [PARROQUIA] es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(6).SetFocus
                Exit Sub
   End If

   ' Valida Número de días de Retención
   If txtCampo(7).Text = "" Then
      MsgBox "Número de Días de Retención es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(7).SetFocus
      Exit Sub
   End If
   
    'Valida causa contable
    If txtCampo(8).Text = "" Then
        MsgBox "La causa contable es mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(8).SetFocus
        Exit Sub
    End If


    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2586"
    PMPasoValores sqlconn&, "@i_localidad_a", 0, SQLINT4, VLCiudad$
    PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT4, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_banco_p", 0, SQLINT2, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_oficina_p", 0, SQLINT2, (txtCampo(2).Text)
    PMPasoValores sqlconn&, "@i_ciudad_p", 0, SQLINT4, (txtCampo(3).Text)
    PMPasoValores sqlconn&, "@i_banco_c", 0, SQLINT2, (txtCampo(4).Text)
    PMPasoValores sqlconn&, "@i_oficina_c", 0, SQLINT2, (txtCampo(5).Text)
    PMPasoValores sqlconn&, "@i_ciudad_c", 0, SQLINT4, (txtCampo(6).Text)
    PMPasoValores sqlconn&, "@i_num_dias", 0, SQLINT1, (txtCampo(7).Text)
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    PMPasoValores sqlconn&, "@i_causacont", 0, SQLVARCHAR, (txtCampo(8).Text)

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Actualización de Ruta y Tránsito") Then
       PMChequea sqlconn&
      PLBuscar 'Refresca Datos
      PLLimpiar
     Else
        PLLimpiar
   End If

End Sub

Private Sub PLBuscar()
   
   ' Valida Código de Localidad
   If txtCampo(0).Text = "" Then
      MsgBox "Código de la Ciudad Origen es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
   End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2587"
    PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "C"
    PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT4, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Consulta de Ruta y Tránsito") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
      If Val(grdRegistros.Rows - 1) >= 20 Then
         cmdBoton(5).Enabled = True
        Else
          cmdBoton(5).Enabled = False
      End If
      If grdRegistros.Rows <= 2 Then
         grdRegistros.Col = 1
         grdRegistros.Row = 1
         If grdRegistros.Text = "" Then
            PLLimpiar
            Exit Sub
         End If
      End If
      If cmdBoton(3).Enabled = True Then
         cmdBoton(3).SetFocus
      End If
      If txtCampo(1).Enabled = False Then
         txtCampo(1).Enabled = True
      End If
      txtCampo(1).SetFocus
    Else
       PLLimpiar
   End If

End Sub

Private Sub PLCrear()

   ' Valida Código de Localidad
   If txtCampo(0).Text = "" Then
      MsgBox "Código de la Ciudad Origen es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
   End If

   ' Valida Códigos de bancos Propietario y Corresponsal
   If txtCampo(1).Text = "" Then
      MsgBox "Código de Banco Remesa [BANCO] es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(1).SetFocus
      Exit Sub
     ElseIf txtCampo(2).Text = "" Then
        txtCampo(2).Text = "0"
        'MsgBox "Código de Banco Remesa [OFICINA] es mandatorio", 0 + 16, "Mensaje de Error"
        'txtCampo(2).SetFocus
        'Exit Sub
       ElseIf txtCampo(3).Text = "" Then
          txtCampo(3).Text = "0"
          'MsgBox "Código de Banco Remesa [PARROQUIA] es mandatorio", 0 + 16, "Mensaje de Error"
          'txtCampo(3).SetFocus
          'Exit Sub
         ElseIf txtCampo(4).Text = "" Then
            MsgBox "Código de Banco Corresponsal [BANCO] es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
           ElseIf txtCampo(5).Text = "" Then
              MsgBox "Código de Banco Corresponsal [OFICINA] es mandatorio", 0 + 16, "Mensaje de Error"
              txtCampo(5).SetFocus
              Exit Sub
             ElseIf txtCampo(6).Text = "" Then
                MsgBox "Código de Banco Corresponsal [PARROQUIA] es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(6).SetFocus
                Exit Sub
   End If

   ' Valida Número de días de Retención
   If txtCampo(7).Text = "" Then
      MsgBox "Número de Días de Retención es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(7).SetFocus
      Exit Sub
    End If

    'Valida causa contable
    If txtCampo(8).Text = "" Then
        MsgBox "La causa contable es mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(8).SetFocus
        Exit Sub
    End If

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2585"
     PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT4, (txtCampo(0).Text)
     PMPasoValores sqlconn&, "@i_banco_p", 0, SQLINT2, (txtCampo(1).Text)
     PMPasoValores sqlconn&, "@i_oficina_p", 0, SQLINT2, (txtCampo(2).Text)
     PMPasoValores sqlconn&, "@i_ciudad_p", 0, SQLINT4, (txtCampo(3).Text)
     PMPasoValores sqlconn&, "@i_banco_c", 0, SQLINT2, (txtCampo(4).Text)
     PMPasoValores sqlconn&, "@i_oficina_c", 0, SQLINT2, (txtCampo(5).Text)
     PMPasoValores sqlconn&, "@i_ciudad_c", 0, SQLINT4, (txtCampo(6).Text)
     PMPasoValores sqlconn&, "@i_num_dias", 0, SQLINT1, (txtCampo(7).Text)
     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
     PMPasoValores sqlconn&, "@i_causacont", 0, SQLVARCHAR, (txtCampo(8).Text)

     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Creación de Ruta y Tránsito") Then
        PMChequea sqlconn&
       PLBuscar
       PLLimpiar
    End If

        
End Sub

Private Sub PLEliminar()

   ' Valida Código de Localidad
   If txtCampo(0).Text = "" Then
      MsgBox "Código de la Ciudad Origen es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
   End If

   ' Valida Códigos de bancos Propietario y Corresponsal
   If txtCampo(1).Text = "" Then
      MsgBox "Código de Banco Remesa [BANCO] es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(1).SetFocus
      Exit Sub
     ElseIf txtCampo(2).Text = "" Then
        MsgBox "Código de Banco Remesa [OFICINA] es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(2).SetFocus
        Exit Sub
       ElseIf txtCampo(3).Text = "" Then
          MsgBox "Código de Banco Remesa [PARROQUIA] es mandatorio", 0 + 16, "Mensaje de Error"
          txtCampo(3).SetFocus
          Exit Sub
         ElseIf txtCampo(4).Text = "" Then
            MsgBox "Código de Banco Corresponsal [BANCO] es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
           ElseIf txtCampo(5).Text = "" Then
              MsgBox "Código de Banco Corresponsal [OFICINA] es mandatorio", 0 + 16, "Mensaje de Error"
              txtCampo(5).SetFocus
              Exit Sub
             ElseIf txtCampo(6).Text = "" Then
                MsgBox "Código de Banco Corresponsal [PARROQUIA] es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(6).SetFocus
                Exit Sub
   End If

   ' Valida Número de días de Retención
   If txtCampo(7).Text = "" Then
      MsgBox "Número de Días de Retención es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(7).SetFocus
      Exit Sub
   End If

    'Valida causa contable
    If txtCampo(8).Text = "" Then
        MsgBox "La causa contable es mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(8).SetFocus
        Exit Sub
    End If


    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2588"
    PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT4, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_banco_p", 0, SQLINT2, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_oficina_p", 0, SQLINT2, (txtCampo(2).Text)
    PMPasoValores sqlconn&, "@i_ciudad_p", 0, SQLINT4, (txtCampo(3).Text)
    PMPasoValores sqlconn&, "@i_banco_c", 0, SQLINT2, (txtCampo(4).Text)
    PMPasoValores sqlconn&, "@i_oficina_c", 0, SQLINT2, (txtCampo(5).Text)
    PMPasoValores sqlconn&, "@i_ciudad_c", 0, SQLINT4, (txtCampo(6).Text)
    PMPasoValores sqlconn&, "@i_num_dias", 0, SQLINT1, (txtCampo(7).Text)
        
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Eliminación de Ruta y Tránsito") Then
       PMChequea sqlconn&
      PLBuscar 'Refreca Datos
      PLLimpiar
     Else
        PLLimpiar
   End If
         
End Sub

Private Sub PLLimpiar()
    txtCampo(1).Enabled = True
    txtCampo(2).Enabled = True
    txtCampo(3).Enabled = True
    txtCampo(4).Enabled = True
    txtCampo(5).Enabled = True
    txtCampo(6).Enabled = True
    txtCampo(7).Enabled = True
    txtCampo(8).Enabled = True
    txtCampo(1).Text = ""
    txtCampo(2).Text = ""
    txtCampo(3).Text = ""
    txtCampo(4).Text = ""
    txtCampo(5).Text = ""
    txtCampo(6).Text = ""
    txtCampo(7).Text = ""
    txtCampo(8).Text = ""
    cmdBoton(3).Enabled = True
    cmdBoton(2).Enabled = False
    cmdBoton(4).Enabled = False
    cmdBoton(5).Enabled = False
    PMLimpiaG grdRegistros
    lblDescripcion.Caption = ""
    txtCampo(0).Text = ""
    txtCampo(0).SetFocus
End Sub

Private Sub PLSiguientes()

   Dim VTBancoP As String
   grdRegistros.Row = grdRegistros.Rows - 1
   grdRegistros.Col = 10
   VTBancoP$ = grdRegistros.Text
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2587"
    PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "C"
    PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT4, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, VTBancoP$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Consulta de Ruta y Tránsito") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&
      If Val(grdRegistros.Tag) >= 20 Then
         cmdBoton(5).Enabled = True
        Else
          cmdBoton(5).Enabled = False
      End If
      If grdRegistros.Rows <= 2 Then
         grdRegistros.Col = 1
         grdRegistros.Row = 1
         If grdRegistros.Text = "" Then
            PLLimpiar
            Exit Sub
         End If
      End If
      If cmdBoton(3).Enabled = True Then
         cmdBoton(3).SetFocus
      End If
    Else
       'PLLimpiar
       cmdBoton(5).Enabled = False
   End If

End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
       Case 0
           VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de Localidad"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código del Banco Remesa"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Código de la Oficina Banco Remesa"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Código de la Parroquia Banco Remesa"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Código del Banco Corresponsal"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Código de la Oficina Banco Corresponsal"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Código de la Parroquia Banco Corresponsal"
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Número de Días de Retención"
    End Select

    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)

    If Keycode% = VGTeclaAyuda% Then
    Load FRegistros
        VLPaso% = True
        txtCampo(Index%) = ""
        Select Case Index%
           Case 0
              VGOperacion$ = "sp_tr_crea_rutayt"
               PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2587"
               PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "L"
               PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
               PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT4, "0"
               PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
               If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Eliminación de Ruta y Tránsito") Then
                 PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
                 PMChequea sqlconn&
                 FRegistros.Show 1
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion.Caption = VGACatalogo.Descripcion$
                
                  If VLCodigo <> "" And VLCodigo <> txtCampo(Index%).Text Then
                    For i% = 1 To 8
                          txtCampo(i%).Text = ""
                    Next i%
                    PMLimpiaG grdRegistros
                  End If
                
               End If
              If txtCampo(Index%).Text <> "" Then
                 cmdBoton(6).SetFocus
                 VLCodigo = txtCampo(Index%).Text
                Else
                 txtCampo(Index%).Text = ""
                 lblDescripcion.Caption = ""
              End If
        End Select
    End If
   
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4, 5, 6, 7, 8
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
    Select Case Index
    Case 0:
         If Len(txtCampo(Index%).Text) = 7 And txtCampo(Index% + 1).Enabled = True Then
            txtCampo(Index% + 1).SetFocus
         End If
    Case 1:
        If Len(txtCampo(Index%).Text) = 3 And txtCampo(Index% + 1).Enabled = True Then
            txtCampo(Index + 1).SetFocus
        End If
    Case 2:
        If Len(txtCampo(Index%).Text) = 3 And txtCampo(Index% + 1).Enabled = True Then
            txtCampo(Index + 1).SetFocus
        End If
    Case 3:
        If Len(txtCampo(Index%).Text) = 3 And txtCampo(Index% + 1).Enabled = True Then
            txtCampo(Index + 1).SetFocus
        End If
    Case 4:
        If Len(txtCampo(Index%).Text) = 3 And txtCampo(Index% + 1).Enabled = True Then
            txtCampo(Index + 1).SetFocus
        End If

    Case 5:
        If Len(txtCampo(Index%).Text) = 3 And txtCampo(Index% + 1).Enabled = True Then
            txtCampo(Index + 1).SetFocus
        End If

    Case 6:
        If Len(txtCampo(Index%).Text) = 3 And txtCampo(Index% + 1).Enabled = True Then
            txtCampo(Index + 1).SetFocus
        End If

    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
       Case 0
          If VLPaso% = False And txtCampo(Index%) <> "" Then
              
            If VLCodigo <> "" And VLCodigo <> txtCampo(Index%).Text Then
                For i% = 1 To 8
                  txtCampo(i%).Text = ""
                Next i%
                PMLimpiaG grdRegistros
            End If

               PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2587"
               PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "L"
               PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
               PMPasoValores sqlconn&, "@i_localidad", 0, SQLINT4, (txtCampo(0).Text)
               If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_rutayt", True, "Ok... Búsqueda de la ciudad de origen") Then
                  PMMapeaObjeto sqlconn&, lblDescripcion
                  PMChequea sqlconn&
                   
                  If txtCampo(Index%).Text <> "" Then
                      cmdBoton(6).SetFocus
                      VLCodigo = txtCampo(Index%).Text
                  End If
               Else
                   txtCampo(Index%).Text = ""
                   lblDescripcion.Caption = ""
                   txtCampo(Index%).SetFocus
                   PLLimpiar
               End If
          End If
    End Select

End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
   Select Case Index
        Case 0, 1, 2, 3, 4, 5, 6, 7, 8
            'Bloquea el Click Derecho
            Clipboard.Clear
            Clipboard.SetText ""
   End Select
End Sub

