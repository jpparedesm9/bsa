VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FCreaServ 
   Appearance      =   0  'Flat
   Caption         =   "Servicios Disponibles"
   ClientHeight    =   5325
   ClientLeft      =   150
   ClientTop       =   1605
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
   Icon            =   "FSERBAC.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1485
      MaxLength       =   4
      TabIndex        =   0
      Top             =   315
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Index           =   4
      Left            =   8400
      Picture         =   "FSERBAC.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   10
      Tag             =   "4028"
      Top             =   3030
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
      Index           =   0
      Left            =   8400
      Picture         =   "FSERBAC.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4027"
      Top             =   2265
      Width           =   870
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
      Index           =   3
      Left            =   8400
      Picture         =   "FSERBAC.frx":091E
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4029"
      Top             =   15
      Width           =   875
   End
   Begin VB.Frame frmHistoria 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   435
      Left            =   5445
      TabIndex        =   17
      Top             =   1200
      Visible         =   0   'False
      Width           =   2895
      Begin VB.OptionButton optGuarda 
         Caption         =   "No Requerido"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   1335
         TabIndex        =   6
         TabStop         =   0   'False
         Top             =   135
         Visible         =   0   'False
         Width           =   1500
      End
      Begin VB.OptionButton optGuarda 
         Caption         =   "Requerido"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   0
         Left            =   90
         TabIndex        =   5
         Top             =   165
         Value           =   -1  'True
         Visible         =   0   'False
         Width           =   1200
      End
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   435
      Left            =   1485
      TabIndex        =   16
      Top             =   1200
      Width           =   2430
      Begin VB.OptionButton optEstado 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   1
         Left            =   1110
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   150
         Width           =   1230
      End
      Begin VB.OptionButton optEstado 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   90
         TabIndex        =   3
         Top             =   135
         Value           =   -1  'True
         Width           =   990
      End
   End
   Begin MSMask.MaskEdBox mskCosto 
      Height          =   285
      Left            =   1485
      TabIndex        =   2
      Top             =   915
      Width           =   1680
      _ExtentX        =   2963
      _ExtentY        =   503
      _Version        =   393216
      MaxLength       =   14
      Format          =   "#,##0"
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1485
      MaxLength       =   40
      TabIndex        =   1
      Top             =   615
      Width           =   6855
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   3405
      Left            =   15
      TabIndex        =   7
      Top             =   1905
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14685
      _ExtentY        =   6006
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
      Picture         =   "FSERBAC.frx":0B80
      Style           =   1  'Graphical
      TabIndex        =   14
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
      Left            =   8400
      Picture         =   "FSERBAC.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   3795
      Width           =   875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Costo Interno:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   18
      Top             =   915
      Width           =   1215
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Nemónico:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   24
      Top             =   315
      Width           =   915
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1485
      TabIndex        =   12
      Top             =   15
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "No. de Rubros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   5865
      TabIndex        =   15
      Top             =   15
      Visible         =   0   'False
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   7320
      TabIndex        =   21
      Top             =   15
      Visible         =   0   'False
      Width           =   1020
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Histórico:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   4440
      TabIndex        =   23
      Top             =   1200
      Visible         =   0   'False
      Width           =   825
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   22
      Top             =   1200
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cód. Serv.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   20
      Top             =   15
      Width           =   975
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Descripción:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   19
      Top             =   615
      Width           =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Servicios disponibles:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   60
      TabIndex        =   13
      Top             =   1695
      Width           =   2595
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   1665
      Y2              =   1665
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   15
      Y2              =   5400
   End
End
Attribute VB_Name = "FCreaServ"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'! removed Dim VLPaso As Integer


Private Sub cmdBoton_Click(Index As Integer)
Dim VTEstado$
Dim VTGuarda$
Dim VTFilas%
Dim VTCodigo$
    Select Case Index%
    Case 0

        'Crear un nuevo servicio disponible

        ' Validacion de la mandatoriedad del nemonico del servicio
        If txtCampo(0).Text = "" Then
            MsgBox "El Nemónico de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        ' Validacion de la mandatoriedad de la descripcion del servicio
        If txtCampo(2).Text = "" Then
            MsgBox "La descripción de servicio es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        ' Validacion de la mandatoriedad del costo interno
        If mskCosto.Text = "" Then
            MsgBox "El costo interno es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto.SetFocus
            Exit Sub
        End If


        ' Verificar el estado del servicio
        If optEstado(0).Value = True Then
            VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
            VTEstado$ = "N"
        End If

        ' Verificar si se guarda historico o no
        If optGuarda(0).Value = True Then
            VTGuarda$ = "S"
        ElseIf optGuarda(1).Value = True Then
            VTGuarda$ = "N"
        End If

        

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4027"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_descr", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_costin", 0, SQLMONEY, mskCosto.Text
         PMPasoValores sqlconn&, "@i_estad", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_histr", 0, SQLCHAR, VTGuarda$
         PMPasoValores sqlconn&, "@i_nemonico", 0, SQLCHAR, txtCampo(0).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ins_serv_pe", True, " Ok... Creación de Servicio") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(1)
             PMChequea sqlconn&

            ' Consultar los servicion disponibles
            cmdBoton_Click (3)
            ' Desactivar el boton de crear
            cmdBoton(0).Enabled = False

        End If

    Case 1

        'Limpiar
        txtCampo(0).Enabled = True
        cmdBoton_Click (3)
        mskCosto.Text = ""
        txtCampo(2).Text = ""
        txtCampo(0).Text = ""
        lblDescripcion(1).Caption = ""
        optEstado(0).Value = True
        optGuarda(0).Value = True
        
        ' Desactivar el boton de Actualizar
        'cmdBoton(4).Enabled = False

        ' Activar el boton de crear
        'cmdBoton(0).Enabled = True
        
         PMObjetoSeguridad cmdBoton(4)
         PMObjetoSeguridad cmdBoton(0)
        

        If lblDescripcion(0).Visible = True Then
            lblDescripcion(0).Caption = ""
            lblDescripcion(0).Visible = False
            lblEtiqueta(6).Visible = False
        End If
        
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        txtCampo(0).SetFocus
    Case 2

        'Salir

        Unload FCreaServ

    Case 3
         
         'Consulta los primeros 20 servicios  y de los siguientes registros

         VTFilas% = VGMaxRows%
         VTCodigo$ = "0"

         While VTFilas% = VGMaxRows%
            
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4029"
              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
              PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
              PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ins_serv_pe", True, "Ok... Consulta de Servicios") Then
                If VTCodigo$ = "0" Then
                     PMMapeaGrid sqlconn&, grdServicios, False
                Else
                     PMMapeaGrid sqlconn&, grdServicios, True
                End If
                 PMChequea sqlconn&
                'VTFilas% = Val(grdServicios.Tag)

                grdServicios.Col = 1
                grdServicios.Row = grdServicios.Rows - 1
                VTCodigo$ = grdServicios.Text
                
                ' Determinar que existan servicions bancarios
                If Val(grdServicios.Tag) > 0 Then
                    grdServicios.ColAlignment(5) = 1
                    grdServicios.ColAlignment(4) = 2
                End If
    
             End If
             VTFilas% = Val(grdServicios.Tag)
        Wend
        grdServicios.Row = 1
    
         
    Case 4
   
        'Actualizar el servicio seleccionado
        
        ' Validacion de la mandatoriedad del nemonico del servicio
        If txtCampo(0).Text = "" Then
            MsgBox "El Nemónico de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        ' Validacion de la mandatoriedad de la descripcion del servicio
        If txtCampo(2).Text = "" Then
            MsgBox "La descripción de servicio es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        ' Validacion de la mandatoriedad del costo interno
        If mskCosto.Text = "" Then
            MsgBox "El costo interno es mandatorio", 0 + 16, "Mensaje de Error"
            mskCosto.SetFocus
            Exit Sub
        End If

        ' Asignación del estado del servicio
        
        If optEstado(0).Value = True Then
            VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
            VTEstado$ = "N"
        End If
        
        ' Determinación de histórico o no

        If optGuarda(0).Value = True Then
            VTGuarda$ = "S"
        Else
            VTGuarda$ = "N"
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4028"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, lblDescripcion(1).Caption
         PMPasoValores sqlconn&, "@i_descr", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_estad", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_histr", 0, SQLCHAR, VTGuarda$
         PMPasoValores sqlconn&, "@i_costin", 0, SQLMONEY, mskCosto.Text
         PMPasoValores sqlconn&, "@i_nemonico", 0, SQLCHAR, txtCampo(0).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ins_serv_pe", True, " Ok... Actualización de Servicio") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
            cmdBoton_Click (3)
        End If
                            
    End Select
End Sub

Private Sub Form_Load()

    '*********************************************************
    'Objetivo:  Carga la forma que se encargara de actualizar
    '           y crear servicios disponibles
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '---------  A.Rodriguez         Emisión Inicial
    '06/Ene/95  J.Bucheli           Revisión General
    '*********************************************************

    ' Coordenadas para el despliegue de la forma
    
    FCreaServ.Left = 15
    FCreaServ.Top = 15
    FCreaServ.Width = 9420
    FCreaServ.Height = 5730

    ' Rutina de seguridad para los botones de Inserción y
    ' Actualizacion
    PMBotonSeguridad FCreaServ, 4
    
    PMObjetoSeguridad cmdBoton(3)
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(4)
     
    ' Desactivar el boton de actualizar
    cmdBoton(4).Enabled = False

    ' Buscar los servicios bancarios disponibles
    cmdBoton_Click (3)

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdServicios_Click()
    
    ' Marcar la fila seleccionada en el grid de Servicios

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
    ' Seleccionar el Servicio para actualización
    VTRow% = grdServicios.Row

    grdServicios.Col = 1
    grdServicios.Row = 1

    ' Determinar si existen servicios bancarios
    If (grdServicios.Text <> "") Then

      grdServicios.Row = VTRow%
      PMMarcarRegistro
      
      PMObjetoSeguridad cmdBoton(4)
      'cmdBoton(4).Enabled = True
      cmdBoton(0).Enabled = False
      
      txtCampo(0).Enabled = False
      
    End If

End Sub

Private Sub grdServicios_GotFocus()
     FPrincipal.pnlHelpLine.Caption = " Haga doble click para Seleccionar"
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

Private Sub mskCosto_GotFocus()

    ' Despliegue en la linea de ayuda

    FPrincipal.pnlHelpLine.Caption = " Costo interno del Servicio"

    mskCosto.SelStart = 0
    mskCosto.SelLength = Len(mskCosto.Text)

End Sub

Private Sub mskCosto_KeyPress(KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
    End If

End Sub

Private Sub mskCosto_LostFocus()

    ' Validacion de que el Texto ingresado sea numerico

    If mskCosto.Text <> "" Then
        If Not IsNumeric(mskCosto.Text) Then
            mskCosto.Text = ""
            mskCosto.SetFocus
            Exit Sub
        End If
    End If

End Sub

Private Sub optEstado_GotFocus(Index As Integer)
    Select Case Index%
    Case 0, 1
        FPrincipal.pnlHelpLine.Caption = " Estado del Servicio"
    End Select

End Sub

Private Sub optGuarda_GotFocus(Index As Integer)
    Select Case Index%
    Case 0, 1
        FPrincipal.pnlHelpLine.Caption = " Histórico Requerido"
    End Select
End Sub

Private Sub PMMarcarRegistro()
    
    grdServicios.Col = 1
    lblDescripcion(1).Caption = grdServicios.Text
    
    grdServicios.Col = 2
    txtCampo(0).Text = grdServicios.Text
    txtCampo(0).Enabled = False
    
    grdServicios.Col = 3
    txtCampo(2).Text = grdServicios.Text
    
    grdServicios.Col = 4
    If grdServicios.Text = "V" Then
        optEstado(0).Value = True
    Else
        optEstado(1).Value = True
    End If
    
    
    grdServicios.Col = 5
    mskCosto.Text = grdServicios.Text
    
    grdServicios.Col = 6
    lblDescripcion(0).Caption = grdServicios.Text
    lblDescripcion(0).Visible = True
    lblEtiqueta(6).Visible = True

    grdServicios.Col = 7
    If grdServicios.Text = "S" Then
        optGuarda(0).Value = True
    Else
        optGuarda(1).Value = True
    End If
    
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Nemónico del Servicio"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Descripción del Servicio"
    End Select

    ' Resalta el contenido del objeto
    
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)

    ' Validacion del tipo de los carateres permisibles de ingreso
    Select Case Index%
    Case 0, 2
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    End Select

End Sub



