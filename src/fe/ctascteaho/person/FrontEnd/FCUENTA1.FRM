VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FPersoCuenta 
   Appearance      =   0  'Flat
   Caption         =   "Personalización de Cuentas"
   ClientHeight    =   5310
   ClientLeft      =   60
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
   ForeColor       =   &H80000008&
   Icon            =   "FCUENTA1.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5310
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   3
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   1
      Top             =   330
      Width           =   930
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8100
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   21
      Top             =   1575
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7875
      Picture         =   "FCUENTA1.frx":030A
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   20
      Top             =   1575
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Transmitir"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   740
      Index           =   0
      Left            =   8400
      Picture         =   "FCUENTA1.frx":03E4
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4071"
      Top             =   3015
      Width           =   875
   End
   Begin MSGrid.Grid grdCuentas 
      Height          =   3510
      Index           =   1
      Left            =   4200
      TabIndex        =   7
      Top             =   1785
      Width           =   4095
      _Version        =   65536
      _ExtentX        =   7224
      _ExtentY        =   6192
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
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   3
      Left            =   8400
      Picture         =   "FCUENTA1.frx":074A
      Style           =   1  'Graphical
      TabIndex        =   5
      Tag             =   "4072"
      Top             =   60
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1920
      MaxLength       =   7
      TabIndex        =   3
      Top             =   930
      Width           =   930
   End
   Begin VB.ComboBox cmbEnte 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   15
      Width           =   2625
   End
   Begin MSGrid.Grid grdCuentas 
      Height          =   3510
      Index           =   0
      Left            =   30
      TabIndex        =   6
      Top             =   1785
      Width           =   4110
      _Version        =   65536
      _ExtentX        =   7250
      _ExtentY        =   6192
      _StockProps     =   77
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
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1920
      MaxLength       =   2
      TabIndex        =   4
      Top             =   1230
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   0
      Left            =   1920
      MaxLength       =   8
      TabIndex        =   2
      Top             =   630
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   2
      Left            =   8400
      Picture         =   "FCUENTA1.frx":09AC
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   4530
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Limpiar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   1
      Left            =   8400
      Picture         =   "FCUENTA1.frx":0D12
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   3765
      Width           =   875
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2865
      TabIndex        =   23
      Top             =   330
      Width           =   5430
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Grupo:"
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   4
      Left            =   45
      TabIndex        =   22
      Top             =   330
      Width           =   1230
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   4170
      X2              =   4170
      Y1              =   1545
      Y2              =   5325
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cuentas Ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   4215
      TabIndex        =   11
      Top             =   1590
      Width           =   1470
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cuentas Corrientes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   45
      TabIndex        =   15
      Top             =   1575
      Width           =   1680
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8340
      Y1              =   1545
      Y2              =   1545
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Personalización:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   14
      Left            =   60
      TabIndex        =   12
      Top             =   15
      Width           =   1845
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rol:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   45
      TabIndex        =   18
      Top             =   1230
      Width           =   360
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2865
      TabIndex        =   16
      Top             =   1230
      Width           =   5430
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2865
      TabIndex        =   13
      Top             =   930
      Width           =   5430
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Persona:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   45
      TabIndex        =   14
      Top             =   930
      Width           =   1410
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Empresa:"
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   17
      Top             =   630
      Width           =   1440
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2865
      TabIndex        =   19
      Top             =   630
      Width           =   5430
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   15
      Y2              =   5325
   End
End
Attribute VB_Name = "FPersoCuenta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
Dim VLEnte As String
Dim VLGrupo As String

Private Sub cmbEnte_Change()
    If cmbEnte.Text <> "" Then
        Select Case cmbEnte.Text
        Case "CUENTA"
            VLEnte$ = "C"
            txtCampo(2).Text = "1"
            lblDescripcion(2).Caption = "PROPIETARIO"
            txtCampo(2).Enabled = False
        
        Case "PERSONA"
            VLEnte$ = "P"
            txtCampo(2).Text = "1"
            lblDescripcion(2).Caption = "PROPIETARIO"
            txtCampo(2).Enabled = False
        Case "EMPRESARIAL"
    
            
            txtCampo(0).Enabled = True
            lblDescripcion(0).Visible = True
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(2).ForeColor = "&H00800000&"
            
            
            VLEnte$ = "E"
    
        Case "GRUPO ECONOMICO"
            
            txtCampo(0).Enabled = True
            lblDescripcion(0).Visible = True
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(2).ForeColor = "&H00800000&"
            
            
            txtCampo(0).Enabled = True
            lblDescripcion(0).Visible = True
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(4).ForeColor = "&H00800000&"
            
            VLEnte$ = "G"
        
        Case "DEFAULT"
            VLEnte$ = "D"
            txtCampo(2).Text = "1"
            lblDescripcion(2).Caption = "PROPIETARIO"
            txtCampo(2).Enabled = False
        
        End Select
    End If

End Sub

Private Sub cmbEnte_GotFocus()
 FPrincipal.pnlHelpLine.Caption = " Tipo Personalización"
End Sub

Private Sub cmbEnte_LostFocus()
    If cmbEnte.Text <> "" Then
        Select Case cmbEnte.Text
        Case "CUENTA"
            
            VLEnte$ = "C"
            txtCampo(2).Text = "1"
            lblDescripcion(2).Caption = "PROPIETARIO"
            txtCampo(2).Enabled = False
            txtCampo(0).Enabled = False
            txtCampo(3).Enabled = False
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(2).ForeColor = &H808080
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(4).ForeColor = &H808080
            txtCampo(3).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
        Case "PERSONAL"
            
            VLEnte$ = "P"
            txtCampo(2).Text = "1"
            lblDescripcion(2).Caption = "PROPIETARIO"
            txtCampo(2).Enabled = False
            txtCampo(0).Enabled = False
            txtCampo(3).Enabled = False
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(2).ForeColor = &H808080
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(4).ForeColor = &H808080
            txtCampo(3).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            
        
        Case "EMPRESARIAL"
    
            txtCampo(0).Enabled = True
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(2).ForeColor = &H800000
            txtCampo(2).Text = ""
            txtCampo(2).Enabled = False
            lblDescripcion(2).Caption = ""
            txtCampo(3).Enabled = False
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(4).ForeColor = &H808080
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            VLEnte$ = "E"
            txtCampo(0).SetFocus
            txtCampo(3).Text = ""
            lblDescripcion(3).Caption = ""
        Case "GRUPO ECONOMICO"
            
            txtCampo(3).Enabled = True
            txtCampo(0).Enabled = True
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(2).ForeColor = &H800000
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(4).ForeColor = &H800000
            txtCampo(2).Text = ""
            lblDescripcion(2).Caption = ""
            txtCampo(2).Enabled = False
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(0).Text = ""
            lblDescripcion(1).Caption = ""
            VLEnte$ = "G"
            txtCampo(3).SetFocus
        
        Case "DEFAULT"
            
            VLEnte$ = "D"
            txtCampo(2).Text = "1"
            lblDescripcion(2).Caption = "PROPIETARIO"
            txtCampo(2).Enabled = False
            txtCampo(0).Enabled = False
            txtCampo(3).Enabled = False
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(2).ForeColor = &H808080
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            lblEtiqueta(4).ForeColor = &H808080
            txtCampo(3).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            

        End Select
    End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim j%
Dim i%
Dim VTMarca%
Dim VTFilas1%
Dim VTCuentas1$
Dim VTFilas2%
Dim VTCuentas2$
   Select Case Index%
    Case 0
        'Validación de Mandatoriedades

        If cmbEnte.Text = "" Then
            MsgBox "Tipo de Personalización es mandatoria", 0 + 16, "Mensaje de Error"
            cmbEnte.SetFocus
            Exit Sub
        End If
        If VLEnte$ = "G" Then
            If txtCampo(3).Text = "" Then
                MsgBox "El código de grupo es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(3).SetFocus
                Exit Sub
            End If
        End If
        
        If VLEnte$ = "E" Or VLEnte$ = "G" Then
            If txtCampo(0).Text = "" Then
                MsgBox "El código de empresa es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
                Exit Sub
            End If
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código de persona es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If txtCampo(2).Text = "" Then
            MsgBox "El código del rol es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        'Determina si hay alguna cuenta marcada

        For j% = 0 To 1
            For i% = 0 To grdCuentas(j%).Rows - 1
                grdCuentas(j%).Col = 0
                If grdCuentas(j%).Text = "X" Then
                    VTMarca% = 0
                End If
            Next i%
        Next j%
        If VTMarca% = 1 Then
            MsgBox "El código de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            grdCuentas(0).SetFocus
            Exit Sub
        End If
        'Arreglar desde aquí
        For j% = 0 To 1
            For i% = 1 To grdCuentas(j%).Rows - 1 Step 1
                grdCuentas(j%).Row = i%
                grdCuentas(j%).Col = 0
                If grdCuentas(j%).Text = "X" Then
                    grdCuentas(j%).Row = i%
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4071"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
                    If VLEnte$ = "G" Then
                         PMPasoValores sqlconn&, "@i_cod_emp", 0, SQLINT4, txtCampo(3).Text
                    Else
                         PMPasoValores sqlconn&, "@i_cod_emp", 0, SQLINT4, txtCampo(0).Text
                    End If
                     PMPasoValores sqlconn&, "@i_cod_persona", 0, SQLINT4, txtCampo(1).Text
                     PMPasoValores sqlconn&, "@i_rol", 0, SQLCHAR, txtCampo(2).Text
                     PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, VLEnte$
                    grdCuentas(j%).Col = 1
                     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT4, (grdCuentas(j%).Text)
                    grdCuentas(j%).Col = 7
                     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, grdCuentas(j%).Text
                    grdCuentas(j%).Col = 8
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, grdCuentas(j%).Text
                    
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_cuenta", True, " Ok...Transacción" & "[" & grdCuentas(j%).Text & "]") Then
                         PMChequea sqlconn&
                        grdCuentas(j%).Col = 0
                        grdCuentas(j%).Text = ""
                    Else
                        grdCuentas(j%).Col = 2
                        MsgBox "Fallo la cuenta " + grdCuentas(j%).Text, 0 + 16, "Mensaje de Error"
                        
                    End If
                End If
            Next i%
        Next j%
        cmdBoton_Click (3)
         'Después Consultar y quitar el visto
    Case 1 'Limpiar
        cmbEnte.Clear
        cmbEnte.AddItem "CUENTA", 0
        cmbEnte.AddItem "PERSONAL", 1
        cmbEnte.AddItem "EMPRESARIAL", 2
        cmbEnte.AddItem "GRUPO ECONOMICO", 3
        cmbEnte.AddItem "DEFAULT", 4
        cmbEnte.ListIndex = 0
        For i% = 0 To 3
            txtCampo(i%).Text = ""
        Next i%
        'txtCampo(2).Enabled = True
        For i% = 0 To 3
            lblDescripcion(i%).Caption = ""
        Next i%
        txtCampo(2).Text = "1"
        lblDescripcion(2).Caption = "PROPIETARIO"
        txtCampo(2).Enabled = False
        txtCampo(1).Enabled = True
        txtCampo(0).Enabled = False
        txtCampo(3).Enabled = False
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
        lblEtiqueta(2).ForeColor = &H808080
'P_FIXIT: Replace 'lblEtiqueta.ForeColor=[Value]' function with 'lblEtiqueta.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: lblEtiqueta.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
        lblEtiqueta(4).ForeColor = &H808080
        VGPersonaliza% = False
        For i% = 0 To 1
            For j% = 1 To grdCuentas(i%).Rows - 1
            grdCuentas(i%).Col = 0
            If grdCuentas(i%).Text = "X" Then
                grdCuentas(i%).Text = Str$(grdCuentas(i%).Row)
                grdCuentas(i%).Picture = picVisto(1)
            End If
            
            Next j%
            PMLimpiaGrid grdCuentas(i%)
        Next i%
        cmdBoton(0).Enabled = False
        cmbEnte.SetFocus

    Case 2 'Salir
        
        Unload FPersoCuenta
        Unload FConsultaCta
        Unload FBuscarGrupo
        Unload FBuscarCliente
        'Unload FBuscarLabor
    Case 3
        
        If cmbEnte.Text = "" Then
            MsgBox "El tipo de personalización es mandatoria", 0 + 16, "Mensaje de Error"
            cmbEnte.SetFocus
            Exit Sub
        End If
        Select Case VLEnte$
        Case "P", "C", "D"
            If txtCampo(1).Text = "" Then
                MsgBox "El código de persona es mandatoria", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If
            'Mapear los grids
        Case "E"
            If txtCampo(0).Text = "" Then
                MsgBox "El código de empresa es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
            If txtCampo(1).Text = "" Then
                MsgBox "El código de persona es mandatoria", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If

        Case "G"
            If txtCampo(3).Text = "" Then
                MsgBox "El código de grupo es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(3).SetFocus
                Exit Sub
            End If
            If txtCampo(0).Text = "" Then
                MsgBox "El código de empresa es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
            If txtCampo(1).Text = "" Then
                MsgBox "El código de persona es mandatoria", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If

        End Select
            'Mapea Grids
            
            VTFilas1% = VGMaxRows%
            VTCuentas1$ = "0"
            While VTFilas1% = VGMaxRows%
            
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4072"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "C"
                 PMPasoValores sqlconn&, "@i_cod_persona", 0, SQLINT4, txtCampo(1).Text
                 PMPasoValores sqlconn&, "@i_cod_emp", 0, SQLINT4, txtCampo(0).Text
                 PMPasoValores sqlconn&, "@i_rol", 0, SQLCHAR, txtCampo(2).Text
                 PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, VLEnte$
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                
                 PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT4, VTCuentas1$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_cuenta", True, "Ok... Consulta de Cuentas") Then
                    If VTCuentas1$ = "0" Then
                         PMMapeaGrid sqlconn&, grdCuentas(0), False
                    Else
                         PMMapeaGrid sqlconn&, grdCuentas(0), True
                    End If
                     PMChequea sqlconn&
                    'VTFilas1% = Val(grdCuentas(0).Tag)
        
                    grdCuentas(0).Col = 1
                    grdCuentas(0).Row = grdCuentas(0).Rows - 1
                    VTCuentas1$ = grdCuentas(0).Text
                End If
                VTFilas1% = Val(grdCuentas(0).Tag)
        Wend
        grdCuentas(0).Row = 1

        VTFilas2% = VGMaxRows%
        VTCuentas2$ = "0"
        
        While VTFilas2% = VGMaxRows%
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4072"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_cod_persona", 0, SQLINT4, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_cod_emp", 0, SQLINT4, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_rol", 0, SQLCHAR, txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, VLEnte$
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT4, VTCuentas2$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_cuenta", True, "Ok... Consulta de Cuentas") Then
                If VTCuentas2$ = "0" Then
                     PMMapeaGrid sqlconn&, grdCuentas(1), False
                Else
                     PMMapeaGrid sqlconn&, grdCuentas(1), True
                End If
                 PMChequea sqlconn&
                'VTFilas2% = Val(grdCuentas(1).Tag)
    
                grdCuentas(1).Col = 1
                grdCuentas(1).Row = grdCuentas(1).Rows - 1
                VTCuentas2$ = grdCuentas(1).Text
            End If
        VTFilas2% = Val(grdCuentas(1).Tag)
    Wend
    grdCuentas(1).Row = 1
End Select
End Sub

Private Sub Form_Load()
    FPersoCuenta.Left = 15
    FPersoCuenta.Top = 15
    FPersoCuenta.Width = 9420
    FPersoCuenta.Height = 5730
    'PMBotonSeguridad FPersoCuenta, 3
    cmbEnte.Clear
    cmbEnte.AddItem "CUENTA", 0
    cmbEnte.AddItem "PERSONAL", 1
    cmbEnte.AddItem "EMPRESARIAL", 2
    cmbEnte.AddItem "GRUPO ECONOMICO", 3
    cmbEnte.AddItem "DEFAULT", 4
    cmbEnte.ListIndex = 0
    txtCampo(2).Text = "1"
    lblDescripcion(2).Caption = "PROPIETARIO"
    txtCampo(2).Enabled = False
    cmdBoton(0).Enabled = False
    txtCampo(0).Enabled = False
    VGPersonaliza% = False
    
 PMObjetoSeguridad cmdBoton(3)
 PMObjetoSeguridad cmdBoton(0)
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdCuentas_DblClick(Index As Integer)
Dim VTRow%
Dim j%
Dim VTR%
    VTRow% = grdCuentas(Index%).Row
    grdCuentas(Index%).Row = 1
    grdCuentas(Index%).Col = 1
    If grdCuentas(Index%).Text <> "" Then
        grdCuentas(Index%).Row = VTRow%
        Select Case VLEnte$
        Case "C"
            cmdBoton(0).Enabled = False
            PMMarcarRegistro Index%
            grdCuentas(Index%).Col = 1
            VGCuenta$ = grdCuentas(Index%).Text
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4072"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
            grdCuentas(Index%).Col = 10
             PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, grdCuentas(Index%).Text
            grdCuentas(Index%).Col = 7
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, grdCuentas(Index%).Text
            grdCuentas(Index%).Col = 8
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, grdCuentas(Index%).Text
             PMPasoValores sqlconn&, "@i_cuenta", 0, SQLINT4, VGCuenta$
            ReDim Valores(4) As String
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_personaliza_cuenta", True, " Ok...Transacción" & "[" & grdCuentas(j%).Text & "]") Then
                 VTR% = FMMapeaArreglo(sqlconn&, Valores())
                 PMChequea sqlconn&
                If Valores(1) <> "" Then
                    FConsultaCta.txtCampo(0).Text = Valores(1)
                    FConsultaCta.txtCampo(0).Enabled = False
                    FConsultaCta.lblDescripcion(0).Caption = Valores(2)
                End If
                
            End If

            
            grdCuentas(Index%).Col = 7
            FConsultaCta.lblDescripcion(4).Caption = grdCuentas(Index%).Text
            grdCuentas(Index%).Col = 2
            FConsultaCta.lblDescripcion(5).Caption = grdCuentas(Index%).Text
            grdCuentas(Index%).Col = 8
            FConsultaCta.lblDescripcion(1).Caption = grdCuentas(Index%).Text
            grdCuentas(Index%).Col = 6
            FConsultaCta.txtCampo(2).Text = grdCuentas(Index%).Text
            grdCuentas(Index%).Col = 9
            FConsultaCta.lblDescripcion(2).Caption = grdCuentas(Index%).Text
            
            If txtCampo(2).Text <> "" Then
                PMCatalogo "V", "pe_categoria", FConsultaCta.txtCampo(2), FConsultaCta.lblDescripcion(3)
            Else
                lblDescripcion(3).Caption = ""
            End If
            VGPersonaliza% = False
             FConsultaCta.Show 1
            If VGPersonaliza% = True Then
                cmdBoton_Click (0)
            Else
                cmdBoton_Click (3)
            End If

        Case Else
            Select Case Index%
            Case 0, 1
                If Val(grdCuentas(Index%).Tag) > 0 Then
                  cmdBoton(0).Enabled = True
                  PMMarcarRegistro Index%
                  
                End If
            End Select
        End Select
    End If

End Sub

Private Sub grdCuentas_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
    Select Case Index%
    Case 0, 1
        grdCuentas(Index%).Col = 0
        grdCuentas(Index%).SelStartCol = 1
        grdCuentas(Index%).SelEndCol = grdCuentas(Index%).Cols - 1
        If grdCuentas(Index%).Row = 0 Then
            grdCuentas(Index%).SelStartRow = 1
            grdCuentas(Index%).SelEndRow = 1
        Else
            grdCuentas(Index%).SelStartRow = grdCuentas(Index%).Row
            grdCuentas(Index%).SelEndRow = grdCuentas(Index%).Row
        End If
    End Select

End Sub

Private Sub PMMarcarRegistro(Index As Integer)
    
    grdCuentas(Index%).Col = 0
    If grdCuentas(Index%).Text <> "X" Then
        grdCuentas(Index%).Text = "X"
        grdCuentas(Index%).Picture = picVisto(0)
    Else
        If grdCuentas(Index%).Text = "X" Then
            grdCuentas(Index%).Text = Str$(grdCuentas(Index%).Row)
            grdCuentas(Index%).Picture = picVisto(1)
        End If
    End If
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código Empresa [F5 Ayuda]"
    
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Código Persona [F5 Ayuda]"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Rol [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Código Grupo [F5 Ayuda]"
    
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
VLGrupo$ = "0"
If KeyCode% = VGTeclaAyuda% Then
    VLPaso% = True
    
    Select Case Index%
    Case 0 'Codigo de Empresa
        Select Case VLEnte$
         Case "E"
            
            FBuscarCliente.optCliente(0).Enabled = False 'Persona
            FBuscarCliente.optCliente(1).Value = True
            FBuscarCliente.Show 1
            FBuscarCliente.optCliente(0).Enabled = True '
        
        Case "G"
            
            If txtCampo(3).Text = "" Then
                MsgBox "El código de grupo es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(3).SetFocus
                Exit Sub
            End If
            
            
            FBuscarLabor.optCriterio(1).Enabled = False 'Compañía
            FBuscarLabor.optCriterio(2).Enabled = False 'Compañía
            FBuscarLabor.optCriterio(0).Value = True
            FBuscarLabor.txtValor.Text = txtCampo(3).Text
            FBuscarLabor.txtValor.Enabled = False
            FBuscarLabor.lblnombre.Caption = lblDescripcion(3).Caption
            FBuscarLabor.Show 1
            FBuscarLabor.optCriterio(1).Enabled = True 'Compañía
            FBuscarLabor.optCriterio(2).Enabled = True 'Compañía
            FBuscarLabor.txtValor.Text = ""
            FBuscarLabor.lblnombre.Caption = ""
            FBuscarLabor.txtValor.Enabled = True
            
            

        End Select
        If VGBusqueda(1) <> "" Then
           
            txtCampo(0).Text = VGBusqueda(1)   'Código de la empresa
            lblDescripcion(0).Caption = VGBusqueda(2) ' Descripción de la empresa
            VLPaso% = True
        End If
        If VLEnte$ = "G" Then
            VLGrupo$ = VGBusqueda(0)
        
        End If

        If txtCampo(0).Text <> "" Then
            txtCampo(0).Enabled = False
        End If

    Case 1 ' Codigo de Persona
        Select Case VLEnte$
        Case "P", "C", "D"
        'If VLEnte$ = "P" Or VLEnte$ = "C" Or VLEnte$ = "D" Then
            If VLEnte$ = "C" Then
              FBuscarCliente.optCliente(1).Enabled = True 'Compañía
            Else
              FBuscarCliente.optCliente(1).Enabled = False 'Compañía
            End If

            FBuscarCliente.optCliente(0).Value = True
            FBuscarCliente.Show 1
            FBuscarCliente.optCliente(1).Enabled = True
            If VGBusqueda(1) <> "" Then
                txtCampo(1).Text = VGBusqueda(1)
                lblDescripcion(1).Caption = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
                VLPaso% = True
            End If
        'End If
        Case "E", "G"
            If txtCampo(0).Text = "" Then
                MsgBox "El código de empresa es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
            FBuscarLabor.optCriterio(0).Enabled = False 'Compañía
            FBuscarLabor.optCriterio(2).Enabled = False 'Compañía
            FBuscarLabor.optCriterio(1).Value = True
            FBuscarLabor.txtValor.Text = txtCampo(0).Text
            FBuscarLabor.lblnombre.Caption = lblDescripcion(0).Caption
            FBuscarLabor.txtValor.Enabled = False
            FBuscarLabor.Show 1
            FBuscarLabor.optCriterio(0).Enabled = True 'Compañía
            FBuscarLabor.optCriterio(2).Enabled = True 'Compañía
            FBuscarLabor.txtValor.Enabled = True
            If VGBusqueda(1) <> "" Then
                txtCampo(1).Text = VGBusqueda(1) 'cod de persona
                lblDescripcion(1).Caption = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4) 'nombre de persona
                txtCampo(2).Text = VGBusqueda(5) ' codigo del rol
                lblDescripcion(2).Caption = VGBusqueda(6) 'des del rol
                
                VLPaso% = True
            End If

        
        End Select
    Case 2 ' Codigo del Rol
        
        PMCatalogo "A", "cl_rol_empresa", txtCampo(2), lblDescripcion(2)
        VLPaso% = True

    Case 3 ' Codigo del grupo
            
        FBuscarGrupo.Show 1
        If VGBusqueda(1) <> "" Then
            txtCampo(3).Text = VGBusqueda(1)   'Código de la empresa
            lblDescripcion(3).Caption = VGBusqueda(2) ' Descripción de la empresa
            VLPaso% = True
            txtCampo(3).Enabled = False
        End If
        

    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
        Select Case Index%
    Case 0, 1, 3 ' Grupo
        If ((KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57))) Then
                KeyAscii% = 0
        End If

    Case 2 'Rol
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))

    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
    Select Case Index%
    Case 0 'Codigo de Empresa

        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                ReDim VTArreglo(7) As String
                Select Case VLEnte$
                Case "E"
                    
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1190"
                     PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (txtCampo(0).Text)
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_qrente", True, "") Then
                         VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTArreglo(2) = "C" Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                            txtCampo(0).Enabled = False
                        Else
                            MsgBox "Código No corresponde a Compañía", 0 + 16, "Mensaje de Error"
                            txtCampo(0).Text = ""
                            txtCampo(0).SetFocus
                        End If
                    Else
                        lblDescripcion(0).Caption = ""

                    End If
            
                Case "G" 'OJo
                    
                    If txtCampo(3).Text = "" Then
                        MsgBox "El código de grupo es mandatorio", 0 + 16, "Mensaje de Error"
                        txtCampo(0).Text = ""
                        txtCampo(3).SetFocus
                        Exit Sub
                    End If
                    '*********Query que consulte si la empresa existe y pertenece al grupo
                    
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1253"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "EXG"
                     PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, (txtCampo(0).Text)
                     PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT4, (txtCampo(3).Text)
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_laboral", True, "") Then
                         PMMapeaObjeto sqlconn&, lblDescripcion(0)
                         PMChequea sqlconn&
                        txtCampo(0).Enabled = False
                    Else
                      ' MsgBox "Empresa no corresponde a Grupo", 0 + 16, "Mensaje de Error"
                       txtCampo(0).Text = ""
                       txtCampo(0).SetFocus
                    End If
                End Select
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If
    Case 1 'Código de Persona
        
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                ReDim VTArreglo(7) As String
                Select Case VLEnte$
                Case "C", "D", "P"

                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1190"
                     PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (txtCampo(1).Text)
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_qrente", False, "") Then
                         VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTArreglo(2) = "P" Then
                            lblDescripcion(1).Caption = VTArreglo(1)
                        Else
                           If VLEnte$ <> "C" Then
                            MsgBox "Código No corresponde a Persona", 0 + 16, "Mensaje de Error"
                            txtCampo(1).Text = ""
                            txtCampo(1).SetFocus
                           Else
                            lblDescripcion(1).Caption = VTArreglo(1)
                           End If
                        End If
                    Else
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Caption = ""
                    End If
                Case "E", "G"
                    If txtCampo(0).Text = "" Then
                        MsgBox "El código de empresa es mandatorio", 0 + 16, "Mensaje de Error"
                        txtCampo(1).Text = ""
                        txtCampo(0).SetFocus
                       Exit Sub
                    End If
                        '*************************OJO**************
                        ' Query que consulte si la persona ingresada existe y trabaja en esa compañía
                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1255"
                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "PXE"
                    PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT4, (txtCampo(0).Text)
                    PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, (txtCampo(1).Text)
                   ReDim VTValores(5) As String
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_laboral", False, "") Then
                        VTR% = FMMapeaArreglo(sqlconn&, VTValores())
                        PMChequea sqlconn&
                       If VTValores(1) <> "" Then
                            lblDescripcion(1).Caption = VTValores(1)
                            txtCampo(2).Text = VTValores(2)
                            lblDescripcion(2).Caption = VTValores(3)
                            txtCampo(1).Enabled = False
                 
                       Else
                          MsgBox "Código no corresponde a persona", 0 + 16, "Mensaje de Error"
                          txtCampo(1).Text = ""
                          txtCampo(1).SetFocus
                        End If
                   Else
                        txtCampo(1).Text = ""
                        lblDescripcion(1).Caption = ""
                    End If
                End Select
            Else
                If VLEnte$ = "E" Or VLEnte$ = "G" Then
                    txtCampo(2).Text = ""
                    lblDescripcion(2).Caption = ""
                End If
                lblDescripcion(1).Caption = ""
            End If

        End If
        
    Case 2
        
        'Query de servicio a personalizar
        
        If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                PMCatalogo "V", "cl_rol_empresa", txtCampo(2), lblDescripcion(2)
            Else
                txtCampo(2).Text = ""
                lblDescripcion(2).Caption = ""
            End If
         End If
        
    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text <> "" Then
                ReDim VTArreglo(7) As String
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1184"
                 PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT4, (txtCampo(3).Text)
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_grupo", False, "") Then
                     VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMChequea sqlconn&
                    lblDescripcion(3).Caption = VTArreglo(2)
                    txtCampo(3).Enabled = False
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(3).Caption = ""

                End If
            Else
                lblDescripcion(3).Caption = ""
            End If
        End If

    
End Select

End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2, 3
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


