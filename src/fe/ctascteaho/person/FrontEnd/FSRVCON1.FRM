VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form Fsrvcon 
   Appearance      =   0  'Flat
   Caption         =   "Servicios Contratados"
   ClientHeight    =   5325
   ClientLeft      =   300
   ClientTop       =   1455
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
   HelpContextID   =   190
   Icon            =   "FSRVCON1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1575
      TabIndex        =   1
      Top             =   345
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
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
      Index           =   0
      Left            =   8415
      Picture         =   "FSRVCON1.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4019"
      Top             =   2265
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Index           =   4
      Left            =   8415
      Picture         =   "FSRVCON1.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4020"
      Top             =   3030
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.ComboBox cmbCuenta 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   1575
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   30
      Width           =   2205
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   420
      Left            =   1575
      TabIndex        =   13
      Top             =   1530
      Width           =   2775
      Begin VB.OptionButton optEstado 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   0
         Left            =   120
         TabIndex        =   4
         Top             =   135
         Value           =   -1  'True
         Width           =   960
      End
      Begin VB.OptionButton optEstado 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   1350
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   135
         Width           =   1305
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1575
      MaxLength       =   2
      TabIndex        =   3
      Top             =   1245
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1575
      MaxLength       =   3
      TabIndex        =   2
      Top             =   945
      Width           =   930
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   3015
      Left            =   15
      TabIndex        =   6
      Top             =   2250
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   5318
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
      Left            =   8415
      Picture         =   "FSRVCON1.frx":091E
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3795
      Width           =   875
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
      Left            =   8415
      Picture         =   "FSRVCON1.frx":0C84
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   15
      Width           =   875
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
      Left            =   8415
      Picture         =   "FSRVCON1.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   4560
      Width           =   875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   60
      TabIndex        =   19
      Top             =   60
      Width           =   1110
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Servicios Contratados por la Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   15
      TabIndex        =   20
      Top             =   2055
      Width           =   3870
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   6705
      TabIndex        =   21
      Top             =   1665
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Ultimo Cambio Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   4755
      TabIndex        =   22
      Top             =   1680
      Width           =   1920
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   60
      TabIndex        =   14
      Top             =   1665
      Width           =   660
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1575
      TabIndex        =   25
      Top             =   645
      Width           =   6780
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Número de Cta.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   24
      Top             =   345
      Width           =   1395
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre de Cta.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   23
      Top             =   645
      Width           =   1395
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2520
      TabIndex        =   15
      Top             =   1245
      Width           =   5835
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Ciclo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   60
      TabIndex        =   16
      Top             =   1245
      Width           =   495
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2520
      TabIndex        =   17
      Top             =   945
      Width           =   5835
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Serv.Disponible:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   18
      Top             =   945
      Width           =   1410
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   15
      X2              =   8385
      Y1              =   2025
      Y2              =   2025
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   225
      TabIndex        =   11
      Top             =   -3225
      Width           =   660
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
Attribute VB_Name = "Fsrvcon"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
'! removed Dim VLValor As Integer

Dim VLTipo As Integer

Private Sub cmbCuenta_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Tipo de la Cuenta"
End Sub

Private Sub cmbCuenta_LostFocus()
If cmbCuenta.Text <> "" Then
    If cmbCuenta.Text = "CTA CORRIENTE" Then
        mskCuenta.Mask = VGMascaraCtaCte$
    Else
        mskCuenta.Mask = VGMascaraCtaAho$
    End If
End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTEstado$
    Dim i%
    Dim VTFilas%
    Dim VTServicio$
    Select Case Index%
    Case 0
        
        'Inserción de un nuevo servicio contratado por la cuenta

        If mskCuenta.ClipText = "" Then
            MsgBox "El código de la cuenta  es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código de servicio disponible es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "El ciclo de cobro/pago es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If optEstado(0).Value = True Then
                VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
                VTEstado$ = "N"
        End If
                    
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4019"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_servicio_dis", 0, SQLINT2, txtCampo(1).Text
        If cmbCuenta.Text = "CTA AHORROS" Then
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
        Else
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
        End If
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_serv_contratado", True, "Ok...Creación de Servicio Contratado") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
        End If
        cmdBoton_Click (3)
    Case 1 'Limpiar
         
        
        PMLimpiaGrid grdServicios
        cmbCuenta.Clear
        For i% = 1 To 2
        txtCampo(i%).Text = ""
        Next i%
        txtCampo(1).Enabled = True
        For i% = 0 To 3
        lblDescripcion(i%).Caption = ""
        Next i%
        optEstado(0).Value = True
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        cmbCuenta.AddItem "CTA AHORROS", 0
        cmbCuenta.AddItem "CTA CORRIENTE", 1
        cmbCuenta.ListIndex = 0
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        If VLTipo% = True Then
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        Else
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        End If
        
        
    
    Case 2 'Salir
         Unload Fsrvcon
    Case 3  'Buscar con Siguientes automático
         
        If mskCuenta.ClipText = "" Then
            MsgBox "El código de la cuenta  es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
         
         VTFilas% = VGMaxRows%
         VTServicio$ = "0"

         While VTFilas% = VGMaxRows%
            
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4021"
             If cmbCuenta.Text = "CTA AHORROS" Then
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
             Else
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
             End If
                      PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (mskCuenta.ClipText)
              PMPasoValores sqlconn&, "@i_servicio_dis", 0, SQLINT2, VTServicio$
              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_serv_contratado", True, "Ok... Consulta de Servicios") Then
                If VTServicio$ = "0" Then
                     PMMapeaGrid sqlconn&, grdServicios, False
                Else
                     PMMapeaGrid sqlconn&, grdServicios, True
                End If
                 PMChequea sqlconn&
                'VTFilas% = Val(grdServicios.Tag)
                If Val(grdServicios.Tag) > 0 Then
                    grdServicios.ColAlignment(5) = 2
                End If
                grdServicios.Row = grdServicios.Rows - 1
                grdServicios.Col = 1
                VTServicio$ = grdServicios.Text
                    
                ' Determinar que existan servicions bancarios
            End If
            VTFilas% = Val(grdServicios.Tag)
        Wend
        grdServicios.Row = 1

    Case 4 'Actualizar el estado, el valor , el ciclo de un servicio contratado
        If mskCuenta.ClipText = "" Then
            MsgBox "El código de la cuenta  es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código de servicio disponible es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "El ciclo de cobro/pago es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
            
        
        If optEstado(0).Value = True Then
                VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
                VTEstado$ = "N"
        End If
                    
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4020"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_servicio_dis", 0, SQLINT2, txtCampo(1).Text
        If cmbCuenta.Text = "CTA AHORROS" Then
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
        Else
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
        End If
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_serv_contratado", True, "Ok...Actualización de Servicio Contratado") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
        End If
        
    End Select
End Sub

Private Sub Form_Load()
    Fsrvcon.Left = 15
    Fsrvcon.Top = 15
    Fsrvcon.Width = 9420
    Fsrvcon.Height = 5730
''    PMBotonSeguridad Fsrvcon, 4
    cmbCuenta.Clear
    cmbCuenta.AddItem "CTA AHORROS", 0
    cmbCuenta.AddItem "CTA CORRIENTE", 1
    cmbCuenta.ListIndex = 0
    mskCuenta.Mask = VGMascaraCtaAho$
''    cmdBoton(0).Enabled = True
''    cmdBoton(4).Enabled = False

PMObjetoSeguridad cmdBoton(3)
PMObjetoSeguridad cmdBoton(0)
PMObjetoSeguridad cmdBoton(4)

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdServicios_Click()
    grdServicios.Col = 0
    grdServicios.SelStartCol = 1
    grdServicios.SelEndCol = grdServicios.Cols - 1
    If grdServicios.Row = 0 Then
        grdServicios.SelStartRow = 1
        grdServicios.SelEndRow = 1
    Else
        grdServicios.SelStartRow = grdServicios.Row
        grdServicios.SelEndRow = grdServicios.Row
    End If
End Sub

Private Sub grdServicios_DblClick()
Dim VTRow%
    VTRow% = grdServicios.Row
    grdServicios.Row = 1
    grdServicios.Col = 1
    If grdServicios.Text <> "" Then
        grdServicios.Row = VTRow%
        PMMarcarRegistro
    End If
End Sub

Private Sub grdServicios_GotFocus()
FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Actualizar"
End Sub

Private Sub grdServicios_KeyUp(KeyCode As Integer, Shift As Integer)
    grdServicios.Col = 0
    grdServicios.SelStartCol = 1
    grdServicios.SelEndCol = grdServicios.Cols - 1
    If grdServicios.Row = 0 Then
        grdServicios.SelStartRow = 1
        grdServicios.SelEndRow = 1
    Else
        grdServicios.SelStartRow = grdServicios.Row
        grdServicios.SelEndRow = grdServicios.Row
    End If
    
End Sub

Private Sub mskCuenta_GotFocus()
    
    If cmbCuenta.Text <> "" Then
        If cmbCuenta.Text = "CTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte$
        Else
            mskCuenta.Mask = VGMascaraCtaAho$
        End If
    End If
    
    FPrincipal.pnlHelpLine.Caption = " Número de la cuenta corriente/ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)

End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If cmbCuenta.Text = "" Then
        MsgBox "El tipo de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
        cmbCuenta.SetFocus
        Exit Sub
    End If
    If mskCuenta.ClipText <> "" Then
        If cmbCuenta.Text = "CTA CORRIENTE" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                VLTipo% = True
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(0).Caption = ""
                    mskCuenta.SetFocus
                End If
                
            Else
                MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
            
        Else
            
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                VLTipo% = False
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(0).Caption = ""
                    mskCuenta.SetFocus
                    
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                lblDescripcion(0).Caption = ""
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        End If
    Else
        lblDescripcion(0).Caption = ""
    End If


End Sub

Private Sub PMMarcarRegistro()
     cmdBoton(4).Enabled = True
     cmdBoton(0).Enabled = False
    
    grdServicios.Col = 1
    txtCampo(1).Text = grdServicios.Text
    txtCampo(1).Enabled = False
    
    grdServicios.Col = 2
    lblDescripcion(2).Caption = grdServicios.Text
    
    grdServicios.Col = 3
    txtCampo(2).Text = grdServicios.Text
    
    grdServicios.Col = 4
    lblDescripcion(3).Caption = grdServicios.Text

    grdServicios.Col = 5
    lblDescripcion(1).Caption = grdServicios.Text
    
    grdServicios.Col = 6
    If grdServicios.Text = "V" Then
        optEstado(0).Value = True
    Else
        optEstado(1).Value = True
    End If
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
Case 1, 2
    VLPaso% = False

End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio Disponible"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Ciclo de cobro/pago del servicio contratado"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 1
            VGOperacion$ = "sp_help_serv_pe"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "Ok...Consulta de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGACatalogo.Codigo$ <> "" Then
                    txtCampo(1).Text = VGACatalogo.Codigo$
                    lblDescripcion(2).Caption = VGACatalogo.Descripcion$
            
                    
                    VLPaso% = True
                End If


            Else
            VGOperacion$ = ""
            End If
            txtCampo(1).Text = VGACatalogo.Codigo$
            lblDescripcion(2).Caption = VGACatalogo.Descripcion$
            
        Case 2
            PMCatalogo "A", "pe_ciclo", txtCampo(2), lblDescripcion(3)

End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 2
    If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 123)) Then
        KeyAscii% = 0
    Else
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    End If
    Case 1, 3
    If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
    End If

    End Select

End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
        Select Case Index%
        Case 1
            ' Consulta de Servicios Disponibles

            If VLPaso% = False Then
                If txtCampo(1).Text <> "" Then
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                     PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "") Then
                         PMMapeaObjeto sqlconn&, lblDescripcion(2)
                         PMChequea sqlconn&
                    Else
                        lblDescripcion(2).Caption = ""
                        txtCampo(1).Text = ""
                        VLPaso% = True
                    End If
                Else
                    lblDescripcion(2).Caption = ""
                End If
            End If
        
        Case 2
            If VLPaso% = False Then
                If txtCampo(2).Text <> "" Then
                    PMCatalogo "V", "pe_ciclo", txtCampo(2), lblDescripcion(3)
                Else
                    lblDescripcion(3).Caption = ""
                End If
             End If
            
 
End Select
End Sub



