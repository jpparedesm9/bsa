VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form FRango 
   Appearance      =   0  'Flat
   Caption         =   "Rango"
   ClientHeight    =   5325
   ClientLeft      =   210
   ClientTop       =   1380
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
   Icon            =   "FRANGO1.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Eliminar"
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
      Index           =   4
      Left            =   8385
      Picture         =   "FRANGO1.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "4036"
      Top             =   3030
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1395
      MaxLength       =   3
      TabIndex        =   1
      Top             =   915
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
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
      Height          =   750
      Index           =   0
      Left            =   8385
      Picture         =   "FRANGO1.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   4
      Tag             =   "4037"
      Top             =   0
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
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
      Height          =   750
      Index           =   3
      Left            =   8385
      Picture         =   "FRANGO1.frx":08D2
      Style           =   1  'Graphical
      TabIndex        =   5
      Tag             =   "4035"
      Top             =   2265
      Width           =   875
   End
   Begin MSGrid.Grid grdRangos 
      Height          =   3090
      Left            =   15
      TabIndex        =   9
      Top             =   2220
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14632
      _ExtentY        =   5451
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1395
      MaxLength       =   2
      TabIndex        =   0
      Top             =   315
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
      Left            =   8385
      Picture         =   "FRANGO1.frx":0BDC
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   4560
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
      Left            =   8385
      Picture         =   "FRANGO1.frx":0F42
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   3795
      Width           =   875
   End
   Begin MhinrelLib.MhRealInput mskCosto 
      Height          =   285
      Index           =   0
      Left            =   1395
      TabIndex        =   2
      Top             =   1230
      Width           =   2265
      _Version        =   458753
      _ExtentX        =   3995
      _ExtentY        =   503
      _StockProps     =   205
      ForeColor       =   -2147483630
      Enabled         =   -1  'True
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      SpinChangeReal  =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      CaretVisible    =   -1  'True
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput mskCosto 
      Height          =   285
      Index           =   2
      Left            =   1395
      TabIndex        =   3
      Top             =   1550
      Width           =   2265
      _Version        =   458753
      _ExtentX        =   3995
      _ExtentY        =   503
      _StockProps     =   205
      ForeColor       =   -2147483630
      Enabled         =   -1  'True
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      SpinChangeReal  =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      CaretVisible    =   -1  'True
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Grupo Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   17
      Top             =   915
      Width           =   1200
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1395
      TabIndex        =   20
      Top             =   615
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2340
      TabIndex        =   19
      Top             =   615
      Width           =   5970
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   18
      Top             =   615
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Rangos:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   30
      TabIndex        =   13
      Top             =   1980
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   1395
      TabIndex        =   12
      Top             =   15
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   60
      TabIndex        =   14
      Top             =   345
      Width           =   1065
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Hasta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   16
      Top             =   1575
      Width           =   570
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Desde:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   60
      TabIndex        =   15
      Top             =   1275
      Width           =   615
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2340
      TabIndex        =   11
      Top             =   315
      Width           =   5970
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rango :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   10
      Top             =   15
      Width           =   690
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8340
      Y1              =   1890
      Y2              =   1875
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   15
      Y2              =   5475
   End
End
Attribute VB_Name = "FRango"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
'! removed Dim VLTrans As Integer

Dim VLMoneda As String

Private Sub cmdBoton_Click(Index As Integer)
    
    Const MB_YESNO = 4
'! removed Const MB_YESNOCANCEL = 3

    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const IDNO = 7
    '! removed Const MB_DEFBUTTON1 = 0
    '! removed Const IDCANCEL = 2
    Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim Response As String
    Dim VTFilas%
    Dim VTTipoRango$
    Dim VTGrupoRango$
    Dim VTRango$
    Dim VLEstado$
    DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
   
   Select Case Index%
    Case 0 'Buscar
        
        If txtCampo(3).Text = "" Then
            MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El grupo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        ' Trae los 20 primeros y luego añade los siguientes de 20 en 20

         VTFilas% = VGMaxRows%
         VTTipoRango$ = txtCampo(3).Text
         VTGrupoRango$ = txtCampo(0).Text
         VTRango$ = "0"
         While VTFilas% = VGMaxRows%
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4037"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, VTTipoRango$
             PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, VTGrupoRango$
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, VTRango$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rango_pe", True, "Ok...Consulta de Rangos") Then
                If VTRango$ = "0" Then
                     PMMapeaGrid sqlconn&, grdRangos, False
                Else
                     PMMapeaGrid sqlconn&, grdRangos, True
                End If
                 PMChequea sqlconn&
                If Val(grdRangos.Tag) > 0 Then
                    'cmdBoton(4).Enabled = True
                    PMObjetoSeguridad cmdBoton(4)
                    grdRangos.ColAlignment(2) = 1
                    grdRangos.ColAlignment(3) = 1
                    grdRangos.ColAlignment(4) = 2
                End If
                VTFilas% = Val(grdRangos.Tag)

                grdRangos.Col = 1
                grdRangos.Row = grdRangos.Rows - 1
                VTRango$ = grdRangos.Text
             
                
             End If

        Wend
        grdRangos.Row = 1
    

    Case 1 'Limpiar
        If mskCosto(0).Text <> "" Or mskCosto(2).Text <> "" Then
            mskCosto(0).Text = Format$("", "#,##0.00")
            mskCosto(2).Text = Format$("", "#,##0.00")
            'mskCosto(0).Format = "#,##0.00"
            'mskCosto(2).Format = "#,##0.00"
            mskCosto(0).SetFocus
        Else
            If txtCampo(0).Text <> "" Then

                txtCampo(0).Text = ""
                txtCampo(0).Enabled = True
                txtCampo(0).SetFocus
                PMLimpiaGrid grdRangos
            Else
                txtCampo(3).Text = ""
                txtCampo(3).Enabled = True
                lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
                lblDescripcion(3).Caption = ""
                VLMoneda$ = ""
                txtCampo(3).SetFocus
            End If
        End If
              lblDescripcion(2).Caption = ""
        VLPaso% = True
        'cmdBoton(3).Enabled = True
        'cmdBoton(4).Enabled = True
        PMObjetoSeguridad cmdBoton(0)
        PMObjetoSeguridad cmdBoton(3)
        PMObjetoSeguridad cmdBoton(4)
        
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        'optEstado(0).Value = True
        'cmdBoton(0).Enabled = True
        
    Case 2 'Salir
        
        Unload FRango
    
    Case 3
        
        'Inserto un nuevo registro de rango
        If txtCampo(3).Text = "" Then
            MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El grupo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        
        'If optEstado(0).Value = True Then
            VLEstado$ = "V"
        'Else
        '    VLEstado$ = "N"
        'End If
        If mskCosto(0).Text = "" Then
            MsgBox "El valor inicial es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(0).SetFocus
            Exit Sub
        End If
        If mskCosto(2).Text = "" Then
            MsgBox "El valor final es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto(2).SetFocus
            Exit Sub
        End If
        
        If mskCosto(2).Text <> "" Then
            If Val(Format$(mskCosto(0).Text)) > Val(Format$(mskCosto(2).Text)) Then
            MsgBox "El valor inicial está incorrecto", 0 + 16, "Mensaje de Error"
            mskCosto(0).Text = Format$("", "#,##0.00")
            mskCosto(0).SetFocus
            Exit Sub
            End If
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4035"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Caption
         PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_desde", 0, SQLMONEY, mskCosto(0).Text
         PMPasoValores sqlconn&, "@i_hasta", 0, SQLMONEY, mskCosto(2).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VLEstado$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rango_pe", True, "Ok...Creación de un Rango") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(2)
             PMChequea sqlconn&
            cmdBoton(3).Enabled = False
            cmdBoton_Click (0)
        End If
    
    Case 4
            
        'Elimino último registro de rango
        
        ' Validación de mandatoriedades

        If txtCampo(3).Text = "" Then
            MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El grupo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        'Determinación del estado del rango
        PMMarcarRegistro
        Response = MsgBox("Desea Eliminar el último rango del rango?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4036"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, lblDescripcion(2).Caption
             PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, txtCampo(0).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rango_pe", True, " Ok... Actualización de Rango") Then
                 PMChequea sqlconn&
                cmdBoton(4).Enabled = False
                cmdBoton_Click (0)
                mskCosto(0).Text = Format$("", "#,##0.00")
                mskCosto(2).Text = Format$("", "#,##0.00")
                'mskCosto(0).Format = "#,##0.00"
                'mskCosto(2).Format = "#,##0.00"
                mskCosto(0).SetFocus
            End If
        Else
            Exit Sub
        End If
End Select
End Sub

Private Sub Form_Load()
    FRango.Left = 15
    FRango.Top = 15
    FRango.Width = 9420
    FRango.Height = 5900
    ' Verifica si se va a insertar o a actualizar
    ' True si se insertar
    ' False si se actualiza
'''''    PMBotonSeguridad FRango, 4
'''''    cmdBoton(4).Enabled = False

PMObjetoSeguridad cmdBoton(0)
PMObjetoSeguridad cmdBoton(3)
PMObjetoSeguridad cmdBoton(4)
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRangos_Click()
    grdRangos.Col = 0
    grdRangos.SelStartCol = 1
    grdRangos.SelEndCol = grdRangos.Cols - 1
    If grdRangos.Row = 0 Then
        grdRangos.SelStartRow = 1
        grdRangos.SelEndRow = 1
    Else
        grdRangos.SelStartRow = grdRangos.Row
        grdRangos.SelEndRow = grdRangos.Row
    End If

End Sub

Private Sub grdRangos_DblClick()
    'cmdBoton(4).Enabled = True
    PMObjetoSeguridad cmdBoton(4)
End Sub

Private Sub grdRangos_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para actualizar"
End Sub

Private Sub grdRangos_KeyUp(KeyCode As Integer, Shift As Integer)
    grdRangos.Col = 0
    grdRangos.SelStartCol = 1
    grdRangos.SelEndCol = grdRangos.Cols - 1
    If grdRangos.Row = 0 Then
        grdRangos.SelStartRow = 1
        grdRangos.SelEndRow = 1
    Else
        grdRangos.SelStartRow = grdRangos.Row
        grdRangos.SelEndRow = grdRangos.Row
    End If

End Sub

Private Sub mskCosto_GotFocus(Index As Integer)
'    If VLMoneda$ = "S" Then
'        mskCosto(Index%).Format = "#,##0.00"
'    ElseIf VLMoneda$ = "N" Then
'        mskCosto(Index%).Format = "#,##0"
'
'    End If
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Valor Inicial del Rango"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Valor Final del Rango"
End Select
    mskCosto(Index%).SelStart = 0
    mskCosto(Index%).SelLength = Len(mskCosto(Index%).Text)

End Sub

Private Sub mskCosto_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 2
        If (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 8) And (KeyAscii <> 46) Then
            KeyAscii = 0
        End If
        KeyAscii = FMValidarNumero((mskCosto(Index).Text), 16, KeyAscii, "105")
   End Select

End Sub

Private Sub mskCosto_LostFocus(Index As Integer)

Select Case Index%
    
    Case 0
        ' Valor inicial del rango
        ' Verifica que el inicial del rango sea menor que el final del rango
        If mskCosto(0).Text <> "" Then
            If Not IsNumeric(mskCosto(0).Text) Then
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
         End If
    Case 2
        'Valor Final
        'Verifica que el valor final sea mayor que el inicial
        If mskCosto(2).Text <> "" Then
            If Not IsNumeric(mskCosto(0).Text) Then
                mskCosto(0).Text = ""
                mskCosto(0).SetFocus
                Exit Sub
            End If
            If mskCosto(0).Text <> "" Then
                If Val(Format$(mskCosto(2).Text)) < Val(Format$(mskCosto(0).Text)) Then
                    MsgBox "El valor final está incorrecto", 0 + 16, "Mensaje de Error"
                    mskCosto(2).Text = ""
                    mskCosto(2).SetFocus
                    Exit Sub
                End If
            End If
        End If
End Select
End Sub

Private Sub PMMarcarRegistro()
Dim Index%
        cmdBoton(0).Enabled = False
        If VLMoneda$ = "S" Then
            'mskCosto(Index%).Format = "#,##0.00"
            mskCosto(Index%).Text = Format$(mskCosto(Index%).Text, "#,##0.00")
        ElseIf VLMoneda$ = "N" Then
            mskCosto(Index%).Text = Format(0, "#,##0")
            
        End If

        grdRangos.Row = grdRangos.Rows - 1
        
        grdRangos.Col = 1
        lblDescripcion(2).Caption = grdRangos.Text
        
        grdRangos.Col = 2
        mskCosto(0).Text = grdRangos.Text
        
        grdRangos.Col = 3
        mskCosto(2).Text = grdRangos.Text
    
        grdRangos.Col = 4
        'If grdRangos.Text = "V" Then
        '    optEstado(0).Value = True
        'Else
        '    optEstado(1).Value = True
        'End If
        
End Sub

Private Sub mskCosto_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 2
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 3
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Grupo de Rango"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Tipo de Rango [F5 Ayuda]"
    End Select
    cmdBoton(3).Visible = True
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTCodigo$
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
            
        Case 3
                VLPaso% = True
                VGOperacion$ = "sp_help_rango_pe"
                VGConsulta% = True
                VGTipo$ = "T"
                VTFilas% = VGMaxRows%
                VTCodigo$ = "0"
                While VTFilas% = VGMaxRows%
                ' GBB26May98008 II:
                ' Se debe haver un load a la forma antes de cargar los valores
                Load FRegistros
                'GBB26May98008 IF:
        
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                     PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                     PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                        If VTCodigo$ = "0" Then
                             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                        Else
                             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                        End If
                         PMChequea sqlconn&
                        VTFilas% = Val(FRegistros.grdRegistros.Tag)

                        FRegistros.grdRegistros.Col = 1
                        FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                        VTCodigo$ = FRegistros.grdRegistros.Text
                    Else
                        VGOperacion$ = ""
                        VGTipo$ = ""

                    End If

            Wend
            FRegistros.grdRegistros.Row = 1
                    
                FRegistros.Show 1
                If VGValores(1) <> "" Then

                    txtCampo(3).Text = VGValores(1)
                    lblDescripcion(0).Caption = VGValores(2)
                    lblDescripcion(1).Caption = VGValores(3)
                    lblDescripcion(3).Caption = VGValores(4)
                    VLPaso% = True
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4044"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Caption
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", False, "") Then
                         PMMapeaVariable sqlconn&, VLMoneda$
                         PMChequea sqlconn&
                    End If
                End If
        End Select
    End If


End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 3
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
   Dim VTR%
        
    Select Case Index%
    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, txtCampo(3).Text
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                ReDim Valores(10) As String
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                     VTR% = FMMapeaArreglo(sqlconn&, Valores())
                     PMChequea sqlconn&
                    
                    lblDescripcion(0).Caption = Valores(1)
                    lblDescripcion(1).Caption = Valores(2)
                    lblDescripcion(3).Caption = Valores(3)
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4044"
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
                     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(1).Caption
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", False, "") Then
                         PMMapeaVariable sqlconn&, VLMoneda$
                         PMChequea sqlconn&
                    End If

                    
                Else
                    txtCampo(3).Text = ""
                    lblDescripcion(0).Caption = ""
                    lblDescripcion(1).Caption = ""
                    lblDescripcion(3).Caption = ""
                    
                    VLPaso% = True
                End If
            Else
               
               lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
                lblDescripcion(3).Caption = ""
    
            End If
        End If
    End Select

End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 3
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


