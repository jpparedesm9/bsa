VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FCatalogoServ 
   Appearance      =   0  'Flat
   BackColor       =    &H8000000F&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Registros Seleccionados"
   ClientHeight    =   3225
   ClientLeft      =   4275
   ClientTop       =   1350
   ClientWidth     =   5295
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
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3225
   ScaleWidth      =   5295
   Begin MSGrid.Grid grdRegistros 
      Height          =   2805
      Left            =   30
      TabIndex        =   1
      Top             =   30
      Width           =   5235
      _Version        =   65536
      _ExtentX        =   9235
      _ExtentY        =   4948
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
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
   Begin VB.CommandButton cmdSiguientes 
      Appearance      =   0  'Flat
      Caption         =   "&Siguientes"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   345
      Left            =   15
      TabIndex        =   0
      Top             =   2865
      Width           =   5265
   End
End
Attribute VB_Name = "FCatalogoServ"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

Private Sub cmdSiguientes_Click()
'*********************************************************
'Objetivo:  Permite obtener los siguientes registros
'           de la lista de ayuda seleccionada
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    

    grdRegistros.Row = grdRegistros.Rows - 1
    Select Case VGOperacion$
    Case "operacionHCont", "operacionHCons"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, ""
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, "0"
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, grdRegistros.Text
        grdRegistros.Col = 4
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, grdRegistros.Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
             PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, True
             PMChequea sqlconn&
            If FCatalogoServ.grdRegistros.Tag <> 20 Then
                cmdSiguientes.Enabled = False
            End If
        End If
    Case "operacionH2Cont", "operacionH2Cons"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H2"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, ""
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, "0"
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
        grdRegistros.Col = 1
         PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, grdRegistros.Text
        grdRegistros.Col = 4
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, grdRegistros.Text
        
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
             PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, True
             PMChequea sqlconn&
        End If
    End Select
End Sub

Private Sub Form_Activate()
'*********************************************************
'Objetivo:  Permite activar o desactivar el boton de
'           siguientes de la lista de ayuda seleccionada
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'28/May/98  Geovanna Bonilla B. Migración VB3 a VB5J.Bucheli           Revisión General
'*********************************************************

'GBB27May98002 DI:Comparación de string con enteros
    'If grdRegistros.Tag < 20 Then
    If Val(grdRegistros.Tag) < 20 Then
        cmdSiguientes.Enabled = False
   'GBB27May98002 IF:
    Else
        cmdSiguientes.Enabled = True
    End If
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii% = 27 Then
        Select Case VGOperacion$
        Case "operacionHCons", "operacionH2Cons"
            FConsultaCta.txtCampo(1).Text = ""
            FConsultaCta.lblDescripcion(6).Caption = ""
            FConsultaCta.txtCampo(3).Text = ""
            FConsultaCta.lblDescripcion(7).Caption = ""
        Case "operacionHCont", "operacionH2Cont"
            FContratacion.txtCampo(5).Text = ""
            FContratacion.lblDescripcion(8).Caption = ""
            FContratacion.txtCampo(6).Text = ""
            FContratacion.lblDescripcion(9).Caption = ""
        End Select
        Unload FCatalogoServ
    Else
        If KeyAscii% = 13 Then
            grdRegistros_DblClick
        End If
    End If
End Sub

Private Sub grdRegistros_DblClick()
    If FCatalogoServ.grdRegistros.Rows <> 0 Then
        Select Case VGOperacion$
        Case "operacionHCons", "operacionH2Cons"
            grdRegistros.Col = 1
            FConsultaCta.txtCampo(1).Text = grdRegistros.Text
            grdRegistros.Col = 3
            FConsultaCta.lblDescripcion(6).Caption = grdRegistros.Text
            grdRegistros.Col = 4
            FConsultaCta.txtCampo(3).Text = grdRegistros.Text
            grdRegistros.Col = 5
            FConsultaCta.lblDescripcion(7).Caption = grdRegistros.Text
        Case "operacionHCont", "operacionH2Cont"
            grdRegistros.Col = 1
            FContratacion.txtCampo(5).Text = grdRegistros.Text
            grdRegistros.Col = 3
            FContratacion.lblDescripcion(8).Caption = grdRegistros.Text
            grdRegistros.Col = 4
            FContratacion.txtCampo(6).Text = grdRegistros.Text
            grdRegistros.Col = 5
            FContratacion.lblDescripcion(9).Caption = grdRegistros.Text
        Case "FCONVAR2-1", "FCONVAR2-2"
            grdRegistros.Col = 1
            FconVarCosto.txtCampo(0).Text = grdRegistros.Text
            grdRegistros.Col = 3
            FconVarCosto.lblDescripcion(1).Caption = grdRegistros.Text
            grdRegistros.Col = 4
            FconVarCosto.lblDescripcion(11).Caption = grdRegistros.Text
            grdRegistros.Col = 5
            FconVarCosto.lblDescripcion(5).Caption = grdRegistros.Text
        End Select
    Else
        Select Case VGOperacion$
        Case "operacionHCons", "operacionH2Cons"
            FConsultaCta.txtCampo(1).Text = ""
            FConsultaCta.lblDescripcion(6).Caption = ""
            FConsultaCta.txtCampo(3).Text = ""
            FConsultaCta.lblDescripcion(7).Caption = ""
        Case "operacionHCont", "operacionH2Cont"
            FContratacion.txtCampo(5).Text = ""
            FContratacion.lblDescripcion(8).Caption = ""
            FContratacion.txtCampo(6).Text = ""
            FContratacion.lblDescripcion(9).Caption = ""
        Case "FCONVAR2-1", "FCONVAR2-2"
            FconVarCosto.txtCampo(0).Text = ""
            FconVarCosto.lblDescripcion(1).Caption = ""
            FconVarCosto.lblDescripcion(11).Caption = ""
            FconVarCosto.lblDescripcion(5).Caption = ""
        End Select
    End If
    Unload FCatalogoServ
End Sub

'! Private Sub lstCatalogo_DblClick()
'! '*********************************************************
'! 'Objetivo:  Permite seleccionar un dato de la lista de
'! '           ayuda que se encuentra activa
'! '*********************************************************
'! '                    MODIFICACIONES
'! 'FECHA      AUTOR               RAZON
'! '---------  J.Uria              Emisión Inicial
'! '07/Jul/94  J.Bucheli           Revisión General
'! '*********************************************************
'!
'! '    If FCatalogo!lstCatalogo.ListCount <> 0 Then
'! '        VTUb1% = InStr(1, lstCatalogo.Text, Chr$(9))
'! '        'VGACatalogo.Codigo$ = Mid$(FCatalogo!lstCatalogo.Text, 1, VTUb1% - 1)
'! '        'VTUb2% = InStr(VTUb1% + 1, FCatalogo!lstCatalogo.Text, Chr$(9))
'! '        If VTUb2% <> 0 Then
'! '            'VGACatalogo.Descripcion$ = Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, VTUb2% - VTUb1% - 1)
'! '        Else
'! '            'VGACatalogo.Descripcion$ = Mid$(FCatalogo!lstCatalogo.Text, VTUb1% + 1, Len(FCatalogo!lstCatalogo.Text) - VTUb1% + 1)
'! '        End If
'! '    Else
'! '        VGACatalogo.Codigo$ = ""
'! '        VGACatalogo.Descripcion$ = ""
'! '    End If
'! '    Unload FCatalogo
'! End Sub
'!
'!

