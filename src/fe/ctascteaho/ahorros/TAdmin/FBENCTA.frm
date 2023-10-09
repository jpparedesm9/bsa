VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FBenCta 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Beneficiarios de una Cuenta"
   ClientHeight    =   4155
   ClientLeft      =   90
   ClientTop       =   1590
   ClientWidth     =   6135
   ControlBox      =   0   'False
   FillColor       =   &H00FFFFFF&
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
   HelpContextID   =   1080
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4155
   ScaleWidth      =   6135
   Begin Threed.SSPanel SSPCta 
      Height          =   255
      Index           =   0
      Left            =   600
      TabIndex        =   12
      Top             =   10
      Width           =   1575
      _Version        =   65536
      _ExtentX        =   2778
      _ExtentY        =   450
      _StockProps     =   15
      ForeColor       =   8388608
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSFrame frnBeneficiario 
      Height          =   1200
      Left            =   0
      TabIndex        =   8
      Top             =   360
      Width           =   6120
      _Version        =   65536
      _ExtentX        =   10795
      _ExtentY        =   2117
      _StockProps     =   14
      Caption         =   "Beneficiario"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Begin Threed.SSCommand cmdBoton 
         Height          =   270
         Index           =   0
         Left            =   2640
         TabIndex        =   3
         Top             =   840
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   476
         _StockProps     =   78
         Caption         =   "Agregar"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
      Begin VB.TextBox txtPctje 
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   4920
         MaxLength       =   5
         TabIndex        =   2
         Top             =   480
         Width           =   735
      End
      Begin VB.TextBox txtNombre 
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1440
         MaxLength       =   64
         TabIndex        =   1
         Top             =   480
         Width           =   3495
      End
      Begin VB.TextBox txtCed 
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   120
         MaxLength       =   20
         TabIndex        =   0
         Top             =   480
         Width           =   1335
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   270
         Index           =   1
         Left            =   3780
         TabIndex        =   5
         Top             =   840
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   476
         _StockProps     =   78
         Caption         =   "Modificar"
         ForeColor       =   8388608
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
         Font3D          =   3
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   270
         Index           =   2
         Left            =   4920
         TabIndex        =   6
         Top             =   840
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   476
         _StockProps     =   78
         Caption         =   "Eliminar"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Font3D          =   3
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   290
         Index           =   3
         Left            =   5670
         TabIndex        =   14
         Top             =   480
         WhatsThisHelpID =   2066
         Width           =   350
         _Version        =   65536
         _ExtentX        =   617
         _ExtentY        =   512
         _StockProps     =   78
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   1
         Font3D          =   3
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "%"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   3
         Left            =   4920
         TabIndex        =   11
         Top             =   240
         Width           =   135
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Nombre"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   2
         Left            =   1440
         TabIndex        =   10
         Top             =   240
         Width           =   615
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Ced/NIT/Pas"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   1
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   1005
      End
   End
   Begin MSGrid.Grid grdBeneficiarios 
      Height          =   2265
      Left            =   0
      TabIndex        =   4
      Top             =   1560
      Width           =   6120
      _Version        =   65536
      _ExtentX        =   10795
      _ExtentY        =   3995
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
   Begin Threed.SSPanel SSPCta 
      Height          =   255
      Index           =   1
      Left            =   2190
      TabIndex        =   13
      Top             =   10
      Width           =   3900
      _Version        =   65536
      _ExtentX        =   6879
      _ExtentY        =   450
      _StockProps     =   15
      ForeColor       =   8388608
      BackColor       =   13160660
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Alignment       =   1
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   285
      Index           =   4
      Left            =   5160
      TabIndex        =   15
      Top             =   3870
      Width           =   945
      _Version        =   65536
      _ExtentX        =   1667
      _ExtentY        =   503
      _StockProps     =   78
      Caption         =   "Salir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   1
      Font3D          =   3
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cta: "
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   0
      Left            =   90
      TabIndex        =   7
      Top             =   45
      Width           =   375
   End
End
Attribute VB_Name = "FBenCta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FBENCTA.frm
' NOMBRE LOGICO:    FBenCta
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
' Permite el mantenimiento de los beneficiarios de una cuenta
' Corriente o Ahorros
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 14-May-03      ALF             Emisión Inicial
'*************************************************************
Option Explicit
Dim VLTrn As String
Dim VLBase As String
Dim VLSP As String

Private Sub cmdBoton_Click(Index As Integer)
    Dim respuesta As Integer
    Select Case Index%
    Case 0  'Agregar

        ' Validacion de Mandatoriedades
        
        ' Cédula del Beneficiario
        If Trim$(txtCed.Text) = "" Then
            MsgBox "Identificación del beneficiario es mandatorio", 0 + 16, "Mensaje de Error"
            txtCed.SetFocus
            Exit Sub
        End If

        ' Nombre del Beneficiario
        If Trim$(txtNombre.Text) = "" Then
            MsgBox "El nombre del beneficiario es mandatorio", 0 + 16, "Mensaje de Error"
            txtNombre.SetFocus
            Exit Sub
        End If

        ' Porcentaje de beneficio
        If Trim$(txtPctje.Text) = "" Then
            MsgBox "El porcentaje asignado es mandatorio", 0 + 16, "Mensaje de Error"
            txtPctje.SetFocus
            Exit Sub
        End If
        
        'Valida el porcentaje
         If Val(txtPctje.Text) > 100 Then
            MsgBox "El porcentaje no puede ser mayor a 100", 0 + 16, "Mensaje de Error"
            txtPctje.SetFocus
            Exit Sub
        End If
        If Val(txtPctje.Text) = 0 Then
            MsgBox "El porcentaje no puede ser igual a cero", 0 + 16, "Mensaje de Error"
            txtPctje.SetFocus
            Exit Sub
        End If
        
  
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VLTrn
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLVARCHAR, "I"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, Trim$(VGADatosI(0))
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLVARCHAR, Trim$(txtCed.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, Trim$(txtNombre.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_porcentaje", 0, SQLFLT8, Trim$(txtPctje.Text)
        If FMTransmitirRPC(sqlconn&, ServerName$, VLBase, VLSP, True, " Ok... Consulta de beneficiarios") Then
            PMChequea sqlconn&
            PLLimpiar
        End If
        
        PLBuscar
        
    Case 1 'Modificar
     
        ' Validacion de Mandatoriedades
        
        ' Cédula del Beneficiario
        If Trim$(txtCed.Text) = "" Then
            MsgBox "Identificación del beneficiario es mandatorio", 0 + 16, "Mensaje de Error"
            txtCed.SetFocus
            Exit Sub
        End If

        ' Nombre del Beneficiario
        If Trim$(txtNombre.Text) = "" Then
            MsgBox "El nombre del beneficiario es mandatorio", 0 + 16, "Mensaje de Error"
            txtNombre.SetFocus
            Exit Sub
        End If

        ' Porcentaje de beneficio
        If Trim$(txtPctje.Text) = "" Then
            MsgBox "El porcentaje asignado es mandatorio", 0 + 16, "Mensaje de Error"
            txtPctje.SetFocus
            Exit Sub
        End If
        
        'Valida el porcentaje
         If Val(txtPctje.Text) > 100 Then
            MsgBox "El porcentaje no puede ser mayor a 100", 0 + 16, "Mensaje de Error"
            txtPctje.SetFocus
            Exit Sub
        End If
        If Val(txtPctje.Text) = 0 Then
            MsgBox "El porcentaje no puede ser igual a cero", 0 + 16, "Mensaje de Error"
            txtPctje.SetFocus
            Exit Sub
        End If
        
        
        grdBeneficiarios.Col = 1
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VLTrn
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLVARCHAR, "U"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, Trim$(VGADatosI(0))
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_ced_ruc", 0, SQLVARCHAR, Trim$(txtCed.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, Trim$(txtNombre.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_porcentaje", 0, SQLFLT8, Trim$(txtPctje.Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_beneficiario", 0, SQLINT4, Trim$(grdBeneficiarios.Text)
        If FMTransmitirRPC(sqlconn&, ServerName$, VLBase, VLSP, True, " Ok... Modificación de beneficiarios") Then
            PMChequea sqlconn&
            PLLimpiar
        End If
        PLBuscar
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = True
        grdBeneficiarios.Enabled = True
      
    Case 2 'Eliminar
    
        grdBeneficiarios.Col = 3
        If grdBeneficiarios.Text <> "" And grdBeneficiarios.Row <> 0 Then
            respuesta = MsgBox("Está seguro de eliminar beneficiario: " + grdBeneficiarios.Text + " ?", vbYesNo)
            If respuesta% = 7 Then
                Exit Sub
            End If
            grdBeneficiarios.Col = 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VLTrn
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLVARCHAR, "D"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, Trim$(VGADatosI(0))
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_beneficiario", 0, SQLINT4, Trim$(grdBeneficiarios.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, VLBase, VLSP, True, " Ok... Eliminación del beneficiario " & "[" & grdBeneficiarios.Text & "]") Then
                PMChequea sqlconn&
            End If
            PLBuscar
        Else
            MsgBox "Debe seleccionar el beneficiario a eliminar", 0 + 16, "Mensaje de Error"
        End If
    
    Case 3 'Limpiar
        PLLimpiar
    Case 4 'Salir
        'Si esta en modo de edición verifica que se complete el 100 antes de salir
        If VGADatosI(3) <> "consulta" And Not FLVerificar Then Exit Sub
        Unload Me
    End Select
End Sub

Private Sub Form_Load()
    FBenCta.Left = FPrincipal.Left + 50
    FBenCta.Top = FPrincipal.Top + 1000
    FBenCta.Width = 6255
    FBenCta.Height = 4530
    PMLoadResStrings Me
    PMLoadResIcons Me
    PLLimpiaGrid
    PLLimpiar
    SSPCta(0).Caption = VGADatosI(0)
    SSPCta(1).Caption = VGADatosI(1)
    If VGADatosI(3) = "consulta" Then
        grdBeneficiarios.Top = 360
        grdBeneficiarios.Height = 3465
        frnBeneficiario.Enabled = False
        frnBeneficiario.Visible = False
    Else
        grdBeneficiarios.Top = 0   '1560
        grdBeneficiarios.Height = 2265
        frnBeneficiario.Enabled = True
        frnBeneficiario.Visible = True
    End If
    
    If VGADatosI(2) = "3" Then
       VLTrn = "2821"
       VLBase = "cob_cuentas"
       VLSP = "sp_beneficiario_ctacte"
    Else
       VLTrn = "333"
       VLBase = "cob_ahorros"
       VLSP = "sp_beneficiario_ahorros"
    End If
    PLBuscar
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub
Private Sub grdBeneficiarios_Click()
    grdBeneficiarios.Col = 0
    grdBeneficiarios.SelStartCol = 1
    grdBeneficiarios.SelEndCol = grdBeneficiarios.Cols - 1
    If grdBeneficiarios.Row = 0 Then
       grdBeneficiarios.SelStartRow = 1
       grdBeneficiarios.SelEndRow = 1
    Else
       grdBeneficiarios.SelStartRow = grdBeneficiarios.Row
       grdBeneficiarios.SelEndRow = grdBeneficiarios.Row
    End If
End Sub

Private Sub grdBeneficiarios_DblClick()
    grdBeneficiarios.Col = 0
    grdBeneficiarios.SelStartCol = 1
    grdBeneficiarios.SelEndCol = grdBeneficiarios.Cols - 1
    If grdBeneficiarios.Row = 0 Then
       grdBeneficiarios.SelStartRow = 1
       grdBeneficiarios.SelEndRow = 1
    Else
       grdBeneficiarios.Col = 1
       If grdBeneficiarios.Text <> "" And VGADatosI(3) <> "consulta" Then
            grdBeneficiarios.SelStartRow = grdBeneficiarios.Row
            grdBeneficiarios.SelEndRow = grdBeneficiarios.Row
            grdBeneficiarios.Col = 2
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            txtCed.Text = Trim$(grdBeneficiarios.Text)
            grdBeneficiarios.Col = 3
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            txtNombre.Text = Trim$(grdBeneficiarios.Text)
            grdBeneficiarios.Col = 4
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            txtPctje.Text = Trim$(grdBeneficiarios.Text)
            cmdBoton(1).Enabled = True
            cmdBoton(0).Enabled = False
            cmdBoton(2).Enabled = False
            grdBeneficiarios.Enabled = False
            If txtCed.Enabled And txtCed.Visible Then txtCed.SetFocus
       Else
            cmdBoton(0).Enabled = True
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = False
            grdBeneficiarios.Enabled = True
       End If
    End If

End Sub

Private Sub grdBeneficiarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de Beneficiarios de la cuenta"
End Sub


Private Sub PLLimpiaGrid()
    PMLimpiaGrid grdBeneficiarios
    grdBeneficiarios.Cols = 5
    grdBeneficiarios.ColWidth(0) = 400
    grdBeneficiarios.ColWidth(1) = 1
    grdBeneficiarios.ColWidth(2) = 1500
    grdBeneficiarios.ColWidth(3) = 3300
    grdBeneficiarios.ColWidth(4) = 780
    grdBeneficiarios.Row = 0
    grdBeneficiarios.Col = 0
    grdBeneficiarios.Text = "No."
    grdBeneficiarios.Col = 1
    grdBeneficiarios.Text = "Secuencial"
    grdBeneficiarios.Col = 2
    grdBeneficiarios.Text = "Ced. /NIT /Pas."
    grdBeneficiarios.Col = 3
    grdBeneficiarios.Text = "Nombre"
    grdBeneficiarios.Col = 4
    grdBeneficiarios.Text = "Porcentaje"
End Sub

Private Sub txtCed_GotFocus()
    txtCed.SelStart = 0
    txtCed.SelLength = Len(txtCed.Text)
End Sub

Private Sub txtCed_KeyPress(KeyAscii As Integer)
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
   KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (KeyAscii% < 48 Or KeyAscii% < 57) Then
       KeyAscii% = 0
   End If
End Sub
Private Sub txtNombre_GotFocus()
    txtNombre.SelStart = 0
    txtNombre.SelLength = Len(txtNombre.Text)
End Sub
Private Sub txtPctje_GotFocus()
    txtPctje.SelStart = 0
    txtPctje.SelLength = Len(txtPctje.Text)
End Sub
Private Sub txtNombre_KeyPress(KeyAscii As Integer)
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
   KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   If (KeyAscii% <> 8 And KeyAscii% <> 32 And KeyAscii% <> 209) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (KeyAscii% < 65 Or KeyAscii > 90) Then
       KeyAscii% = 0
   End If
End Sub
Private Sub txtPctje_KeyPress(KeyAscii As Integer)
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
   KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
   If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (KeyAscii% <> 46) Then
       KeyAscii% = 0
   End If
End Sub


Private Sub PLLimpiar()
   txtCed.Text = ""
   txtNombre.Text = ""
   txtPctje.Text = ""
   cmdBoton(0).Enabled = True
   cmdBoton(1).Enabled = False
   cmdBoton(2).Enabled = True
   grdBeneficiarios.Enabled = True
   If txtCed.Enabled And txtCed.Visible Then txtCed.SetFocus
End Sub

Private Sub PLBuscar()
Dim VTR As Integer
Dim i As Integer
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VLTrn
   PMPasoValores sqlconn&, "@i_tipo", 0, SQLVARCHAR, "S"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
   PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, Trim$(VGADatosI(0))
   PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
   If FMTransmitirRPC(sqlconn&, ServerName$, VLBase, VLSP, True, " Ok... Consulta de beneficiarios") Then
       ReDim Beneficiarios(8, 40) As String
       VTR = FMMapeaMatriz(sqlconn&, Beneficiarios())
       PMLimpiaGrid grdBeneficiarios
       PMChequea sqlconn&
       PLLimpiaGrid
       For i% = 1 To VTR%
           grdBeneficiarios.AddItem Str$(i%) & Chr(9) & Beneficiarios(0, i%) & Chr(9) & Beneficiarios(1, i%) & Chr(9) & Beneficiarios(2, i%) & Chr(9) & Beneficiarios(3, i%)
       Next i%
       If grdBeneficiarios.Rows > 2 Then
          grdBeneficiarios.RemoveItem 1
       End If
   End If
 End Sub
 
Private Function FLVerificar() As Boolean
   FLVerificar = False
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VLTrn
   PMPasoValores sqlconn&, "@i_tipo", 0, SQLVARCHAR, "T"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
   PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, Trim$(VGADatosI(0))
   PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
   If FMTransmitirRPC(sqlconn&, ServerName$, VLBase, VLSP, True, " Ok... Consulta de beneficiarios") Then
      PMChequea sqlconn&
      FLVerificar = True
   End If
 End Function
 

